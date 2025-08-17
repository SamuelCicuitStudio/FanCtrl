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
      008007 CD 8B 3C         [ 4]   83 	call	___sdcc_external_startup
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
      008004 CC 83 CA         [ 2]  113 	jp	_main
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
      00805A CD 86 F1         [ 4]  126 	call	_TIM4_GetFlagStatus
      00805D 4D               [ 1]  127 	tnz	a
      00805E 26 01            [ 1]  128 	jrne	00121$
      008060 81               [ 4]  129 	ret
      008061                        130 00121$:
                                    131 ;	main.c: 71: TIM4_ClearFlag(TIM4_FLAG_UPDATE);
      008061 A6 01            [ 1]  132 	ld	a, #0x01
      008063 CD 87 01         [ 4]  133 	call	_TIM4_ClearFlag
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
      00808B CD 8A D6         [ 4]  152 	call	__modulong
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
      00816A CD 85 D6         [ 4]  303 	call	_GPIO_WriteLow
      00816D 72 5F 00 15      [ 1]  304 	clr	_fan_on+0
      008171 81               [ 4]  305 	ret
                                    306 ;	main.c: 97: static inline void fan_on_fn(void){ GPIO_WriteHigh(FAN_PORT, FAN_PIN);  fan_on = 1; fan_on_started_s = uptime_s; }
                                    307 ;	-----------------------------------------
                                    308 ;	 function fan_on_fn
                                    309 ;	-----------------------------------------
      008172                        310 _fan_on_fn:
      008172 A6 10            [ 1]  311 	ld	a, #0x10
      008174 AE 50 0F         [ 2]  312 	ldw	x, #0x500f
      008177 CD 85 CD         [ 4]  313 	call	_GPIO_WriteHigh
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
      008192 CD 85 CD         [ 4]  328 	call	_GPIO_WriteHigh
                                    329 ;	main.c: 102: GPIO_WriteHigh(LED_G_PORT, LED_G_PIN);
      008195 A6 40            [ 1]  330 	ld	a, #0x40
      008197 AE 50 0A         [ 2]  331 	ldw	x, #0x500a
      00819A CD 85 CD         [ 4]  332 	call	_GPIO_WriteHigh
                                    333 ;	main.c: 103: GPIO_WriteHigh(LED_B_PORT, LED_B_PIN);
      00819D A6 20            [ 1]  334 	ld	a, #0x20
      00819F AE 50 0A         [ 2]  335 	ldw	x, #0x500a
                                    336 ;	main.c: 104: }
      0081A2 CC 85 CD         [ 2]  337 	jp	_GPIO_WriteHigh
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
      0081BC CC 85 D6         [ 2]  359 	jp	_GPIO_WriteLow
                                    360 ;	main.c: 110: case MODE_MID:  GPIO_WriteLow(LED_B_PORT, LED_B_PIN); break; /* Blue   */
      0081BF                        361 00102$:
      0081BF A6 20            [ 1]  362 	ld	a, #0x20
      0081C1 AE 50 0A         [ 2]  363 	ldw	x, #0x500a
      0081C4 CC 85 D6         [ 2]  364 	jp	_GPIO_WriteLow
                                    365 ;	main.c: 111: case MODE_HIGH: GPIO_WriteLow(LED_R_PORT, LED_R_PIN); break; /* Red    */
      0081C7                        366 00103$:
      0081C7 A6 80            [ 1]  367 	ld	a, #0x80
      0081C9 AE 50 0A         [ 2]  368 	ldw	x, #0x500a
                                    369 ;	main.c: 113: }
                                    370 ;	main.c: 114: }
      0081CC CC 85 D6         [ 2]  371 	jp	_GPIO_WriteLow
                                    372 ;	main.c: 117: static inline uint8_t button_raw_level(void) {
                                    373 ;	-----------------------------------------
                                    374 ;	 function button_raw_level
                                    375 ;	-----------------------------------------
      0081CF                        376 _button_raw_level:
                                    377 ;	main.c: 118: return (uint8_t)GPIO_ReadInputPin(BTN_PORT, BTN_PIN) ? 1u : 0u;
      0081CF A6 10            [ 1]  378 	ld	a, #0x10
      0081D1 AE 50 05         [ 2]  379 	ldw	x, #0x5005
      0081D4 CD 85 F0         [ 4]  380 	call	_GPIO_ReadInputPin
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
      0081E6 CD 85 F0         [ 4]  398 	call	_GPIO_ReadInputPin
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
      0082DE CD 89 00         [ 4]  561 	call	_CLK_HSIPrescalerConfig
                                    562 ;	main.c: 168: CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER4, ENABLE);
      0082E1 4B 01            [ 1]  563 	push	#0x01
      0082E3 A6 04            [ 1]  564 	ld	a, #0x04
      0082E5 CD 88 0A         [ 4]  565 	call	_CLK_PeripheralClockConfig
                                    566 ;	main.c: 169: }
      0082E8 81               [ 4]  567 	ret
                                    568 ;	main.c: 171: static void gpio_init(void) {
                                    569 ;	-----------------------------------------
                                    570 ;	 function gpio_init
                                    571 ;	-----------------------------------------
      0082E9                        572 _gpio_init:
                                    573 ;	main.c: 173: GPIO_DeInit(GPIOC);
      0082E9 AE 50 0A         [ 2]  574 	ldw	x, #0x500a
      0082EC CD 85 43         [ 4]  575 	call	_GPIO_DeInit
                                    576 ;	main.c: 174: GPIO_DeInit(GPIOD);
      0082EF AE 50 0F         [ 2]  577 	ldw	x, #0x500f
      0082F2 CD 85 43         [ 4]  578 	call	_GPIO_DeInit
                                    579 ;	main.c: 175: GPIO_DeInit(GPIOB);
      0082F5 AE 50 05         [ 2]  580 	ldw	x, #0x5005
      0082F8 CD 85 43         [ 4]  581 	call	_GPIO_DeInit
                                    582 ;	main.c: 178: GPIO_Init(FAN_PORT, FAN_PIN, GPIO_MODE_OUT_PP_LOW_FAST);
      0082FB 4B E0            [ 1]  583 	push	#0xe0
      0082FD A6 10            [ 1]  584 	ld	a, #0x10
      0082FF AE 50 0F         [ 2]  585 	ldw	x, #0x500f
      008302 CD 85 50         [ 4]  586 	call	_GPIO_Init
                                    587 ;	main.c: 181: GPIO_Init(LED_R_PORT, LED_R_PIN, GPIO_MODE_OUT_PP_HIGH_FAST);
      008305 4B F0            [ 1]  588 	push	#0xf0
      008307 A6 80            [ 1]  589 	ld	a, #0x80
      008309 AE 50 0A         [ 2]  590 	ldw	x, #0x500a
      00830C CD 85 50         [ 4]  591 	call	_GPIO_Init
                                    592 ;	main.c: 182: GPIO_Init(LED_G_PORT, LED_G_PIN, GPIO_MODE_OUT_PP_HIGH_FAST);
      00830F 4B F0            [ 1]  593 	push	#0xf0
      008311 A6 40            [ 1]  594 	ld	a, #0x40
      008313 AE 50 0A         [ 2]  595 	ldw	x, #0x500a
      008316 CD 85 50         [ 4]  596 	call	_GPIO_Init
                                    597 ;	main.c: 183: GPIO_Init(LED_B_PORT, LED_B_PIN, GPIO_MODE_OUT_PP_HIGH_FAST);
      008319 4B F0            [ 1]  598 	push	#0xf0
      00831B A6 20            [ 1]  599 	ld	a, #0x20
      00831D AE 50 0A         [ 2]  600 	ldw	x, #0x500a
      008320 CD 85 50         [ 4]  601 	call	_GPIO_Init
                                    602 ;	main.c: 186: GPIO_Init(BTN_PORT, BTN_PIN, GPIO_MODE_IN_PU_NO_IT);
      008323 4B 40            [ 1]  603 	push	#0x40
      008325 A6 10            [ 1]  604 	ld	a, #0x10
      008327 AE 50 05         [ 2]  605 	ldw	x, #0x5005
      00832A CD 85 50         [ 4]  606 	call	_GPIO_Init
                                    607 ;	main.c: 187: }
      00832D 81               [ 4]  608 	ret
                                    609 ;	main.c: 190: static void tim4_init_1ms(void) {
                                    610 ;	-----------------------------------------
                                    611 ;	 function tim4_init_1ms
                                    612 ;	-----------------------------------------
      00832E                        613 _tim4_init_1ms:
                                    614 ;	main.c: 192: TIM4_TimeBaseInit(TIM4_PRESCALER_128, 125 - 1);
      00832E 4B 7C            [ 1]  615 	push	#0x7c
      008330 A6 07            [ 1]  616 	ld	a, #0x07
      008332 CD 86 30         [ 4]  617 	call	_TIM4_TimeBaseInit
                                    618 ;	main.c: 193: TIM4_SetCounter(0);
      008335 4F               [ 1]  619 	clr	a
      008336 CD 86 E1         [ 4]  620 	call	_TIM4_SetCounter
                                    621 ;	main.c: 194: TIM4_ClearFlag(TIM4_FLAG_UPDATE);
      008339 A6 01            [ 1]  622 	ld	a, #0x01
      00833B CD 87 01         [ 4]  623 	call	_TIM4_ClearFlag
                                    624 ;	main.c: 195: TIM4_Cmd(ENABLE);
      00833E A6 01            [ 1]  625 	ld	a, #0x01
                                    626 ;	main.c: 196: }
      008340 CC 86 3C         [ 2]  627 	jp	_TIM4_Cmd
                                    628 ;	main.c: 198: static void wwdg_init(void) {
                                    629 ;	-----------------------------------------
                                    630 ;	 function wwdg_init
                                    631 ;	-----------------------------------------
      008343                        632 _wwdg_init:
                                    633 ;	main.c: 199: WWDG_Init(WWDG_START_COUNTER, WWDG_WINDOW);
      008343 4B 50            [ 1]  634 	push	#0x50
      008345 A6 7F            [ 1]  635 	ld	a, #0x7f
      008347 CD 8A AA         [ 4]  636 	call	_WWDG_Init
                                    637 ;	main.c: 200: }
      00834A 81               [ 4]  638 	ret
                                    639 ;	main.c: 203: static inline void wwdg_service(void) {
                                    640 ;	-----------------------------------------
                                    641 ;	 function wwdg_service
                                    642 ;	-----------------------------------------
      00834B                        643 _wwdg_service:
                                    644 ;	main.c: 204: uint8_t c = (uint8_t)(WWDG_GetCounter() & 0x7F);
      00834B CD 8A C5         [ 4]  645 	call	_WWDG_GetCounter
      00834E A4 7F            [ 1]  646 	and	a, #0x7f
                                    647 ;	main.c: 205: if ((c < WWDG_WINDOW) && (c >= WWDG_REFRESH_FLOOR)) {
      008350 A1 50            [ 1]  648 	cp	a, #0x50
      008352 25 01            [ 1]  649 	jrc	00120$
      008354 81               [ 4]  650 	ret
      008355                        651 00120$:
      008355 A1 44            [ 1]  652 	cp	a, #0x44
      008357 24 01            [ 1]  653 	jrnc	00121$
      008359 81               [ 4]  654 	ret
      00835A                        655 00121$:
                                    656 ;	main.c: 206: WWDG_SetCounter(WWDG_START_COUNTER);
      00835A A6 7F            [ 1]  657 	ld	a, #0x7f
                                    658 ;	main.c: 208: }
      00835C CC 8A BF         [ 2]  659 	jp	_WWDG_SetCounter
                                    660 ;	main.c: 211: static void enter_mode(mode_t m) {
                                    661 ;	-----------------------------------------
                                    662 ;	 function enter_mode
                                    663 ;	-----------------------------------------
      00835F                        664 _enter_mode:
                                    665 ;	main.c: 214: switch (mode) {
      00835F C7 00 14         [ 1]  666 	ld	_mode+0, a
      008362 27 15            [ 1]  667 	jreq	00101$
      008364 C6 00 14         [ 1]  668 	ld	a, _mode+0
      008367 4A               [ 1]  669 	dec	a
      008368 27 1E            [ 1]  670 	jreq	00104$
      00836A C6 00 14         [ 1]  671 	ld	a, _mode+0
      00836D A1 02            [ 1]  672 	cp	a, #0x02
      00836F 27 17            [ 1]  673 	jreq	00104$
      008371 C6 00 14         [ 1]  674 	ld	a, _mode+0
      008374 A1 03            [ 1]  675 	cp	a, #0x03
      008376 27 10            [ 1]  676 	jreq	00104$
      008378 81               [ 4]  677 	ret
                                    678 ;	main.c: 215: case MODE_OFF:
      008379                        679 00101$:
                                    680 ;	main.c: 96: static inline void fan_off(void)  { GPIO_WriteLow (FAN_PORT, FAN_PIN);  fan_on = 0; }
      008379 A6 10            [ 1]  681 	ld	a, #0x10
      00837B AE 50 0F         [ 2]  682 	ldw	x, #0x500f
      00837E CD 85 D6         [ 4]  683 	call	_GPIO_WriteLow
      008381 72 5F 00 15      [ 1]  684 	clr	_fan_on+0
                                    685 ;	main.c: 217: led_off_all();
                                    686 ;	main.c: 218: break;
      008385 CC 81 8D         [ 2]  687 	jp	_led_off_all
                                    688 ;	main.c: 222: case MODE_HIGH:
      008388                        689 00104$:
                                    690 ;	main.c: 224: led_set_for_mode(mode);
      008388 C6 00 14         [ 1]  691 	ld	a, _mode+0
      00838B CD 81 A5         [ 4]  692 	call	_led_set_for_mode
                                    693 ;	main.c: 96: static inline void fan_off(void)  { GPIO_WriteLow (FAN_PORT, FAN_PIN);  fan_on = 0; }
      00838E A6 10            [ 1]  694 	ld	a, #0x10
      008390 AE 50 0F         [ 2]  695 	ldw	x, #0x500f
      008393 CD 85 D6         [ 4]  696 	call	_GPIO_WriteLow
      008396 72 5F 00 15      [ 1]  697 	clr	_fan_on+0
                                    698 ;	main.c: 226: schedule_next_interval();
                                    699 ;	main.c: 228: }
                                    700 ;	main.c: 229: }
      00839A CC 82 8E         [ 2]  701 	jp	_schedule_next_interval
                                    702 ;	main.c: 232: static void advance_mode(void) {
                                    703 ;	-----------------------------------------
                                    704 ;	 function advance_mode
                                    705 ;	-----------------------------------------
      00839D                        706 _advance_mode:
                                    707 ;	main.c: 233: switch (mode) {
      00839D C6 00 14         [ 1]  708 	ld	a, _mode+0
      0083A0 27 15            [ 1]  709 	jreq	00101$
      0083A2 C6 00 14         [ 1]  710 	ld	a, _mode+0
      0083A5 4A               [ 1]  711 	dec	a
      0083A6 27 14            [ 1]  712 	jreq	00102$
      0083A8 C6 00 14         [ 1]  713 	ld	a, _mode+0
      0083AB A1 02            [ 1]  714 	cp	a, #0x02
      0083AD 27 12            [ 1]  715 	jreq	00103$
      0083AF C6 00 14         [ 1]  716 	ld	a, _mode+0
      0083B2 A1 03            [ 1]  717 	cp	a, #0x03
      0083B4 27 10            [ 1]  718 	jreq	00104$
      0083B6 81               [ 4]  719 	ret
                                    720 ;	main.c: 234: case MODE_OFF:  enter_mode(MODE_ECO);  break;
      0083B7                        721 00101$:
      0083B7 A6 01            [ 1]  722 	ld	a, #0x01
      0083B9 CC 83 5F         [ 2]  723 	jp	_enter_mode
                                    724 ;	main.c: 235: case MODE_ECO:  enter_mode(MODE_MID);  break;
      0083BC                        725 00102$:
      0083BC A6 02            [ 1]  726 	ld	a, #0x02
      0083BE CC 83 5F         [ 2]  727 	jp	_enter_mode
                                    728 ;	main.c: 236: case MODE_MID:  enter_mode(MODE_HIGH); break;
      0083C1                        729 00103$:
      0083C1 A6 03            [ 1]  730 	ld	a, #0x03
      0083C3 CC 83 5F         [ 2]  731 	jp	_enter_mode
                                    732 ;	main.c: 237: case MODE_HIGH: enter_mode(MODE_OFF);  break;
      0083C6                        733 00104$:
      0083C6 4F               [ 1]  734 	clr	a
                                    735 ;	main.c: 238: }
                                    736 ;	main.c: 239: }
      0083C7 CC 83 5F         [ 2]  737 	jp	_enter_mode
                                    738 ;	main.c: 242: int main(void) {
                                    739 ;	-----------------------------------------
                                    740 ;	 function main
                                    741 ;	-----------------------------------------
      0083CA                        742 _main:
      0083CA 52 04            [ 2]  743 	sub	sp, #4
                                    744 ;	main.c: 243: clock_init();
      0083CC CD 82 DD         [ 4]  745 	call	_clock_init
                                    746 ;	main.c: 244: gpio_init();
      0083CF CD 82 E9         [ 4]  747 	call	_gpio_init
                                    748 ;	main.c: 245: tim4_init_1ms();
      0083D2 CD 83 2E         [ 4]  749 	call	_tim4_init_1ms
                                    750 ;	main.c: 246: wwdg_init();
      0083D5 CD 83 43         [ 4]  751 	call	_wwdg_init
                                    752 ;	main.c: 249: enter_mode(MODE_OFF);
      0083D8 4F               [ 1]  753 	clr	a
      0083D9 CD 83 5F         [ 4]  754 	call	_enter_mode
                                    755 ;	main.c: 252: lfsr ^= (uint16_t)TIM4->CNTR;
      0083DC C6 53 46         [ 1]  756 	ld	a, 0x5346
      0083DF C8 00 1F         [ 1]  757 	xor	a, _lfsr+1
      0083E2 97               [ 1]  758 	ld	xl, a
      0083E3 4F               [ 1]  759 	clr	a
      0083E4 C8 00 1E         [ 1]  760 	xor	a, _lfsr+0
      0083E7 95               [ 1]  761 	ld	xh, a
      0083E8 CF 00 1E         [ 2]  762 	ldw	_lfsr+0, x
                                    763 ;	main.c: 254: uint32_t last_ms = 0;
      0083EB 5F               [ 1]  764 	clrw	x
      0083EC 1F 03            [ 2]  765 	ldw	(0x03, sp), x
      0083EE 1F 01            [ 2]  766 	ldw	(0x01, sp), x
      0083F0                        767 00137$:
                                    768 ;	main.c: 70: if (TIM4_GetFlagStatus(TIM4_FLAG_UPDATE) != RESET) {
      0083F0 A6 01            [ 1]  769 	ld	a, #0x01
      0083F2 CD 86 F1         [ 4]  770 	call	_TIM4_GetFlagStatus
      0083F5 4D               [ 1]  771 	tnz	a
      0083F6 27 49            [ 1]  772 	jreq	00129$
                                    773 ;	main.c: 71: TIM4_ClearFlag(TIM4_FLAG_UPDATE);
      0083F8 A6 01            [ 1]  774 	ld	a, #0x01
      0083FA CD 87 01         [ 4]  775 	call	_TIM4_ClearFlag
                                    776 ;	main.c: 72: uptime_ms++;
      0083FD CE 00 03         [ 2]  777 	ldw	x, _uptime_ms+2
      008400 90 CE 00 01      [ 2]  778 	ldw	y, _uptime_ms+0
      008404 5C               [ 1]  779 	incw	x
      008405 26 02            [ 1]  780 	jrne	00247$
      008407 90 5C            [ 1]  781 	incw	y
      008409                        782 00247$:
      008409 CF 00 03         [ 2]  783 	ldw	_uptime_ms+2, x
      00840C 90 CF 00 01      [ 2]  784 	ldw	_uptime_ms+0, y
                                    785 ;	main.c: 73: if ((uptime_ms % MS_PER_SEC) == 0u) {
      008410 4B E8            [ 1]  786 	push	#0xe8
      008412 4B 03            [ 1]  787 	push	#0x03
      008414 5F               [ 1]  788 	clrw	x
      008415 89               [ 2]  789 	pushw	x
      008416 3B 00 04         [ 1]  790 	push	_uptime_ms+3
      008419 3B 00 03         [ 1]  791 	push	_uptime_ms+2
      00841C 3B 00 02         [ 1]  792 	push	_uptime_ms+1
      00841F 3B 00 01         [ 1]  793 	push	_uptime_ms+0
      008422 CD 8A D6         [ 4]  794 	call	__modulong
      008425 5B 08            [ 2]  795 	addw	sp, #8
      008427 5D               [ 2]  796 	tnzw	x
      008428 26 17            [ 1]  797 	jrne	00129$
      00842A 90 5D            [ 2]  798 	tnzw	y
      00842C 26 13            [ 1]  799 	jrne	00129$
                                    800 ;	main.c: 74: uptime_s++;
      00842E CE 00 07         [ 2]  801 	ldw	x, _uptime_s+2
      008431 90 CE 00 05      [ 2]  802 	ldw	y, _uptime_s+0
      008435 5C               [ 1]  803 	incw	x
      008436 26 02            [ 1]  804 	jrne	00250$
      008438 90 5C            [ 1]  805 	incw	y
      00843A                        806 00250$:
      00843A CF 00 07         [ 2]  807 	ldw	_uptime_s+2, x
      00843D 90 CF 00 05      [ 2]  808 	ldw	_uptime_s+0, y
                                    809 ;	main.c: 258: tick_1ms_poll();
      008441                        810 00129$:
                                    811 ;	main.c: 261: if (uptime_ms != last_ms) {
      008441 1E 03            [ 2]  812 	ldw	x, (0x03, sp)
      008443 C3 00 03         [ 2]  813 	cpw	x, _uptime_ms+2
      008446 26 0A            [ 1]  814 	jrne	00252$
      008448 1E 01            [ 2]  815 	ldw	x, (0x01, sp)
      00844A C3 00 01         [ 2]  816 	cpw	x, _uptime_ms+0
      00844D 26 03            [ 1]  817 	jrne	00252$
      00844F CC 85 28         [ 2]  818 	jp	00123$
      008452                        819 00252$:
                                    820 ;	main.c: 262: last_ms = uptime_ms;
      008452 CE 00 03         [ 2]  821 	ldw	x, _uptime_ms+2
      008455 1F 03            [ 2]  822 	ldw	(0x03, sp), x
      008457 CE 00 01         [ 2]  823 	ldw	x, _uptime_ms+0
      00845A 1F 01            [ 2]  824 	ldw	(0x01, sp), x
                                    825 ;	main.c: 265: button_update_1ms();
      00845C CD 81 DF         [ 4]  826 	call	_button_update_1ms
                                    827 ;	main.c: 268: if (btn.long_event) {
      00845F C6 00 13         [ 1]  828 	ld	a, _btn+10
      008462 27 0A            [ 1]  829 	jreq	00104$
                                    830 ;	main.c: 269: btn.long_event = 0u;
      008464 35 00 00 13      [ 1]  831 	mov	_btn+10, #0x00
                                    832 ;	main.c: 270: enter_mode(MODE_OFF);                 /* Long press => OFF */
      008468 4F               [ 1]  833 	clr	a
      008469 CD 83 5F         [ 4]  834 	call	_enter_mode
      00846C 20 0C            [ 2]  835 	jra	00105$
      00846E                        836 00104$:
                                    837 ;	main.c: 271: } else if (btn.short_event) {
      00846E C6 00 12         [ 1]  838 	ld	a, _btn+9
      008471 27 07            [ 1]  839 	jreq	00105$
                                    840 ;	main.c: 272: btn.short_event = 0u;
      008473 35 00 00 12      [ 1]  841 	mov	_btn+9, #0x00
                                    842 ;	main.c: 273: advance_mode();                        /* Short press => next mode, LED updates immediately */
      008477 CD 83 9D         [ 4]  843 	call	_advance_mode
      00847A                        844 00105$:
                                    845 ;	main.c: 277: if ((uptime_ms % MS_PER_SEC) == 0u) {
      00847A 4B E8            [ 1]  846 	push	#0xe8
      00847C 4B 03            [ 1]  847 	push	#0x03
      00847E 5F               [ 1]  848 	clrw	x
      00847F 89               [ 2]  849 	pushw	x
      008480 3B 00 04         [ 1]  850 	push	_uptime_ms+3
      008483 3B 00 03         [ 1]  851 	push	_uptime_ms+2
      008486 3B 00 02         [ 1]  852 	push	_uptime_ms+1
      008489 3B 00 01         [ 1]  853 	push	_uptime_ms+0
      00848C CD 8A D6         [ 4]  854 	call	__modulong
      00848F 5B 08            [ 2]  855 	addw	sp, #8
      008491 5D               [ 2]  856 	tnzw	x
      008492 26 04            [ 1]  857 	jrne	00256$
      008494 90 5D            [ 2]  858 	tnzw	y
      008496 27 03            [ 1]  859 	jreq	00257$
      008498                        860 00256$:
      008498 CC 85 28         [ 2]  861 	jp	00123$
      00849B                        862 00257$:
                                    863 ;	main.c: 278: if (mode == MODE_ECO || mode == MODE_MID || mode == MODE_HIGH) {
      00849B C6 00 14         [ 1]  864 	ld	a, _mode+0
      00849E 4A               [ 1]  865 	dec	a
      00849F 27 0E            [ 1]  866 	jreq	00115$
      0084A1 C6 00 14         [ 1]  867 	ld	a, _mode+0
      0084A4 A1 02            [ 1]  868 	cp	a, #0x02
      0084A6 27 07            [ 1]  869 	jreq	00115$
      0084A8 C6 00 14         [ 1]  870 	ld	a, _mode+0
      0084AB A1 03            [ 1]  871 	cp	a, #0x03
      0084AD 26 68            [ 1]  872 	jrne	00116$
      0084AF                        873 00115$:
                                    874 ;	main.c: 279: if (fan_on) {
      0084AF C6 00 15         [ 1]  875 	ld	a, _fan_on+0
      0084B2 27 33            [ 1]  876 	jreq	00111$
                                    877 ;	main.c: 281: if ((uptime_s - fan_on_started_s) >= FAN_ON_DURATION_S) {
      0084B4 CE 00 07         [ 2]  878 	ldw	x, _uptime_s+2
      0084B7 72 B0 00 18      [ 2]  879 	subw	x, _fan_on_started_s+2
      0084BB C6 00 06         [ 1]  880 	ld	a, _uptime_s+1
      0084BE C2 00 17         [ 1]  881 	sbc	a, _fan_on_started_s+1
      0084C1 90 97            [ 1]  882 	ld	yl, a
      0084C3 C6 00 05         [ 1]  883 	ld	a, _uptime_s+0
      0084C6 C2 00 16         [ 1]  884 	sbc	a, _fan_on_started_s+0
      0084C9 88               [ 1]  885 	push	a
      0084CA A3 01 2C         [ 2]  886 	cpw	x, #0x012c
      0084CD 90 9F            [ 1]  887 	ld	a, yl
      0084CF A2 00            [ 1]  888 	sbc	a, #0x00
      0084D1 84               [ 1]  889 	pop	a
      0084D2 A2 00            [ 1]  890 	sbc	a, #0x00
      0084D4 25 52            [ 1]  891 	jrc	00123$
                                    892 ;	main.c: 96: static inline void fan_off(void)  { GPIO_WriteLow (FAN_PORT, FAN_PIN);  fan_on = 0; }
      0084D6 A6 10            [ 1]  893 	ld	a, #0x10
      0084D8 AE 50 0F         [ 2]  894 	ldw	x, #0x500f
      0084DB CD 85 D6         [ 4]  895 	call	_GPIO_WriteLow
      0084DE 72 5F 00 15      [ 1]  896 	clr	_fan_on+0
                                    897 ;	main.c: 283: schedule_next_interval();        /* pick new jitter for the next interval */
      0084E2 CD 82 8E         [ 4]  898 	call	_schedule_next_interval
      0084E5 20 41            [ 2]  899 	jra	00123$
      0084E7                        900 00111$:
                                    901 ;	main.c: 287: if (uptime_s >= next_on_time_s) {
      0084E7 CE 00 07         [ 2]  902 	ldw	x, _uptime_s+2
      0084EA C3 00 1C         [ 2]  903 	cpw	x, _next_on_time_s+2
      0084ED C6 00 06         [ 1]  904 	ld	a, _uptime_s+1
      0084F0 C2 00 1B         [ 1]  905 	sbc	a, _next_on_time_s+1
      0084F3 C6 00 05         [ 1]  906 	ld	a, _uptime_s+0
      0084F6 C2 00 1A         [ 1]  907 	sbc	a, _next_on_time_s+0
      0084F9 25 2D            [ 1]  908 	jrc	00123$
                                    909 ;	main.c: 97: static inline void fan_on_fn(void){ GPIO_WriteHigh(FAN_PORT, FAN_PIN);  fan_on = 1; fan_on_started_s = uptime_s; }
      0084FB A6 10            [ 1]  910 	ld	a, #0x10
      0084FD AE 50 0F         [ 2]  911 	ldw	x, #0x500f
      008500 CD 85 CD         [ 4]  912 	call	_GPIO_WriteHigh
      008503 35 01 00 15      [ 1]  913 	mov	_fan_on+0, #0x01
      008507 CE 00 07         [ 2]  914 	ldw	x, _uptime_s+2
      00850A 90 CE 00 05      [ 2]  915 	ldw	y, _uptime_s+0
      00850E CF 00 18         [ 2]  916 	ldw	_fan_on_started_s+2, x
      008511 90 CF 00 16      [ 2]  917 	ldw	_fan_on_started_s+0, y
                                    918 ;	main.c: 288: fan_on_fn();
      008515 20 11            [ 2]  919 	jra	00123$
      008517                        920 00116$:
                                    921 ;	main.c: 293: if (fan_on) fan_off();
      008517 C6 00 15         [ 1]  922 	ld	a, _fan_on+0
      00851A 27 0C            [ 1]  923 	jreq	00123$
                                    924 ;	main.c: 96: static inline void fan_off(void)  { GPIO_WriteLow (FAN_PORT, FAN_PIN);  fan_on = 0; }
      00851C A6 10            [ 1]  925 	ld	a, #0x10
      00851E AE 50 0F         [ 2]  926 	ldw	x, #0x500f
      008521 CD 85 D6         [ 4]  927 	call	_GPIO_WriteLow
      008524 72 5F 00 15      [ 1]  928 	clr	_fan_on+0
                                    929 ;	main.c: 293: if (fan_on) fan_off();
      008528                        930 00123$:
                                    931 ;	main.c: 204: uint8_t c = (uint8_t)(WWDG_GetCounter() & 0x7F);
      008528 CD 8A C5         [ 4]  932 	call	_WWDG_GetCounter
      00852B A4 7F            [ 1]  933 	and	a, #0x7f
                                    934 ;	main.c: 205: if ((c < WWDG_WINDOW) && (c >= WWDG_REFRESH_FLOOR)) {
      00852D A1 50            [ 1]  935 	cp	a, #0x50
      00852F 25 03            [ 1]  936 	jrc	00271$
      008531 CC 83 F0         [ 2]  937 	jp	00137$
      008534                        938 00271$:
      008534 A1 44            [ 1]  939 	cp	a, #0x44
      008536 24 03            [ 1]  940 	jrnc	00272$
      008538 CC 83 F0         [ 2]  941 	jp	00137$
      00853B                        942 00272$:
                                    943 ;	main.c: 206: WWDG_SetCounter(WWDG_START_COUNTER);
      00853B A6 7F            [ 1]  944 	ld	a, #0x7f
      00853D CD 8A BF         [ 4]  945 	call	_WWDG_SetCounter
                                    946 ;	main.c: 299: wwdg_service();
                                    947 ;	main.c: 301: }
      008540 CC 83 F0         [ 2]  948 	jp	00137$
                                    949 	.area CODE
                                    950 	.area CONST
                                    951 	.area INITIALIZER
      008039                        952 __xinit__uptime_ms:
      008039 00 00 00 00            953 	.byte #0x00, #0x00, #0x00, #0x00	; 0
      00803D                        954 __xinit__uptime_s:
      00803D 00 00 00 00            955 	.byte #0x00, #0x00, #0x00, #0x00	; 0
      008041                        956 __xinit__btn:
      008041 01                     957 	.db #0x01	; 1
      008042 01                     958 	.db #0x01	; 1
      008043 00 00                  959 	.dw #0x0000
      008045 00                     960 	.db #0x00	; 0
      008046 00 00 00 00            961 	.byte #0x00, #0x00, #0x00, #0x00	; 0
      00804A 00                     962 	.db #0x00	; 0
      00804B 00                     963 	.db #0x00	; 0
      00804C                        964 __xinit__mode:
      00804C 00                     965 	.db #0x00	; 0
      00804D                        966 __xinit__fan_on:
      00804D 00                     967 	.db #0x00	; 0
      00804E                        968 __xinit__fan_on_started_s:
      00804E 00 00 00 00            969 	.byte #0x00, #0x00, #0x00, #0x00	; 0
      008052                        970 __xinit__next_on_time_s:
      008052 00 00 00 00            971 	.byte #0x00, #0x00, #0x00, #0x00	; 0
      008056                        972 __xinit__lfsr:
      008056 AC E1                  973 	.dw #0xace1
                                    974 	.area CABS (ABS)
