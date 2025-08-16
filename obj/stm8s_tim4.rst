                                      1 ;--------------------------------------------------------
                                      2 ; File Created by SDCC : free open source ISO C Compiler
                                      3 ; Version 4.5.0 #15242 (MINGW64)
                                      4 ;--------------------------------------------------------
                                      5 	.module stm8s_tim4
                                      6 	
                                      7 ;--------------------------------------------------------
                                      8 ; Public variables in this module
                                      9 ;--------------------------------------------------------
                                     10 	.globl _TIM4_DeInit
                                     11 	.globl _TIM4_TimeBaseInit
                                     12 	.globl _TIM4_Cmd
                                     13 	.globl _TIM4_ITConfig
                                     14 	.globl _TIM4_UpdateDisableConfig
                                     15 	.globl _TIM4_UpdateRequestConfig
                                     16 	.globl _TIM4_SelectOnePulseMode
                                     17 	.globl _TIM4_PrescalerConfig
                                     18 	.globl _TIM4_ARRPreloadConfig
                                     19 	.globl _TIM4_GenerateEvent
                                     20 	.globl _TIM4_SetCounter
                                     21 	.globl _TIM4_SetAutoreload
                                     22 	.globl _TIM4_GetCounter
                                     23 	.globl _TIM4_GetPrescaler
                                     24 	.globl _TIM4_GetFlagStatus
                                     25 	.globl _TIM4_ClearFlag
                                     26 	.globl _TIM4_GetITStatus
                                     27 	.globl _TIM4_ClearITPendingBit
                                     28 ;--------------------------------------------------------
                                     29 ; ram data
                                     30 ;--------------------------------------------------------
                                     31 	.area DATA
                                     32 ;--------------------------------------------------------
                                     33 ; ram data
                                     34 ;--------------------------------------------------------
                                     35 	.area INITIALIZED
                                     36 ;--------------------------------------------------------
                                     37 ; absolute external ram data
                                     38 ;--------------------------------------------------------
                                     39 	.area DABS (ABS)
                                     40 
                                     41 ; default segment ordering for linker
                                     42 	.area HOME
                                     43 	.area GSINIT
                                     44 	.area GSFINAL
                                     45 	.area CONST
                                     46 	.area INITIALIZER
                                     47 	.area CODE
                                     48 
                                     49 ;--------------------------------------------------------
                                     50 ; global & static initialisations
                                     51 ;--------------------------------------------------------
                                     52 	.area HOME
                                     53 	.area GSINIT
                                     54 	.area GSFINAL
                                     55 	.area GSINIT
                                     56 ;--------------------------------------------------------
                                     57 ; Home
                                     58 ;--------------------------------------------------------
                                     59 	.area HOME
                                     60 	.area HOME
                                     61 ;--------------------------------------------------------
                                     62 ; code
                                     63 ;--------------------------------------------------------
                                     64 	.area CODE
                                     65 ;	lib/src/stm8s_tim4.c: 49: void TIM4_DeInit(void)
                                     66 ;	-----------------------------------------
                                     67 ;	 function TIM4_DeInit
                                     68 ;	-----------------------------------------
      008623                         69 _TIM4_DeInit:
                                     70 ;	lib/src/stm8s_tim4.c: 51: TIM4->CR1 = TIM4_CR1_RESET_VALUE;
      008623 35 00 53 40      [ 1]   71 	mov	0x5340+0, #0x00
                                     72 ;	lib/src/stm8s_tim4.c: 52: TIM4->IER = TIM4_IER_RESET_VALUE;
      008627 35 00 53 43      [ 1]   73 	mov	0x5343+0, #0x00
                                     74 ;	lib/src/stm8s_tim4.c: 53: TIM4->CNTR = TIM4_CNTR_RESET_VALUE;
      00862B 35 00 53 46      [ 1]   75 	mov	0x5346+0, #0x00
                                     76 ;	lib/src/stm8s_tim4.c: 54: TIM4->PSCR = TIM4_PSCR_RESET_VALUE;
      00862F 35 00 53 47      [ 1]   77 	mov	0x5347+0, #0x00
                                     78 ;	lib/src/stm8s_tim4.c: 55: TIM4->ARR = TIM4_ARR_RESET_VALUE;
      008633 35 FF 53 48      [ 1]   79 	mov	0x5348+0, #0xff
                                     80 ;	lib/src/stm8s_tim4.c: 56: TIM4->SR1 = TIM4_SR1_RESET_VALUE;
      008637 35 00 53 44      [ 1]   81 	mov	0x5344+0, #0x00
                                     82 ;	lib/src/stm8s_tim4.c: 57: }
      00863B 81               [ 4]   83 	ret
                                     84 ;	lib/src/stm8s_tim4.c: 65: void TIM4_TimeBaseInit(TIM4_Prescaler_TypeDef TIM4_Prescaler, uint8_t TIM4_Period)
                                     85 ;	-----------------------------------------
                                     86 ;	 function TIM4_TimeBaseInit
                                     87 ;	-----------------------------------------
      00863C                         88 _TIM4_TimeBaseInit:
                                     89 ;	lib/src/stm8s_tim4.c: 70: TIM4->PSCR = (uint8_t)(TIM4_Prescaler);
      00863C C7 53 47         [ 1]   90 	ld	0x5347, a
                                     91 ;	lib/src/stm8s_tim4.c: 72: TIM4->ARR = (uint8_t)(TIM4_Period);
      00863F AE 53 48         [ 2]   92 	ldw	x, #0x5348
      008642 7B 03            [ 1]   93 	ld	a, (0x03, sp)
      008644 F7               [ 1]   94 	ld	(x), a
                                     95 ;	lib/src/stm8s_tim4.c: 73: }
      008645 85               [ 2]   96 	popw	x
      008646 84               [ 1]   97 	pop	a
      008647 FC               [ 2]   98 	jp	(x)
                                     99 ;	lib/src/stm8s_tim4.c: 81: void TIM4_Cmd(FunctionalState NewState)
                                    100 ;	-----------------------------------------
                                    101 ;	 function TIM4_Cmd
                                    102 ;	-----------------------------------------
      008648                        103 _TIM4_Cmd:
      008648 88               [ 1]  104 	push	a
      008649 6B 01            [ 1]  105 	ld	(0x01, sp), a
                                    106 ;	lib/src/stm8s_tim4.c: 89: TIM4->CR1 |= TIM4_CR1_CEN;
      00864B C6 53 40         [ 1]  107 	ld	a, 0x5340
                                    108 ;	lib/src/stm8s_tim4.c: 87: if (NewState != DISABLE)
      00864E 0D 01            [ 1]  109 	tnz	(0x01, sp)
      008650 27 07            [ 1]  110 	jreq	00102$
                                    111 ;	lib/src/stm8s_tim4.c: 89: TIM4->CR1 |= TIM4_CR1_CEN;
      008652 AA 01            [ 1]  112 	or	a, #0x01
      008654 C7 53 40         [ 1]  113 	ld	0x5340, a
      008657 20 05            [ 2]  114 	jra	00104$
      008659                        115 00102$:
                                    116 ;	lib/src/stm8s_tim4.c: 93: TIM4->CR1 &= (uint8_t)(~TIM4_CR1_CEN);
      008659 A4 FE            [ 1]  117 	and	a, #0xfe
      00865B C7 53 40         [ 1]  118 	ld	0x5340, a
      00865E                        119 00104$:
                                    120 ;	lib/src/stm8s_tim4.c: 95: }
      00865E 84               [ 1]  121 	pop	a
      00865F 81               [ 4]  122 	ret
                                    123 ;	lib/src/stm8s_tim4.c: 107: void TIM4_ITConfig(TIM4_IT_TypeDef TIM4_IT, FunctionalState NewState)
                                    124 ;	-----------------------------------------
                                    125 ;	 function TIM4_ITConfig
                                    126 ;	-----------------------------------------
      008660                        127 _TIM4_ITConfig:
      008660 88               [ 1]  128 	push	a
      008661 97               [ 1]  129 	ld	xl, a
                                    130 ;	lib/src/stm8s_tim4.c: 116: TIM4->IER |= (uint8_t)TIM4_IT;
      008662 C6 53 43         [ 1]  131 	ld	a, 0x5343
      008665 6B 01            [ 1]  132 	ld	(0x01, sp), a
                                    133 ;	lib/src/stm8s_tim4.c: 113: if (NewState != DISABLE)
      008667 0D 04            [ 1]  134 	tnz	(0x04, sp)
      008669 27 08            [ 1]  135 	jreq	00102$
                                    136 ;	lib/src/stm8s_tim4.c: 116: TIM4->IER |= (uint8_t)TIM4_IT;
      00866B 9F               [ 1]  137 	ld	a, xl
      00866C 1A 01            [ 1]  138 	or	a, (0x01, sp)
      00866E C7 53 43         [ 1]  139 	ld	0x5343, a
      008671 20 07            [ 2]  140 	jra	00104$
      008673                        141 00102$:
                                    142 ;	lib/src/stm8s_tim4.c: 121: TIM4->IER &= (uint8_t)(~TIM4_IT);
      008673 9F               [ 1]  143 	ld	a, xl
      008674 43               [ 1]  144 	cpl	a
      008675 14 01            [ 1]  145 	and	a, (0x01, sp)
      008677 C7 53 43         [ 1]  146 	ld	0x5343, a
      00867A                        147 00104$:
                                    148 ;	lib/src/stm8s_tim4.c: 123: }
      00867A 84               [ 1]  149 	pop	a
      00867B 85               [ 2]  150 	popw	x
      00867C 84               [ 1]  151 	pop	a
      00867D FC               [ 2]  152 	jp	(x)
                                    153 ;	lib/src/stm8s_tim4.c: 131: void TIM4_UpdateDisableConfig(FunctionalState NewState)
                                    154 ;	-----------------------------------------
                                    155 ;	 function TIM4_UpdateDisableConfig
                                    156 ;	-----------------------------------------
      00867E                        157 _TIM4_UpdateDisableConfig:
      00867E 88               [ 1]  158 	push	a
      00867F 6B 01            [ 1]  159 	ld	(0x01, sp), a
                                    160 ;	lib/src/stm8s_tim4.c: 139: TIM4->CR1 |= TIM4_CR1_UDIS;
      008681 C6 53 40         [ 1]  161 	ld	a, 0x5340
                                    162 ;	lib/src/stm8s_tim4.c: 137: if (NewState != DISABLE)
      008684 0D 01            [ 1]  163 	tnz	(0x01, sp)
      008686 27 07            [ 1]  164 	jreq	00102$
                                    165 ;	lib/src/stm8s_tim4.c: 139: TIM4->CR1 |= TIM4_CR1_UDIS;
      008688 AA 02            [ 1]  166 	or	a, #0x02
      00868A C7 53 40         [ 1]  167 	ld	0x5340, a
      00868D 20 05            [ 2]  168 	jra	00104$
      00868F                        169 00102$:
                                    170 ;	lib/src/stm8s_tim4.c: 143: TIM4->CR1 &= (uint8_t)(~TIM4_CR1_UDIS);
      00868F A4 FD            [ 1]  171 	and	a, #0xfd
      008691 C7 53 40         [ 1]  172 	ld	0x5340, a
      008694                        173 00104$:
                                    174 ;	lib/src/stm8s_tim4.c: 145: }
      008694 84               [ 1]  175 	pop	a
      008695 81               [ 4]  176 	ret
                                    177 ;	lib/src/stm8s_tim4.c: 155: void TIM4_UpdateRequestConfig(TIM4_UpdateSource_TypeDef TIM4_UpdateSource)
                                    178 ;	-----------------------------------------
                                    179 ;	 function TIM4_UpdateRequestConfig
                                    180 ;	-----------------------------------------
      008696                        181 _TIM4_UpdateRequestConfig:
      008696 88               [ 1]  182 	push	a
      008697 6B 01            [ 1]  183 	ld	(0x01, sp), a
                                    184 ;	lib/src/stm8s_tim4.c: 163: TIM4->CR1 |= TIM4_CR1_URS;
      008699 C6 53 40         [ 1]  185 	ld	a, 0x5340
                                    186 ;	lib/src/stm8s_tim4.c: 161: if (TIM4_UpdateSource != TIM4_UPDATESOURCE_GLOBAL)
      00869C 0D 01            [ 1]  187 	tnz	(0x01, sp)
      00869E 27 07            [ 1]  188 	jreq	00102$
                                    189 ;	lib/src/stm8s_tim4.c: 163: TIM4->CR1 |= TIM4_CR1_URS;
      0086A0 AA 04            [ 1]  190 	or	a, #0x04
      0086A2 C7 53 40         [ 1]  191 	ld	0x5340, a
      0086A5 20 05            [ 2]  192 	jra	00104$
      0086A7                        193 00102$:
                                    194 ;	lib/src/stm8s_tim4.c: 167: TIM4->CR1 &= (uint8_t)(~TIM4_CR1_URS);
      0086A7 A4 FB            [ 1]  195 	and	a, #0xfb
      0086A9 C7 53 40         [ 1]  196 	ld	0x5340, a
      0086AC                        197 00104$:
                                    198 ;	lib/src/stm8s_tim4.c: 169: }
      0086AC 84               [ 1]  199 	pop	a
      0086AD 81               [ 4]  200 	ret
                                    201 ;	lib/src/stm8s_tim4.c: 179: void TIM4_SelectOnePulseMode(TIM4_OPMode_TypeDef TIM4_OPMode)
                                    202 ;	-----------------------------------------
                                    203 ;	 function TIM4_SelectOnePulseMode
                                    204 ;	-----------------------------------------
      0086AE                        205 _TIM4_SelectOnePulseMode:
      0086AE 88               [ 1]  206 	push	a
      0086AF 6B 01            [ 1]  207 	ld	(0x01, sp), a
                                    208 ;	lib/src/stm8s_tim4.c: 187: TIM4->CR1 |= TIM4_CR1_OPM;
      0086B1 C6 53 40         [ 1]  209 	ld	a, 0x5340
                                    210 ;	lib/src/stm8s_tim4.c: 185: if (TIM4_OPMode != TIM4_OPMODE_REPETITIVE)
      0086B4 0D 01            [ 1]  211 	tnz	(0x01, sp)
      0086B6 27 07            [ 1]  212 	jreq	00102$
                                    213 ;	lib/src/stm8s_tim4.c: 187: TIM4->CR1 |= TIM4_CR1_OPM;
      0086B8 AA 08            [ 1]  214 	or	a, #0x08
      0086BA C7 53 40         [ 1]  215 	ld	0x5340, a
      0086BD 20 05            [ 2]  216 	jra	00104$
      0086BF                        217 00102$:
                                    218 ;	lib/src/stm8s_tim4.c: 191: TIM4->CR1 &= (uint8_t)(~TIM4_CR1_OPM);
      0086BF A4 F7            [ 1]  219 	and	a, #0xf7
      0086C1 C7 53 40         [ 1]  220 	ld	0x5340, a
      0086C4                        221 00104$:
                                    222 ;	lib/src/stm8s_tim4.c: 193: }
      0086C4 84               [ 1]  223 	pop	a
      0086C5 81               [ 4]  224 	ret
                                    225 ;	lib/src/stm8s_tim4.c: 215: void TIM4_PrescalerConfig(TIM4_Prescaler_TypeDef Prescaler, TIM4_PSCReloadMode_TypeDef TIM4_PSCReloadMode)
                                    226 ;	-----------------------------------------
                                    227 ;	 function TIM4_PrescalerConfig
                                    228 ;	-----------------------------------------
      0086C6                        229 _TIM4_PrescalerConfig:
                                    230 ;	lib/src/stm8s_tim4.c: 222: TIM4->PSCR = (uint8_t)Prescaler;
      0086C6 C7 53 47         [ 1]  231 	ld	0x5347, a
                                    232 ;	lib/src/stm8s_tim4.c: 225: TIM4->EGR = (uint8_t)TIM4_PSCReloadMode;
      0086C9 7B 03            [ 1]  233 	ld	a, (0x03, sp)
      0086CB C7 53 45         [ 1]  234 	ld	0x5345, a
                                    235 ;	lib/src/stm8s_tim4.c: 226: }
      0086CE 85               [ 2]  236 	popw	x
      0086CF 84               [ 1]  237 	pop	a
      0086D0 FC               [ 2]  238 	jp	(x)
                                    239 ;	lib/src/stm8s_tim4.c: 234: void TIM4_ARRPreloadConfig(FunctionalState NewState)
                                    240 ;	-----------------------------------------
                                    241 ;	 function TIM4_ARRPreloadConfig
                                    242 ;	-----------------------------------------
      0086D1                        243 _TIM4_ARRPreloadConfig:
      0086D1 88               [ 1]  244 	push	a
      0086D2 6B 01            [ 1]  245 	ld	(0x01, sp), a
                                    246 ;	lib/src/stm8s_tim4.c: 242: TIM4->CR1 |= TIM4_CR1_ARPE;
      0086D4 C6 53 40         [ 1]  247 	ld	a, 0x5340
                                    248 ;	lib/src/stm8s_tim4.c: 240: if (NewState != DISABLE)
      0086D7 0D 01            [ 1]  249 	tnz	(0x01, sp)
      0086D9 27 07            [ 1]  250 	jreq	00102$
                                    251 ;	lib/src/stm8s_tim4.c: 242: TIM4->CR1 |= TIM4_CR1_ARPE;
      0086DB AA 80            [ 1]  252 	or	a, #0x80
      0086DD C7 53 40         [ 1]  253 	ld	0x5340, a
      0086E0 20 05            [ 2]  254 	jra	00104$
      0086E2                        255 00102$:
                                    256 ;	lib/src/stm8s_tim4.c: 246: TIM4->CR1 &= (uint8_t)(~TIM4_CR1_ARPE);
      0086E2 A4 7F            [ 1]  257 	and	a, #0x7f
      0086E4 C7 53 40         [ 1]  258 	ld	0x5340, a
      0086E7                        259 00104$:
                                    260 ;	lib/src/stm8s_tim4.c: 248: }
      0086E7 84               [ 1]  261 	pop	a
      0086E8 81               [ 4]  262 	ret
                                    263 ;	lib/src/stm8s_tim4.c: 257: void TIM4_GenerateEvent(TIM4_EventSource_TypeDef TIM4_EventSource)
                                    264 ;	-----------------------------------------
                                    265 ;	 function TIM4_GenerateEvent
                                    266 ;	-----------------------------------------
      0086E9                        267 _TIM4_GenerateEvent:
                                    268 ;	lib/src/stm8s_tim4.c: 263: TIM4->EGR = (uint8_t)(TIM4_EventSource);
      0086E9 C7 53 45         [ 1]  269 	ld	0x5345, a
                                    270 ;	lib/src/stm8s_tim4.c: 264: }
      0086EC 81               [ 4]  271 	ret
                                    272 ;	lib/src/stm8s_tim4.c: 272: void TIM4_SetCounter(uint8_t Counter)
                                    273 ;	-----------------------------------------
                                    274 ;	 function TIM4_SetCounter
                                    275 ;	-----------------------------------------
      0086ED                        276 _TIM4_SetCounter:
                                    277 ;	lib/src/stm8s_tim4.c: 275: TIM4->CNTR = (uint8_t)(Counter);
      0086ED C7 53 46         [ 1]  278 	ld	0x5346, a
                                    279 ;	lib/src/stm8s_tim4.c: 276: }
      0086F0 81               [ 4]  280 	ret
                                    281 ;	lib/src/stm8s_tim4.c: 284: void TIM4_SetAutoreload(uint8_t Autoreload)
                                    282 ;	-----------------------------------------
                                    283 ;	 function TIM4_SetAutoreload
                                    284 ;	-----------------------------------------
      0086F1                        285 _TIM4_SetAutoreload:
                                    286 ;	lib/src/stm8s_tim4.c: 287: TIM4->ARR = (uint8_t)(Autoreload);
      0086F1 C7 53 48         [ 1]  287 	ld	0x5348, a
                                    288 ;	lib/src/stm8s_tim4.c: 288: }
      0086F4 81               [ 4]  289 	ret
                                    290 ;	lib/src/stm8s_tim4.c: 295: uint8_t TIM4_GetCounter(void)
                                    291 ;	-----------------------------------------
                                    292 ;	 function TIM4_GetCounter
                                    293 ;	-----------------------------------------
      0086F5                        294 _TIM4_GetCounter:
                                    295 ;	lib/src/stm8s_tim4.c: 298: return (uint8_t)(TIM4->CNTR);
      0086F5 C6 53 46         [ 1]  296 	ld	a, 0x5346
                                    297 ;	lib/src/stm8s_tim4.c: 299: }
      0086F8 81               [ 4]  298 	ret
                                    299 ;	lib/src/stm8s_tim4.c: 306: TIM4_Prescaler_TypeDef TIM4_GetPrescaler(void)
                                    300 ;	-----------------------------------------
                                    301 ;	 function TIM4_GetPrescaler
                                    302 ;	-----------------------------------------
      0086F9                        303 _TIM4_GetPrescaler:
                                    304 ;	lib/src/stm8s_tim4.c: 309: return (TIM4_Prescaler_TypeDef)(TIM4->PSCR);
      0086F9 C6 53 47         [ 1]  305 	ld	a, 0x5347
                                    306 ;	lib/src/stm8s_tim4.c: 310: }
      0086FC 81               [ 4]  307 	ret
                                    308 ;	lib/src/stm8s_tim4.c: 319: FlagStatus TIM4_GetFlagStatus(TIM4_FLAG_TypeDef TIM4_FLAG)
                                    309 ;	-----------------------------------------
                                    310 ;	 function TIM4_GetFlagStatus
                                    311 ;	-----------------------------------------
      0086FD                        312 _TIM4_GetFlagStatus:
      0086FD 97               [ 1]  313 	ld	xl, a
                                    314 ;	lib/src/stm8s_tim4.c: 326: if ((TIM4->SR1 & (uint8_t)TIM4_FLAG)  != 0)
      0086FE C6 53 44         [ 1]  315 	ld	a, 0x5344
      008701 89               [ 2]  316 	pushw	x
      008702 14 02            [ 1]  317 	and	a, (2, sp)
      008704 85               [ 2]  318 	popw	x
      008705 4D               [ 1]  319 	tnz	a
      008706 27 03            [ 1]  320 	jreq	00102$
                                    321 ;	lib/src/stm8s_tim4.c: 328: bitstatus = SET;
      008708 A6 01            [ 1]  322 	ld	a, #0x01
      00870A 81               [ 4]  323 	ret
      00870B                        324 00102$:
                                    325 ;	lib/src/stm8s_tim4.c: 332: bitstatus = RESET;
      00870B 4F               [ 1]  326 	clr	a
                                    327 ;	lib/src/stm8s_tim4.c: 334: return ((FlagStatus)bitstatus);
                                    328 ;	lib/src/stm8s_tim4.c: 335: }
      00870C 81               [ 4]  329 	ret
                                    330 ;	lib/src/stm8s_tim4.c: 344: void TIM4_ClearFlag(TIM4_FLAG_TypeDef TIM4_FLAG)
                                    331 ;	-----------------------------------------
                                    332 ;	 function TIM4_ClearFlag
                                    333 ;	-----------------------------------------
      00870D                        334 _TIM4_ClearFlag:
                                    335 ;	lib/src/stm8s_tim4.c: 350: TIM4->SR1 = (uint8_t)(~TIM4_FLAG);
      00870D 43               [ 1]  336 	cpl	a
      00870E C7 53 44         [ 1]  337 	ld	0x5344, a
                                    338 ;	lib/src/stm8s_tim4.c: 351: }
      008711 81               [ 4]  339 	ret
                                    340 ;	lib/src/stm8s_tim4.c: 360: ITStatus TIM4_GetITStatus(TIM4_IT_TypeDef TIM4_IT)
                                    341 ;	-----------------------------------------
                                    342 ;	 function TIM4_GetITStatus
                                    343 ;	-----------------------------------------
      008712                        344 _TIM4_GetITStatus:
      008712 52 02            [ 2]  345 	sub	sp, #2
      008714 97               [ 1]  346 	ld	xl, a
                                    347 ;	lib/src/stm8s_tim4.c: 369: itstatus = (uint8_t)(TIM4->SR1 & (uint8_t)TIM4_IT);
      008715 C6 53 44         [ 1]  348 	ld	a, 0x5344
      008718 41               [ 1]  349 	exg	a, xl
      008719 6B 01            [ 1]  350 	ld	(0x01, sp), a
      00871B 41               [ 1]  351 	exg	a, xl
      00871C 14 01            [ 1]  352 	and	a, (0x01, sp)
      00871E 6B 02            [ 1]  353 	ld	(0x02, sp), a
                                    354 ;	lib/src/stm8s_tim4.c: 371: itenable = (uint8_t)(TIM4->IER & (uint8_t)TIM4_IT);
      008720 C6 53 43         [ 1]  355 	ld	a, 0x5343
      008723 14 01            [ 1]  356 	and	a, (0x01, sp)
                                    357 ;	lib/src/stm8s_tim4.c: 373: if ((itstatus != (uint8_t)RESET ) && (itenable != (uint8_t)RESET ))
      008725 0D 02            [ 1]  358 	tnz	(0x02, sp)
      008727 27 06            [ 1]  359 	jreq	00102$
      008729 4D               [ 1]  360 	tnz	a
      00872A 27 03            [ 1]  361 	jreq	00102$
                                    362 ;	lib/src/stm8s_tim4.c: 375: bitstatus = (ITStatus)SET;
      00872C A6 01            [ 1]  363 	ld	a, #0x01
                                    364 ;	lib/src/stm8s_tim4.c: 379: bitstatus = (ITStatus)RESET;
      00872E 21                     365 	.byte 0x21
      00872F                        366 00102$:
      00872F 4F               [ 1]  367 	clr	a
      008730                        368 00103$:
                                    369 ;	lib/src/stm8s_tim4.c: 381: return ((ITStatus)bitstatus);
                                    370 ;	lib/src/stm8s_tim4.c: 382: }
      008730 5B 02            [ 2]  371 	addw	sp, #2
      008732 81               [ 4]  372 	ret
                                    373 ;	lib/src/stm8s_tim4.c: 391: void TIM4_ClearITPendingBit(TIM4_IT_TypeDef TIM4_IT)
                                    374 ;	-----------------------------------------
                                    375 ;	 function TIM4_ClearITPendingBit
                                    376 ;	-----------------------------------------
      008733                        377 _TIM4_ClearITPendingBit:
                                    378 ;	lib/src/stm8s_tim4.c: 397: TIM4->SR1 = (uint8_t)(~TIM4_IT);
      008733 43               [ 1]  379 	cpl	a
      008734 C7 53 44         [ 1]  380 	ld	0x5344, a
                                    381 ;	lib/src/stm8s_tim4.c: 398: }
      008737 81               [ 4]  382 	ret
                                    383 	.area CODE
                                    384 	.area CONST
                                    385 	.area INITIALIZER
                                    386 	.area CABS (ABS)
