;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler
; Version 4.5.0 #15242 (MINGW64)
;--------------------------------------------------------
	.module stm8s_tim4
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _TIM4_DeInit
	.globl _TIM4_TimeBaseInit
	.globl _TIM4_Cmd
	.globl _TIM4_ITConfig
	.globl _TIM4_UpdateDisableConfig
	.globl _TIM4_UpdateRequestConfig
	.globl _TIM4_SelectOnePulseMode
	.globl _TIM4_PrescalerConfig
	.globl _TIM4_ARRPreloadConfig
	.globl _TIM4_GenerateEvent
	.globl _TIM4_SetCounter
	.globl _TIM4_SetAutoreload
	.globl _TIM4_GetCounter
	.globl _TIM4_GetPrescaler
	.globl _TIM4_GetFlagStatus
	.globl _TIM4_ClearFlag
	.globl _TIM4_GetITStatus
	.globl _TIM4_ClearITPendingBit
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
;	lib/src/stm8s_tim4.c: 49: void TIM4_DeInit(void)
;	-----------------------------------------
;	 function TIM4_DeInit
;	-----------------------------------------
_TIM4_DeInit:
;	lib/src/stm8s_tim4.c: 51: TIM4->CR1 = TIM4_CR1_RESET_VALUE;
	mov	0x5340+0, #0x00
;	lib/src/stm8s_tim4.c: 52: TIM4->IER = TIM4_IER_RESET_VALUE;
	mov	0x5343+0, #0x00
;	lib/src/stm8s_tim4.c: 53: TIM4->CNTR = TIM4_CNTR_RESET_VALUE;
	mov	0x5346+0, #0x00
;	lib/src/stm8s_tim4.c: 54: TIM4->PSCR = TIM4_PSCR_RESET_VALUE;
	mov	0x5347+0, #0x00
;	lib/src/stm8s_tim4.c: 55: TIM4->ARR = TIM4_ARR_RESET_VALUE;
	mov	0x5348+0, #0xff
;	lib/src/stm8s_tim4.c: 56: TIM4->SR1 = TIM4_SR1_RESET_VALUE;
	mov	0x5344+0, #0x00
;	lib/src/stm8s_tim4.c: 57: }
	ret
;	lib/src/stm8s_tim4.c: 65: void TIM4_TimeBaseInit(TIM4_Prescaler_TypeDef TIM4_Prescaler, uint8_t TIM4_Period)
;	-----------------------------------------
;	 function TIM4_TimeBaseInit
;	-----------------------------------------
_TIM4_TimeBaseInit:
;	lib/src/stm8s_tim4.c: 70: TIM4->PSCR = (uint8_t)(TIM4_Prescaler);
	ld	0x5347, a
;	lib/src/stm8s_tim4.c: 72: TIM4->ARR = (uint8_t)(TIM4_Period);
	ldw	x, #0x5348
	ld	a, (0x03, sp)
	ld	(x), a
;	lib/src/stm8s_tim4.c: 73: }
	popw	x
	pop	a
	jp	(x)
;	lib/src/stm8s_tim4.c: 81: void TIM4_Cmd(FunctionalState NewState)
;	-----------------------------------------
;	 function TIM4_Cmd
;	-----------------------------------------
_TIM4_Cmd:
	push	a
	ld	(0x01, sp), a
;	lib/src/stm8s_tim4.c: 89: TIM4->CR1 |= TIM4_CR1_CEN;
	ld	a, 0x5340
;	lib/src/stm8s_tim4.c: 87: if (NewState != DISABLE)
	tnz	(0x01, sp)
	jreq	00102$
;	lib/src/stm8s_tim4.c: 89: TIM4->CR1 |= TIM4_CR1_CEN;
	or	a, #0x01
	ld	0x5340, a
	jra	00104$
00102$:
;	lib/src/stm8s_tim4.c: 93: TIM4->CR1 &= (uint8_t)(~TIM4_CR1_CEN);
	and	a, #0xfe
	ld	0x5340, a
00104$:
;	lib/src/stm8s_tim4.c: 95: }
	pop	a
	ret
;	lib/src/stm8s_tim4.c: 107: void TIM4_ITConfig(TIM4_IT_TypeDef TIM4_IT, FunctionalState NewState)
;	-----------------------------------------
;	 function TIM4_ITConfig
;	-----------------------------------------
_TIM4_ITConfig:
	push	a
	ld	xl, a
;	lib/src/stm8s_tim4.c: 116: TIM4->IER |= (uint8_t)TIM4_IT;
	ld	a, 0x5343
	ld	(0x01, sp), a
;	lib/src/stm8s_tim4.c: 113: if (NewState != DISABLE)
	tnz	(0x04, sp)
	jreq	00102$
;	lib/src/stm8s_tim4.c: 116: TIM4->IER |= (uint8_t)TIM4_IT;
	ld	a, xl
	or	a, (0x01, sp)
	ld	0x5343, a
	jra	00104$
00102$:
;	lib/src/stm8s_tim4.c: 121: TIM4->IER &= (uint8_t)(~TIM4_IT);
	ld	a, xl
	cpl	a
	and	a, (0x01, sp)
	ld	0x5343, a
00104$:
;	lib/src/stm8s_tim4.c: 123: }
	pop	a
	popw	x
	pop	a
	jp	(x)
;	lib/src/stm8s_tim4.c: 131: void TIM4_UpdateDisableConfig(FunctionalState NewState)
;	-----------------------------------------
;	 function TIM4_UpdateDisableConfig
;	-----------------------------------------
_TIM4_UpdateDisableConfig:
	push	a
	ld	(0x01, sp), a
;	lib/src/stm8s_tim4.c: 139: TIM4->CR1 |= TIM4_CR1_UDIS;
	ld	a, 0x5340
;	lib/src/stm8s_tim4.c: 137: if (NewState != DISABLE)
	tnz	(0x01, sp)
	jreq	00102$
;	lib/src/stm8s_tim4.c: 139: TIM4->CR1 |= TIM4_CR1_UDIS;
	or	a, #0x02
	ld	0x5340, a
	jra	00104$
00102$:
;	lib/src/stm8s_tim4.c: 143: TIM4->CR1 &= (uint8_t)(~TIM4_CR1_UDIS);
	and	a, #0xfd
	ld	0x5340, a
00104$:
;	lib/src/stm8s_tim4.c: 145: }
	pop	a
	ret
;	lib/src/stm8s_tim4.c: 155: void TIM4_UpdateRequestConfig(TIM4_UpdateSource_TypeDef TIM4_UpdateSource)
;	-----------------------------------------
;	 function TIM4_UpdateRequestConfig
;	-----------------------------------------
_TIM4_UpdateRequestConfig:
	push	a
	ld	(0x01, sp), a
;	lib/src/stm8s_tim4.c: 163: TIM4->CR1 |= TIM4_CR1_URS;
	ld	a, 0x5340
;	lib/src/stm8s_tim4.c: 161: if (TIM4_UpdateSource != TIM4_UPDATESOURCE_GLOBAL)
	tnz	(0x01, sp)
	jreq	00102$
;	lib/src/stm8s_tim4.c: 163: TIM4->CR1 |= TIM4_CR1_URS;
	or	a, #0x04
	ld	0x5340, a
	jra	00104$
00102$:
;	lib/src/stm8s_tim4.c: 167: TIM4->CR1 &= (uint8_t)(~TIM4_CR1_URS);
	and	a, #0xfb
	ld	0x5340, a
00104$:
;	lib/src/stm8s_tim4.c: 169: }
	pop	a
	ret
;	lib/src/stm8s_tim4.c: 179: void TIM4_SelectOnePulseMode(TIM4_OPMode_TypeDef TIM4_OPMode)
;	-----------------------------------------
;	 function TIM4_SelectOnePulseMode
;	-----------------------------------------
_TIM4_SelectOnePulseMode:
	push	a
	ld	(0x01, sp), a
;	lib/src/stm8s_tim4.c: 187: TIM4->CR1 |= TIM4_CR1_OPM;
	ld	a, 0x5340
;	lib/src/stm8s_tim4.c: 185: if (TIM4_OPMode != TIM4_OPMODE_REPETITIVE)
	tnz	(0x01, sp)
	jreq	00102$
;	lib/src/stm8s_tim4.c: 187: TIM4->CR1 |= TIM4_CR1_OPM;
	or	a, #0x08
	ld	0x5340, a
	jra	00104$
00102$:
;	lib/src/stm8s_tim4.c: 191: TIM4->CR1 &= (uint8_t)(~TIM4_CR1_OPM);
	and	a, #0xf7
	ld	0x5340, a
00104$:
;	lib/src/stm8s_tim4.c: 193: }
	pop	a
	ret
;	lib/src/stm8s_tim4.c: 215: void TIM4_PrescalerConfig(TIM4_Prescaler_TypeDef Prescaler, TIM4_PSCReloadMode_TypeDef TIM4_PSCReloadMode)
;	-----------------------------------------
;	 function TIM4_PrescalerConfig
;	-----------------------------------------
_TIM4_PrescalerConfig:
;	lib/src/stm8s_tim4.c: 222: TIM4->PSCR = (uint8_t)Prescaler;
	ld	0x5347, a
;	lib/src/stm8s_tim4.c: 225: TIM4->EGR = (uint8_t)TIM4_PSCReloadMode;
	ld	a, (0x03, sp)
	ld	0x5345, a
;	lib/src/stm8s_tim4.c: 226: }
	popw	x
	pop	a
	jp	(x)
;	lib/src/stm8s_tim4.c: 234: void TIM4_ARRPreloadConfig(FunctionalState NewState)
;	-----------------------------------------
;	 function TIM4_ARRPreloadConfig
;	-----------------------------------------
_TIM4_ARRPreloadConfig:
	push	a
	ld	(0x01, sp), a
;	lib/src/stm8s_tim4.c: 242: TIM4->CR1 |= TIM4_CR1_ARPE;
	ld	a, 0x5340
;	lib/src/stm8s_tim4.c: 240: if (NewState != DISABLE)
	tnz	(0x01, sp)
	jreq	00102$
;	lib/src/stm8s_tim4.c: 242: TIM4->CR1 |= TIM4_CR1_ARPE;
	or	a, #0x80
	ld	0x5340, a
	jra	00104$
00102$:
;	lib/src/stm8s_tim4.c: 246: TIM4->CR1 &= (uint8_t)(~TIM4_CR1_ARPE);
	and	a, #0x7f
	ld	0x5340, a
00104$:
;	lib/src/stm8s_tim4.c: 248: }
	pop	a
	ret
;	lib/src/stm8s_tim4.c: 257: void TIM4_GenerateEvent(TIM4_EventSource_TypeDef TIM4_EventSource)
;	-----------------------------------------
;	 function TIM4_GenerateEvent
;	-----------------------------------------
_TIM4_GenerateEvent:
;	lib/src/stm8s_tim4.c: 263: TIM4->EGR = (uint8_t)(TIM4_EventSource);
	ld	0x5345, a
;	lib/src/stm8s_tim4.c: 264: }
	ret
;	lib/src/stm8s_tim4.c: 272: void TIM4_SetCounter(uint8_t Counter)
;	-----------------------------------------
;	 function TIM4_SetCounter
;	-----------------------------------------
_TIM4_SetCounter:
;	lib/src/stm8s_tim4.c: 275: TIM4->CNTR = (uint8_t)(Counter);
	ld	0x5346, a
;	lib/src/stm8s_tim4.c: 276: }
	ret
;	lib/src/stm8s_tim4.c: 284: void TIM4_SetAutoreload(uint8_t Autoreload)
;	-----------------------------------------
;	 function TIM4_SetAutoreload
;	-----------------------------------------
_TIM4_SetAutoreload:
;	lib/src/stm8s_tim4.c: 287: TIM4->ARR = (uint8_t)(Autoreload);
	ld	0x5348, a
;	lib/src/stm8s_tim4.c: 288: }
	ret
;	lib/src/stm8s_tim4.c: 295: uint8_t TIM4_GetCounter(void)
;	-----------------------------------------
;	 function TIM4_GetCounter
;	-----------------------------------------
_TIM4_GetCounter:
;	lib/src/stm8s_tim4.c: 298: return (uint8_t)(TIM4->CNTR);
	ld	a, 0x5346
;	lib/src/stm8s_tim4.c: 299: }
	ret
;	lib/src/stm8s_tim4.c: 306: TIM4_Prescaler_TypeDef TIM4_GetPrescaler(void)
;	-----------------------------------------
;	 function TIM4_GetPrescaler
;	-----------------------------------------
_TIM4_GetPrescaler:
;	lib/src/stm8s_tim4.c: 309: return (TIM4_Prescaler_TypeDef)(TIM4->PSCR);
	ld	a, 0x5347
;	lib/src/stm8s_tim4.c: 310: }
	ret
;	lib/src/stm8s_tim4.c: 319: FlagStatus TIM4_GetFlagStatus(TIM4_FLAG_TypeDef TIM4_FLAG)
;	-----------------------------------------
;	 function TIM4_GetFlagStatus
;	-----------------------------------------
_TIM4_GetFlagStatus:
	ld	xl, a
;	lib/src/stm8s_tim4.c: 326: if ((TIM4->SR1 & (uint8_t)TIM4_FLAG)  != 0)
	ld	a, 0x5344
	pushw	x
	and	a, (2, sp)
	popw	x
	tnz	a
	jreq	00102$
;	lib/src/stm8s_tim4.c: 328: bitstatus = SET;
	ld	a, #0x01
	ret
00102$:
;	lib/src/stm8s_tim4.c: 332: bitstatus = RESET;
	clr	a
;	lib/src/stm8s_tim4.c: 334: return ((FlagStatus)bitstatus);
;	lib/src/stm8s_tim4.c: 335: }
	ret
;	lib/src/stm8s_tim4.c: 344: void TIM4_ClearFlag(TIM4_FLAG_TypeDef TIM4_FLAG)
;	-----------------------------------------
;	 function TIM4_ClearFlag
;	-----------------------------------------
_TIM4_ClearFlag:
;	lib/src/stm8s_tim4.c: 350: TIM4->SR1 = (uint8_t)(~TIM4_FLAG);
	cpl	a
	ld	0x5344, a
;	lib/src/stm8s_tim4.c: 351: }
	ret
;	lib/src/stm8s_tim4.c: 360: ITStatus TIM4_GetITStatus(TIM4_IT_TypeDef TIM4_IT)
;	-----------------------------------------
;	 function TIM4_GetITStatus
;	-----------------------------------------
_TIM4_GetITStatus:
	sub	sp, #2
	ld	xl, a
;	lib/src/stm8s_tim4.c: 369: itstatus = (uint8_t)(TIM4->SR1 & (uint8_t)TIM4_IT);
	ld	a, 0x5344
	exg	a, xl
	ld	(0x01, sp), a
	exg	a, xl
	and	a, (0x01, sp)
	ld	(0x02, sp), a
;	lib/src/stm8s_tim4.c: 371: itenable = (uint8_t)(TIM4->IER & (uint8_t)TIM4_IT);
	ld	a, 0x5343
	and	a, (0x01, sp)
;	lib/src/stm8s_tim4.c: 373: if ((itstatus != (uint8_t)RESET ) && (itenable != (uint8_t)RESET ))
	tnz	(0x02, sp)
	jreq	00102$
	tnz	a
	jreq	00102$
;	lib/src/stm8s_tim4.c: 375: bitstatus = (ITStatus)SET;
	ld	a, #0x01
;	lib/src/stm8s_tim4.c: 379: bitstatus = (ITStatus)RESET;
	.byte 0x21
00102$:
	clr	a
00103$:
;	lib/src/stm8s_tim4.c: 381: return ((ITStatus)bitstatus);
;	lib/src/stm8s_tim4.c: 382: }
	addw	sp, #2
	ret
;	lib/src/stm8s_tim4.c: 391: void TIM4_ClearITPendingBit(TIM4_IT_TypeDef TIM4_IT)
;	-----------------------------------------
;	 function TIM4_ClearITPendingBit
;	-----------------------------------------
_TIM4_ClearITPendingBit:
;	lib/src/stm8s_tim4.c: 397: TIM4->SR1 = (uint8_t)(~TIM4_IT);
	cpl	a
	ld	0x5344, a
;	lib/src/stm8s_tim4.c: 398: }
	ret
	.area CODE
	.area CONST
	.area INITIALIZER
	.area CABS (ABS)
