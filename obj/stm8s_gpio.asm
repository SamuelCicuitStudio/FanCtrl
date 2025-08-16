;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler
; Version 4.5.0 #15242 (MINGW64)
;--------------------------------------------------------
	.module stm8s_gpio
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _GPIO_DeInit
	.globl _GPIO_Init
	.globl _GPIO_Write
	.globl _GPIO_WriteHigh
	.globl _GPIO_WriteLow
	.globl _GPIO_WriteReverse
	.globl _GPIO_ReadOutputData
	.globl _GPIO_ReadInputData
	.globl _GPIO_ReadInputPin
	.globl _GPIO_ExternalPullUpConfig
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area DATA
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area INITIALIZED
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
; global & static initialisations
;--------------------------------------------------------
	.area HOME
	.area GSINIT
	.area GSFINAL
	.area GSINIT
;--------------------------------------------------------
; Home
;--------------------------------------------------------
	.area HOME
	.area HOME
;--------------------------------------------------------
; code
;--------------------------------------------------------
	.area CODE
;	lib/src/stm8s_gpio.c: 53: void GPIO_DeInit(GPIO_TypeDef* GPIOx)
;	-----------------------------------------
;	 function GPIO_DeInit
;	-----------------------------------------
_GPIO_DeInit:
	exgw	x, y
;	lib/src/stm8s_gpio.c: 55: GPIOx->ODR = GPIO_ODR_RESET_VALUE; /* Reset Output Data Register */
	clr	(y)
;	lib/src/stm8s_gpio.c: 56: GPIOx->DDR = GPIO_DDR_RESET_VALUE; /* Reset Data Direction Register */
	ldw	x, y
	clr	(0x02, x)
;	lib/src/stm8s_gpio.c: 57: GPIOx->CR1 = GPIO_CR1_RESET_VALUE; /* Reset Control Register 1 */
	ldw	x, y
	clr	(0x0003, x)
;	lib/src/stm8s_gpio.c: 58: GPIOx->CR2 = GPIO_CR2_RESET_VALUE; /* Reset Control Register 2 */
	ldw	x, y
	clr	(0x0004, x)
;	lib/src/stm8s_gpio.c: 59: }
	ret
;	lib/src/stm8s_gpio.c: 71: void GPIO_Init(GPIO_TypeDef* GPIOx, GPIO_Pin_TypeDef GPIO_Pin, GPIO_Mode_TypeDef GPIO_Mode)
;	-----------------------------------------
;	 function GPIO_Init
;	-----------------------------------------
_GPIO_Init:
	sub	sp, #8
	ldw	(0x07, sp), x
	ld	(0x06, sp), a
;	lib/src/stm8s_gpio.c: 81: GPIOx->CR2 &= (uint8_t)(~(GPIO_Pin));
	ldw	x, (0x07, sp)
	addw	x, #0x0004
	ldw	(0x01, sp), x
	ld	a, (x)
	push	a
	ld	a, (0x07, sp)
	cpl	a
	ld	(0x04, sp), a
	pop	a
	and	a, (0x03, sp)
	ldw	x, (0x01, sp)
	ld	(x), a
;	lib/src/stm8s_gpio.c: 98: GPIOx->DDR |= (uint8_t)GPIO_Pin;
	ldw	x, (0x07, sp)
	incw	x
	incw	x
	ldw	(0x04, sp), x
;	lib/src/stm8s_gpio.c: 87: if ((((uint8_t)(GPIO_Mode)) & (uint8_t)0x80) != (uint8_t)0x00) /* Output mode */
	tnz	(0x0b, sp)
	jrpl	00105$
;	lib/src/stm8s_gpio.c: 91: GPIOx->ODR |= (uint8_t)GPIO_Pin;
	ldw	x, (0x07, sp)
	ld	a, (x)
;	lib/src/stm8s_gpio.c: 89: if ((((uint8_t)(GPIO_Mode)) & (uint8_t)0x10) != (uint8_t)0x00) /* High level */
	push	a
	ld	a, (0x0c, sp)
	bcp	a, #0x10
	pop	a
	jreq	00102$
;	lib/src/stm8s_gpio.c: 91: GPIOx->ODR |= (uint8_t)GPIO_Pin;
	or	a, (0x06, sp)
	ld	(x), a
	jra	00103$
00102$:
;	lib/src/stm8s_gpio.c: 95: GPIOx->ODR &= (uint8_t)(~(GPIO_Pin));
	and	a, (0x03, sp)
	ld	(x), a
00103$:
;	lib/src/stm8s_gpio.c: 98: GPIOx->DDR |= (uint8_t)GPIO_Pin;
	ldw	x, (0x04, sp)
	ld	a, (x)
	or	a, (0x06, sp)
	ldw	x, (0x04, sp)
	ld	(x), a
	jra	00106$
00105$:
;	lib/src/stm8s_gpio.c: 103: GPIOx->DDR &= (uint8_t)(~(GPIO_Pin));
	ldw	x, (0x04, sp)
	ld	a, (x)
	and	a, (0x03, sp)
	ldw	x, (0x04, sp)
	ld	(x), a
00106$:
;	lib/src/stm8s_gpio.c: 112: GPIOx->CR1 |= (uint8_t)GPIO_Pin;
	ldw	x, (0x07, sp)
	addw	x, #0x0003
	ld	a, (x)
;	lib/src/stm8s_gpio.c: 110: if ((((uint8_t)(GPIO_Mode)) & (uint8_t)0x40) != (uint8_t)0x00) /* Pull-Up or Push-Pull */
	push	a
	ld	a, (0x0c, sp)
	bcp	a, #0x40
	pop	a
	jreq	00108$
;	lib/src/stm8s_gpio.c: 112: GPIOx->CR1 |= (uint8_t)GPIO_Pin;
	or	a, (0x06, sp)
	ld	(x), a
	jra	00109$
00108$:
;	lib/src/stm8s_gpio.c: 116: GPIOx->CR1 &= (uint8_t)(~(GPIO_Pin));
	and	a, (0x03, sp)
	ld	(x), a
00109$:
;	lib/src/stm8s_gpio.c: 81: GPIOx->CR2 &= (uint8_t)(~(GPIO_Pin));
	ldw	x, (0x01, sp)
	ld	a, (x)
;	lib/src/stm8s_gpio.c: 123: if ((((uint8_t)(GPIO_Mode)) & (uint8_t)0x20) != (uint8_t)0x00) /* Interrupt or Slow slope */
	push	a
	ld	a, (0x0c, sp)
	bcp	a, #0x20
	pop	a
	jreq	00111$
;	lib/src/stm8s_gpio.c: 125: GPIOx->CR2 |= (uint8_t)GPIO_Pin;
	or	a, (0x06, sp)
	ldw	x, (0x01, sp)
	ld	(x), a
	jra	00113$
00111$:
;	lib/src/stm8s_gpio.c: 129: GPIOx->CR2 &= (uint8_t)(~(GPIO_Pin));
	and	a, (0x03, sp)
	ldw	x, (0x01, sp)
	ld	(x), a
00113$:
;	lib/src/stm8s_gpio.c: 131: }
	addw	sp, #8
	popw	x
	pop	a
	jp	(x)
;	lib/src/stm8s_gpio.c: 141: void GPIO_Write(GPIO_TypeDef* GPIOx, uint8_t PortVal)
;	-----------------------------------------
;	 function GPIO_Write
;	-----------------------------------------
_GPIO_Write:
;	lib/src/stm8s_gpio.c: 143: GPIOx->ODR = PortVal;
	ld	(x), a
;	lib/src/stm8s_gpio.c: 144: }
	ret
;	lib/src/stm8s_gpio.c: 154: void GPIO_WriteHigh(GPIO_TypeDef* GPIOx, GPIO_Pin_TypeDef PortPins)
;	-----------------------------------------
;	 function GPIO_WriteHigh
;	-----------------------------------------
_GPIO_WriteHigh:
	push	a
	ld	(0x01, sp), a
;	lib/src/stm8s_gpio.c: 156: GPIOx->ODR |= (uint8_t)PortPins;
	ld	a, (x)
	or	a, (0x01, sp)
	ld	(x), a
;	lib/src/stm8s_gpio.c: 157: }
	pop	a
	ret
;	lib/src/stm8s_gpio.c: 167: void GPIO_WriteLow(GPIO_TypeDef* GPIOx, GPIO_Pin_TypeDef PortPins)
;	-----------------------------------------
;	 function GPIO_WriteLow
;	-----------------------------------------
_GPIO_WriteLow:
	push	a
;	lib/src/stm8s_gpio.c: 169: GPIOx->ODR &= (uint8_t)(~PortPins);
	push	a
	ld	a, (x)
	ld	(0x02, sp), a
	pop	a
	cpl	a
	and	a, (0x01, sp)
	ld	(x), a
;	lib/src/stm8s_gpio.c: 170: }
	pop	a
	ret
;	lib/src/stm8s_gpio.c: 180: void GPIO_WriteReverse(GPIO_TypeDef* GPIOx, GPIO_Pin_TypeDef PortPins)
;	-----------------------------------------
;	 function GPIO_WriteReverse
;	-----------------------------------------
_GPIO_WriteReverse:
	push	a
	ld	(0x01, sp), a
;	lib/src/stm8s_gpio.c: 182: GPIOx->ODR ^= (uint8_t)PortPins;
	ld	a, (x)
	xor	a, (0x01, sp)
	ld	(x), a
;	lib/src/stm8s_gpio.c: 183: }
	pop	a
	ret
;	lib/src/stm8s_gpio.c: 191: uint8_t GPIO_ReadOutputData(GPIO_TypeDef* GPIOx)
;	-----------------------------------------
;	 function GPIO_ReadOutputData
;	-----------------------------------------
_GPIO_ReadOutputData:
;	lib/src/stm8s_gpio.c: 193: return ((uint8_t)GPIOx->ODR);
	ld	a, (x)
;	lib/src/stm8s_gpio.c: 194: }
	ret
;	lib/src/stm8s_gpio.c: 202: uint8_t GPIO_ReadInputData(GPIO_TypeDef* GPIOx)
;	-----------------------------------------
;	 function GPIO_ReadInputData
;	-----------------------------------------
_GPIO_ReadInputData:
;	lib/src/stm8s_gpio.c: 204: return ((uint8_t)GPIOx->IDR);
	ld	a, (0x1, x)
;	lib/src/stm8s_gpio.c: 205: }
	ret
;	lib/src/stm8s_gpio.c: 213: BitStatus GPIO_ReadInputPin(GPIO_TypeDef* GPIOx, GPIO_Pin_TypeDef GPIO_Pin)
;	-----------------------------------------
;	 function GPIO_ReadInputPin
;	-----------------------------------------
_GPIO_ReadInputPin:
	push	a
	ld	(0x01, sp), a
;	lib/src/stm8s_gpio.c: 215: return ((BitStatus)(GPIOx->IDR & (uint8_t)GPIO_Pin));
	ld	a, (0x1, x)
	and	a, (0x01, sp)
	neg	a
	clr	a
	rlc	a
;	lib/src/stm8s_gpio.c: 216: }
	addw	sp, #1
	ret
;	lib/src/stm8s_gpio.c: 225: void GPIO_ExternalPullUpConfig(GPIO_TypeDef* GPIOx, GPIO_Pin_TypeDef GPIO_Pin, FunctionalState NewState)
;	-----------------------------------------
;	 function GPIO_ExternalPullUpConfig
;	-----------------------------------------
_GPIO_ExternalPullUpConfig:
	push	a
;	lib/src/stm8s_gpio.c: 233: GPIOx->CR1 |= (uint8_t)GPIO_Pin;
	addw	x, #0x0003
	push	a
	ld	a, (x)
	ld	(0x02, sp), a
	pop	a
;	lib/src/stm8s_gpio.c: 231: if (NewState != DISABLE) /* External Pull-Up Set*/
	tnz	(0x04, sp)
	jreq	00102$
;	lib/src/stm8s_gpio.c: 233: GPIOx->CR1 |= (uint8_t)GPIO_Pin;
	or	a, (0x01, sp)
	ld	(x), a
	jra	00104$
00102$:
;	lib/src/stm8s_gpio.c: 236: GPIOx->CR1 &= (uint8_t)(~(GPIO_Pin));
	cpl	a
	and	a, (0x01, sp)
	ld	(x), a
00104$:
;	lib/src/stm8s_gpio.c: 238: }
	pop	a
	popw	x
	pop	a
	jp	(x)
	.area CODE
	.area CONST
	.area INITIALIZER
	.area CABS (ABS)
