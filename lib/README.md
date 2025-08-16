---

# STM8S Fan Controller (STM8S003F3P6)

Firmware for an STM8S003F3P6 board that controls a **5 V fan** (via PD4 & a 2N7002 low-side MOSFET) and a **common-anode RGB LED** (PC5/6/7), using a **single push-button** (PB4).
No interrupts are used; everything is **polled** with a **TIM4 1 ms** timebase. A **window watchdog (WWDG)** is enabled and refreshed **only inside the allowed window**.

---

## Hardware Pin Map (must match your board)

* **Fan MOSFET gate**: `PD4` (ON = **HIGH**) through \~100 Ω to a 2N7002AQ gate
  MOSFET **S**→GND, **D**→FAN–, FAN+→+5 V
* **RGB LED (common-anode @3.3 V; ON = drive pin LOW)**

  * **Blue**: `PC5`
  * **Green**: `PC6`
  * **Red**: `PC7`
* **Button**: `PB4` with \~10 k pull-up to 3.3 V, **active LOW** to GND
* **Programming** (ST-LINK, SWIM): VDD, GND, **SWIM**, **NRST**

> If your board wiring differs, change the `#define`s in `main.c`.

---

## Firmware Behavior

Modes (short-press cycles): **OFF → ECO → MID → HIGH → OFF → …**

* **OFF**: LED off; fan off.
* **ECO** (Green): fan ON **5 min** every **70–80 min** (random per interval).
* **MID** (Blue): fan ON **5 min** every **55–65 min**.
* **HIGH** (Red): fan ON **5 min** every **40–50 min**.

Button logic:

* **Short press** (< 1 s): advance to next mode; LED updates immediately.
* **Long press** (≥ 2 s): force **OFF** from any state.
* **Debounce**: 20 ms, non-blocking.

Timing:

* `TIM4` provides a **1 ms** tick; we derive a **1 s** scheduler counter.
* Jitter is provided by a tiny 16-bit **LFSR** (non-crypto PRNG).

Watchdog:

* **WWDG** is started with `Start=0x7F`, `Window=0x50`.
* Firmware **refreshes only when** `0x44 ≤ counter < 0x50` (too-early or too-late causes reset).

---

## Toolchain Options

You can use **either** ST’s STVP GUI **or** CLI flashing with `stm8flash`. The project builds with **SDCC**.

### Option A — Windows (Recommended: MSYS2 MinGW 64-bit)

1. **Install MSYS2**
   Download from [https://www.msys2.org/](https://www.msys2.org/) and open **MSYS2 MinGW 64-bit** (not PowerShell).

2. **Update & install packages**

```bash
pacman -Syu             # let it restart if asked
pacman -Su
pacman -S make git mingw-w64-x86_64-sdcc mingw-w64-x86_64-gcc
```

3. **stm8flash (for ST-LINK CLI flashing)**

```bash
pacman -S stm8flash     # if available in your repo
# If not available:
git clone https://github.com/vdudouyt/stm8flash.git
cd stm8flash && make && make install
```

> If you prefer ST’s GUI, install **ST Visual Programmer (STVP)** and use ST-LINK there.

### Option B — PowerShell with Chocolatey (no MSYS2)

```powershell
choco install make
choco install sdcc
# For CLI flashing:
choco install git
git clone https://github.com/vdudouyt/stm8flash.git
# build stm8flash with mingw or use prebuilt binary if available
```

### Option C — WSL / Linux

```bash
sudo apt update
sudo apt install make sdcc git
# stm8flash:
sudo apt install stm8flash || (git clone https://github.com/vdudouyt/stm8flash && cd stm8flash && make && sudo make install)
```

---

## Project Layout

```
.
├─ main.c                       # the polling state machine + WWDG
├─ Makefile                     # SDCC + make build
└─ lib/
   ├─ inc/                      # headers (stm8s.h, etc.)
   └─ src/                      # SPL sources you include:
      ├─ stm8s_clk.c
      ├─ stm8s_gpio.c
      ├─ stm8s_tim4.c
      └─ stm8s_wwdg.c
```

**Makefile** must compile with:

```
-DSTM8S003 -DUSE_STDPERIPH_DRIVER -I. -Ilib/inc
```

and link the SPL sources above.

---

## Build

> **Use the MSYS2 MinGW 64-bit terminal** (or your chosen environment where `make` exists).

```bash
cd /d/your/path/to/project   # MSYS2 path style for D:\
make
```

Outputs:

* `obj/*.rel` — object files
* `FanCtrl.ihx` — Intel HEX
* `FanCtrl.hex` — final HEX (via `packihx`)

Clean:

```bash
make clean
```

---

## Flashing

### A) CLI (stm8flash + ST-LINK)

```bash
stm8flash -c stlinkv2 -p stm8s003f3 -w FanCtrl.hex
```

### B) GUI (STVP + ST-LINK)

1. Open **ST Visual Programmer**.
2. Select device **STM8S003F3** and your **ST-LINK**.
3. Load `FanCtrl.hex` and **Program**.
4. Ensure SWIM connector orientation and pins: **VDD, GND, SWIM, NRST**.

---

## First Power-Up / Acceptance Checklist

1. Power up: **LED OFF, fan OFF** (MODE\_OFF).
2. **Short press**:

   * Mode **ECO** (Green) — fan first ON after a random **70–80 min**, ON for **5 min**.
   * Next short press: **MID** (Blue) — **55–65 min** intervals, **5 min** ON.
   * Next: **HIGH** (Red) — **40–50 min** intervals, **5 min** ON.
   * Next: **OFF** — LED/fan OFF indefinitely.
3. **Long press** (≥ 2 s) from any state → **OFF**.

---

## Troubleshooting

**“make: command not found”**
You’re in PowerShell/CMD without `make`. Use **MSYS2 MinGW 64-bit** or install `make` via Chocolatey.

**“cannot find stm8s.h”**
Check include path: your compile command must have `-Ilib/inc` (and `-I.`). Ensure you’re in the repo root and `lib/inc/stm8s.h` exists.

**Board doesn’t respond / resets frequently**

* Ensure your build includes `stm8s_wwdg.c`, and the main loop calls `wwdg_service()` regularly.
* If option bytes enable **IWDG** by default on your MCU, either configure it or disable in option bytes; this project uses **WWDG**.

**LED inverted**
These pins assume **common-anode** LED: driving pin **LOW** turns that color **ON**. If your LED is wired differently, invert in `led_set_for_mode()`.

**Fan always ON/OFF**
Check PD4 gate resistor (\~100 Ω), MOSFET orientation, and that the fan negative lead is on the MOSFET drain.

---

## Notes

* The PRNG (LFSR) is used **only** to pick the next interval within each mode’s window; it’s deterministic and lightweight (not for security).
* The implementation is **fully non-blocking**: button debounce and scheduling run from the polled 1 ms tick; no interrupts are required.

---