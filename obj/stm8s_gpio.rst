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
      008543                         61 _GPIO_DeInit:
      008543 51               [ 1]   62 	exgw	x, y
                                     63 ;	lib/src/stm8s_gpio.c: 55: GPIOx->ODR = GPIO_ODR_RESET_VALUE; /* Reset Output Data Register */
      008544 90 7F            [ 1]   64 	clr	(y)
                                     65 ;	lib/src/stm8s_gpio.c: 56: GPIOx->DDR = GPIO_DDR_RESET_VALUE; /* Reset Data Direction Register */
      008546 93               [ 1]   66 	ldw	x, y
      008547 6F 02            [ 1]   67 	clr	(0x02, x)
                                     68 ;	lib/src/stm8s_gpio.c: 57: GPIOx->CR1 = GPIO_CR1_RESET_VALUE; /* Reset Control Register 1 */
      008549 93               [ 1]   69 	ldw	x, y
      00854A 6F 03            [ 1]   70 	clr	(0x0003, x)
                                     71 ;	lib/src/stm8s_gpio.c: 58: GPIOx->CR2 = GPIO_CR2_RESET_VALUE; /* Reset Control Register 2 */
      00854C 93               [ 1]   72 	ldw	x, y
      00854D 6F 04            [ 1]   73 	clr	(0x0004, x)
                                     74 ;	lib/src/stm8s_gpio.c: 59: }
      00854F 81               [ 4]   75 	ret
                                     76 ;	lib/src/stm8s_gpio.c: 71: void GPIO_Init(GPIO_TypeDef* GPIOx, GPIO_Pin_TypeDef GPIO_Pin, GPIO_Mode_TypeDef GPIO_Mode)
                                     77 ;	-----------------------------------------
                                     78 ;	 function GPIO_Init
                                     79 ;	-----------------------------------------
      008550                         80 _GPIO_Init:
      008550 52 08            [ 2]   81 	sub	sp, #8
      008552 1F 07            [ 2]   82 	ldw	(0x07, sp), x
      008554 6B 06            [ 1]   83 	ld	(0x06, sp), a
                                     84 ;	lib/src/stm8s_gpio.c: 81: GPIOx->CR2 &= (uint8_t)(~(GPIO_Pin));
      008556 1E 07            [ 2]   85 	ldw	x, (0x07, sp)
      008558 1C 00 04         [ 2]   86 	addw	x, #0x0004
      00855B 1F 01            [ 2]   87 	ldw	(0x01, sp), x
      00855D F6               [ 1]   88 	ld	a, (x)
      00855E 88               [ 1]   89 	push	a
      00855F 7B 07            [ 1]   90 	ld	a, (0x07, sp)
      008561 43               [ 1]   91 	cpl	a
      008562 6B 04            [ 1]   92 	ld	(0x04, sp), a
      008564 84               [ 1]   93 	pop	a
      008565 14 03            [ 1]   94 	and	a, (0x03, sp)
      008567 1E 01            [ 2]   95 	ldw	x, (0x01, sp)
      008569 F7               [ 1]   96 	ld	(x), a
                                     97 ;	lib/src/stm8s_gpio.c: 98: GPIOx->DDR |= (uint8_t)GPIO_Pin;
      00856A 1E 07            [ 2]   98 	ldw	x, (0x07, sp)
      00856C 5C               [ 1]   99 	incw	x
      00856D 5C               [ 1]  100 	incw	x
      00856E 1F 04            [ 2]  101 	ldw	(0x04, sp), x
                                    102 ;	lib/src/stm8s_gpio.c: 87: if ((((uint8_t)(GPIO_Mode)) & (uint8_t)0x80) != (uint8_t)0x00) /* Output mode */
      008570 0D 0B            [ 1]  103 	tnz	(0x0b, sp)
      008572 2A 1D            [ 1]  104 	jrpl	00105$
                                    105 ;	lib/src/stm8s_gpio.c: 91: GPIOx->ODR |= (uint8_t)GPIO_Pin;
      008574 1E 07            [ 2]  106 	ldw	x, (0x07, sp)
      008576 F6               [ 1]  107 	ld	a, (x)
                                    108 ;	lib/src/stm8s_gpio.c: 89: if ((((uint8_t)(GPIO_Mode)) & (uint8_t)0x10) != (uint8_t)0x00) /* High level */
      008577 88               [ 1]  109 	push	a
      008578 7B 0C            [ 1]  110 	ld	a, (0x0c, sp)
      00857A A5 10            [ 1]  111 	bcp	a, #0x10
      00857C 84               [ 1]  112 	pop	a
      00857D 27 05            [ 1]  113 	jreq	00102$
                                    114 ;	lib/src/stm8s_gpio.c: 91: GPIOx->ODR |= (uint8_t)GPIO_Pin;
      00857F 1A 06            [ 1]  115 	or	a, (0x06, sp)
      008581 F7               [ 1]  116 	ld	(x), a
      008582 20 03            [ 2]  117 	jra	00103$
      008584                        118 00102$:
                                    119 ;	lib/src/stm8s_gpio.c: 95: GPIOx->ODR &= (uint8_t)(~(GPIO_Pin));
      008584 14 03            [ 1]  120 	and	a, (0x03, sp)
      008586 F7               [ 1]  121 	ld	(x), a
      008587                        122 00103$:
                                    123 ;	lib/src/stm8s_gpio.c: 98: GPIOx->DDR |= (uint8_t)GPIO_Pin;
      008587 1E 04            [ 2]  124 	ldw	x, (0x04, sp)
      008589 F6               [ 1]  125 	ld	a, (x)
      00858A 1A 06            [ 1]  126 	or	a, (0x06, sp)
      00858C 1E 04            [ 2]  127 	ldw	x, (0x04, sp)
      00858E F7               [ 1]  128 	ld	(x), a
      00858F 20 08            [ 2]  129 	jra	00106$
      008591                        130 00105$:
                                    131 ;	lib/src/stm8s_gpio.c: 103: GPIOx->DDR &= (uint8_t)(~(GPIO_Pin));
      008591 1E 04            [ 2]  132 	ldw	x, (0x04, sp)
      008593 F6               [ 1]  133 	ld	a, (x)
      008594 14 03            [ 1]  134 	and	a, (0x03, sp)
      008596 1E 04            [ 2]  135 	ldw	x, (0x04, sp)
      008598 F7               [ 1]  136 	ld	(x), a
      008599                        137 00106$:
                                    138 ;	lib/src/stm8s_gpio.c: 112: GPIOx->CR1 |= (uint8_t)GPIO_Pin;
      008599 1E 07            [ 2]  139 	ldw	x, (0x07, sp)
      00859B 1C 00 03         [ 2]  140 	addw	x, #0x0003
      00859E F6               [ 1]  141 	ld	a, (x)
                                    142 ;	lib/src/stm8s_gpio.c: 110: if ((((uint8_t)(GPIO_Mode)) & (uint8_t)0x40) != (uint8_t)0x00) /* Pull-Up or Push-Pull */
      00859F 88               [ 1]  143 	push	a
      0085A0 7B 0C            [ 1]  144 	ld	a, (0x0c, sp)
      0085A2 A5 40            [ 1]  145 	bcp	a, #0x40
      0085A4 84               [ 1]  146 	pop	a
      0085A5 27 05            [ 1]  147 	jreq	00108$
                                    148 ;	lib/src/stm8s_gpio.c: 112: GPIOx->CR1 |= (uint8_t)GPIO_Pin;
      0085A7 1A 06            [ 1]  149 	or	a, (0x06, sp)
      0085A9 F7               [ 1]  150 	ld	(x), a
      0085AA 20 03            [ 2]  151 	jra	00109$
      0085AC                        152 00108$:
                                    153 ;	lib/src/stm8s_gpio.c: 116: GPIOx->CR1 &= (uint8_t)(~(GPIO_Pin));
      0085AC 14 03            [ 1]  154 	and	a, (0x03, sp)
      0085AE F7               [ 1]  155 	ld	(x), a
      0085AF                        156 00109$:
                                    157 ;	lib/src/stm8s_gpio.c: 81: GPIOx->CR2 &= (uint8_t)(~(GPIO_Pin));
      0085AF 1E 01            [ 2]  158 	ldw	x, (0x01, sp)
      0085B1 F6               [ 1]  159 	ld	a, (x)
                                    160 ;	lib/src/stm8s_gpio.c: 123: if ((((uint8_t)(GPIO_Mode)) & (uint8_t)0x20) != (uint8_t)0x00) /* Interrupt or Slow slope */
      0085B2 88               [ 1]  161 	push	a
      0085B3 7B 0C            [ 1]  162 	ld	a, (0x0c, sp)
      0085B5 A5 20            [ 1]  163 	bcp	a, #0x20
      0085B7 84               [ 1]  164 	pop	a
      0085B8 27 07            [ 1]  165 	jreq	00111$
                                    166 ;	lib/src/stm8s_gpio.c: 125: GPIOx->CR2 |= (uint8_t)GPIO_Pin;
      0085BA 1A 06            [ 1]  167 	or	a, (0x06, sp)
      0085BC 1E 01            [ 2]  168 	ldw	x, (0x01, sp)
      0085BE F7               [ 1]  169 	ld	(x), a
      0085BF 20 05            [ 2]  170 	jra	00113$
      0085C1                        171 00111$:
                                    172 ;	lib/src/stm8s_gpio.c: 129: GPIOx->CR2 &= (uint8_t)(~(GPIO_Pin));
      0085C1 14 03            [ 1]  173 	and	a, (0x03, sp)
      0085C3 1E 01            [ 2]  174 	ldw	x, (0x01, sp)
      0085C5 F7               [ 1]  175 	ld	(x), a
      0085C6                        176 00113$:
                                    177 ;	lib/src/stm8s_gpio.c: 131: }
      0085C6 5B 08            [ 2]  178 	addw	sp, #8
      0085C8 85               [ 2]  179 	popw	x
      0085C9 84               [ 1]  180 	pop	a
      0085CA FC               [ 2]  181 	jp	(x)
                                    182 ;	lib/src/stm8s_gpio.c: 141: void GPIO_Write(GPIO_TypeDef* GPIOx, uint8_t PortVal)
                                    183 ;	-----------------------------------------
                                    184 ;	 function GPIO_Write
                                    185 ;	-----------------------------------------
      0085CB                        186 _GPIO_Write:
                                    187 ;	lib/src/stm8s_gpio.c: 143: GPIOx->ODR = PortVal;
      0085CB F7               [ 1]  188 	ld	(x), a
                                    189 ;	lib/src/stm8s_gpio.c: 144: }
      0085CC 81               [ 4]  190 	ret
                                    191 ;	lib/src/stm8s_gpio.c: 154: void GPIO_WriteHigh(GPIO_TypeDef* GPIOx, GPIO_Pin_TypeDef PortPins)
                                    192 ;	-----------------------------------------
                                    193 ;	 function GPIO_WriteHigh
                                    194 ;	-----------------------------------------
      0085CD                        195 _GPIO_WriteHigh:
      0085CD 88               [ 1]  196 	push	a
      0085CE 6B 01            [ 1]  197 	ld	(0x01, sp), a
                                    198 ;	lib/src/stm8s_gpio.c: 156: GPIOx->ODR |= (uint8_t)PortPins;
      0085D0 F6               [ 1]  199 	ld	a, (x)
      0085D1 1A 01            [ 1]  200 	or	a, (0x01, sp)
      0085D3 F7               [ 1]  201 	ld	(x), a
                                    202 ;	lib/src/stm8s_gpio.c: 157: }
      0085D4 84               [ 1]  203 	pop	a
      0085D5 81               [ 4]  204 	ret
                                    205 ;	lib/src/stm8s_gpio.c: 167: void GPIO_WriteLow(GPIO_TypeDef* GPIOx, GPIO_Pin_TypeDef PortPins)
                                    206 ;	-----------------------------------------
                                    207 ;	 function GPIO_WriteLow
                                    208 ;	-----------------------------------------
      0085D6                        209 _GPIO_WriteLow:
      0085D6 88               [ 1]  210 	push	a
                                    211 ;	lib/src/stm8s_gpio.c: 169: GPIOx->ODR &= (uint8_t)(~PortPins);
      0085D7 88               [ 1]  212 	push	a
      0085D8 F6               [ 1]  213 	ld	a, (x)
      0085D9 6B 02            [ 1]  214 	ld	(0x02, sp), a
      0085DB 84               [ 1]  215 	pop	a
      0085DC 43               [ 1]  216 	cpl	a
      0085DD 14 01            [ 1]  217 	and	a, (0x01, sp)
      0085DF F7               [ 1]  218 	ld	(x), a
                                    219 ;	lib/src/stm8s_gpio.c: 170: }
      0085E0 84               [ 1]  220 	pop	a
      0085E1 81               [ 4]  221 	ret
                                    222 ;	lib/src/stm8s_gpio.c: 180: void GPIO_WriteReverse(GPIO_TypeDef* GPIOx, GPIO_Pin_TypeDef PortPins)
                                    223 ;	-----------------------------------------
                                    224 ;	 function GPIO_WriteReverse
                                    225 ;	-----------------------------------------
      0085E2                        226 _GPIO_WriteReverse:
      0085E2 88               [ 1]  227 	push	a
      0085E3 6B 01            [ 1]  228 	ld	(0x01, sp), a
                                    229 ;	lib/src/stm8s_gpio.c: 182: GPIOx->ODR ^= (uint8_t)PortPins;
      0085E5 F6               [ 1]  230 	ld	a, (x)
      0085E6 18 01            [ 1]  231 	xor	a, (0x01, sp)
      0085E8 F7               [ 1]  232 	ld	(x), a
                                    233 ;	lib/src/stm8s_gpio.c: 183: }
      0085E9 84               [ 1]  234 	pop	a
      0085EA 81               [ 4]  235 	ret
                                    236 ;	lib/src/stm8s_gpio.c: 191: uint8_t GPIO_ReadOutputData(GPIO_TypeDef* GPIOx)
                                    237 ;	-----------------------------------------
                                    238 ;	 function GPIO_ReadOutputData
                                    239 ;	-----------------------------------------
      0085EB                        240 _GPIO_ReadOutputData:
                                    241 ;	lib/src/stm8s_gpio.c: 193: return ((uint8_t)GPIOx->ODR);
      0085EB F6               [ 1]  242 	ld	a, (x)
                                    243 ;	lib/src/stm8s_gpio.c: 194: }
      0085EC 81               [ 4]  244 	ret
                                    245 ;	lib/src/stm8s_gpio.c: 202: uint8_t GPIO_ReadInputData(GPIO_TypeDef* GPIOx)
                                    246 ;	-----------------------------------------
                                    247 ;	 function GPIO_ReadInputData
                                    248 ;	-----------------------------------------
      0085ED                        249 _GPIO_ReadInputData:
                                    250 ;	lib/src/stm8s_gpio.c: 204: return ((uint8_t)GPIOx->IDR);
      0085ED E6 01            [ 1]  251 	ld	a, (0x1, x)
                                    252 ;	lib/src/stm8s_gpio.c: 205: }
      0085EF 81               [ 4]  253 	ret
                                    254 ;	lib/src/stm8s_gpio.c: 213: BitStatus GPIO_ReadInputPin(GPIO_TypeDef* GPIOx, GPIO_Pin_TypeDef GPIO_Pin)
                                    255 ;	-----------------------------------------
                                    256 ;	 function GPIO_ReadInputPin
                                    257 ;	-----------------------------------------
      0085F0                        258 _GPIO_ReadInputPin:
      0085F0 88               [ 1]  259 	push	a
      0085F1 6B 01            [ 1]  260 	ld	(0x01, sp), a
                                    261 ;	lib/src/stm8s_gpio.c: 215: return ((BitStatus)(GPIOx->IDR & (uint8_t)GPIO_Pin));
      0085F3 E6 01            [ 1]  262 	ld	a, (0x1, x)
      0085F5 14 01            [ 1]  263 	and	a, (0x01, sp)
      0085F7 40               [ 1]  264 	neg	a
      0085F8 4F               [ 1]  265 	clr	a
      0085F9 49               [ 1]  266 	rlc	a
                                    267 ;	lib/src/stm8s_gpio.c: 216: }
      0085FA 5B 01            [ 2]  268 	addw	sp, #1
      0085FC 81               [ 4]  269 	ret
                                    270 ;	lib/src/stm8s_gpio.c: 225: void GPIO_ExternalPullUpConfig(GPIO_TypeDef* GPIOx, GPIO_Pin_TypeDef GPIO_Pin, FunctionalState NewState)
                                    271 ;	-----------------------------------------
                                    272 ;	 function GPIO_ExternalPullUpConfig
                                    273 ;	-----------------------------------------
      0085FD                        274 _GPIO_ExternalPullUpConfig:
      0085FD 88               [ 1]  275 	push	a
                                    276 ;	lib/src/stm8s_gpio.c: 233: GPIOx->CR1 |= (uint8_t)GPIO_Pin;
      0085FE 1C 00 03         [ 2]  277 	addw	x, #0x0003
      008601 88               [ 1]  278 	push	a
      008602 F6               [ 1]  279 	ld	a, (x)
      008603 6B 02            [ 1]  280 	ld	(0x02, sp), a
      008605 84               [ 1]  281 	pop	a
                                    282 ;	lib/src/stm8s_gpio.c: 231: if (NewState != DISABLE) /* External Pull-Up Set*/
      008606 0D 04            [ 1]  283 	tnz	(0x04, sp)
      008608 27 05            [ 1]  284 	jreq	00102$
                                    285 ;	lib/src/stm8s_gpio.c: 233: GPIOx->CR1 |= (uint8_t)GPIO_Pin;
      00860A 1A 01            [ 1]  286 	or	a, (0x01, sp)
      00860C F7               [ 1]  287 	ld	(x), a
      00860D 20 04            [ 2]  288 	jra	00104$
      00860F                        289 00102$:
                                    290 ;	lib/src/stm8s_gpio.c: 236: GPIOx->CR1 &= (uint8_t)(~(GPIO_Pin));
      00860F 43               [ 1]  291 	cpl	a
      008610 14 01            [ 1]  292 	and	a, (0x01, sp)
      008612 F7               [ 1]  293 	ld	(x), a
      008613                        294 00104$:
                                    295 ;	lib/src/stm8s_gpio.c: 238: }
      008613 84               [ 1]  296 	pop	a
      008614 85               [ 2]  297 	popw	x
      008615 84               [ 1]  298 	pop	a
      008616 FC               [ 2]  299 	jp	(x)
                                    300 	.area CODE
                                    301 	.area CONST
                                    302 	.area INITIALIZER
                                    303 	.area CABS (ABS)
