;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler
; Version 4.5.0 #15242 (MINGW64)
;--------------------------------------------------------
	.module main
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _main
	.globl _WWDG_GetCounter
	.globl _WWDG_SetCounter
	.globl _WWDG_Init
	.globl _TIM4_ClearFlag
	.globl _TIM4_GetFlagStatus
	.globl _TIM4_SetCounter
	.globl _TIM4_Cmd
	.globl _TIM4_TimeBaseInit
	.globl _GPIO_ReadInputPin
	.globl _GPIO_WriteLow
	.globl _GPIO_WriteHigh
	.globl _GPIO_Init
	.globl _GPIO_DeInit
	.globl _CLK_HSIPrescalerConfig
	.globl _CLK_PeripheralClockConfig
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area DATA
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area INITIALIZED
_uptime_ms:
	.ds 4
_uptime_s:
	.ds 4
_btn:
	.ds 11
_mode:
	.ds 1
_fan_on:
	.ds 1
_fan_on_started_s:
	.ds 4
_next_on_time_s:
	.ds 4
_lfsr:
	.ds 2
;--------------------------------------------------------
; Stack segment in internal ram
;--------------------------------------------------------
	.area SSEG
__start__stack:
	.ds	1

;--------------------------------------------------------
; absolute external ram data
;--------------------------------------------------------
	.area DABS (ABS)

; default segment ordering for linker
	.area HOME
	.area GSINIT
	.area GSFINAL
	.area CONST
	.area INITIALIZER
	.area CODE

;--------------------------------------------------------
; interrupt vector
;--------------------------------------------------------
	.area HOME
__interrupt_vect:
	int s_GSINIT ; reset
;--------------------------------------------------------
; global & static initialisations
;--------------------------------------------------------
	.area HOME
	.area GSINIT
	.area GSFINAL
	.area GSINIT
	call	___sdcc_external_startup
	tnz	a
	jreq	__sdcc_init_data
	jp	__sdcc_program_startup
__sdcc_init_data:
; stm8_genXINIT() start
	ldw x, #l_DATA
	jreq	00002$
00001$:
	clr (s_DATA - 1, x)
	decw x
	jrne	00001$
00002$:
	ldw	x, #l_INITIALIZER
	jreq	00004$
00003$:
	ld	a, (s_INITIALIZER - 1, x)
	ld	(s_INITIALIZED - 1, x), a
	decw	x
	jrne	00003$
00004$:
; stm8_genXINIT() end
	.area GSFINAL
	jp	__sdcc_program_startup
;--------------------------------------------------------
; Home
;--------------------------------------------------------
	.area HOME
	.area HOME
__sdcc_program_startup:
	jp	_main
;	return from main will return to caller
;--------------------------------------------------------
; code
;--------------------------------------------------------
	.area CODE
;	main.c: 69: static inline void tick_1ms_poll(void) {
;	-----------------------------------------
;	 function tick_1ms_poll
;	-----------------------------------------
_tick_1ms_poll:
;	main.c: 70: if (TIM4_GetFlagStatus(TIM4_FLAG_UPDATE) != RESET) {
	ld	a, #0x01
	call	_TIM4_GetFlagStatus
	tnz	a
	jrne	00121$
	ret
00121$:
;	main.c: 71: TIM4_ClearFlag(TIM4_FLAG_UPDATE);
	ld	a, #0x01
	call	_TIM4_ClearFlag
;	main.c: 72: uptime_ms++;
	ldw	x, _uptime_ms+2
	ldw	y, _uptime_ms+0
	incw	x
	jrne	00122$
	incw	y
00122$:
	ldw	_uptime_ms+2, x
	ldw	_uptime_ms+0, y
;	main.c: 73: if ((uptime_ms % MS_PER_SEC) == 0u) {
	push	#0xe8
	push	#0x03
	clrw	x
	pushw	x
	push	_uptime_ms+3
	push	_uptime_ms+2
	push	_uptime_ms+1
	push	_uptime_ms+0
	call	__modulong
	addw	sp, #8
	tnzw	x
	jrne	00123$
	tnzw	y
	jreq	00124$
00123$:
	ret
00124$:
;	main.c: 74: uptime_s++;
	ldw	x, _uptime_s+2
	ldw	y, _uptime_s+0
	incw	x
	jrne	00125$
	incw	y
00125$:
	ldw	_uptime_s+2, x
	ldw	_uptime_s+0, y
;	main.c: 77: }
	ret
;	main.c: 80: static inline uint16_t rand16(void) {
;	-----------------------------------------
;	 function rand16
;	-----------------------------------------
_rand16:
	sub	sp, #4
;	main.c: 82: uint16_t lsb = (uint16_t)((lfsr ^ (lfsr >> 2) ^ (lfsr >> 3) ^ (lfsr >> 5)) & 1u);
	ldw	x, _lfsr+0
	srlw	x
	srlw	x
	ld	a, xl
	xor	a, _lfsr+1
	ld	(0x02, sp), a
	ld	a, xh
	xor	a, _lfsr+0
	ld	(0x01, sp), a
	ldw	x, _lfsr+0
	srlw	x
	srlw	x
	srlw	x
	ld	a, xl
	xor	a, (0x02, sp)
	ld	(0x04, sp), a
	ld	a, xh
	xor	a, (0x01, sp)
	ld	(0x03, sp), a
	ldw	x, _lfsr+0
	ld	a, #0x20
	div	x, a
	ld	a, xl
	xor	a, (0x04, sp)
	ld	xl, a
	ld	a, xh
	xor	a, (0x03, sp)
	ld	a, xl
	and	a, #0x01
	ld	xl, a
;	main.c: 83: lfsr = (uint16_t)((lfsr >> 1) | (lsb << 15));
	ldw	y, _lfsr+0
	srlw	y
	ld	a, xl
	clrw	x
	srl	a
	rrcw	x
	ldw	(0x03, sp), x
	ld	a, yh
	or	a, (0x03, sp)
	ld	yh, a
	ldw	_lfsr+0, y
;	main.c: 84: return lfsr;
	ldw	x, _lfsr+0
;	main.c: 85: }
	addw	sp, #4
	ret
;	main.c: 88: static uint32_t rand_minutes_range_to_seconds(uint8_t min_min, uint8_t max_min) {
;	-----------------------------------------
;	 function rand_minutes_range_to_seconds
;	-----------------------------------------
_rand_minutes_range_to_seconds:
	sub	sp, #6
	ld	(0x06, sp), a
;	main.c: 89: uint8_t span = (uint8_t)(max_min - min_min + 1u);
	ld	a, (0x09, sp)
	sub	a, (0x06, sp)
	inc	a
	ld	(0x01, sp), a
;	main.c: 82: uint16_t lsb = (uint16_t)((lfsr ^ (lfsr >> 2) ^ (lfsr >> 3) ^ (lfsr >> 5)) & 1u);
	ldw	x, _lfsr+0
	srlw	x
	srlw	x
	ld	a, xl
	xor	a, _lfsr+1
	ld	(0x03, sp), a
	ld	a, xh
	xor	a, _lfsr+0
	ld	(0x02, sp), a
	ldw	x, _lfsr+0
	srlw	x
	srlw	x
	srlw	x
	ld	a, xl
	xor	a, (0x03, sp)
	ld	(0x05, sp), a
	ld	a, xh
	xor	a, (0x02, sp)
	ld	(0x04, sp), a
	ldw	x, _lfsr+0
	ld	a, #0x20
	div	x, a
	ld	a, xl
	xor	a, (0x05, sp)
	ld	xl, a
	ld	a, xh
	xor	a, (0x04, sp)
	ld	a, xl
	and	a, #0x01
	ld	xl, a
;	main.c: 90: uint8_t r = (uint8_t)(rand16() % span);
	ldw	y, _lfsr+0
	srlw	y
	ld	a, xl
	clrw	x
	srl	a
	rrcw	x
	ldw	(0x04, sp), x
	ld	a, yh
	or	a, (0x04, sp)
	ld	yh, a
	ldw	_lfsr+0, y
	ldw	x, _lfsr+0
	ld	a, (0x01, sp)
	clrw	y
	ld	yl, a
	divw	x, y
	ldw	x, y
;	main.c: 91: uint8_t minutes = (uint8_t)(min_min + r);
	addw	x, (5, sp)
;	main.c: 92: return (uint32_t)minutes * 60u;
	ld	a, #0x3c
	mul	x, a
	clrw	y
;	main.c: 93: }
	addw	sp, #6
	ret
;	main.c: 96: static inline void fan_off(void)  { GPIO_WriteLow (FAN_PORT, FAN_PIN);  fan_on = 0; }
;	-----------------------------------------
;	 function fan_off
;	-----------------------------------------
_fan_off:
	ld	a, #0x10
	ldw	x, #0x500f
	call	_GPIO_WriteLow
	clr	_fan_on+0
	ret
;	main.c: 97: static inline void fan_on_fn(void){ GPIO_WriteHigh(FAN_PORT, FAN_PIN);  fan_on = 1; fan_on_started_s = uptime_s; }
;	-----------------------------------------
;	 function fan_on_fn
;	-----------------------------------------
_fan_on_fn:
	ld	a, #0x10
	ldw	x, #0x500f
	call	_GPIO_WriteHigh
	mov	_fan_on+0, #0x01
	ldw	x, _uptime_s+2
	ldw	y, _uptime_s+0
	ldw	_fan_on_started_s+2, x
	ldw	_fan_on_started_s+0, y
	ret
;	main.c: 100: static void led_off_all(void) {
;	-----------------------------------------
;	 function led_off_all
;	-----------------------------------------
_led_off_all:
;	main.c: 101: GPIO_WriteHigh(LED_R_PORT, LED_R_PIN);
	ld	a, #0x80
	ldw	x, #0x500a
	call	_GPIO_WriteHigh
;	main.c: 102: GPIO_WriteHigh(LED_G_PORT, LED_G_PIN);
	ld	a, #0x40
	ldw	x, #0x500a
	call	_GPIO_WriteHigh
;	main.c: 103: GPIO_WriteHigh(LED_B_PORT, LED_B_PIN);
	ld	a, #0x20
	ldw	x, #0x500a
;	main.c: 104: }
	jp	_GPIO_WriteHigh
;	main.c: 106: static void led_set_for_mode(mode_t m) {
;	-----------------------------------------
;	 function led_set_for_mode
;	-----------------------------------------
_led_set_for_mode:
;	main.c: 107: led_off_all();
	push	a
	call	_led_off_all
	pop	a
;	main.c: 108: switch (m) {
	cp	a, #0x01
	jreq	00101$
	cp	a, #0x02
	jreq	00102$
	cp	a, #0x03
	jreq	00103$
	ret
;	main.c: 109: case MODE_ECO:  GPIO_WriteLow(LED_G_PORT, LED_G_PIN); break; /* Green  */
00101$:
	ld	a, #0x40
	ldw	x, #0x500a
	jp	_GPIO_WriteLow
;	main.c: 110: case MODE_MID:  GPIO_WriteLow(LED_B_PORT, LED_B_PIN); break; /* Blue   */
00102$:
	ld	a, #0x20
	ldw	x, #0x500a
	jp	_GPIO_WriteLow
;	main.c: 111: case MODE_HIGH: GPIO_WriteLow(LED_R_PORT, LED_R_PIN); break; /* Red    */
00103$:
	ld	a, #0x80
	ldw	x, #0x500a
;	main.c: 113: }
;	main.c: 114: }
	jp	_GPIO_WriteLow
;	main.c: 117: static inline uint8_t button_raw_level(void) {
;	-----------------------------------------
;	 function button_raw_level
;	-----------------------------------------
_button_raw_level:
;	main.c: 118: return (uint8_t)GPIO_ReadInputPin(BTN_PORT, BTN_PIN) ? 1u : 0u;
	ld	a, #0x10
	ldw	x, #0x5005
	call	_GPIO_ReadInputPin
	tnz	a
	jreq	00103$
	ld	a, #0x01
	ret
00103$:
	clr	a
;	main.c: 119: }
	ret
;	main.c: 122: static void button_update_1ms(void) {
;	-----------------------------------------
;	 function button_update_1ms
;	-----------------------------------------
_button_update_1ms:
	sub	sp, #4
;	main.c: 123: uint8_t raw = button_raw_level();
	ld	a, #0x10
	ldw	x, #0x5005
	call	_GPIO_ReadInputPin
	tnz	a
	jreq	00123$
	ld	a, #0x01
	.byte 0x21
00123$:
	clr	a
00124$:
	ld	(0x03, sp), a
	ld	(0x04, sp), a
;	main.c: 125: if (raw == btn.last_sample) {
	ld	a, _btn+1
;	main.c: 126: if (btn.stable_time_ms < 0xFFFF) btn.stable_time_ms++;
;	main.c: 125: if (raw == btn.last_sample) {
	cp	a, (0x03, sp)
	jrne	00104$
;	main.c: 126: if (btn.stable_time_ms < 0xFFFF) btn.stable_time_ms++;
	ldw	x, _btn+2
	ldw	y, x
	cpw	y, #0xffff
	jrnc	00105$
	incw	x
	ldw	_btn+2, x
	jra	00105$
00104$:
;	main.c: 128: btn.stable_time_ms = 0;
	ldw	x, #(_btn+2)
	clr	(0x1, x)
	clr	(x)
;	main.c: 129: btn.last_sample = raw;
	ldw	x, #(_btn+1)
	ld	a, (0x03, sp)
	ld	(x), a
00105$:
;	main.c: 132: if (btn.stable_time_ms == DEBOUNCE_MS) {
	ldw	x, _btn+2
	cpw	x, #0x0014
	jrne	00121$
;	main.c: 133: if (raw != btn.stable_level) {
	ldw	x, #(_btn+0)
	ld	a, (x)
	cp	a, (0x04, sp)
	jreq	00121$
;	main.c: 134: btn.stable_level = raw;
	ld	a, (0x04, sp)
	ld	(x), a
;	main.c: 137: btn.in_press = 1u;
;	main.c: 138: btn.press_start_ms = uptime_ms;
	ldw	x, #(_btn+0)+5
;	main.c: 136: if (raw == 0u) { /* pressed */
	tnz	(0x04, sp)
	jrne	00114$
;	main.c: 137: btn.in_press = 1u;
	mov	_btn+4, #0x01
;	main.c: 138: btn.press_start_ms = uptime_ms;
	ldw	y, _uptime_ms+2
	ldw	(0x2, x), y
	ldw	y, _uptime_ms+0
	ldw	(x), y
	jra	00121$
00114$:
;	main.c: 140: if (btn.in_press) {
	ld	a, _btn+4
	jreq	00121$
;	main.c: 141: uint32_t dur_ms = uptime_ms - btn.press_start_ms;
	ldw	y, x
	ldw	y, (0x2, y)
	ldw	(0x03, sp), y
	ldw	x, (x)
	ldw	(0x01, sp), x
	ldw	y, _uptime_ms+2
	subw	y, (0x03, sp)
	ld	a, _uptime_ms+1
	sbc	a, (0x02, sp)
	ld	xl, a
	ld	a, _uptime_ms+0
	sbc	a, (0x01, sp)
	ld	xh, a
;	main.c: 142: btn.in_press = 0u;
	mov	_btn+4, #0x00
;	main.c: 144: if (dur_ms >= LONG_PRESS_MIN_MS)       btn.long_event  = 1u;
	cpw	y, #0x07d0
	ld	a, xl
	sbc	a, #0x00
	ld	a, xh
	sbc	a, #0x00
	jrc	00109$
	mov	_btn+10, #0x01
	jra	00121$
00109$:
;	main.c: 145: else if (dur_ms <  SHORT_PRESS_MAX_MS) btn.short_event = 1u;
	cpw	y, #0x03e8
	clr	a
	sbc	a, #0x00
	clr	a
	sbc	a, #0x00
	jrnc	00121$
	mov	_btn+9, #0x01
00121$:
;	main.c: 151: }
	addw	sp, #4
	ret
;	main.c: 154: static void schedule_next_interval(void) {
;	-----------------------------------------
;	 function schedule_next_interval
;	-----------------------------------------
_schedule_next_interval:
;	main.c: 156: switch (mode) {
	ld	a, _mode+0
	dec	a
	jreq	00101$
	ld	a, _mode+0
	cp	a, #0x02
	jreq	00102$
	ld	a, _mode+0
	cp	a, #0x03
	jreq	00103$
	jra	00104$
;	main.c: 157: case MODE_ECO:  interval_s = rand_minutes_range_to_seconds(70, 80); break;
00101$:
	push	#0x50
	ld	a, #0x46
	call	_rand_minutes_range_to_seconds
	pop	a
	jra	00105$
;	main.c: 158: case MODE_MID:  interval_s = rand_minutes_range_to_seconds(55, 65); break;
00102$:
	push	#0x41
	ld	a, #0x37
	call	_rand_minutes_range_to_seconds
	pop	a
	jra	00105$
;	main.c: 159: case MODE_HIGH: interval_s = rand_minutes_range_to_seconds(40, 50); break;
00103$:
	push	#0x32
	ld	a, #0x28
	call	_rand_minutes_range_to_seconds
	pop	a
	jra	00105$
;	main.c: 160: default: interval_s = 0; break;
00104$:
	clrw	x
	clrw	y
;	main.c: 161: }
00105$:
;	main.c: 162: next_on_time_s = uptime_s + interval_s;
	addw	x, _uptime_s+2
	ld	a, yl
	adc	a, _uptime_s+1
	rlwa	y
	adc	a, _uptime_s+0
	ld	yh, a
	ldw	_next_on_time_s+2, x
	ldw	_next_on_time_s+0, y
;	main.c: 163: }
	ret
;	main.c: 166: static void clock_init(void) {
;	-----------------------------------------
;	 function clock_init
;	-----------------------------------------
_clock_init:
;	main.c: 167: CLK_HSIPrescalerConfig(CLK_PRESCALER_HSIDIV1);
	clr	a
	call	_CLK_HSIPrescalerConfig
;	main.c: 168: CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER4, ENABLE);
	push	#0x01
	ld	a, #0x04
	call	_CLK_PeripheralClockConfig
;	main.c: 169: }
	ret
;	main.c: 171: static void gpio_init(void) {
;	-----------------------------------------
;	 function gpio_init
;	-----------------------------------------
_gpio_init:
;	main.c: 173: GPIO_DeInit(FAN_PORT);
	ldw	x, #0x500f
	call	_GPIO_DeInit
;	main.c: 174: GPIO_Init(FAN_PORT, FAN_PIN, GPIO_MODE_OUT_PP_LOW_FAST);
	push	#0xe0
	ld	a, #0x10
	ldw	x, #0x500f
	call	_GPIO_Init
;	main.c: 177: GPIO_DeInit(LED_R_PORT);
	ldw	x, #0x500a
	call	_GPIO_DeInit
;	main.c: 178: GPIO_Init(LED_R_PORT, LED_R_PIN, GPIO_MODE_OUT_PP_HIGH_FAST);
	push	#0xf0
	ld	a, #0x80
	ldw	x, #0x500a
	call	_GPIO_Init
;	main.c: 179: GPIO_DeInit(LED_G_PORT);
	ldw	x, #0x500a
	call	_GPIO_DeInit
;	main.c: 180: GPIO_Init(LED_G_PORT, LED_G_PIN, GPIO_MODE_OUT_PP_HIGH_FAST);
	push	#0xf0
	ld	a, #0x40
	ldw	x, #0x500a
	call	_GPIO_Init
;	main.c: 181: GPIO_DeInit(LED_B_PORT);
	ldw	x, #0x500a
	call	_GPIO_DeInit
;	main.c: 182: GPIO_Init(LED_B_PORT, LED_B_PIN, GPIO_MODE_OUT_PP_HIGH_FAST);
	push	#0xf0
	ld	a, #0x20
	ldw	x, #0x500a
	call	_GPIO_Init
;	main.c: 185: GPIO_DeInit(BTN_PORT);
	ldw	x, #0x5005
	call	_GPIO_DeInit
;	main.c: 186: GPIO_Init(BTN_PORT, BTN_PIN, GPIO_MODE_IN_PU_NO_IT);
	push	#0x40
	ld	a, #0x10
	ldw	x, #0x5005
	call	_GPIO_Init
;	main.c: 187: }
	ret
;	main.c: 189: static void tim4_init_1ms(void) {
;	-----------------------------------------
;	 function tim4_init_1ms
;	-----------------------------------------
_tim4_init_1ms:
;	main.c: 191: TIM4_TimeBaseInit(TIM4_PRESCALER_128, 125 - 1);
	push	#0x7c
	ld	a, #0x07
	call	_TIM4_TimeBaseInit
;	main.c: 192: TIM4_SetCounter(0);
	clr	a
	call	_TIM4_SetCounter
;	main.c: 193: TIM4_ClearFlag(TIM4_FLAG_UPDATE);
	ld	a, #0x01
	call	_TIM4_ClearFlag
;	main.c: 194: TIM4_Cmd(ENABLE);
	ld	a, #0x01
;	main.c: 195: }
	jp	_TIM4_Cmd
;	main.c: 197: static void wwdg_init(void) {
;	-----------------------------------------
;	 function wwdg_init
;	-----------------------------------------
_wwdg_init:
;	main.c: 198: WWDG_Init(WWDG_START_COUNTER, WWDG_WINDOW);
	push	#0x50
	ld	a, #0x7f
	call	_WWDG_Init
;	main.c: 199: }
	ret
;	main.c: 202: static inline void wwdg_service(void) {
;	-----------------------------------------
;	 function wwdg_service
;	-----------------------------------------
_wwdg_service:
;	main.c: 203: uint8_t c = (uint8_t)(WWDG_GetCounter() & 0x7F);
	call	_WWDG_GetCounter
	and	a, #0x7f
;	main.c: 204: if ((c < WWDG_WINDOW) && (c >= WWDG_REFRESH_FLOOR)) {
	cp	a, #0x50
	jrc	00120$
	ret
00120$:
	cp	a, #0x44
	jrnc	00121$
	ret
00121$:
;	main.c: 205: WWDG_SetCounter(WWDG_START_COUNTER);
	ld	a, #0x7f
;	main.c: 207: }
	jp	_WWDG_SetCounter
;	main.c: 210: static void enter_mode(mode_t m) {
;	-----------------------------------------
;	 function enter_mode
;	-----------------------------------------
_enter_mode:
;	main.c: 213: switch (mode) {
	ld	_mode+0, a
	jreq	00101$
	ld	a, _mode+0
	dec	a
	jreq	00104$
	ld	a, _mode+0
	cp	a, #0x02
	jreq	00104$
	ld	a, _mode+0
	cp	a, #0x03
	jreq	00104$
	ret
;	main.c: 214: case MODE_OFF:
00101$:
;	main.c: 96: static inline void fan_off(void)  { GPIO_WriteLow (FAN_PORT, FAN_PIN);  fan_on = 0; }
	ld	a, #0x10
	ldw	x, #0x500f
	call	_GPIO_WriteLow
	clr	_fan_on+0
;	main.c: 216: led_off_all();
;	main.c: 217: break;
	jp	_led_off_all
;	main.c: 221: case MODE_HIGH:
00104$:
;	main.c: 223: led_set_for_mode(mode);
	ld	a, _mode+0
	call	_led_set_for_mode
;	main.c: 96: static inline void fan_off(void)  { GPIO_WriteLow (FAN_PORT, FAN_PIN);  fan_on = 0; }
	ld	a, #0x10
	ldw	x, #0x500f
	call	_GPIO_WriteLow
	clr	_fan_on+0
;	main.c: 225: schedule_next_interval();
;	main.c: 227: }
;	main.c: 228: }
	jp	_schedule_next_interval
;	main.c: 231: static void advance_mode(void) {
;	-----------------------------------------
;	 function advance_mode
;	-----------------------------------------
_advance_mode:
;	main.c: 232: switch (mode) {
	ld	a, _mode+0
	jreq	00101$
	ld	a, _mode+0
	dec	a
	jreq	00102$
	ld	a, _mode+0
	cp	a, #0x02
	jreq	00103$
	ld	a, _mode+0
	cp	a, #0x03
	jreq	00104$
	ret
;	main.c: 233: case MODE_OFF:  enter_mode(MODE_ECO);  break;
00101$:
	ld	a, #0x01
	jp	_enter_mode
;	main.c: 234: case MODE_ECO:  enter_mode(MODE_MID);  break;
00102$:
	ld	a, #0x02
	jp	_enter_mode
;	main.c: 235: case MODE_MID:  enter_mode(MODE_HIGH); break;
00103$:
	ld	a, #0x03
	jp	_enter_mode
;	main.c: 236: case MODE_HIGH: enter_mode(MODE_OFF);  break;
00104$:
	clr	a
;	main.c: 237: }
;	main.c: 238: }
	jp	_enter_mode
;	main.c: 241: int main(void) {
;	-----------------------------------------
;	 function main
;	-----------------------------------------
_main:
	sub	sp, #4
;	main.c: 242: clock_init();
	call	_clock_init
;	main.c: 243: gpio_init();
	call	_gpio_init
;	main.c: 244: tim4_init_1ms();
	call	_tim4_init_1ms
;	main.c: 245: wwdg_init();
	call	_wwdg_init
;	main.c: 248: enter_mode(MODE_OFF);
	clr	a
	call	_enter_mode
;	main.c: 251: lfsr ^= (uint16_t)TIM4->CNTR;
	ld	a, 0x5346
	xor	a, _lfsr+1
	ld	xl, a
	clr	a
	xor	a, _lfsr+0
	ld	xh, a
	ldw	_lfsr+0, x
;	main.c: 253: uint32_t last_ms = 0;
	clrw	x
	ldw	(0x03, sp), x
	ldw	(0x01, sp), x
00137$:
;	main.c: 70: if (TIM4_GetFlagStatus(TIM4_FLAG_UPDATE) != RESET) {
	ld	a, #0x01
	call	_TIM4_GetFlagStatus
	tnz	a
	jreq	00129$
;	main.c: 71: TIM4_ClearFlag(TIM4_FLAG_UPDATE);
	ld	a, #0x01
	call	_TIM4_ClearFlag
;	main.c: 72: uptime_ms++;
	ldw	x, _uptime_ms+2
	ldw	y, _uptime_ms+0
	incw	x
	jrne	00247$
	incw	y
00247$:
	ldw	_uptime_ms+2, x
	ldw	_uptime_ms+0, y
;	main.c: 73: if ((uptime_ms % MS_PER_SEC) == 0u) {
	push	#0xe8
	push	#0x03
	clrw	x
	pushw	x
	push	_uptime_ms+3
	push	_uptime_ms+2
	push	_uptime_ms+1
	push	_uptime_ms+0
	call	__modulong
	addw	sp, #8
	tnzw	x
	jrne	00129$
	tnzw	y
	jrne	00129$
;	main.c: 74: uptime_s++;
	ldw	x, _uptime_s+2
	ldw	y, _uptime_s+0
	incw	x
	jrne	00250$
	incw	y
00250$:
	ldw	_uptime_s+2, x
	ldw	_uptime_s+0, y
;	main.c: 257: tick_1ms_poll();
00129$:
;	main.c: 260: if (uptime_ms != last_ms) {
	ldw	x, (0x03, sp)
	cpw	x, _uptime_ms+2
	jrne	00252$
	ldw	x, (0x01, sp)
	cpw	x, _uptime_ms+0
	jrne	00252$
	jp	00123$
00252$:
;	main.c: 261: last_ms = uptime_ms;
	ldw	x, _uptime_ms+2
	ldw	(0x03, sp), x
	ldw	x, _uptime_ms+0
	ldw	(0x01, sp), x
;	main.c: 264: button_update_1ms();
	call	_button_update_1ms
;	main.c: 267: if (btn.long_event) {
	ld	a, _btn+10
	jreq	00104$
;	main.c: 268: btn.long_event = 0u;
	mov	_btn+10, #0x00
;	main.c: 269: enter_mode(MODE_OFF);                 /* Long press => OFF */
	clr	a
	call	_enter_mode
	jra	00105$
00104$:
;	main.c: 270: } else if (btn.short_event) {
	ld	a, _btn+9
	jreq	00105$
;	main.c: 271: btn.short_event = 0u;
	mov	_btn+9, #0x00
;	main.c: 272: advance_mode();                        /* Short press => next mode, LED updates immediately */
	call	_advance_mode
00105$:
;	main.c: 276: if ((uptime_ms % MS_PER_SEC) == 0u) {
	push	#0xe8
	push	#0x03
	clrw	x
	pushw	x
	push	_uptime_ms+3
	push	_uptime_ms+2
	push	_uptime_ms+1
	push	_uptime_ms+0
	call	__modulong
	addw	sp, #8
	tnzw	x
	jrne	00256$
	tnzw	y
	jreq	00257$
00256$:
	jp	00123$
00257$:
;	main.c: 277: if (mode == MODE_ECO || mode == MODE_MID || mode == MODE_HIGH) {
	ld	a, _mode+0
	dec	a
	jreq	00115$
	ld	a, _mode+0
	cp	a, #0x02
	jreq	00115$
	ld	a, _mode+0
	cp	a, #0x03
	jrne	00116$
00115$:
;	main.c: 278: if (fan_on) {
	ld	a, _fan_on+0
	jreq	00111$
;	main.c: 280: if ((uptime_s - fan_on_started_s) >= FAN_ON_DURATION_S) {
	ldw	x, _uptime_s+2
	subw	x, _fan_on_started_s+2
	ld	a, _uptime_s+1
	sbc	a, _fan_on_started_s+1
	ld	yl, a
	ld	a, _uptime_s+0
	sbc	a, _fan_on_started_s+0
	push	a
	cpw	x, #0x012c
	ld	a, yl
	sbc	a, #0x00
	pop	a
	sbc	a, #0x00
	jrc	00123$
;	main.c: 96: static inline void fan_off(void)  { GPIO_WriteLow (FAN_PORT, FAN_PIN);  fan_on = 0; }
	ld	a, #0x10
	ldw	x, #0x500f
	call	_GPIO_WriteLow
	clr	_fan_on+0
;	main.c: 282: schedule_next_interval();        /* pick new jitter for the next interval */
	call	_schedule_next_interval
	jra	00123$
00111$:
;	main.c: 286: if (uptime_s >= next_on_time_s) {
	ldw	x, _uptime_s+2
	cpw	x, _next_on_time_s+2
	ld	a, _uptime_s+1
	sbc	a, _next_on_time_s+1
	ld	a, _uptime_s+0
	sbc	a, _next_on_time_s+0
	jrc	00123$
;	main.c: 97: static inline void fan_on_fn(void){ GPIO_WriteHigh(FAN_PORT, FAN_PIN);  fan_on = 1; fan_on_started_s = uptime_s; }
	ld	a, #0x10
	ldw	x, #0x500f
	call	_GPIO_WriteHigh
	mov	_fan_on+0, #0x01
	ldw	x, _uptime_s+2
	ldw	y, _uptime_s+0
	ldw	_fan_on_started_s+2, x
	ldw	_fan_on_started_s+0, y
;	main.c: 287: fan_on_fn();
	jra	00123$
00116$:
;	main.c: 292: if (fan_on) fan_off();
	ld	a, _fan_on+0
	jreq	00123$
;	main.c: 96: static inline void fan_off(void)  { GPIO_WriteLow (FAN_PORT, FAN_PIN);  fan_on = 0; }
	ld	a, #0x10
	ldw	x, #0x500f
	call	_GPIO_WriteLow
	clr	_fan_on+0
;	main.c: 292: if (fan_on) fan_off();
00123$:
;	main.c: 203: uint8_t c = (uint8_t)(WWDG_GetCounter() & 0x7F);
	call	_WWDG_GetCounter
	and	a, #0x7f
;	main.c: 204: if ((c < WWDG_WINDOW) && (c >= WWDG_REFRESH_FLOOR)) {
	cp	a, #0x50
	jrc	00271$
	jp	00137$
00271$:
	cp	a, #0x44
	jrnc	00272$
	jp	00137$
00272$:
;	main.c: 205: WWDG_SetCounter(WWDG_START_COUNTER);
	ld	a, #0x7f
	call	_WWDG_SetCounter
;	main.c: 298: wwdg_service();
;	main.c: 300: }
	jp	00137$
	.area CODE
	.area CONST
	.area INITIALIZER
__xinit__uptime_ms:
	.byte #0x00, #0x00, #0x00, #0x00	; 0
__xinit__uptime_s:
	.byte #0x00, #0x00, #0x00, #0x00	; 0
__xinit__btn:
	.db #0x01	; 1
	.db #0x01	; 1
	.dw #0x0000
	.db #0x00	; 0
	.byte #0x00, #0x00, #0x00, #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
__xinit__mode:
	.db #0x00	; 0
__xinit__fan_on:
	.db #0x00	; 0
__xinit__fan_on_started_s:
	.byte #0x00, #0x00, #0x00, #0x00	; 0
__xinit__next_on_time_s:
	.byte #0x00, #0x00, #0x00, #0x00	; 0
__xinit__lfsr:
	.dw #0xace1
	.area CABS (ABS)
