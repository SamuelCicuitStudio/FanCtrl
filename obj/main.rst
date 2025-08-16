                                      1 ;--------------------------------------------------------
                                      2 ; File Created by SDCC : free open source ISO C Compiler
                                      3 ; Version 4.5.0 #15242 (MINGW64)
                                      4 ;--------------------------------------------------------
                                      5 	.module main
                                      6 	
                                      7 ;--------------------------------------------------------
                                      8 ; Public variables in this module
                                      9 ;--------------------------------------------------------
                                     10 	.globl _main
                                     11 	.globl _WWDG_GetCounter
                                     12 	.globl _WWDG_SetCounter
                                     13 	.globl _WWDG_Init
                                     14 	.globl _TIM4_ClearFlag
                                     15 	.globl _TIM4_GetFlagStatus
                                     16 	.globl _TIM4_SetCounter
                                     17 	.globl _TIM4_Cmd
                                     18 	.globl _TIM4_TimeBaseInit
                                     19 	.globl _GPIO_ReadInputPin
                                     20 	.globl _GPIO_WriteLow
                                     21 	.globl _GPIO_WriteHigh
                                     22 	.globl _GPIO_Init
                                     23 	.globl _GPIO_DeInit
                                     24 	.globl _CLK_HSIPrescalerConfig
                                     25 	.globl _CLK_PeripheralClockConfig
                                     26 ;--------------------------------------------------------
                                     27 ; ram data
                                     28 ;--------------------------------------------------------
                                     29 	.area DATA
                                     30 ;--------------------------------------------------------
                                     31 ; ram data
                                     32 ;--------------------------------------------------------
                                     33 	.area INITIALIZED
      000001                         34 _uptime_ms:
      000001                         35 	.ds 4
      000005                         36 _uptime_s:
      000005                         37 	.ds 4
      000009                         38 _btn:
      000009                         39 	.ds 11
      000014                         40 _mode:
      000014                         41 	.ds 1
      000015                         42 _fan_on:
      000015                         43 	.ds 1
      000016                         44 _fan_on_started_s:
      000016                         45 	.ds 4
      00001A                         46 _next_on_time_s:
      00001A                         47 	.ds 4
      00001E                         48 _lfsr:
      00001E                         49 	.ds 2
                                     50 ;--------------------------------------------------------
                                     51 ; Stack segment in internal ram
                                     52 ;--------------------------------------------------------
                                     53 	.area SSEG
      000020                         54 __start__stack:
      000020                         55 	.ds	1
                                     56 
                                     57 ;--------------------------------------------------------
                                     58 ; absolute external ram data
                                     59 ;--------------------------------------------------------
                                     60 	.area DABS (ABS)
                                     61 
                                     62 ; default segment ordering for linker
                                     63 	.area HOME
                                     64 	.area GSINIT
                                     65 	.area GSFINAL
                                     66 	.area CONST
                                     67 	.area INITIALIZER
                                     68 	.area CODE
                                     69 
                                     70 ;--------------------------------------------------------
                                     71 ; interrupt vector
                                     72 ;--------------------------------------------------------
                                     73 	.area HOME
      008000                         74 __interrupt_vect:
      008000 82 00 80 07             75 	int s_GSINIT ; reset
                                     76 ;--------------------------------------------------------
                                     77 ; global & static initialisations
                                     78 ;--------------------------------------------------------
                                     79 	.area HOME
                                     80 	.area GSINIT
                                     81 	.area GSFINAL
                                     82 	.area GSINIT
      008007 CD 8B 48         [ 4]   83 	call	___sdcc_external_startup
      00800A 4D               [ 1]   84 	tnz	a
      00800B 27 03            [ 1]   85 	jreq	__sdcc_init_data
      00800D CC 80 04         [ 2]   86 	jp	__sdcc_program_startup
      008010                         87 __sdcc_init_data:
                                     88 ; stm8_genXINIT() start
      008010 AE 00 00         [ 2]   89 	ldw x, #l_DATA
      008013 27 07            [ 1]   90 	jreq	00002$
      008015                         91 00001$:
      008015 72 4F 00 00      [ 1]   92 	clr (s_DATA - 1, x)
      008019 5A               [ 2]   93 	decw x
      00801A 26 F9            [ 1]   94 	jrne	00001$
      00801C                         95 00002$:
      00801C AE 00 1F         [ 2]   96 	ldw	x, #l_INITIALIZER
      00801F 27 09            [ 1]   97 	jreq	00004$
      008021                         98 00003$:
      008021 D6 80 38         [ 1]   99 	ld	a, (s_INITIALIZER - 1, x)
      008024 D7 00 00         [ 1]  100 	ld	(s_INITIALIZED - 1, x), a
      008027 5A               [ 2]  101 	decw	x
      008028 26 F7            [ 1]  102 	jrne	00003$
      00802A                        103 00004$:
                                    104 ; stm8_genXINIT() end
                                    105 	.area GSFINAL
      00802A CC 80 04         [ 2]  106 	jp	__sdcc_program_startup
                                    107 ;--------------------------------------------------------
                                    108 ; Home
                                    109 ;--------------------------------------------------------
                                    110 	.area HOME
                                    111 	.area HOME
      008004                        112 __sdcc_program_startup:
      008004 CC 83 D6         [ 2]  113 	jp	_main
                                    114 ;	return from main will return to caller
                                    115 ;--------------------------------------------------------
                                    116 ; code
                                    117 ;--------------------------------------------------------
                                    118 	.area CODE
                                    119 ;	main.c: 69: static inline void tick_1ms_poll(void) {
                                    120 ;	-----------------------------------------
                                    121 ;	 function tick_1ms_poll
                                    122 ;	-----------------------------------------
      008058                        123 _tick_1ms_poll:
                                    124 ;	main.c: 70: if (TIM4_GetFlagStatus(TIM4_FLAG_UPDATE) != RESET) {
      008058 A6 01            [ 1]  125 	ld	a, #0x01
      00805A CD 86 FD         [ 4]  126 	call	_TIM4_GetFlagStatus
      00805D 4D               [ 1]  127 	tnz	a
      00805E 26 01            [ 1]  128 	jrne	00121$
      008060 81               [ 4]  129 	ret
      008061                        130 00121$:
                                    131 ;	main.c: 71: TIM4_ClearFlag(TIM4_FLAG_UPDATE);
      008061 A6 01            [ 1]  132 	ld	a, #0x01
      008063 CD 87 0D         [ 4]  133 	call	_TIM4_ClearFlag
                                    134 ;	main.c: 72: uptime_ms++;
      008066 CE 00 03         [ 2]  135 	ldw	x, _uptime_ms+2
      008069 90 CE 00 01      [ 2]  136 	ldw	y, _uptime_ms+0
      00806D 5C               [ 1]  137 	incw	x
      00806E 26 02            [ 1]  138 	jrne	00122$
      008070 90 5C            [ 1]  139 	incw	y
      008072                        140 00122$:
      008072 CF 00 03         [ 2]  141 	ldw	_uptime_ms+2, x
      008075 90 CF 00 01      [ 2]  142 	ldw	_uptime_ms+0, y
                                    143 ;	main.c: 73: if ((uptime_ms % MS_PER_SEC) == 0u) {
      008079 4B E8            [ 1]  144 	push	#0xe8
      00807B 4B 03            [ 1]  145 	push	#0x03
      00807D 5F               [ 1]  146 	clrw	x
      00807E 89               [ 2]  147 	pushw	x
      00807F 3B 00 04         [ 1]  148 	push	_uptime_ms+3
      008082 3B 00 03         [ 1]  149 	push	_uptime_ms+2
      008085 3B 00 02         [ 1]  150 	push	_uptime_ms+1
      008088 3B 00 01         [ 1]  151 	push	_uptime_ms+0
      00808B CD 8A E2         [ 4]  152 	call	__modulong
      00808E 5B 08            [ 2]  153 	addw	sp, #8
      008090 5D               [ 2]  154 	tnzw	x
      008091 26 04            [ 1]  155 	jrne	00123$
      008093 90 5D            [ 2]  156 	tnzw	y
      008095 27 01            [ 1]  157 	jreq	00124$
      008097                        158 00123$:
      008097 81               [ 4]  159 	ret
      008098                        160 00124$:
                                    161 ;	main.c: 74: uptime_s++;
      008098 CE 00 07         [ 2]  162 	ldw	x, _uptime_s+2
      00809B 90 CE 00 05      [ 2]  163 	ldw	y, _uptime_s+0
      00809F 5C               [ 1]  164 	incw	x
      0080A0 26 02            [ 1]  165 	jrne	00125$
      0080A2 90 5C            [ 1]  166 	incw	y
      0080A4                        167 00125$:
      0080A4 CF 00 07         [ 2]  168 	ldw	_uptime_s+2, x
      0080A7 90 CF 00 05      [ 2]  169 	ldw	_uptime_s+0, y
                                    170 ;	main.c: 77: }
      0080AB 81               [ 4]  171 	ret
                                    172 ;	main.c: 80: static inline uint16_t rand16(void) {
                                    173 ;	-----------------------------------------
                                    174 ;	 function rand16
                                    175 ;	-----------------------------------------
      0080AC                        176 _rand16:
      0080AC 52 04            [ 2]  177 	sub	sp, #4
                                    178 ;	main.c: 82: uint16_t lsb = (uint16_t)((lfsr ^ (lfsr >> 2) ^ (lfsr >> 3) ^ (lfsr >> 5)) & 1u);
      0080AE CE 00 1E         [ 2]  179 	ldw	x, _lfsr+0
      0080B1 54               [ 2]  180 	srlw	x
      0080B2 54               [ 2]  181 	srlw	x
      0080B3 9F               [ 1]  182 	ld	a, xl
      0080B4 C8 00 1F         [ 1]  183 	xor	a, _lfsr+1
      0080B7 6B 02            [ 1]  184 	ld	(0x02, sp), a
      0080B9 9E               [ 1]  185 	ld	a, xh
      0080BA C8 00 1E         [ 1]  186 	xor	a, _lfsr+0
      0080BD 6B 01            [ 1]  187 	ld	(0x01, sp), a
      0080BF CE 00 1E         [ 2]  188 	ldw	x, _lfsr+0
      0080C2 54               [ 2]  189 	srlw	x
      0080C3 54               [ 2]  190 	srlw	x
      0080C4 54               [ 2]  191 	srlw	x
      0080C5 9F               [ 1]  192 	ld	a, xl
      0080C6 18 02            [ 1]  193 	xor	a, (0x02, sp)
      0080C8 6B 04            [ 1]  194 	ld	(0x04, sp), a
      0080CA 9E               [ 1]  195 	ld	a, xh
      0080CB 18 01            [ 1]  196 	xor	a, (0x01, sp)
      0080CD 6B 03            [ 1]  197 	ld	(0x03, sp), a
      0080CF CE 00 1E         [ 2]  198 	ldw	x, _lfsr+0
      0080D2 A6 20            [ 1]  199 	ld	a, #0x20
      0080D4 62               [ 2]  200 	div	x, a
      0080D5 9F               [ 1]  201 	ld	a, xl
      0080D6 18 04            [ 1]  202 	xor	a, (0x04, sp)
      0080D8 97               [ 1]  203 	ld	xl, a
      0080D9 9E               [ 1]  204 	ld	a, xh
      0080DA 18 03            [ 1]  205 	xor	a, (0x03, sp)
      0080DC 9F               [ 1]  206 	ld	a, xl
      0080DD A4 01            [ 1]  207 	and	a, #0x01
      0080DF 97               [ 1]  208 	ld	xl, a
                                    209 ;	main.c: 83: lfsr = (uint16_t)((lfsr >> 1) | (lsb << 15));
      0080E0 90 CE 00 1E      [ 2]  210 	ldw	y, _lfsr+0
      0080E4 90 54            [ 2]  211 	srlw	y
      0080E6 9F               [ 1]  212 	ld	a, xl
      0080E7 5F               [ 1]  213 	clrw	x
      0080E8 44               [ 1]  214 	srl	a
      0080E9 56               [ 2]  215 	rrcw	x
      0080EA 1F 03            [ 2]  216 	ldw	(0x03, sp), x
      0080EC 90 9E            [ 1]  217 	ld	a, yh
      0080EE 1A 03            [ 1]  218 	or	a, (0x03, sp)
      0080F0 90 95            [ 1]  219 	ld	yh, a
      0080F2 90 CF 00 1E      [ 2]  220 	ldw	_lfsr+0, y
                                    221 ;	main.c: 84: return lfsr;
      0080F6 CE 00 1E         [ 2]  222 	ldw	x, _lfsr+0
                                    223 ;	main.c: 85: }
      0080F9 5B 04            [ 2]  224 	addw	sp, #4
      0080FB 81               [ 4]  225 	ret
                                    226 ;	main.c: 88: static uint32_t rand_minutes_range_to_seconds(uint8_t min_min, uint8_t max_min) {
                                    227 ;	-----------------------------------------
                                    228 ;	 function rand_minutes_range_to_seconds
                                    229 ;	-----------------------------------------
      0080FC                        230 _rand_minutes_range_to_seconds:
      0080FC 52 06            [ 2]  231 	sub	sp, #6
      0080FE 6B 06            [ 1]  232 	ld	(0x06, sp), a
                                    233 ;	main.c: 89: uint8_t span = (uint8_t)(max_min - min_min + 1u);
      008100 7B 09            [ 1]  234 	ld	a, (0x09, sp)
      008102 10 06            [ 1]  235 	sub	a, (0x06, sp)
      008104 4C               [ 1]  236 	inc	a
      008105 6B 01            [ 1]  237 	ld	(0x01, sp), a
                                    238 ;	main.c: 82: uint16_t lsb = (uint16_t)((lfsr ^ (lfsr >> 2) ^ (lfsr >> 3) ^ (lfsr >> 5)) & 1u);
      008107 CE 00 1E         [ 2]  239 	ldw	x, _lfsr+0
      00810A 54               [ 2]  240 	srlw	x
      00810B 54               [ 2]  241 	srlw	x
      00810C 9F               [ 1]  242 	ld	a, xl
      00810D C8 00 1F         [ 1]  243 	xor	a, _lfsr+1
      008110 6B 03            [ 1]  244 	ld	(0x03, sp), a
      008112 9E               [ 1]  245 	ld	a, xh
      008113 C8 00 1E         [ 1]  246 	xor	a, _lfsr+0
      008116 6B 02            [ 1]  247 	ld	(0x02, sp), a
      008118 CE 00 1E         [ 2]  248 	ldw	x, _lfsr+0
      00811B 54               [ 2]  249 	srlw	x
      00811C 54               [ 2]  250 	srlw	x
      00811D 54               [ 2]  251 	srlw	x
      00811E 9F               [ 1]  252 	ld	a, xl
      00811F 18 03            [ 1]  253 	xor	a, (0x03, sp)
      008121 6B 05            [ 1]  254 	ld	(0x05, sp), a
      008123 9E               [ 1]  255 	ld	a, xh
      008124 18 02            [ 1]  256 	xor	a, (0x02, sp)
      008126 6B 04            [ 1]  257 	ld	(0x04, sp), a
      008128 CE 00 1E         [ 2]  258 	ldw	x, _lfsr+0
      00812B A6 20            [ 1]  259 	ld	a, #0x20
      00812D 62               [ 2]  260 	div	x, a
      00812E 9F               [ 1]  261 	ld	a, xl
      00812F 18 05            [ 1]  262 	xor	a, (0x05, sp)
      008131 97               [ 1]  263 	ld	xl, a
      008132 9E               [ 1]  264 	ld	a, xh
      008133 18 04            [ 1]  265 	xor	a, (0x04, sp)
      008135 9F               [ 1]  266 	ld	a, xl
      008136 A4 01            [ 1]  267 	and	a, #0x01
      008138 97               [ 1]  268 	ld	xl, a
                                    269 ;	main.c: 90: uint8_t r = (uint8_t)(rand16() % span);
      008139 90 CE 00 1E      [ 2]  270 	ldw	y, _lfsr+0
      00813D 90 54            [ 2]  271 	srlw	y
      00813F 9F               [ 1]  272 	ld	a, xl
      008140 5F               [ 1]  273 	clrw	x
      008141 44               [ 1]  274 	srl	a
      008142 56               [ 2]  275 	rrcw	x
      008143 1F 04            [ 2]  276 	ldw	(0x04, sp), x
      008145 90 9E            [ 1]  277 	ld	a, yh
      008147 1A 04            [ 1]  278 	or	a, (0x04, sp)
      008149 90 95            [ 1]  279 	ld	yh, a
      00814B 90 CF 00 1E      [ 2]  280 	ldw	_lfsr+0, y
      00814F CE 00 1E         [ 2]  281 	ldw	x, _lfsr+0
      008152 7B 01            [ 1]  282 	ld	a, (0x01, sp)
      008154 90 5F            [ 1]  283 	clrw	y
      008156 90 97            [ 1]  284 	ld	yl, a
      008158 65               [ 2]  285 	divw	x, y
      008159 93               [ 1]  286 	ldw	x, y
                                    287 ;	main.c: 91: uint8_t minutes = (uint8_t)(min_min + r);
      00815A 72 FB 05         [ 2]  288 	addw	x, (5, sp)
                                    289 ;	main.c: 92: return (uint32_t)minutes * 60u;
      00815D A6 3C            [ 1]  290 	ld	a, #0x3c
      00815F 42               [ 4]  291 	mul	x, a
      008160 90 5F            [ 1]  292 	clrw	y
                                    293 ;	main.c: 93: }
      008162 5B 06            [ 2]  294 	addw	sp, #6
      008164 81               [ 4]  295 	ret
                                    296 ;	main.c: 96: static inline void fan_off(void)  { GPIO_WriteLow (FAN_PORT, FAN_PIN);  fan_on = 0; }
                                    297 ;	-----------------------------------------
                                    298 ;	 function fan_off
                                    299 ;	-----------------------------------------
      008165                        300 _fan_off:
      008165 A6 10            [ 1]  301 	ld	a, #0x10
      008167 AE 50 0F         [ 2]  302 	ldw	x, #0x500f
      00816A CD 85 E2         [ 4]  303 	call	_GPIO_WriteLow
      00816D 72 5F 00 15      [ 1]  304 	clr	_fan_on+0
      008171 81               [ 4]  305 	ret
                                    306 ;	main.c: 97: static inline void fan_on_fn(void){ GPIO_WriteHigh(FAN_PORT, FAN_PIN);  fan_on = 1; fan_on_started_s = uptime_s; }
                                    307 ;	-----------------------------------------
                                    308 ;	 function fan_on_fn
                                    309 ;	-----------------------------------------
      008172                        310 _fan_on_fn:
      008172 A6 10            [ 1]  311 	ld	a, #0x10
      008174 AE 50 0F         [ 2]  312 	ldw	x, #0x500f
      008177 CD 85 D9         [ 4]  313 	call	_GPIO_WriteHigh
      00817A 35 01 00 15      [ 1]  314 	mov	_fan_on+0, #0x01
      00817E CE 00 07         [ 2]  315 	ldw	x, _uptime_s+2
      008181 90 CE 00 05      [ 2]  316 	ldw	y, _uptime_s+0
      008185 CF 00 18         [ 2]  317 	ldw	_fan_on_started_s+2, x
      008188 90 CF 00 16      [ 2]  318 	ldw	_fan_on_started_s+0, y
      00818C 81               [ 4]  319 	ret
                                    320 ;	main.c: 100: static void led_off_all(void) {
                                    321 ;	-----------------------------------------
                                    322 ;	 function led_off_all
                                    323 ;	-----------------------------------------
      00818D                        324 _led_off_all:
                                    325 ;	main.c: 101: GPIO_WriteHigh(LED_R_PORT, LED_R_PIN);
      00818D A6 80            [ 1]  326 	ld	a, #0x80
      00818F AE 50 0A         [ 2]  327 	ldw	x, #0x500a
      008192 CD 85 D9         [ 4]  328 	call	_GPIO_WriteHigh
                                    329 ;	main.c: 102: GPIO_WriteHigh(LED_G_PORT, LED_G_PIN);
      008195 A6 40            [ 1]  330 	ld	a, #0x40
      008197 AE 50 0A         [ 2]  331 	ldw	x, #0x500a
      00819A CD 85 D9         [ 4]  332 	call	_GPIO_WriteHigh
                                    333 ;	main.c: 103: GPIO_WriteHigh(LED_B_PORT, LED_B_PIN);
      00819D A6 20            [ 1]  334 	ld	a, #0x20
      00819F AE 50 0A         [ 2]  335 	ldw	x, #0x500a
                                    336 ;	main.c: 104: }
      0081A2 CC 85 D9         [ 2]  337 	jp	_GPIO_WriteHigh
                                    338 ;	main.c: 106: static void led_set_for_mode(mode_t m) {
                                    339 ;	-----------------------------------------
                                    340 ;	 function led_set_for_mode
                                    341 ;	-----------------------------------------
      0081A5                        342 _led_set_for_mode:
                                    343 ;	main.c: 107: led_off_all();
      0081A5 88               [ 1]  344 	push	a
      0081A6 CD 81 8D         [ 4]  345 	call	_led_off_all
      0081A9 84               [ 1]  346 	pop	a
                                    347 ;	main.c: 108: switch (m) {
      0081AA A1 01            [ 1]  348 	cp	a, #0x01
      0081AC 27 09            [ 1]  349 	jreq	00101$
      0081AE A1 02            [ 1]  350 	cp	a, #0x02
      0081B0 27 0D            [ 1]  351 	jreq	00102$
      0081B2 A1 03            [ 1]  352 	cp	a, #0x03
      0081B4 27 11            [ 1]  353 	jreq	00103$
      0081B6 81               [ 4]  354 	ret
                                    355 ;	main.c: 109: case MODE_ECO:  GPIO_WriteLow(LED_G_PORT, LED_G_PIN); break; /* Green  */
      0081B7                        356 00101$:
      0081B7 A6 40            [ 1]  357 	ld	a, #0x40
      0081B9 AE 50 0A         [ 2]  358 	ldw	x, #0x500a
      0081BC CC 85 E2         [ 2]  359 	jp	_GPIO_WriteLow
                                    360 ;	main.c: 110: case MODE_MID:  GPIO_WriteLow(LED_B_PORT, LED_B_PIN); break; /* Blue   */
      0081BF                        361 00102$:
      0081BF A6 20            [ 1]  362 	ld	a, #0x20
      0081C1 AE 50 0A         [ 2]  363 	ldw	x, #0x500a
      0081C4 CC 85 E2         [ 2]  364 	jp	_GPIO_WriteLow
                                    365 ;	main.c: 111: case MODE_HIGH: GPIO_WriteLow(LED_R_PORT, LED_R_PIN); break; /* Red    */
      0081C7                        366 00103$:
      0081C7 A6 80            [ 1]  367 	ld	a, #0x80
      0081C9 AE 50 0A         [ 2]  368 	ldw	x, #0x500a
                                    369 ;	main.c: 113: }
                                    370 ;	main.c: 114: }
      0081CC CC 85 E2         [ 2]  371 	jp	_GPIO_WriteLow
                                    372 ;	main.c: 117: static inline uint8_t button_raw_level(void) {
                                    373 ;	-----------------------------------------
                                    374 ;	 function button_raw_level
                                    375 ;	-----------------------------------------
      0081CF                        376 _button_raw_level:
                                    377 ;	main.c: 118: return (uint8_t)GPIO_ReadInputPin(BTN_PORT, BTN_PIN) ? 1u : 0u;
      0081CF A6 10            [ 1]  378 	ld	a, #0x10
      0081D1 AE 50 05         [ 2]  379 	ldw	x, #0x5005
      0081D4 CD 85 FC         [ 4]  380 	call	_GPIO_ReadInputPin
      0081D7 4D               [ 1]  381 	tnz	a
      0081D8 27 03            [ 1]  382 	jreq	00103$
      0081DA A6 01            [ 1]  383 	ld	a, #0x01
      0081DC 81               [ 4]  384 	ret
      0081DD                        385 00103$:
      0081DD 4F               [ 1]  386 	clr	a
                                    387 ;	main.c: 119: }
      0081DE 81               [ 4]  388 	ret
                                    389 ;	main.c: 122: static void button_update_1ms(void) {
                                    390 ;	-----------------------------------------
                                    391 ;	 function button_update_1ms
                                    392 ;	-----------------------------------------
      0081DF                        393 _button_update_1ms:
      0081DF 52 04            [ 2]  394 	sub	sp, #4
                                    395 ;	main.c: 123: uint8_t raw = button_raw_level();
      0081E1 A6 10            [ 1]  396 	ld	a, #0x10
      0081E3 AE 50 05         [ 2]  397 	ldw	x, #0x5005
      0081E6 CD 85 FC         [ 4]  398 	call	_GPIO_ReadInputPin
      0081E9 4D               [ 1]  399 	tnz	a
      0081EA 27 03            [ 1]  400 	jreq	00123$
      0081EC A6 01            [ 1]  401 	ld	a, #0x01
      0081EE 21                     402 	.byte 0x21
      0081EF                        403 00123$:
      0081EF 4F               [ 1]  404 	clr	a
      0081F0                        405 00124$:
      0081F0 6B 03            [ 1]  406 	ld	(0x03, sp), a
      0081F2 6B 04            [ 1]  407 	ld	(0x04, sp), a
                                    408 ;	main.c: 125: if (raw == btn.last_sample) {
      0081F4 C6 00 0A         [ 1]  409 	ld	a, _btn+1
                                    410 ;	main.c: 126: if (btn.stable_time_ms < 0xFFFF) btn.stable_time_ms++;
                                    411 ;	main.c: 125: if (raw == btn.last_sample) {
      0081F7 11 03            [ 1]  412 	cp	a, (0x03, sp)
      0081F9 26 11            [ 1]  413 	jrne	00104$
                                    414 ;	main.c: 126: if (btn.stable_time_ms < 0xFFFF) btn.stable_time_ms++;
      0081FB CE 00 0B         [ 2]  415 	ldw	x, _btn+2
      0081FE 90 93            [ 1]  416 	ldw	y, x
      008200 90 A3 FF FF      [ 2]  417 	cpw	y, #0xffff
      008204 24 12            [ 1]  418 	jrnc	00105$
      008206 5C               [ 1]  419 	incw	x
      008207 CF 00 0B         [ 2]  420 	ldw	_btn+2, x
      00820A 20 0C            [ 2]  421 	jra	00105$
      00820C                        422 00104$:
                                    423 ;	main.c: 128: btn.stable_time_ms = 0;
      00820C AE 00 0B         [ 2]  424 	ldw	x, #(_btn+2)
      00820F 6F 01            [ 1]  425 	clr	(0x1, x)
      008211 7F               [ 1]  426 	clr	(x)
                                    427 ;	main.c: 129: btn.last_sample = raw;
      008212 AE 00 0A         [ 2]  428 	ldw	x, #(_btn+1)
      008215 7B 03            [ 1]  429 	ld	a, (0x03, sp)
      008217 F7               [ 1]  430 	ld	(x), a
      008218                        431 00105$:
                                    432 ;	main.c: 132: if (btn.stable_time_ms == DEBOUNCE_MS) {
      008218 CE 00 0B         [ 2]  433 	ldw	x, _btn+2
      00821B A3 00 14         [ 2]  434 	cpw	x, #0x0014
      00821E 26 6B            [ 1]  435 	jrne	00121$
                                    436 ;	main.c: 133: if (raw != btn.stable_level) {
      008220 AE 00 09         [ 2]  437 	ldw	x, #(_btn+0)
      008223 F6               [ 1]  438 	ld	a, (x)
      008224 11 04            [ 1]  439 	cp	a, (0x04, sp)
      008226 27 63            [ 1]  440 	jreq	00121$
                                    441 ;	main.c: 134: btn.stable_level = raw;
      008228 7B 04            [ 1]  442 	ld	a, (0x04, sp)
      00822A F7               [ 1]  443 	ld	(x), a
                                    444 ;	main.c: 137: btn.in_press = 1u;
                                    445 ;	main.c: 138: btn.press_start_ms = uptime_ms;
      00822B AE 00 0E         [ 2]  446 	ldw	x, #(_btn+0)+5
                                    447 ;	main.c: 136: if (raw == 0u) { /* pressed */
      00822E 0D 04            [ 1]  448 	tnz	(0x04, sp)
      008230 26 11            [ 1]  449 	jrne	00114$
                                    450 ;	main.c: 137: btn.in_press = 1u;
      008232 35 01 00 0D      [ 1]  451 	mov	_btn+4, #0x01
                                    452 ;	main.c: 138: btn.press_start_ms = uptime_ms;
      008236 90 CE 00 03      [ 2]  453 	ldw	y, _uptime_ms+2
      00823A EF 02            [ 2]  454 	ldw	(0x2, x), y
      00823C 90 CE 00 01      [ 2]  455 	ldw	y, _uptime_ms+0
      008240 FF               [ 2]  456 	ldw	(x), y
      008241 20 48            [ 2]  457 	jra	00121$
      008243                        458 00114$:
                                    459 ;	main.c: 140: if (btn.in_press) {
      008243 C6 00 0D         [ 1]  460 	ld	a, _btn+4
      008246 27 43            [ 1]  461 	jreq	00121$
                                    462 ;	main.c: 141: uint32_t dur_ms = uptime_ms - btn.press_start_ms;
      008248 90 93            [ 1]  463 	ldw	y, x
      00824A 90 EE 02         [ 2]  464 	ldw	y, (0x2, y)
      00824D 17 03            [ 2]  465 	ldw	(0x03, sp), y
      00824F FE               [ 2]  466 	ldw	x, (x)
      008250 1F 01            [ 2]  467 	ldw	(0x01, sp), x
      008252 90 CE 00 03      [ 2]  468 	ldw	y, _uptime_ms+2
      008256 72 F2 03         [ 2]  469 	subw	y, (0x03, sp)
      008259 C6 00 02         [ 1]  470 	ld	a, _uptime_ms+1
      00825C 12 02            [ 1]  471 	sbc	a, (0x02, sp)
      00825E 97               [ 1]  472 	ld	xl, a
      00825F C6 00 01         [ 1]  473 	ld	a, _uptime_ms+0
      008262 12 01            [ 1]  474 	sbc	a, (0x01, sp)
      008264 95               [ 1]  475 	ld	xh, a
                                    476 ;	main.c: 142: btn.in_press = 0u;
      008265 35 00 00 0D      [ 1]  477 	mov	_btn+4, #0x00
                                    478 ;	main.c: 144: if (dur_ms >= LONG_PRESS_MIN_MS)       btn.long_event  = 1u;
      008269 90 A3 07 D0      [ 2]  479 	cpw	y, #0x07d0
      00826D 9F               [ 1]  480 	ld	a, xl
      00826E A2 00            [ 1]  481 	sbc	a, #0x00
      008270 9E               [ 1]  482 	ld	a, xh
      008271 A2 00            [ 1]  483 	sbc	a, #0x00
      008273 25 06            [ 1]  484 	jrc	00109$
      008275 35 01 00 13      [ 1]  485 	mov	_btn+10, #0x01
      008279 20 10            [ 2]  486 	jra	00121$
      00827B                        487 00109$:
                                    488 ;	main.c: 145: else if (dur_ms <  SHORT_PRESS_MAX_MS) btn.short_event = 1u;
      00827B 90 A3 03 E8      [ 2]  489 	cpw	y, #0x03e8
      00827F 4F               [ 1]  490 	clr	a
      008280 A2 00            [ 1]  491 	sbc	a, #0x00
      008282 4F               [ 1]  492 	clr	a
      008283 A2 00            [ 1]  493 	sbc	a, #0x00
      008285 24 04            [ 1]  494 	jrnc	00121$
      008287 35 01 00 12      [ 1]  495 	mov	_btn+9, #0x01
      00828B                        496 00121$:
                                    497 ;	main.c: 151: }
      00828B 5B 04            [ 2]  498 	addw	sp, #4
      00828D 81               [ 4]  499 	ret
                                    500 ;	main.c: 154: static void schedule_next_interval(void) {
                                    501 ;	-----------------------------------------
                                    502 ;	 function schedule_next_interval
                                    503 ;	-----------------------------------------
      00828E                        504 _schedule_next_interval:
                                    505 ;	main.c: 156: switch (mode) {
      00828E C6 00 14         [ 1]  506 	ld	a, _mode+0
      008291 4A               [ 1]  507 	dec	a
      008292 27 10            [ 1]  508 	jreq	00101$
      008294 C6 00 14         [ 1]  509 	ld	a, _mode+0
      008297 A1 02            [ 1]  510 	cp	a, #0x02
      008299 27 13            [ 1]  511 	jreq	00102$
      00829B C6 00 14         [ 1]  512 	ld	a, _mode+0
      00829E A1 03            [ 1]  513 	cp	a, #0x03
      0082A0 27 16            [ 1]  514 	jreq	00103$
      0082A2 20 1E            [ 2]  515 	jra	00104$
                                    516 ;	main.c: 157: case MODE_ECO:  interval_s = rand_minutes_range_to_seconds(70, 80); break;
      0082A4                        517 00101$:
      0082A4 4B 50            [ 1]  518 	push	#0x50
      0082A6 A6 46            [ 1]  519 	ld	a, #0x46
      0082A8 CD 80 FC         [ 4]  520 	call	_rand_minutes_range_to_seconds
      0082AB 84               [ 1]  521 	pop	a
      0082AC 20 17            [ 2]  522 	jra	00105$
                                    523 ;	main.c: 158: case MODE_MID:  interval_s = rand_minutes_range_to_seconds(55, 65); break;
      0082AE                        524 00102$:
      0082AE 4B 41            [ 1]  525 	push	#0x41
      0082B0 A6 37            [ 1]  526 	ld	a, #0x37
      0082B2 CD 80 FC         [ 4]  527 	call	_rand_minutes_range_to_seconds
      0082B5 84               [ 1]  528 	pop	a
      0082B6 20 0D            [ 2]  529 	jra	00105$
                                    530 ;	main.c: 159: case MODE_HIGH: interval_s = rand_minutes_range_to_seconds(40, 50); break;
      0082B8                        531 00103$:
      0082B8 4B 32            [ 1]  532 	push	#0x32
      0082BA A6 28            [ 1]  533 	ld	a, #0x28
      0082BC CD 80 FC         [ 4]  534 	call	_rand_minutes_range_to_seconds
      0082BF 84               [ 1]  535 	pop	a
      0082C0 20 03            [ 2]  536 	jra	00105$
                                    537 ;	main.c: 160: default: interval_s = 0; break;
      0082C2                        538 00104$:
      0082C2 5F               [ 1]  539 	clrw	x
      0082C3 90 5F            [ 1]  540 	clrw	y
                                    541 ;	main.c: 161: }
      0082C5                        542 00105$:
                                    543 ;	main.c: 162: next_on_time_s = uptime_s + interval_s;
      0082C5 72 BB 00 07      [ 2]  544 	addw	x, _uptime_s+2
      0082C9 90 9F            [ 1]  545 	ld	a, yl
      0082CB C9 00 06         [ 1]  546 	adc	a, _uptime_s+1
      0082CE 90 02            [ 1]  547 	rlwa	y
      0082D0 C9 00 05         [ 1]  548 	adc	a, _uptime_s+0
      0082D3 90 95            [ 1]  549 	ld	yh, a
      0082D5 CF 00 1C         [ 2]  550 	ldw	_next_on_time_s+2, x
      0082D8 90 CF 00 1A      [ 2]  551 	ldw	_next_on_time_s+0, y
                                    552 ;	main.c: 163: }
      0082DC 81               [ 4]  553 	ret
                                    554 ;	main.c: 166: static void clock_init(void) {
                                    555 ;	-----------------------------------------
                                    556 ;	 function clock_init
                                    557 ;	-----------------------------------------
      0082DD                        558 _clock_init:
                                    559 ;	main.c: 167: CLK_HSIPrescalerConfig(CLK_PRESCALER_HSIDIV1);
      0082DD 4F               [ 1]  560 	clr	a
      0082DE CD 89 0C         [ 4]  561 	call	_CLK_HSIPrescalerConfig
                                    562 ;	main.c: 168: CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER4, ENABLE);
      0082E1 4B 01            [ 1]  563 	push	#0x01
      0082E3 A6 04            [ 1]  564 	ld	a, #0x04
      0082E5 CD 88 16         [ 4]  565 	call	_CLK_PeripheralClockConfig
                                    566 ;	main.c: 169: }
      0082E8 81               [ 4]  567 	ret
                                    568 ;	main.c: 171: static void gpio_init(void) {
                                    569 ;	-----------------------------------------
                                    570 ;	 function gpio_init
                                    571 ;	-----------------------------------------
      0082E9                        572 _gpio_init:
                                    573 ;	main.c: 173: GPIO_DeInit(FAN_PORT);
      0082E9 AE 50 0F         [ 2]  574 	ldw	x, #0x500f
      0082EC CD 85 4F         [ 4]  575 	call	_GPIO_DeInit
                                    576 ;	main.c: 174: GPIO_Init(FAN_PORT, FAN_PIN, GPIO_MODE_OUT_PP_LOW_FAST);
      0082EF 4B E0            [ 1]  577 	push	#0xe0
      0082F1 A6 10            [ 1]  578 	ld	a, #0x10
      0082F3 AE 50 0F         [ 2]  579 	ldw	x, #0x500f
      0082F6 CD 85 5C         [ 4]  580 	call	_GPIO_Init
                                    581 ;	main.c: 177: GPIO_DeInit(LED_R_PORT);
      0082F9 AE 50 0A         [ 2]  582 	ldw	x, #0x500a
      0082FC CD 85 4F         [ 4]  583 	call	_GPIO_DeInit
                                    584 ;	main.c: 178: GPIO_Init(LED_R_PORT, LED_R_PIN, GPIO_MODE_OUT_PP_HIGH_FAST);
      0082FF 4B F0            [ 1]  585 	push	#0xf0
      008301 A6 80            [ 1]  586 	ld	a, #0x80
      008303 AE 50 0A         [ 2]  587 	ldw	x, #0x500a
      008306 CD 85 5C         [ 4]  588 	call	_GPIO_Init
                                    589 ;	main.c: 179: GPIO_DeInit(LED_G_PORT);
      008309 AE 50 0A         [ 2]  590 	ldw	x, #0x500a
      00830C CD 85 4F         [ 4]  591 	call	_GPIO_DeInit
                                    592 ;	main.c: 180: GPIO_Init(LED_G_PORT, LED_G_PIN, GPIO_MODE_OUT_PP_HIGH_FAST);
      00830F 4B F0            [ 1]  593 	push	#0xf0
      008311 A6 40            [ 1]  594 	ld	a, #0x40
      008313 AE 50 0A         [ 2]  595 	ldw	x, #0x500a
      008316 CD 85 5C         [ 4]  596 	call	_GPIO_Init
                                    597 ;	main.c: 181: GPIO_DeInit(LED_B_PORT);
      008319 AE 50 0A         [ 2]  598 	ldw	x, #0x500a
      00831C CD 85 4F         [ 4]  599 	call	_GPIO_DeInit
                                    600 ;	main.c: 182: GPIO_Init(LED_B_PORT, LED_B_PIN, GPIO_MODE_OUT_PP_HIGH_FAST);
      00831F 4B F0            [ 1]  601 	push	#0xf0
      008321 A6 20            [ 1]  602 	ld	a, #0x20
      008323 AE 50 0A         [ 2]  603 	ldw	x, #0x500a
      008326 CD 85 5C         [ 4]  604 	call	_GPIO_Init
                                    605 ;	main.c: 185: GPIO_DeInit(BTN_PORT);
      008329 AE 50 05         [ 2]  606 	ldw	x, #0x5005
      00832C CD 85 4F         [ 4]  607 	call	_GPIO_DeInit
                                    608 ;	main.c: 186: GPIO_Init(BTN_PORT, BTN_PIN, GPIO_MODE_IN_PU_NO_IT);
      00832F 4B 40            [ 1]  609 	push	#0x40
      008331 A6 10            [ 1]  610 	ld	a, #0x10
      008333 AE 50 05         [ 2]  611 	ldw	x, #0x5005
      008336 CD 85 5C         [ 4]  612 	call	_GPIO_Init
                                    613 ;	main.c: 187: }
      008339 81               [ 4]  614 	ret
                                    615 ;	main.c: 189: static void tim4_init_1ms(void) {
                                    616 ;	-----------------------------------------
                                    617 ;	 function tim4_init_1ms
                                    618 ;	-----------------------------------------
      00833A                        619 _tim4_init_1ms:
                                    620 ;	main.c: 191: TIM4_TimeBaseInit(TIM4_PRESCALER_128, 125 - 1);
      00833A 4B 7C            [ 1]  621 	push	#0x7c
      00833C A6 07            [ 1]  622 	ld	a, #0x07
      00833E CD 86 3C         [ 4]  623 	call	_TIM4_TimeBaseInit
                                    624 ;	main.c: 192: TIM4_SetCounter(0);
      008341 4F               [ 1]  625 	clr	a
      008342 CD 86 ED         [ 4]  626 	call	_TIM4_SetCounter
                                    627 ;	main.c: 193: TIM4_ClearFlag(TIM4_FLAG_UPDATE);
      008345 A6 01            [ 1]  628 	ld	a, #0x01
      008347 CD 87 0D         [ 4]  629 	call	_TIM4_ClearFlag
                                    630 ;	main.c: 194: TIM4_Cmd(ENABLE);
      00834A A6 01            [ 1]  631 	ld	a, #0x01
                                    632 ;	main.c: 195: }
      00834C CC 86 48         [ 2]  633 	jp	_TIM4_Cmd
                                    634 ;	main.c: 197: static void wwdg_init(void) {
                                    635 ;	-----------------------------------------
                                    636 ;	 function wwdg_init
                                    637 ;	-----------------------------------------
      00834F                        638 _wwdg_init:
                                    639 ;	main.c: 198: WWDG_Init(WWDG_START_COUNTER, WWDG_WINDOW);
      00834F 4B 50            [ 1]  640 	push	#0x50
      008351 A6 7F            [ 1]  641 	ld	a, #0x7f
      008353 CD 8A B6         [ 4]  642 	call	_WWDG_Init
                                    643 ;	main.c: 199: }
      008356 81               [ 4]  644 	ret
                                    645 ;	main.c: 202: static inline void wwdg_service(void) {
                                    646 ;	-----------------------------------------
                                    647 ;	 function wwdg_service
                                    648 ;	-----------------------------------------
      008357                        649 _wwdg_service:
                                    650 ;	main.c: 203: uint8_t c = (uint8_t)(WWDG_GetCounter() & 0x7F);
      008357 CD 8A D1         [ 4]  651 	call	_WWDG_GetCounter
      00835A A4 7F            [ 1]  652 	and	a, #0x7f
                                    653 ;	main.c: 204: if ((c < WWDG_WINDOW) && (c >= WWDG_REFRESH_FLOOR)) {
      00835C A1 50            [ 1]  654 	cp	a, #0x50
      00835E 25 01            [ 1]  655 	jrc	00120$
      008360 81               [ 4]  656 	ret
      008361                        657 00120$:
      008361 A1 44            [ 1]  658 	cp	a, #0x44
      008363 24 01            [ 1]  659 	jrnc	00121$
      008365 81               [ 4]  660 	ret
      008366                        661 00121$:
                                    662 ;	main.c: 205: WWDG_SetCounter(WWDG_START_COUNTER);
      008366 A6 7F            [ 1]  663 	ld	a, #0x7f
                                    664 ;	main.c: 207: }
      008368 CC 8A CB         [ 2]  665 	jp	_WWDG_SetCounter
                                    666 ;	main.c: 210: static void enter_mode(mode_t m) {
                                    667 ;	-----------------------------------------
                                    668 ;	 function enter_mode
                                    669 ;	-----------------------------------------
      00836B                        670 _enter_mode:
                                    671 ;	main.c: 213: switch (mode) {
      00836B C7 00 14         [ 1]  672 	ld	_mode+0, a
      00836E 27 15            [ 1]  673 	jreq	00101$
      008370 C6 00 14         [ 1]  674 	ld	a, _mode+0
      008373 4A               [ 1]  675 	dec	a
      008374 27 1E            [ 1]  676 	jreq	00104$
      008376 C6 00 14         [ 1]  677 	ld	a, _mode+0
      008379 A1 02            [ 1]  678 	cp	a, #0x02
      00837B 27 17            [ 1]  679 	jreq	00104$
      00837D C6 00 14         [ 1]  680 	ld	a, _mode+0
      008380 A1 03            [ 1]  681 	cp	a, #0x03
      008382 27 10            [ 1]  682 	jreq	00104$
      008384 81               [ 4]  683 	ret
                                    684 ;	main.c: 214: case MODE_OFF:
      008385                        685 00101$:
                                    686 ;	main.c: 96: static inline void fan_off(void)  { GPIO_WriteLow (FAN_PORT, FAN_PIN);  fan_on = 0; }
      008385 A6 10            [ 1]  687 	ld	a, #0x10
      008387 AE 50 0F         [ 2]  688 	ldw	x, #0x500f
      00838A CD 85 E2         [ 4]  689 	call	_GPIO_WriteLow
      00838D 72 5F 00 15      [ 1]  690 	clr	_fan_on+0
                                    691 ;	main.c: 216: led_off_all();
                                    692 ;	main.c: 217: break;
      008391 CC 81 8D         [ 2]  693 	jp	_led_off_all
                                    694 ;	main.c: 221: case MODE_HIGH:
      008394                        695 00104$:
                                    696 ;	main.c: 223: led_set_for_mode(mode);
      008394 C6 00 14         [ 1]  697 	ld	a, _mode+0
      008397 CD 81 A5         [ 4]  698 	call	_led_set_for_mode
                                    699 ;	main.c: 96: static inline void fan_off(void)  { GPIO_WriteLow (FAN_PORT, FAN_PIN);  fan_on = 0; }
      00839A A6 10            [ 1]  700 	ld	a, #0x10
      00839C AE 50 0F         [ 2]  701 	ldw	x, #0x500f
      00839F CD 85 E2         [ 4]  702 	call	_GPIO_WriteLow
      0083A2 72 5F 00 15      [ 1]  703 	clr	_fan_on+0
                                    704 ;	main.c: 225: schedule_next_interval();
                                    705 ;	main.c: 227: }
                                    706 ;	main.c: 228: }
      0083A6 CC 82 8E         [ 2]  707 	jp	_schedule_next_interval
                                    708 ;	main.c: 231: static void advance_mode(void) {
                                    709 ;	-----------------------------------------
                                    710 ;	 function advance_mode
                                    711 ;	-----------------------------------------
      0083A9                        712 _advance_mode:
                                    713 ;	main.c: 232: switch (mode) {
      0083A9 C6 00 14         [ 1]  714 	ld	a, _mode+0
      0083AC 27 15            [ 1]  715 	jreq	00101$
      0083AE C6 00 14         [ 1]  716 	ld	a, _mode+0
      0083B1 4A               [ 1]  717 	dec	a
      0083B2 27 14            [ 1]  718 	jreq	00102$
      0083B4 C6 00 14         [ 1]  719 	ld	a, _mode+0
      0083B7 A1 02            [ 1]  720 	cp	a, #0x02
      0083B9 27 12            [ 1]  721 	jreq	00103$
      0083BB C6 00 14         [ 1]  722 	ld	a, _mode+0
      0083BE A1 03            [ 1]  723 	cp	a, #0x03
      0083C0 27 10            [ 1]  724 	jreq	00104$
      0083C2 81               [ 4]  725 	ret
                                    726 ;	main.c: 233: case MODE_OFF:  enter_mode(MODE_ECO);  break;
      0083C3                        727 00101$:
      0083C3 A6 01            [ 1]  728 	ld	a, #0x01
      0083C5 CC 83 6B         [ 2]  729 	jp	_enter_mode
                                    730 ;	main.c: 234: case MODE_ECO:  enter_mode(MODE_MID);  break;
      0083C8                        731 00102$:
      0083C8 A6 02            [ 1]  732 	ld	a, #0x02
      0083CA CC 83 6B         [ 2]  733 	jp	_enter_mode
                                    734 ;	main.c: 235: case MODE_MID:  enter_mode(MODE_HIGH); break;
      0083CD                        735 00103$:
      0083CD A6 03            [ 1]  736 	ld	a, #0x03
      0083CF CC 83 6B         [ 2]  737 	jp	_enter_mode
                                    738 ;	main.c: 236: case MODE_HIGH: enter_mode(MODE_OFF);  break;
      0083D2                        739 00104$:
      0083D2 4F               [ 1]  740 	clr	a
                                    741 ;	main.c: 237: }
                                    742 ;	main.c: 238: }
      0083D3 CC 83 6B         [ 2]  743 	jp	_enter_mode
                                    744 ;	main.c: 241: int main(void) {
                                    745 ;	-----------------------------------------
                                    746 ;	 function main
                                    747 ;	-----------------------------------------
      0083D6                        748 _main:
      0083D6 52 04            [ 2]  749 	sub	sp, #4
                                    750 ;	main.c: 242: clock_init();
      0083D8 CD 82 DD         [ 4]  751 	call	_clock_init
                                    752 ;	main.c: 243: gpio_init();
      0083DB CD 82 E9         [ 4]  753 	call	_gpio_init
                                    754 ;	main.c: 244: tim4_init_1ms();
      0083DE CD 83 3A         [ 4]  755 	call	_tim4_init_1ms
                                    756 ;	main.c: 245: wwdg_init();
      0083E1 CD 83 4F         [ 4]  757 	call	_wwdg_init
                                    758 ;	main.c: 248: enter_mode(MODE_OFF);
      0083E4 4F               [ 1]  759 	clr	a
      0083E5 CD 83 6B         [ 4]  760 	call	_enter_mode
                                    761 ;	main.c: 251: lfsr ^= (uint16_t)TIM4->CNTR;
      0083E8 C6 53 46         [ 1]  762 	ld	a, 0x5346
      0083EB C8 00 1F         [ 1]  763 	xor	a, _lfsr+1
      0083EE 97               [ 1]  764 	ld	xl, a
      0083EF 4F               [ 1]  765 	clr	a
      0083F0 C8 00 1E         [ 1]  766 	xor	a, _lfsr+0
      0083F3 95               [ 1]  767 	ld	xh, a
      0083F4 CF 00 1E         [ 2]  768 	ldw	_lfsr+0, x
                                    769 ;	main.c: 253: uint32_t last_ms = 0;
      0083F7 5F               [ 1]  770 	clrw	x
      0083F8 1F 03            [ 2]  771 	ldw	(0x03, sp), x
      0083FA 1F 01            [ 2]  772 	ldw	(0x01, sp), x
      0083FC                        773 00137$:
                                    774 ;	main.c: 70: if (TIM4_GetFlagStatus(TIM4_FLAG_UPDATE) != RESET) {
      0083FC A6 01            [ 1]  775 	ld	a, #0x01
      0083FE CD 86 FD         [ 4]  776 	call	_TIM4_GetFlagStatus
      008401 4D               [ 1]  777 	tnz	a
      008402 27 49            [ 1]  778 	jreq	00129$
                                    779 ;	main.c: 71: TIM4_ClearFlag(TIM4_FLAG_UPDATE);
      008404 A6 01            [ 1]  780 	ld	a, #0x01
      008406 CD 87 0D         [ 4]  781 	call	_TIM4_ClearFlag
                                    782 ;	main.c: 72: uptime_ms++;
      008409 CE 00 03         [ 2]  783 	ldw	x, _uptime_ms+2
      00840C 90 CE 00 01      [ 2]  784 	ldw	y, _uptime_ms+0
      008410 5C               [ 1]  785 	incw	x
      008411 26 02            [ 1]  786 	jrne	00247$
      008413 90 5C            [ 1]  787 	incw	y
      008415                        788 00247$:
      008415 CF 00 03         [ 2]  789 	ldw	_uptime_ms+2, x
      008418 90 CF 00 01      [ 2]  790 	ldw	_uptime_ms+0, y
                                    791 ;	main.c: 73: if ((uptime_ms % MS_PER_SEC) == 0u) {
      00841C 4B E8            [ 1]  792 	push	#0xe8
      00841E 4B 03            [ 1]  793 	push	#0x03
      008420 5F               [ 1]  794 	clrw	x
      008421 89               [ 2]  795 	pushw	x
      008422 3B 00 04         [ 1]  796 	push	_uptime_ms+3
      008425 3B 00 03         [ 1]  797 	push	_uptime_ms+2
      008428 3B 00 02         [ 1]  798 	push	_uptime_ms+1
      00842B 3B 00 01         [ 1]  799 	push	_uptime_ms+0
      00842E CD 8A E2         [ 4]  800 	call	__modulong
      008431 5B 08            [ 2]  801 	addw	sp, #8
      008433 5D               [ 2]  802 	tnzw	x
      008434 26 17            [ 1]  803 	jrne	00129$
      008436 90 5D            [ 2]  804 	tnzw	y
      008438 26 13            [ 1]  805 	jrne	00129$
                                    806 ;	main.c: 74: uptime_s++;
      00843A CE 00 07         [ 2]  807 	ldw	x, _uptime_s+2
      00843D 90 CE 00 05      [ 2]  808 	ldw	y, _uptime_s+0
      008441 5C               [ 1]  809 	incw	x
      008442 26 02            [ 1]  810 	jrne	00250$
      008444 90 5C            [ 1]  811 	incw	y
      008446                        812 00250$:
      008446 CF 00 07         [ 2]  813 	ldw	_uptime_s+2, x
      008449 90 CF 00 05      [ 2]  814 	ldw	_uptime_s+0, y
                                    815 ;	main.c: 257: tick_1ms_poll();
      00844D                        816 00129$:
                                    817 ;	main.c: 260: if (uptime_ms != last_ms) {
      00844D 1E 03            [ 2]  818 	ldw	x, (0x03, sp)
      00844F C3 00 03         [ 2]  819 	cpw	x, _uptime_ms+2
      008452 26 0A            [ 1]  820 	jrne	00252$
      008454 1E 01            [ 2]  821 	ldw	x, (0x01, sp)
      008456 C3 00 01         [ 2]  822 	cpw	x, _uptime_ms+0
      008459 26 03            [ 1]  823 	jrne	00252$
      00845B CC 85 34         [ 2]  824 	jp	00123$
      00845E                        825 00252$:
                                    826 ;	main.c: 261: last_ms = uptime_ms;
      00845E CE 00 03         [ 2]  827 	ldw	x, _uptime_ms+2
      008461 1F 03            [ 2]  828 	ldw	(0x03, sp), x
      008463 CE 00 01         [ 2]  829 	ldw	x, _uptime_ms+0
      008466 1F 01            [ 2]  830 	ldw	(0x01, sp), x
                                    831 ;	main.c: 264: button_update_1ms();
      008468 CD 81 DF         [ 4]  832 	call	_button_update_1ms
                                    833 ;	main.c: 267: if (btn.long_event) {
      00846B C6 00 13         [ 1]  834 	ld	a, _btn+10
      00846E 27 0A            [ 1]  835 	jreq	00104$
                                    836 ;	main.c: 268: btn.long_event = 0u;
      008470 35 00 00 13      [ 1]  837 	mov	_btn+10, #0x00
                                    838 ;	main.c: 269: enter_mode(MODE_OFF);                 /* Long press => OFF */
      008474 4F               [ 1]  839 	clr	a
      008475 CD 83 6B         [ 4]  840 	call	_enter_mode
      008478 20 0C            [ 2]  841 	jra	00105$
      00847A                        842 00104$:
                                    843 ;	main.c: 270: } else if (btn.short_event) {
      00847A C6 00 12         [ 1]  844 	ld	a, _btn+9
      00847D 27 07            [ 1]  845 	jreq	00105$
                                    846 ;	main.c: 271: btn.short_event = 0u;
      00847F 35 00 00 12      [ 1]  847 	mov	_btn+9, #0x00
                                    848 ;	main.c: 272: advance_mode();                        /* Short press => next mode, LED updates immediately */
      008483 CD 83 A9         [ 4]  849 	call	_advance_mode
      008486                        850 00105$:
                                    851 ;	main.c: 276: if ((uptime_ms % MS_PER_SEC) == 0u) {
      008486 4B E8            [ 1]  852 	push	#0xe8
      008488 4B 03            [ 1]  853 	push	#0x03
      00848A 5F               [ 1]  854 	clrw	x
      00848B 89               [ 2]  855 	pushw	x
      00848C 3B 00 04         [ 1]  856 	push	_uptime_ms+3
      00848F 3B 00 03         [ 1]  857 	push	_uptime_ms+2
      008492 3B 00 02         [ 1]  858 	push	_uptime_ms+1
      008495 3B 00 01         [ 1]  859 	push	_uptime_ms+0
      008498 CD 8A E2         [ 4]  860 	call	__modulong
      00849B 5B 08            [ 2]  861 	addw	sp, #8
      00849D 5D               [ 2]  862 	tnzw	x
      00849E 26 04            [ 1]  863 	jrne	00256$
      0084A0 90 5D            [ 2]  864 	tnzw	y
      0084A2 27 03            [ 1]  865 	jreq	00257$
      0084A4                        866 00256$:
      0084A4 CC 85 34         [ 2]  867 	jp	00123$
      0084A7                        868 00257$:
                                    869 ;	main.c: 277: if (mode == MODE_ECO || mode == MODE_MID || mode == MODE_HIGH) {
      0084A7 C6 00 14         [ 1]  870 	ld	a, _mode+0
      0084AA 4A               [ 1]  871 	dec	a
      0084AB 27 0E            [ 1]  872 	jreq	00115$
      0084AD C6 00 14         [ 1]  873 	ld	a, _mode+0
      0084B0 A1 02            [ 1]  874 	cp	a, #0x02
      0084B2 27 07            [ 1]  875 	jreq	00115$
      0084B4 C6 00 14         [ 1]  876 	ld	a, _mode+0
      0084B7 A1 03            [ 1]  877 	cp	a, #0x03
      0084B9 26 68            [ 1]  878 	jrne	00116$
      0084BB                        879 00115$:
                                    880 ;	main.c: 278: if (fan_on) {
      0084BB C6 00 15         [ 1]  881 	ld	a, _fan_on+0
      0084BE 27 33            [ 1]  882 	jreq	00111$
                                    883 ;	main.c: 280: if ((uptime_s - fan_on_started_s) >= FAN_ON_DURATION_S) {
      0084C0 CE 00 07         [ 2]  884 	ldw	x, _uptime_s+2
      0084C3 72 B0 00 18      [ 2]  885 	subw	x, _fan_on_started_s+2
      0084C7 C6 00 06         [ 1]  886 	ld	a, _uptime_s+1
      0084CA C2 00 17         [ 1]  887 	sbc	a, _fan_on_started_s+1
      0084CD 90 97            [ 1]  888 	ld	yl, a
      0084CF C6 00 05         [ 1]  889 	ld	a, _uptime_s+0
      0084D2 C2 00 16         [ 1]  890 	sbc	a, _fan_on_started_s+0
      0084D5 88               [ 1]  891 	push	a
      0084D6 A3 01 2C         [ 2]  892 	cpw	x, #0x012c
      0084D9 90 9F            [ 1]  893 	ld	a, yl
      0084DB A2 00            [ 1]  894 	sbc	a, #0x00
      0084DD 84               [ 1]  895 	pop	a
      0084DE A2 00            [ 1]  896 	sbc	a, #0x00
      0084E0 25 52            [ 1]  897 	jrc	00123$
                                    898 ;	main.c: 96: static inline void fan_off(void)  { GPIO_WriteLow (FAN_PORT, FAN_PIN);  fan_on = 0; }
      0084E2 A6 10            [ 1]  899 	ld	a, #0x10
      0084E4 AE 50 0F         [ 2]  900 	ldw	x, #0x500f
      0084E7 CD 85 E2         [ 4]  901 	call	_GPIO_WriteLow
      0084EA 72 5F 00 15      [ 1]  902 	clr	_fan_on+0
                                    903 ;	main.c: 282: schedule_next_interval();        /* pick new jitter for the next interval */
      0084EE CD 82 8E         [ 4]  904 	call	_schedule_next_interval
      0084F1 20 41            [ 2]  905 	jra	00123$
      0084F3                        906 00111$:
                                    907 ;	main.c: 286: if (uptime_s >= next_on_time_s) {
      0084F3 CE 00 07         [ 2]  908 	ldw	x, _uptime_s+2
      0084F6 C3 00 1C         [ 2]  909 	cpw	x, _next_on_time_s+2
      0084F9 C6 00 06         [ 1]  910 	ld	a, _uptime_s+1
      0084FC C2 00 1B         [ 1]  911 	sbc	a, _next_on_time_s+1
      0084FF C6 00 05         [ 1]  912 	ld	a, _uptime_s+0
      008502 C2 00 1A         [ 1]  913 	sbc	a, _next_on_time_s+0
      008505 25 2D            [ 1]  914 	jrc	00123$
                                    915 ;	main.c: 97: static inline void fan_on_fn(void){ GPIO_WriteHigh(FAN_PORT, FAN_PIN);  fan_on = 1; fan_on_started_s = uptime_s; }
      008507 A6 10            [ 1]  916 	ld	a, #0x10
      008509 AE 50 0F         [ 2]  917 	ldw	x, #0x500f
      00850C CD 85 D9         [ 4]  918 	call	_GPIO_WriteHigh
      00850F 35 01 00 15      [ 1]  919 	mov	_fan_on+0, #0x01
      008513 CE 00 07         [ 2]  920 	ldw	x, _uptime_s+2
      008516 90 CE 00 05      [ 2]  921 	ldw	y, _uptime_s+0
      00851A CF 00 18         [ 2]  922 	ldw	_fan_on_started_s+2, x
      00851D 90 CF 00 16      [ 2]  923 	ldw	_fan_on_started_s+0, y
                                    924 ;	main.c: 287: fan_on_fn();
      008521 20 11            [ 2]  925 	jra	00123$
      008523                        926 00116$:
                                    927 ;	main.c: 292: if (fan_on) fan_off();
      008523 C6 00 15         [ 1]  928 	ld	a, _fan_on+0
      008526 27 0C            [ 1]  929 	jreq	00123$
                                    930 ;	main.c: 96: static inline void fan_off(void)  { GPIO_WriteLow (FAN_PORT, FAN_PIN);  fan_on = 0; }
      008528 A6 10            [ 1]  931 	ld	a, #0x10
      00852A AE 50 0F         [ 2]  932 	ldw	x, #0x500f
      00852D CD 85 E2         [ 4]  933 	call	_GPIO_WriteLow
      008530 72 5F 00 15      [ 1]  934 	clr	_fan_on+0
                                    935 ;	main.c: 292: if (fan_on) fan_off();
      008534                        936 00123$:
                                    937 ;	main.c: 203: uint8_t c = (uint8_t)(WWDG_GetCounter() & 0x7F);
      008534 CD 8A D1         [ 4]  938 	call	_WWDG_GetCounter
      008537 A4 7F            [ 1]  939 	and	a, #0x7f
                                    940 ;	main.c: 204: if ((c < WWDG_WINDOW) && (c >= WWDG_REFRESH_FLOOR)) {
      008539 A1 50            [ 1]  941 	cp	a, #0x50
      00853B 25 03            [ 1]  942 	jrc	00271$
      00853D CC 83 FC         [ 2]  943 	jp	00137$
      008540                        944 00271$:
      008540 A1 44            [ 1]  945 	cp	a, #0x44
      008542 24 03            [ 1]  946 	jrnc	00272$
      008544 CC 83 FC         [ 2]  947 	jp	00137$
      008547                        948 00272$:
                                    949 ;	main.c: 205: WWDG_SetCounter(WWDG_START_COUNTER);
      008547 A6 7F            [ 1]  950 	ld	a, #0x7f
      008549 CD 8A CB         [ 4]  951 	call	_WWDG_SetCounter
                                    952 ;	main.c: 298: wwdg_service();
                                    953 ;	main.c: 300: }
      00854C CC 83 FC         [ 2]  954 	jp	00137$
                                    955 	.area CODE
                                    956 	.area CONST
                                    957 	.area INITIALIZER
      008039                        958 __xinit__uptime_ms:
      008039 00 00 00 00            959 	.byte #0x00, #0x00, #0x00, #0x00	; 0
      00803D                        960 __xinit__uptime_s:
      00803D 00 00 00 00            961 	.byte #0x00, #0x00, #0x00, #0x00	; 0
      008041                        962 __xinit__btn:
      008041 01                     963 	.db #0x01	; 1
      008042 01                     964 	.db #0x01	; 1
      008043 00 00                  965 	.dw #0x0000
      008045 00                     966 	.db #0x00	; 0
      008046 00 00 00 00            967 	.byte #0x00, #0x00, #0x00, #0x00	; 0
      00804A 00                     968 	.db #0x00	; 0
      00804B 00                     969 	.db #0x00	; 0
      00804C                        970 __xinit__mode:
      00804C 00                     971 	.db #0x00	; 0
      00804D                        972 __xinit__fan_on:
      00804D 00                     973 	.db #0x00	; 0
      00804E                        974 __xinit__fan_on_started_s:
      00804E 00 00 00 00            975 	.byte #0x00, #0x00, #0x00, #0x00	; 0
      008052                        976 __xinit__next_on_time_s:
      008052 00 00 00 00            977 	.byte #0x00, #0x00, #0x00, #0x00	; 0
      008056                        978 __xinit__lfsr:
      008056 AC E1                  979 	.dw #0xace1
                                    980 	.area CABS (ABS)
