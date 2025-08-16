                                      1 ;--------------------------------------------------------
                                      2 ; File Created by SDCC : free open source ISO C Compiler
                                      3 ; Version 4.5.0 #15242 (MINGW64)
                                      4 ;--------------------------------------------------------
                                      5 	.module stm8s_gpio
                                      6 	
                                      7 ;--------------------------------------------------------
                                      8 ; Public variables in this module
                                      9 ;--------------------------------------------------------
                                     10 	.globl _GPIO_DeInit
                                     11 	.globl _GPIO_Init
                                     12 	.globl _GPIO_Write
                                     13 	.globl _GPIO_WriteHigh
                                     14 	.globl _GPIO_WriteLow
                                     15 	.globl _GPIO_WriteReverse
                                     16 	.globl _GPIO_ReadOutputData
                                     17 	.globl _GPIO_ReadInputData
                                     18 	.globl _GPIO_ReadInputPin
                                     19 	.globl _GPIO_ExternalPullUpConfig
                                     20 ;--------------------------------------------------------
                                     21 ; ram data
                                     22 ;--------------------------------------------------------
                                     23 	.area DATA
                                     24 ;--------------------------------------------------------
                                     25 ; ram data
                                     26 ;--------------------------------------------------------
                                     27 	.area INITIALIZED
                                     28 ;--------------------------------------------------------
                                     29 ; absolute external ram data
                                     30 ;--------------------------------------------------------
                                     31 	.area DABS (ABS)
                                     32 
                                     33 ; default segment ordering for linker
                                     34 	.area HOME
                                     35 	.area GSINIT
                                     36 	.area GSFINAL
                                     37 	.area CONST
                                     38 	.area INITIALIZER
                                     39 	.area CODE
                                     40 
                                     41 ;--------------------------------------------------------
                                     42 ; global & static initialisations
                                     43 ;--------------------------------------------------------
                                     44 	.area HOME
                                     45 	.area GSINIT
                                     46 	.area GSFINAL
                                     47 	.area GSINIT
                                     48 ;--------------------------------------------------------
                                     49 ; Home
                                     50 ;--------------------------------------------------------
                                     51 	.area HOME
                                     52 	.area HOME
                                     53 ;--------------------------------------------------------
                                     54 ; code
                                     55 ;--------------------------------------------------------
                                     56 	.area CODE
                                     57 ;	lib/src/stm8s_gpio.c: 53: void GPIO_DeInit(GPIO_TypeDef* GPIOx)
                                     58 ;	-----------------------------------------
                                     59 ;	 function GPIO_DeInit
                                     60 ;	-----------------------------------------
      00854F                         61 _GPIO_DeInit:
      00854F 51               [ 1]   62 	exgw	x, y
                                     63 ;	lib/src/stm8s_gpio.c: 55: GPIOx->ODR = GPIO_ODR_RESET_VALUE; /* Reset Output Data Register */
      008550 90 7F            [ 1]   64 	clr	(y)
                                     65 ;	lib/src/stm8s_gpio.c: 56: GPIOx->DDR = GPIO_DDR_RESET_VALUE; /* Reset Data Direction Register */
      008552 93               [ 1]   66 	ldw	x, y
      008553 6F 02            [ 1]   67 	clr	(0x02, x)
                                     68 ;	lib/src/stm8s_gpio.c: 57: GPIOx->CR1 = GPIO_CR1_RESET_VALUE; /* Reset Control Register 1 */
      008555 93               [ 1]   69 	ldw	x, y
      008556 6F 03            [ 1]   70 	clr	(0x0003, x)
                                     71 ;	lib/src/stm8s_gpio.c: 58: GPIOx->CR2 = GPIO_CR2_RESET_VALUE; /* Reset Control Register 2 */
      008558 93               [ 1]   72 	ldw	x, y
      008559 6F 04            [ 1]   73 	clr	(0x0004, x)
                                     74 ;	lib/src/stm8s_gpio.c: 59: }
      00855B 81               [ 4]   75 	ret
                                     76 ;	lib/src/stm8s_gpio.c: 71: void GPIO_Init(GPIO_TypeDef* GPIOx, GPIO_Pin_TypeDef GPIO_Pin, GPIO_Mode_TypeDef GPIO_Mode)
                                     77 ;	-----------------------------------------
                                     78 ;	 function GPIO_Init
                                     79 ;	-----------------------------------------
      00855C                         80 _GPIO_Init:
      00855C 52 08            [ 2]   81 	sub	sp, #8
      00855E 1F 07            [ 2]   82 	ldw	(0x07, sp), x
      008560 6B 06            [ 1]   83 	ld	(0x06, sp), a
                                     84 ;	lib/src/stm8s_gpio.c: 81: GPIOx->CR2 &= (uint8_t)(~(GPIO_Pin));
      008562 1E 07            [ 2]   85 	ldw	x, (0x07, sp)
      008564 1C 00 04         [ 2]   86 	addw	x, #0x0004
      008567 1F 01            [ 2]   87 	ldw	(0x01, sp), x
      008569 F6               [ 1]   88 	ld	a, (x)
      00856A 88               [ 1]   89 	push	a
      00856B 7B 07            [ 1]   90 	ld	a, (0x07, sp)
      00856D 43               [ 1]   91 	cpl	a
      00856E 6B 04            [ 1]   92 	ld	(0x04, sp), a
      008570 84               [ 1]   93 	pop	a
      008571 14 03            [ 1]   94 	and	a, (0x03, sp)
      008573 1E 01            [ 2]   95 	ldw	x, (0x01, sp)
      008575 F7               [ 1]   96 	ld	(x), a
                                     97 ;	lib/src/stm8s_gpio.c: 98: GPIOx->DDR |= (uint8_t)GPIO_Pin;
      008576 1E 07            [ 2]   98 	ldw	x, (0x07, sp)
      008578 5C               [ 1]   99 	incw	x
      008579 5C               [ 1]  100 	incw	x
      00857A 1F 04            [ 2]  101 	ldw	(0x04, sp), x
                                    102 ;	lib/src/stm8s_gpio.c: 87: if ((((uint8_t)(GPIO_Mode)) & (uint8_t)0x80) != (uint8_t)0x00) /* Output mode */
      00857C 0D 0B            [ 1]  103 	tnz	(0x0b, sp)
      00857E 2A 1D            [ 1]  104 	jrpl	00105$
                                    105 ;	lib/src/stm8s_gpio.c: 91: GPIOx->ODR |= (uint8_t)GPIO_Pin;
      008580 1E 07            [ 2]  106 	ldw	x, (0x07, sp)
      008582 F6               [ 1]  107 	ld	a, (x)
                                    108 ;	lib/src/stm8s_gpio.c: 89: if ((((uint8_t)(GPIO_Mode)) & (uint8_t)0x10) != (uint8_t)0x00) /* High level */
      008583 88               [ 1]  109 	push	a
      008584 7B 0C            [ 1]  110 	ld	a, (0x0c, sp)
      008586 A5 10            [ 1]  111 	bcp	a, #0x10
      008588 84               [ 1]  112 	pop	a
      008589 27 05            [ 1]  113 	jreq	00102$
                                    114 ;	lib/src/stm8s_gpio.c: 91: GPIOx->ODR |= (uint8_t)GPIO_Pin;
      00858B 1A 06            [ 1]  115 	or	a, (0x06, sp)
      00858D F7               [ 1]  116 	ld	(x), a
      00858E 20 03            [ 2]  117 	jra	00103$
      008590                        118 00102$:
                                    119 ;	lib/src/stm8s_gpio.c: 95: GPIOx->ODR &= (uint8_t)(~(GPIO_Pin));
      008590 14 03            [ 1]  120 	and	a, (0x03, sp)
      008592 F7               [ 1]  121 	ld	(x), a
      008593                        122 00103$:
                                    123 ;	lib/src/stm8s_gpio.c: 98: GPIOx->DDR |= (uint8_t)GPIO_Pin;
      008593 1E 04            [ 2]  124 	ldw	x, (0x04, sp)
      008595 F6               [ 1]  125 	ld	a, (x)
      008596 1A 06            [ 1]  126 	or	a, (0x06, sp)
      008598 1E 04            [ 2]  127 	ldw	x, (0x04, sp)
      00859A F7               [ 1]  128 	ld	(x), a
      00859B 20 08            [ 2]  129 	jra	00106$
      00859D                        130 00105$:
                                    131 ;	lib/src/stm8s_gpio.c: 103: GPIOx->DDR &= (uint8_t)(~(GPIO_Pin));
      00859D 1E 04            [ 2]  132 	ldw	x, (0x04, sp)
      00859F F6               [ 1]  133 	ld	a, (x)
      0085A0 14 03            [ 1]  134 	and	a, (0x03, sp)
      0085A2 1E 04            [ 2]  135 	ldw	x, (0x04, sp)
      0085A4 F7               [ 1]  136 	ld	(x), a
      0085A5                        137 00106$:
                                    138 ;	lib/src/stm8s_gpio.c: 112: GPIOx->CR1 |= (uint8_t)GPIO_Pin;
      0085A5 1E 07            [ 2]  139 	ldw	x, (0x07, sp)
      0085A7 1C 00 03         [ 2]  140 	addw	x, #0x0003
      0085AA F6               [ 1]  141 	ld	a, (x)
                                    142 ;	lib/src/stm8s_gpio.c: 110: if ((((uint8_t)(GPIO_Mode)) & (uint8_t)0x40) != (uint8_t)0x00) /* Pull-Up or Push-Pull */
      0085AB 88               [ 1]  143 	push	a
      0085AC 7B 0C            [ 1]  144 	ld	a, (0x0c, sp)
      0085AE A5 40            [ 1]  145 	bcp	a, #0x40
      0085B0 84               [ 1]  146 	pop	a
      0085B1 27 05            [ 1]  147 	jreq	00108$
                                    148 ;	lib/src/stm8s_gpio.c: 112: GPIOx->CR1 |= (uint8_t)GPIO_Pin;
      0085B3 1A 06            [ 1]  149 	or	a, (0x06, sp)
      0085B5 F7               [ 1]  150 	ld	(x), a
      0085B6 20 03            [ 2]  151 	jra	00109$
      0085B8                        152 00108$:
                                    153 ;	lib/src/stm8s_gpio.c: 116: GPIOx->CR1 &= (uint8_t)(~(GPIO_Pin));
      0085B8 14 03            [ 1]  154 	and	a, (0x03, sp)
      0085BA F7               [ 1]  155 	ld	(x), a
      0085BB                        156 00109$:
                                    157 ;	lib/src/stm8s_gpio.c: 81: GPIOx->CR2 &= (uint8_t)(~(GPIO_Pin));
      0085BB 1E 01            [ 2]  158 	ldw	x, (0x01, sp)
      0085BD F6               [ 1]  159 	ld	a, (x)
                                    160 ;	lib/src/stm8s_gpio.c: 123: if ((((uint8_t)(GPIO_Mode)) & (uint8_t)0x20) != (uint8_t)0x00) /* Interrupt or Slow slope */
      0085BE 88               [ 1]  161 	push	a
      0085BF 7B 0C            [ 1]  162 	ld	a, (0x0c, sp)
      0085C1 A5 20            [ 1]  163 	bcp	a, #0x20
      0085C3 84               [ 1]  164 	pop	a
      0085C4 27 07            [ 1]  165 	jreq	00111$
                                    166 ;	lib/src/stm8s_gpio.c: 125: GPIOx->CR2 |= (uint8_t)GPIO_Pin;
      0085C6 1A 06            [ 1]  167 	or	a, (0x06, sp)
      0085C8 1E 01            [ 2]  168 	ldw	x, (0x01, sp)
      0085CA F7               [ 1]  169 	ld	(x), a
      0085CB 20 05            [ 2]  170 	jra	00113$
      0085CD                        171 00111$:
                                    172 ;	lib/src/stm8s_gpio.c: 129: GPIOx->CR2 &= (uint8_t)(~(GPIO_Pin));
      0085CD 14 03            [ 1]  173 	and	a, (0x03, sp)
      0085CF 1E 01            [ 2]  174 	ldw	x, (0x01, sp)
      0085D1 F7               [ 1]  175 	ld	(x), a
      0085D2                        176 00113$:
                                    177 ;	lib/src/stm8s_gpio.c: 131: }
      0085D2 5B 08            [ 2]  178 	addw	sp, #8
      0085D4 85               [ 2]  179 	popw	x
      0085D5 84               [ 1]  180 	pop	a
      0085D6 FC               [ 2]  181 	jp	(x)
                                    182 ;	lib/src/stm8s_gpio.c: 141: void GPIO_Write(GPIO_TypeDef* GPIOx, uint8_t PortVal)
                                    183 ;	-----------------------------------------
                                    184 ;	 function GPIO_Write
                                    185 ;	-----------------------------------------
      0085D7                        186 _GPIO_Write:
                                    187 ;	lib/src/stm8s_gpio.c: 143: GPIOx->ODR = PortVal;
      0085D7 F7               [ 1]  188 	ld	(x), a
                                    189 ;	lib/src/stm8s_gpio.c: 144: }
      0085D8 81               [ 4]  190 	ret
                                    191 ;	lib/src/stm8s_gpio.c: 154: void GPIO_WriteHigh(GPIO_TypeDef* GPIOx, GPIO_Pin_TypeDef PortPins)
                                    192 ;	-----------------------------------------
                                    193 ;	 function GPIO_WriteHigh
                                    194 ;	-----------------------------------------
      0085D9                        195 _GPIO_WriteHigh:
      0085D9 88               [ 1]  196 	push	a
      0085DA 6B 01            [ 1]  197 	ld	(0x01, sp), a
                                    198 ;	lib/src/stm8s_gpio.c: 156: GPIOx->ODR |= (uint8_t)PortPins;
      0085DC F6               [ 1]  199 	ld	a, (x)
      0085DD 1A 01            [ 1]  200 	or	a, (0x01, sp)
      0085DF F7               [ 1]  201 	ld	(x), a
                                    202 ;	lib/src/stm8s_gpio.c: 157: }
      0085E0 84               [ 1]  203 	pop	a
      0085E1 81               [ 4]  204 	ret
                                    205 ;	lib/src/stm8s_gpio.c: 167: void GPIO_WriteLow(GPIO_TypeDef* GPIOx, GPIO_Pin_TypeDef PortPins)
                                    206 ;	-----------------------------------------
                                    207 ;	 function GPIO_WriteLow
                                    208 ;	-----------------------------------------
      0085E2                        209 _GPIO_WriteLow:
      0085E2 88               [ 1]  210 	push	a
                                    211 ;	lib/src/stm8s_gpio.c: 169: GPIOx->ODR &= (uint8_t)(~PortPins);
      0085E3 88               [ 1]  212 	push	a
      0085E4 F6               [ 1]  213 	ld	a, (x)
      0085E5 6B 02            [ 1]  214 	ld	(0x02, sp), a
      0085E7 84               [ 1]  215 	pop	a
      0085E8 43               [ 1]  216 	cpl	a
      0085E9 14 01            [ 1]  217 	and	a, (0x01, sp)
      0085EB F7               [ 1]  218 	ld	(x), a
                                    219 ;	lib/src/stm8s_gpio.c: 170: }
      0085EC 84               [ 1]  220 	pop	a
      0085ED 81               [ 4]  221 	ret
                                    222 ;	lib/src/stm8s_gpio.c: 180: void GPIO_WriteReverse(GPIO_TypeDef* GPIOx, GPIO_Pin_TypeDef PortPins)
                                    223 ;	-----------------------------------------
                                    224 ;	 function GPIO_WriteReverse
                                    225 ;	-----------------------------------------
      0085EE                        226 _GPIO_WriteReverse:
      0085EE 88               [ 1]  227 	push	a
      0085EF 6B 01            [ 1]  228 	ld	(0x01, sp), a
                                    229 ;	lib/src/stm8s_gpio.c: 182: GPIOx->ODR ^= (uint8_t)PortPins;
      0085F1 F6               [ 1]  230 	ld	a, (x)
      0085F2 18 01            [ 1]  231 	xor	a, (0x01, sp)
      0085F4 F7               [ 1]  232 	ld	(x), a
                                    233 ;	lib/src/stm8s_gpio.c: 183: }
      0085F5 84               [ 1]  234 	pop	a
      0085F6 81               [ 4]  235 	ret
                                    236 ;	lib/src/stm8s_gpio.c: 191: uint8_t GPIO_ReadOutputData(GPIO_TypeDef* GPIOx)
                                    237 ;	-----------------------------------------
                                    238 ;	 function GPIO_ReadOutputData
                                    239 ;	-----------------------------------------
      0085F7                        240 _GPIO_ReadOutputData:
                                    241 ;	lib/src/stm8s_gpio.c: 193: return ((uint8_t)GPIOx->ODR);
      0085F7 F6               [ 1]  242 	ld	a, (x)
                                    243 ;	lib/src/stm8s_gpio.c: 194: }
      0085F8 81               [ 4]  244 	ret
                                    245 ;	lib/src/stm8s_gpio.c: 202: uint8_t GPIO_ReadInputData(GPIO_TypeDef* GPIOx)
                                    246 ;	-----------------------------------------
                                    247 ;	 function GPIO_ReadInputData
                                    248 ;	-----------------------------------------
      0085F9                        249 _GPIO_ReadInputData:
                                    250 ;	lib/src/stm8s_gpio.c: 204: return ((uint8_t)GPIOx->IDR);
      0085F9 E6 01            [ 1]  251 	ld	a, (0x1, x)
                                    252 ;	lib/src/stm8s_gpio.c: 205: }
      0085FB 81               [ 4]  253 	ret
                                    254 ;	lib/src/stm8s_gpio.c: 213: BitStatus GPIO_ReadInputPin(GPIO_TypeDef* GPIOx, GPIO_Pin_TypeDef GPIO_Pin)
                                    255 ;	-----------------------------------------
                                    256 ;	 function GPIO_ReadInputPin
                                    257 ;	-----------------------------------------
      0085FC                        258 _GPIO_ReadInputPin:
      0085FC 88               [ 1]  259 	push	a
      0085FD 6B 01            [ 1]  260 	ld	(0x01, sp), a
                                    261 ;	lib/src/stm8s_gpio.c: 215: return ((BitStatus)(GPIOx->IDR & (uint8_t)GPIO_Pin));
      0085FF E6 01            [ 1]  262 	ld	a, (0x1, x)
      008601 14 01            [ 1]  263 	and	a, (0x01, sp)
      008603 40               [ 1]  264 	neg	a
      008604 4F               [ 1]  265 	clr	a
      008605 49               [ 1]  266 	rlc	a
                                    267 ;	lib/src/stm8s_gpio.c: 216: }
      008606 5B 01            [ 2]  268 	addw	sp, #1
      008608 81               [ 4]  269 	ret
                                    270 ;	lib/src/stm8s_gpio.c: 225: void GPIO_ExternalPullUpConfig(GPIO_TypeDef* GPIOx, GPIO_Pin_TypeDef GPIO_Pin, FunctionalState NewState)
                                    271 ;	-----------------------------------------
                                    272 ;	 function GPIO_ExternalPullUpConfig
                                    273 ;	-----------------------------------------
      008609                        274 _GPIO_ExternalPullUpConfig:
      008609 88               [ 1]  275 	push	a
                                    276 ;	lib/src/stm8s_gpio.c: 233: GPIOx->CR1 |= (uint8_t)GPIO_Pin;
      00860A 1C 00 03         [ 2]  277 	addw	x, #0x0003
      00860D 88               [ 1]  278 	push	a
      00860E F6               [ 1]  279 	ld	a, (x)
      00860F 6B 02            [ 1]  280 	ld	(0x02, sp), a
      008611 84               [ 1]  281 	pop	a
                                    282 ;	lib/src/stm8s_gpio.c: 231: if (NewState != DISABLE) /* External Pull-Up Set*/
      008612 0D 04            [ 1]  283 	tnz	(0x04, sp)
      008614 27 05            [ 1]  284 	jreq	00102$
                                    285 ;	lib/src/stm8s_gpio.c: 233: GPIOx->CR1 |= (uint8_t)GPIO_Pin;
      008616 1A 01            [ 1]  286 	or	a, (0x01, sp)
      008618 F7               [ 1]  287 	ld	(x), a
      008619 20 04            [ 2]  288 	jra	00104$
      00861B                        289 00102$:
                                    290 ;	lib/src/stm8s_gpio.c: 236: GPIOx->CR1 &= (uint8_t)(~(GPIO_Pin));
      00861B 43               [ 1]  291 	cpl	a
      00861C 14 01            [ 1]  292 	and	a, (0x01, sp)
      00861E F7               [ 1]  293 	ld	(x), a
      00861F                        294 00104$:
                                    295 ;	lib/src/stm8s_gpio.c: 238: }
      00861F 84               [ 1]  296 	pop	a
      008620 85               [ 2]  297 	popw	x
      008621 84               [ 1]  298 	pop	a
      008622 FC               [ 2]  299 	jp	(x)
                                    300 	.area CODE
                                    301 	.area CONST
                                    302 	.area INITIALIZER
                                    303 	.area CABS (ABS)
