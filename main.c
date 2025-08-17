#include "stm8s.h"

/* ===================== Pin map (STM8S003F3P6) ===================== */
/* Fan driver (2N7002AQ low-side MOSFET) */
#define FAN_PORT      GPIOD
#define FAN_PIN       GPIO_PIN_4     /* PD4 -> 100R -> MOSFET gate (ON = HIGH) */

/* RGB LED (Everlight EASV3015RGBA0, common-anode @3.3V; ON = pin LOW) */
#define LED_B_PORT    GPIOC
#define LED_B_PIN     GPIO_PIN_5     /* PC5 = Blue  */
#define LED_G_PORT    GPIOC
#define LED_G_PIN     GPIO_PIN_6     /* PC6 = Green */
#define LED_R_PORT    GPIOC
#define LED_R_PIN     GPIO_PIN_7     /* PC7 = Red   */

/* Button (PB4 with 10k pull-up to 3.3V; active LOW to GND) */
#define BTN_PORT      GPIOB
#define BTN_PIN       GPIO_PIN_4

/* ===================== Timing / debounce ===================== */
#define DEBOUNCE_MS           20u
#define SHORT_PRESS_MAX_MS  1000u     /* < 1 s  => short */
#define LONG_PRESS_MIN_MS   2000u     /* >=2 s  => long  */

#define MS_PER_SEC          1000u
#define FAN_ON_DURATION_S   (5u * 60u)  /* 5 minutes ON */

/* ===================== WWDG (windowed watchdog) ===================== */
#define WWDG_START_COUNTER   ((uint8_t)0x7F)
#define WWDG_WINDOW          ((uint8_t)0x50)
#define WWDG_REFRESH_FLOOR   ((uint8_t)0x44)

/* ===================== Globals ===================== */
static volatile uint32_t uptime_ms = 0;
static volatile uint32_t uptime_s  = 0;

/* Debouncer state (polling) */
typedef struct {
  uint8_t  stable_level;      /* 1 = released, 0 = pressed (active-low) */
  uint8_t  last_sample;
  uint16_t stable_time_ms;
  uint8_t  in_press;
  uint32_t press_start_ms;
  uint8_t  short_event;       /* 1 when a short press is detected */
  uint8_t  long_event;        /* 1 when a long  press is detected */
} btn_db_t;

static btn_db_t btn = { .stable_level = 1u, .last_sample = 1u };

/* Operating modes */
typedef enum {
  MODE_OFF = 0,
  MODE_ECO,
  MODE_MID,
  MODE_HIGH
} mode_t;

static mode_t mode = MODE_OFF;

/* Fan schedule state */
static uint8_t  fan_on = 0;
static uint32_t fan_on_started_s = 0;
static uint32_t next_on_time_s   = 0;

/* Simple 16-bit LFSR for jitter (non-crypto) */
static uint16_t lfsr = 0xACE1u;

/* ===================== Helpers ===================== */
static inline void tick_1ms_poll(void) {
  if (TIM4_GetFlagStatus(TIM4_FLAG_UPDATE) != RESET) {
    TIM4_ClearFlag(TIM4_FLAG_UPDATE);
    uptime_ms++;
    if ((uptime_ms % MS_PER_SEC) == 0u) {
      uptime_s++;
    }
  }
}

/* PRNG: returns 16-bit pseudo-random value */
static inline uint16_t rand16(void) {
  /* taps: 16,14,13,11 from x^16 + x^14 + x^13 + x^11 + 1 */
  uint16_t lsb = (uint16_t)((lfsr ^ (lfsr >> 2) ^ (lfsr >> 3) ^ (lfsr >> 5)) & 1u);
  lfsr = (uint16_t)((lfsr >> 1) | (lsb << 15));
  return lfsr;
}

/* Inclusive random range in minutes -> seconds */
static uint32_t rand_minutes_range_to_seconds(uint8_t min_min, uint8_t max_min) {
  uint8_t span = (uint8_t)(max_min - min_min + 1u);
  uint8_t r = (uint8_t)(rand16() % span);
  uint8_t minutes = (uint8_t)(min_min + r);
  return (uint32_t)minutes * 60u;
}

/* GPIO helpers */
static inline void fan_off(void)  { GPIO_WriteLow (FAN_PORT, FAN_PIN);  fan_on = 0; }
static inline void fan_on_fn(void){ GPIO_WriteHigh(FAN_PORT, FAN_PIN);  fan_on = 1; fan_on_started_s = uptime_s; }

/* LED: common-anode (LOW = on). Only one color on at a time, or all off. */
static void led_off_all(void) {
  GPIO_WriteHigh(LED_R_PORT, LED_R_PIN);
  GPIO_WriteHigh(LED_G_PORT, LED_G_PIN);
  GPIO_WriteHigh(LED_B_PORT, LED_B_PIN);
}

static void led_set_for_mode(mode_t m) {
  led_off_all();
  switch (m) {
    case MODE_ECO:  GPIO_WriteLow(LED_G_PORT, LED_G_PIN); break; /* Green  */
    case MODE_MID:  GPIO_WriteLow(LED_B_PORT, LED_B_PIN); break; /* Blue   */
    case MODE_HIGH: GPIO_WriteLow(LED_R_PORT, LED_R_PIN); break; /* Red    */
    default: /* OFF */ break;
  }
}

/* Button read (raw): 1=released, 0=pressed */
static inline uint8_t button_raw_level(void) {
  return (uint8_t)GPIO_ReadInputPin(BTN_PORT, BTN_PIN) ? 1u : 0u;
}

/* Debounce + press classification (non-blocking) */
static void button_update_1ms(void) {
  uint8_t raw = button_raw_level();

  if (raw == btn.last_sample) {
    if (btn.stable_time_ms < 0xFFFF) btn.stable_time_ms++;
  } else {
    btn.stable_time_ms = 0;
    btn.last_sample = raw;
  }

  if (btn.stable_time_ms == DEBOUNCE_MS) {
    if (raw != btn.stable_level) {
      btn.stable_level = raw;

      if (raw == 0u) { /* pressed */
        btn.in_press = 1u;
        btn.press_start_ms = uptime_ms;
      } else {         /* released */
        if (btn.in_press) {
          uint32_t dur_ms = uptime_ms - btn.press_start_ms;
          btn.in_press = 0u;

          if (dur_ms >= LONG_PRESS_MIN_MS)       btn.long_event  = 1u;
          else if (dur_ms <  SHORT_PRESS_MAX_MS) btn.short_event = 1u;
          /* else: ignore (1..2 s window) */
        }
      }
    }
  }
}

/* Schedule next fan ON time for current mode (called when entering ECO/MID/HIGH or after finishing ON) */
static void schedule_next_interval(void) {
  uint32_t interval_s = 0;
  switch (mode) {
    case MODE_ECO:  interval_s = rand_minutes_range_to_seconds(70, 80); break;
    case MODE_MID:  interval_s = rand_minutes_range_to_seconds(55, 65); break;
    case MODE_HIGH: interval_s = rand_minutes_range_to_seconds(40, 50); break;
    default: interval_s = 0; break;
  }
  next_on_time_s = uptime_s + interval_s;
}

/* ===================== Init blocks (SPL) ===================== */
static void clock_init(void) {
  CLK_HSIPrescalerConfig(CLK_PRESCALER_HSIDIV1);
  CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER4, ENABLE);
}

static void gpio_init(void) {
  // Deinit once at startup (optional, not per pin)
  GPIO_DeInit(GPIOC);
  GPIO_DeInit(GPIOD);
  GPIO_DeInit(GPIOB);

  // Fan gate
  GPIO_Init(FAN_PORT, FAN_PIN, GPIO_MODE_OUT_PP_LOW_FAST);

  // RGB LED
  GPIO_Init(LED_R_PORT, LED_R_PIN, GPIO_MODE_OUT_PP_HIGH_FAST);
  GPIO_Init(LED_G_PORT, LED_G_PIN, GPIO_MODE_OUT_PP_HIGH_FAST);
  GPIO_Init(LED_B_PORT, LED_B_PIN, GPIO_MODE_OUT_PP_HIGH_FAST);

  // Button
  GPIO_Init(BTN_PORT, BTN_PIN, GPIO_MODE_IN_PU_NO_IT);
}


static void tim4_init_1ms(void) {
  /* 16 MHz / 128 = 125 kHz; ARR = 125-1 => 1 ms update */
  TIM4_TimeBaseInit(TIM4_PRESCALER_128, 125 - 1);
  TIM4_SetCounter(0);
  TIM4_ClearFlag(TIM4_FLAG_UPDATE);
  TIM4_Cmd(ENABLE);
}

static void wwdg_init(void) {
  WWDG_Init(WWDG_START_COUNTER, WWDG_WINDOW);
}

/* Refresh window watchdog only inside allowed window */
static inline void wwdg_service(void) {
  uint8_t c = (uint8_t)(WWDG_GetCounter() & 0x7F);
  if ((c < WWDG_WINDOW) && (c >= WWDG_REFRESH_FLOOR)) {
    WWDG_SetCounter(WWDG_START_COUNTER);
  }
}

/* ===================== Mode transitions ===================== */
static void enter_mode(mode_t m) {
  mode = m;

  switch (mode) {
    case MODE_OFF:
      fan_off();
      led_off_all();
      break;

    case MODE_ECO:
    case MODE_MID:
    case MODE_HIGH:
      /* LED immediately reflects mode; fan OFF initially, scheduled later */
      led_set_for_mode(mode);
      fan_off();
      schedule_next_interval();
      break;
  }
}

/* Short press: ECO -> MID -> HIGH -> OFF -> ECO ... */
static void advance_mode(void) {
  switch (mode) {
    case MODE_OFF:  enter_mode(MODE_ECO);  break;
    case MODE_ECO:  enter_mode(MODE_MID);  break;
    case MODE_MID:  enter_mode(MODE_HIGH); break;
    case MODE_HIGH: enter_mode(MODE_OFF);  break;
  }
}

/* ===================== main ===================== */
int main(void) {
  clock_init();
  gpio_init();
  tim4_init_1ms();
  wwdg_init();

  /* Power-on default: OFF (safety) */
  enter_mode(MODE_OFF);

  /* Seed PRNG a bit differently on each power-up (using counter drift) */
  lfsr ^= (uint16_t)TIM4->CNTR;

  uint32_t last_ms = 0;

  for (;;) {
    /* 1 ms timebase */
    tick_1ms_poll();

    /* Run 1 kHz tasks */
    if (uptime_ms != last_ms) {
      last_ms = uptime_ms;

      /* Button debounce & events */
      button_update_1ms();

      /* Handle button events (non-blocking) */
      if (btn.long_event) {
        btn.long_event = 0u;
        enter_mode(MODE_OFF);                 /* Long press => OFF */
      } else if (btn.short_event) {
        btn.short_event = 0u;
        advance_mode();                        /* Short press => next mode, LED updates immediately */
      }

      /* 1 s scheduler: fan timing for ECO/MID/HIGH */
      if ((uptime_ms % MS_PER_SEC) == 0u) {
        if (mode == MODE_ECO || mode == MODE_MID || mode == MODE_HIGH) {
          if (fan_on) {
            /* Stop after 5 minutes */
            if ((uptime_s - fan_on_started_s) >= FAN_ON_DURATION_S) {
              fan_off();
              schedule_next_interval();        /* pick new jitter for the next interval */
            }
          } else {
            /* Wait until next_on_time_s to start 5-minute ON */
            if (uptime_s >= next_on_time_s) {
              fan_on_fn();
            }
          }
        } else {
          /* MODE_OFF: ensure everything off */
          if (fan_on) fan_off();
        }
      }
    }

    /* Service window watchdog correctly */
    wwdg_service();
  }
}
