                                      1 ;--------------------------------------------------------
                                      2 ; File Created by SDCC : free open source ISO C Compiler
                                      3 ; Version 4.5.0 #15242 (MINGW64)
                                      4 ;--------------------------------------------------------
                                      5 	.module stm8s_clk
                                      6 	
                                      7 ;--------------------------------------------------------
                                      8 ; Public variables in this module
                                      9 ;--------------------------------------------------------
                                     10 	.globl _CLKPrescTable
                                     11 	.globl _HSIDivExp
                                     12 	.globl _CLK_DeInit
                                     13 	.globl _CLK_FastHaltWakeUpCmd
                                     14 	.globl _CLK_HSECmd
                                     15 	.globl _CLK_HSICmd
                                     16 	.globl _CLK_LSICmd
                                     17 	.globl _CLK_CCOCmd
                                     18 	.globl _CLK_ClockSwitchCmd
                                     19 	.globl _CLK_SlowActiveHaltWakeUpCmd
                                     20 	.globl _CLK_PeripheralClockConfig
                                     21 	.globl _CLK_ClockSwitchConfig
                                     22 	.globl _CLK_HSIPrescalerConfig
                                     23 	.globl _CLK_CCOConfig
                                     24 	.globl _CLK_ITConfig
                                     25 	.globl _CLK_SYSCLKConfig
                                     26 	.globl _CLK_SWIMConfig
                                     27 	.globl _CLK_ClockSecuritySystemEnable
                                     28 	.globl _CLK_GetSYSCLKSource
                                     29 	.globl _CLK_GetClockFreq
                                     30 	.globl _CLK_AdjustHSICalibrationValue
                                     31 	.globl _CLK_SYSCLKEmergencyClear
                                     32 	.globl _CLK_GetFlagStatus
                                     33 	.globl _CLK_GetITStatus
                                     34 	.globl _CLK_ClearITPendingBit
                                     35 ;--------------------------------------------------------
                                     36 ; ram data
                                     37 ;--------------------------------------------------------
                                     38 	.area DATA
                                     39 ;--------------------------------------------------------
                                     40 ; ram data
                                     41 ;--------------------------------------------------------
                                     42 	.area INITIALIZED
                                     43 ;--------------------------------------------------------
                                     44 ; absolute external ram data
                                     45 ;--------------------------------------------------------
                                     46 	.area DABS (ABS)
                                     47 
                                     48 ; default segment ordering for linker
                                     49 	.area HOME
                                     50 	.area GSINIT
                                     51 	.area GSFINAL
                                     52 	.area CONST
                                     53 	.area INITIALIZER
                                     54 	.area CODE
                                     55 
                                     56 ;--------------------------------------------------------
                                     57 ; global & static initialisations
                                     58 ;--------------------------------------------------------
                                     59 	.area HOME
                                     60 	.area GSINIT
                                     61 	.area GSFINAL
                                     62 	.area GSINIT
                                     63 ;--------------------------------------------------------
                                     64 ; Home
                                     65 ;--------------------------------------------------------
                                     66 	.area HOME
                                     67 	.area HOME
                                     68 ;--------------------------------------------------------
                                     69 ; code
                                     70 ;--------------------------------------------------------
                                     71 	.area CODE
                                     72 ;	lib/src/stm8s_clk.c: 72: void CLK_DeInit(void)
                                     73 ;	-----------------------------------------
                                     74 ;	 function CLK_DeInit
                                     75 ;	-----------------------------------------
      008738                         76 _CLK_DeInit:
                                     77 ;	lib/src/stm8s_clk.c: 74: CLK->ICKR = CLK_ICKR_RESET_VALUE;
      008738 35 01 50 C0      [ 1]   78 	mov	0x50c0+0, #0x01
                                     79 ;	lib/src/stm8s_clk.c: 75: CLK->ECKR = CLK_ECKR_RESET_VALUE;
      00873C 35 00 50 C1      [ 1]   80 	mov	0x50c1+0, #0x00
                                     81 ;	lib/src/stm8s_clk.c: 76: CLK->SWR  = CLK_SWR_RESET_VALUE;
      008740 35 E1 50 C4      [ 1]   82 	mov	0x50c4+0, #0xe1
                                     83 ;	lib/src/stm8s_clk.c: 77: CLK->SWCR = CLK_SWCR_RESET_VALUE;
      008744 35 00 50 C5      [ 1]   84 	mov	0x50c5+0, #0x00
                                     85 ;	lib/src/stm8s_clk.c: 78: CLK->CKDIVR = CLK_CKDIVR_RESET_VALUE;
      008748 35 18 50 C6      [ 1]   86 	mov	0x50c6+0, #0x18
                                     87 ;	lib/src/stm8s_clk.c: 79: CLK->PCKENR1 = CLK_PCKENR1_RESET_VALUE;
      00874C 35 FF 50 C7      [ 1]   88 	mov	0x50c7+0, #0xff
                                     89 ;	lib/src/stm8s_clk.c: 80: CLK->PCKENR2 = CLK_PCKENR2_RESET_VALUE;
      008750 35 FF 50 CA      [ 1]   90 	mov	0x50ca+0, #0xff
                                     91 ;	lib/src/stm8s_clk.c: 81: CLK->CSSR = CLK_CSSR_RESET_VALUE;
      008754 35 00 50 C8      [ 1]   92 	mov	0x50c8+0, #0x00
                                     93 ;	lib/src/stm8s_clk.c: 82: CLK->CCOR = CLK_CCOR_RESET_VALUE;
      008758 35 00 50 C9      [ 1]   94 	mov	0x50c9+0, #0x00
                                     95 ;	lib/src/stm8s_clk.c: 83: while ((CLK->CCOR & CLK_CCOR_CCOEN)!= 0)
      00875C                         96 00101$:
      00875C 72 00 50 C9 FB   [ 2]   97 	btjt	0x50c9, #0, 00101$
                                     98 ;	lib/src/stm8s_clk.c: 85: CLK->CCOR = CLK_CCOR_RESET_VALUE;
      008761 35 00 50 C9      [ 1]   99 	mov	0x50c9+0, #0x00
                                    100 ;	lib/src/stm8s_clk.c: 86: CLK->HSITRIMR = CLK_HSITRIMR_RESET_VALUE;
      008765 35 00 50 CC      [ 1]  101 	mov	0x50cc+0, #0x00
                                    102 ;	lib/src/stm8s_clk.c: 87: CLK->SWIMCCR = CLK_SWIMCCR_RESET_VALUE;
      008769 35 00 50 CD      [ 1]  103 	mov	0x50cd+0, #0x00
                                    104 ;	lib/src/stm8s_clk.c: 88: }
      00876D 81               [ 4]  105 	ret
                                    106 ;	lib/src/stm8s_clk.c: 99: void CLK_FastHaltWakeUpCmd(FunctionalState NewState)
                                    107 ;	-----------------------------------------
                                    108 ;	 function CLK_FastHaltWakeUpCmd
                                    109 ;	-----------------------------------------
      00876E                        110 _CLK_FastHaltWakeUpCmd:
      00876E 88               [ 1]  111 	push	a
      00876F 6B 01            [ 1]  112 	ld	(0x01, sp), a
                                    113 ;	lib/src/stm8s_clk.c: 107: CLK->ICKR |= CLK_ICKR_FHWU;
      008771 C6 50 C0         [ 1]  114 	ld	a, 0x50c0
                                    115 ;	lib/src/stm8s_clk.c: 104: if (NewState != DISABLE)
      008774 0D 01            [ 1]  116 	tnz	(0x01, sp)
      008776 27 07            [ 1]  117 	jreq	00102$
                                    118 ;	lib/src/stm8s_clk.c: 107: CLK->ICKR |= CLK_ICKR_FHWU;
      008778 AA 04            [ 1]  119 	or	a, #0x04
      00877A C7 50 C0         [ 1]  120 	ld	0x50c0, a
      00877D 20 05            [ 2]  121 	jra	00104$
      00877F                        122 00102$:
                                    123 ;	lib/src/stm8s_clk.c: 112: CLK->ICKR &= (uint8_t)(~CLK_ICKR_FHWU);
      00877F A4 FB            [ 1]  124 	and	a, #0xfb
      008781 C7 50 C0         [ 1]  125 	ld	0x50c0, a
      008784                        126 00104$:
                                    127 ;	lib/src/stm8s_clk.c: 114: }
      008784 84               [ 1]  128 	pop	a
      008785 81               [ 4]  129 	ret
                                    130 ;	lib/src/stm8s_clk.c: 121: void CLK_HSECmd(FunctionalState NewState)
                                    131 ;	-----------------------------------------
                                    132 ;	 function CLK_HSECmd
                                    133 ;	-----------------------------------------
      008786                        134 _CLK_HSECmd:
      008786 88               [ 1]  135 	push	a
      008787 6B 01            [ 1]  136 	ld	(0x01, sp), a
                                    137 ;	lib/src/stm8s_clk.c: 129: CLK->ECKR |= CLK_ECKR_HSEEN;
      008789 C6 50 C1         [ 1]  138 	ld	a, 0x50c1
                                    139 ;	lib/src/stm8s_clk.c: 126: if (NewState != DISABLE)
      00878C 0D 01            [ 1]  140 	tnz	(0x01, sp)
      00878E 27 07            [ 1]  141 	jreq	00102$
                                    142 ;	lib/src/stm8s_clk.c: 129: CLK->ECKR |= CLK_ECKR_HSEEN;
      008790 AA 01            [ 1]  143 	or	a, #0x01
      008792 C7 50 C1         [ 1]  144 	ld	0x50c1, a
      008795 20 05            [ 2]  145 	jra	00104$
      008797                        146 00102$:
                                    147 ;	lib/src/stm8s_clk.c: 134: CLK->ECKR &= (uint8_t)(~CLK_ECKR_HSEEN);
      008797 A4 FE            [ 1]  148 	and	a, #0xfe
      008799 C7 50 C1         [ 1]  149 	ld	0x50c1, a
      00879C                        150 00104$:
                                    151 ;	lib/src/stm8s_clk.c: 136: }
      00879C 84               [ 1]  152 	pop	a
      00879D 81               [ 4]  153 	ret
                                    154 ;	lib/src/stm8s_clk.c: 143: void CLK_HSICmd(FunctionalState NewState)
                                    155 ;	-----------------------------------------
                                    156 ;	 function CLK_HSICmd
                                    157 ;	-----------------------------------------
      00879E                        158 _CLK_HSICmd:
      00879E 88               [ 1]  159 	push	a
      00879F 6B 01            [ 1]  160 	ld	(0x01, sp), a
                                    161 ;	lib/src/stm8s_clk.c: 151: CLK->ICKR |= CLK_ICKR_HSIEN;
      0087A1 C6 50 C0         [ 1]  162 	ld	a, 0x50c0
                                    163 ;	lib/src/stm8s_clk.c: 148: if (NewState != DISABLE)
      0087A4 0D 01            [ 1]  164 	tnz	(0x01, sp)
      0087A6 27 07            [ 1]  165 	jreq	00102$
                                    166 ;	lib/src/stm8s_clk.c: 151: CLK->ICKR |= CLK_ICKR_HSIEN;
      0087A8 AA 01            [ 1]  167 	or	a, #0x01
      0087AA C7 50 C0         [ 1]  168 	ld	0x50c0, a
      0087AD 20 05            [ 2]  169 	jra	00104$
      0087AF                        170 00102$:
                                    171 ;	lib/src/stm8s_clk.c: 156: CLK->ICKR &= (uint8_t)(~CLK_ICKR_HSIEN);
      0087AF A4 FE            [ 1]  172 	and	a, #0xfe
      0087B1 C7 50 C0         [ 1]  173 	ld	0x50c0, a
      0087B4                        174 00104$:
                                    175 ;	lib/src/stm8s_clk.c: 158: }
      0087B4 84               [ 1]  176 	pop	a
      0087B5 81               [ 4]  177 	ret
                                    178 ;	lib/src/stm8s_clk.c: 166: void CLK_LSICmd(FunctionalState NewState)
                                    179 ;	-----------------------------------------
                                    180 ;	 function CLK_LSICmd
                                    181 ;	-----------------------------------------
      0087B6                        182 _CLK_LSICmd:
      0087B6 88               [ 1]  183 	push	a
      0087B7 6B 01            [ 1]  184 	ld	(0x01, sp), a
                                    185 ;	lib/src/stm8s_clk.c: 174: CLK->ICKR |= CLK_ICKR_LSIEN;
      0087B9 C6 50 C0         [ 1]  186 	ld	a, 0x50c0
                                    187 ;	lib/src/stm8s_clk.c: 171: if (NewState != DISABLE)
      0087BC 0D 01            [ 1]  188 	tnz	(0x01, sp)
      0087BE 27 07            [ 1]  189 	jreq	00102$
                                    190 ;	lib/src/stm8s_clk.c: 174: CLK->ICKR |= CLK_ICKR_LSIEN;
      0087C0 AA 08            [ 1]  191 	or	a, #0x08
      0087C2 C7 50 C0         [ 1]  192 	ld	0x50c0, a
      0087C5 20 05            [ 2]  193 	jra	00104$
      0087C7                        194 00102$:
                                    195 ;	lib/src/stm8s_clk.c: 179: CLK->ICKR &= (uint8_t)(~CLK_ICKR_LSIEN);
      0087C7 A4 F7            [ 1]  196 	and	a, #0xf7
      0087C9 C7 50 C0         [ 1]  197 	ld	0x50c0, a
      0087CC                        198 00104$:
                                    199 ;	lib/src/stm8s_clk.c: 181: }
      0087CC 84               [ 1]  200 	pop	a
      0087CD 81               [ 4]  201 	ret
                                    202 ;	lib/src/stm8s_clk.c: 189: void CLK_CCOCmd(FunctionalState NewState)
                                    203 ;	-----------------------------------------
                                    204 ;	 function CLK_CCOCmd
                                    205 ;	-----------------------------------------
      0087CE                        206 _CLK_CCOCmd:
      0087CE 88               [ 1]  207 	push	a
      0087CF 6B 01            [ 1]  208 	ld	(0x01, sp), a
                                    209 ;	lib/src/stm8s_clk.c: 197: CLK->CCOR |= CLK_CCOR_CCOEN;
      0087D1 C6 50 C9         [ 1]  210 	ld	a, 0x50c9
                                    211 ;	lib/src/stm8s_clk.c: 194: if (NewState != DISABLE)
      0087D4 0D 01            [ 1]  212 	tnz	(0x01, sp)
      0087D6 27 07            [ 1]  213 	jreq	00102$
                                    214 ;	lib/src/stm8s_clk.c: 197: CLK->CCOR |= CLK_CCOR_CCOEN;
      0087D8 AA 01            [ 1]  215 	or	a, #0x01
      0087DA C7 50 C9         [ 1]  216 	ld	0x50c9, a
      0087DD 20 05            [ 2]  217 	jra	00104$
      0087DF                        218 00102$:
                                    219 ;	lib/src/stm8s_clk.c: 202: CLK->CCOR &= (uint8_t)(~CLK_CCOR_CCOEN);
      0087DF A4 FE            [ 1]  220 	and	a, #0xfe
      0087E1 C7 50 C9         [ 1]  221 	ld	0x50c9, a
      0087E4                        222 00104$:
                                    223 ;	lib/src/stm8s_clk.c: 204: }
      0087E4 84               [ 1]  224 	pop	a
      0087E5 81               [ 4]  225 	ret
                                    226 ;	lib/src/stm8s_clk.c: 213: void CLK_ClockSwitchCmd(FunctionalState NewState)
                                    227 ;	-----------------------------------------
                                    228 ;	 function CLK_ClockSwitchCmd
                                    229 ;	-----------------------------------------
      0087E6                        230 _CLK_ClockSwitchCmd:
      0087E6 88               [ 1]  231 	push	a
      0087E7 6B 01            [ 1]  232 	ld	(0x01, sp), a
                                    233 ;	lib/src/stm8s_clk.c: 221: CLK->SWCR |= CLK_SWCR_SWEN;
      0087E9 C6 50 C5         [ 1]  234 	ld	a, 0x50c5
                                    235 ;	lib/src/stm8s_clk.c: 218: if (NewState != DISABLE )
      0087EC 0D 01            [ 1]  236 	tnz	(0x01, sp)
      0087EE 27 07            [ 1]  237 	jreq	00102$
                                    238 ;	lib/src/stm8s_clk.c: 221: CLK->SWCR |= CLK_SWCR_SWEN;
      0087F0 AA 02            [ 1]  239 	or	a, #0x02
      0087F2 C7 50 C5         [ 1]  240 	ld	0x50c5, a
      0087F5 20 05            [ 2]  241 	jra	00104$
      0087F7                        242 00102$:
                                    243 ;	lib/src/stm8s_clk.c: 226: CLK->SWCR &= (uint8_t)(~CLK_SWCR_SWEN);
      0087F7 A4 FD            [ 1]  244 	and	a, #0xfd
      0087F9 C7 50 C5         [ 1]  245 	ld	0x50c5, a
      0087FC                        246 00104$:
                                    247 ;	lib/src/stm8s_clk.c: 228: }
      0087FC 84               [ 1]  248 	pop	a
      0087FD 81               [ 4]  249 	ret
                                    250 ;	lib/src/stm8s_clk.c: 238: void CLK_SlowActiveHaltWakeUpCmd(FunctionalState NewState)
                                    251 ;	-----------------------------------------
                                    252 ;	 function CLK_SlowActiveHaltWakeUpCmd
                                    253 ;	-----------------------------------------
      0087FE                        254 _CLK_SlowActiveHaltWakeUpCmd:
      0087FE 88               [ 1]  255 	push	a
      0087FF 6B 01            [ 1]  256 	ld	(0x01, sp), a
                                    257 ;	lib/src/stm8s_clk.c: 246: CLK->ICKR |= CLK_ICKR_SWUAH;
      008801 C6 50 C0         [ 1]  258 	ld	a, 0x50c0
                                    259 ;	lib/src/stm8s_clk.c: 243: if (NewState != DISABLE)
      008804 0D 01            [ 1]  260 	tnz	(0x01, sp)
      008806 27 07            [ 1]  261 	jreq	00102$
                                    262 ;	lib/src/stm8s_clk.c: 246: CLK->ICKR |= CLK_ICKR_SWUAH;
      008808 AA 20            [ 1]  263 	or	a, #0x20
      00880A C7 50 C0         [ 1]  264 	ld	0x50c0, a
      00880D 20 05            [ 2]  265 	jra	00104$
      00880F                        266 00102$:
                                    267 ;	lib/src/stm8s_clk.c: 251: CLK->ICKR &= (uint8_t)(~CLK_ICKR_SWUAH);
      00880F A4 DF            [ 1]  268 	and	a, #0xdf
      008811 C7 50 C0         [ 1]  269 	ld	0x50c0, a
      008814                        270 00104$:
                                    271 ;	lib/src/stm8s_clk.c: 253: }
      008814 84               [ 1]  272 	pop	a
      008815 81               [ 4]  273 	ret
                                    274 ;	lib/src/stm8s_clk.c: 263: void CLK_PeripheralClockConfig(CLK_Peripheral_TypeDef CLK_Peripheral, FunctionalState NewState)
                                    275 ;	-----------------------------------------
                                    276 ;	 function CLK_PeripheralClockConfig
                                    277 ;	-----------------------------------------
      008816                        278 _CLK_PeripheralClockConfig:
      008816 52 02            [ 2]  279 	sub	sp, #2
                                    280 ;	lib/src/stm8s_clk.c: 274: CLK->PCKENR1 |= (uint8_t)((uint8_t)1 << ((uint8_t)CLK_Peripheral & (uint8_t)0x0F));
      008818 97               [ 1]  281 	ld	xl, a
      008819 A4 0F            [ 1]  282 	and	a, #0x0f
      00881B 88               [ 1]  283 	push	a
      00881C A6 01            [ 1]  284 	ld	a, #0x01
      00881E 6B 02            [ 1]  285 	ld	(0x02, sp), a
      008820 84               [ 1]  286 	pop	a
      008821 4D               [ 1]  287 	tnz	a
      008822 27 05            [ 1]  288 	jreq	00134$
      008824                        289 00133$:
      008824 08 01            [ 1]  290 	sll	(0x01, sp)
      008826 4A               [ 1]  291 	dec	a
      008827 26 FB            [ 1]  292 	jrne	00133$
      008829                        293 00134$:
                                    294 ;	lib/src/stm8s_clk.c: 279: CLK->PCKENR1 &= (uint8_t)(~(uint8_t)(((uint8_t)1 << ((uint8_t)CLK_Peripheral & (uint8_t)0x0F))));
      008829 7B 01            [ 1]  295 	ld	a, (0x01, sp)
      00882B 43               [ 1]  296 	cpl	a
      00882C 6B 02            [ 1]  297 	ld	(0x02, sp), a
                                    298 ;	lib/src/stm8s_clk.c: 269: if (((uint8_t)CLK_Peripheral & (uint8_t)0x10) == 0x00)
      00882E 9F               [ 1]  299 	ld	a, xl
      00882F A5 10            [ 1]  300 	bcp	a, #0x10
      008831 26 15            [ 1]  301 	jrne	00108$
                                    302 ;	lib/src/stm8s_clk.c: 274: CLK->PCKENR1 |= (uint8_t)((uint8_t)1 << ((uint8_t)CLK_Peripheral & (uint8_t)0x0F));
      008833 C6 50 C7         [ 1]  303 	ld	a, 0x50c7
                                    304 ;	lib/src/stm8s_clk.c: 271: if (NewState != DISABLE)
      008836 0D 05            [ 1]  305 	tnz	(0x05, sp)
      008838 27 07            [ 1]  306 	jreq	00102$
                                    307 ;	lib/src/stm8s_clk.c: 274: CLK->PCKENR1 |= (uint8_t)((uint8_t)1 << ((uint8_t)CLK_Peripheral & (uint8_t)0x0F));
      00883A 1A 01            [ 1]  308 	or	a, (0x01, sp)
      00883C C7 50 C7         [ 1]  309 	ld	0x50c7, a
      00883F 20 1A            [ 2]  310 	jra	00110$
      008841                        311 00102$:
                                    312 ;	lib/src/stm8s_clk.c: 279: CLK->PCKENR1 &= (uint8_t)(~(uint8_t)(((uint8_t)1 << ((uint8_t)CLK_Peripheral & (uint8_t)0x0F))));
      008841 14 02            [ 1]  313 	and	a, (0x02, sp)
      008843 C7 50 C7         [ 1]  314 	ld	0x50c7, a
      008846 20 13            [ 2]  315 	jra	00110$
      008848                        316 00108$:
                                    317 ;	lib/src/stm8s_clk.c: 287: CLK->PCKENR2 |= (uint8_t)((uint8_t)1 << ((uint8_t)CLK_Peripheral & (uint8_t)0x0F));
      008848 C6 50 CA         [ 1]  318 	ld	a, 0x50ca
                                    319 ;	lib/src/stm8s_clk.c: 284: if (NewState != DISABLE)
      00884B 0D 05            [ 1]  320 	tnz	(0x05, sp)
      00884D 27 07            [ 1]  321 	jreq	00105$
                                    322 ;	lib/src/stm8s_clk.c: 287: CLK->PCKENR2 |= (uint8_t)((uint8_t)1 << ((uint8_t)CLK_Peripheral & (uint8_t)0x0F));
      00884F 1A 01            [ 1]  323 	or	a, (0x01, sp)
      008851 C7 50 CA         [ 1]  324 	ld	0x50ca, a
      008854 20 05            [ 2]  325 	jra	00110$
      008856                        326 00105$:
                                    327 ;	lib/src/stm8s_clk.c: 292: CLK->PCKENR2 &= (uint8_t)(~(uint8_t)(((uint8_t)1 << ((uint8_t)CLK_Peripheral & (uint8_t)0x0F))));
      008856 14 02            [ 1]  328 	and	a, (0x02, sp)
      008858 C7 50 CA         [ 1]  329 	ld	0x50ca, a
      00885B                        330 00110$:
                                    331 ;	lib/src/stm8s_clk.c: 295: }
      00885B 5B 02            [ 2]  332 	addw	sp, #2
      00885D 85               [ 2]  333 	popw	x
      00885E 84               [ 1]  334 	pop	a
      00885F FC               [ 2]  335 	jp	(x)
                                    336 ;	lib/src/stm8s_clk.c: 309: ErrorStatus CLK_ClockSwitchConfig(CLK_SwitchMode_TypeDef CLK_SwitchMode, CLK_Source_TypeDef CLK_NewClock, FunctionalState ITState, CLK_CurrentClockState_TypeDef CLK_CurrentClockState)
                                    337 ;	-----------------------------------------
                                    338 ;	 function CLK_ClockSwitchConfig
                                    339 ;	-----------------------------------------
      008860                        340 _CLK_ClockSwitchConfig:
      008860 88               [ 1]  341 	push	a
      008861 6B 01            [ 1]  342 	ld	(0x01, sp), a
                                    343 ;	lib/src/stm8s_clk.c: 322: clock_master = (CLK_Source_TypeDef)CLK->CMSR;
      008863 C6 50 C3         [ 1]  344 	ld	a, 0x50c3
      008866 90 97            [ 1]  345 	ld	yl, a
                                    346 ;	lib/src/stm8s_clk.c: 328: CLK->SWCR |= CLK_SWCR_SWEN;
      008868 C6 50 C5         [ 1]  347 	ld	a, 0x50c5
                                    348 ;	lib/src/stm8s_clk.c: 325: if (CLK_SwitchMode == CLK_SWITCHMODE_AUTO)
      00886B 0D 01            [ 1]  349 	tnz	(0x01, sp)
      00886D 27 36            [ 1]  350 	jreq	00122$
                                    351 ;	lib/src/stm8s_clk.c: 328: CLK->SWCR |= CLK_SWCR_SWEN;
      00886F AA 02            [ 1]  352 	or	a, #0x02
      008871 C7 50 C5         [ 1]  353 	ld	0x50c5, a
      008874 C6 50 C5         [ 1]  354 	ld	a, 0x50c5
                                    355 ;	lib/src/stm8s_clk.c: 331: if (ITState != DISABLE)
      008877 0D 05            [ 1]  356 	tnz	(0x05, sp)
      008879 27 07            [ 1]  357 	jreq	00102$
                                    358 ;	lib/src/stm8s_clk.c: 333: CLK->SWCR |= CLK_SWCR_SWIEN;
      00887B AA 04            [ 1]  359 	or	a, #0x04
      00887D C7 50 C5         [ 1]  360 	ld	0x50c5, a
      008880 20 05            [ 2]  361 	jra	00103$
      008882                        362 00102$:
                                    363 ;	lib/src/stm8s_clk.c: 337: CLK->SWCR &= (uint8_t)(~CLK_SWCR_SWIEN);
      008882 A4 FB            [ 1]  364 	and	a, #0xfb
      008884 C7 50 C5         [ 1]  365 	ld	0x50c5, a
      008887                        366 00103$:
                                    367 ;	lib/src/stm8s_clk.c: 341: CLK->SWR = (uint8_t)CLK_NewClock;
      008887 AE 50 C4         [ 2]  368 	ldw	x, #0x50c4
      00888A 7B 04            [ 1]  369 	ld	a, (0x04, sp)
      00888C F7               [ 1]  370 	ld	(x), a
                                    371 ;	lib/src/stm8s_clk.c: 344: while((((CLK->SWCR & CLK_SWCR_SWBSY) != 0 )&& (DownCounter != 0)))
      00888D 5F               [ 1]  372 	clrw	x
      00888E 5A               [ 2]  373 	decw	x
      00888F                        374 00105$:
      00888F 72 01 50 C5 06   [ 2]  375 	btjf	0x50c5, #0, 00107$
      008894 5D               [ 2]  376 	tnzw	x
      008895 27 03            [ 1]  377 	jreq	00107$
                                    378 ;	lib/src/stm8s_clk.c: 346: DownCounter--;
      008897 5A               [ 2]  379 	decw	x
      008898 20 F5            [ 2]  380 	jra	00105$
      00889A                        381 00107$:
                                    382 ;	lib/src/stm8s_clk.c: 349: if(DownCounter != 0)
      00889A 5D               [ 2]  383 	tnzw	x
      00889B 27 05            [ 1]  384 	jreq	00109$
                                    385 ;	lib/src/stm8s_clk.c: 351: Swif = SUCCESS;
      00889D A6 01            [ 1]  386 	ld	a, #0x01
      00889F 97               [ 1]  387 	ld	xl, a
      0088A0 20 32            [ 2]  388 	jra	00123$
      0088A2                        389 00109$:
                                    390 ;	lib/src/stm8s_clk.c: 355: Swif = ERROR;
      0088A2 5F               [ 1]  391 	clrw	x
      0088A3 20 2F            [ 2]  392 	jra	00123$
      0088A5                        393 00122$:
                                    394 ;	lib/src/stm8s_clk.c: 361: if (ITState != DISABLE)
      0088A5 0D 05            [ 1]  395 	tnz	(0x05, sp)
      0088A7 27 07            [ 1]  396 	jreq	00112$
                                    397 ;	lib/src/stm8s_clk.c: 363: CLK->SWCR |= CLK_SWCR_SWIEN;
      0088A9 AA 04            [ 1]  398 	or	a, #0x04
      0088AB C7 50 C5         [ 1]  399 	ld	0x50c5, a
      0088AE 20 05            [ 2]  400 	jra	00113$
      0088B0                        401 00112$:
                                    402 ;	lib/src/stm8s_clk.c: 367: CLK->SWCR &= (uint8_t)(~CLK_SWCR_SWIEN);
      0088B0 A4 FB            [ 1]  403 	and	a, #0xfb
      0088B2 C7 50 C5         [ 1]  404 	ld	0x50c5, a
      0088B5                        405 00113$:
                                    406 ;	lib/src/stm8s_clk.c: 371: CLK->SWR = (uint8_t)CLK_NewClock;
      0088B5 AE 50 C4         [ 2]  407 	ldw	x, #0x50c4
      0088B8 7B 04            [ 1]  408 	ld	a, (0x04, sp)
      0088BA F7               [ 1]  409 	ld	(x), a
                                    410 ;	lib/src/stm8s_clk.c: 374: while((((CLK->SWCR & CLK_SWCR_SWIF) != 0 ) && (DownCounter != 0)))
      0088BB 5F               [ 1]  411 	clrw	x
      0088BC 5A               [ 2]  412 	decw	x
      0088BD                        413 00115$:
      0088BD 72 07 50 C5 06   [ 2]  414 	btjf	0x50c5, #3, 00117$
      0088C2 5D               [ 2]  415 	tnzw	x
      0088C3 27 03            [ 1]  416 	jreq	00117$
                                    417 ;	lib/src/stm8s_clk.c: 376: DownCounter--;
      0088C5 5A               [ 2]  418 	decw	x
      0088C6 20 F5            [ 2]  419 	jra	00115$
      0088C8                        420 00117$:
                                    421 ;	lib/src/stm8s_clk.c: 379: if(DownCounter != 0)
      0088C8 5D               [ 2]  422 	tnzw	x
      0088C9 27 08            [ 1]  423 	jreq	00119$
                                    424 ;	lib/src/stm8s_clk.c: 382: CLK->SWCR |= CLK_SWCR_SWEN;
      0088CB 72 12 50 C5      [ 1]  425 	bset	0x50c5, #1
                                    426 ;	lib/src/stm8s_clk.c: 383: Swif = SUCCESS;
      0088CF A6 01            [ 1]  427 	ld	a, #0x01
      0088D1 97               [ 1]  428 	ld	xl, a
                                    429 ;	lib/src/stm8s_clk.c: 387: Swif = ERROR;
      0088D2 21                     430 	.byte 0x21
      0088D3                        431 00119$:
      0088D3 5F               [ 1]  432 	clrw	x
      0088D4                        433 00123$:
                                    434 ;	lib/src/stm8s_clk.c: 390: if(Swif != ERROR)
      0088D4 9F               [ 1]  435 	ld	a, xl
      0088D5 4D               [ 1]  436 	tnz	a
      0088D6 27 2E            [ 1]  437 	jreq	00136$
                                    438 ;	lib/src/stm8s_clk.c: 393: if((CLK_CurrentClockState == CLK_CURRENTCLOCKSTATE_DISABLE) && ( clock_master == CLK_SOURCE_HSI))
      0088D8 0D 06            [ 1]  439 	tnz	(0x06, sp)
      0088DA 26 0C            [ 1]  440 	jrne	00132$
      0088DC 90 9F            [ 1]  441 	ld	a, yl
      0088DE A1 E1            [ 1]  442 	cp	a, #0xe1
      0088E0 26 06            [ 1]  443 	jrne	00132$
                                    444 ;	lib/src/stm8s_clk.c: 395: CLK->ICKR &= (uint8_t)(~CLK_ICKR_HSIEN);
      0088E2 72 11 50 C0      [ 1]  445 	bres	0x50c0, #0
      0088E6 20 1E            [ 2]  446 	jra	00136$
      0088E8                        447 00132$:
                                    448 ;	lib/src/stm8s_clk.c: 397: else if((CLK_CurrentClockState == CLK_CURRENTCLOCKSTATE_DISABLE) && ( clock_master == CLK_SOURCE_LSI))
      0088E8 0D 06            [ 1]  449 	tnz	(0x06, sp)
      0088EA 26 0C            [ 1]  450 	jrne	00128$
      0088EC 90 9F            [ 1]  451 	ld	a, yl
      0088EE A1 D2            [ 1]  452 	cp	a, #0xd2
      0088F0 26 06            [ 1]  453 	jrne	00128$
                                    454 ;	lib/src/stm8s_clk.c: 399: CLK->ICKR &= (uint8_t)(~CLK_ICKR_LSIEN);
      0088F2 72 17 50 C0      [ 1]  455 	bres	0x50c0, #3
      0088F6 20 0E            [ 2]  456 	jra	00136$
      0088F8                        457 00128$:
                                    458 ;	lib/src/stm8s_clk.c: 401: else if ((CLK_CurrentClockState == CLK_CURRENTCLOCKSTATE_DISABLE) && ( clock_master == CLK_SOURCE_HSE))
      0088F8 0D 06            [ 1]  459 	tnz	(0x06, sp)
      0088FA 26 0A            [ 1]  460 	jrne	00136$
      0088FC 90 9F            [ 1]  461 	ld	a, yl
      0088FE A1 B4            [ 1]  462 	cp	a, #0xb4
      008900 26 04            [ 1]  463 	jrne	00136$
                                    464 ;	lib/src/stm8s_clk.c: 403: CLK->ECKR &= (uint8_t)(~CLK_ECKR_HSEEN);
      008902 72 11 50 C1      [ 1]  465 	bres	0x50c1, #0
      008906                        466 00136$:
                                    467 ;	lib/src/stm8s_clk.c: 406: return(Swif);
      008906 9F               [ 1]  468 	ld	a, xl
                                    469 ;	lib/src/stm8s_clk.c: 407: }
      008907 1E 02            [ 2]  470 	ldw	x, (2, sp)
      008909 5B 06            [ 2]  471 	addw	sp, #6
      00890B FC               [ 2]  472 	jp	(x)
                                    473 ;	lib/src/stm8s_clk.c: 415: void CLK_HSIPrescalerConfig(CLK_Prescaler_TypeDef HSIPrescaler)
                                    474 ;	-----------------------------------------
                                    475 ;	 function CLK_HSIPrescalerConfig
                                    476 ;	-----------------------------------------
      00890C                        477 _CLK_HSIPrescalerConfig:
      00890C 88               [ 1]  478 	push	a
      00890D 6B 01            [ 1]  479 	ld	(0x01, sp), a
                                    480 ;	lib/src/stm8s_clk.c: 421: CLK->CKDIVR &= (uint8_t)(~CLK_CKDIVR_HSIDIV);
      00890F C6 50 C6         [ 1]  481 	ld	a, 0x50c6
      008912 A4 E7            [ 1]  482 	and	a, #0xe7
      008914 C7 50 C6         [ 1]  483 	ld	0x50c6, a
                                    484 ;	lib/src/stm8s_clk.c: 424: CLK->CKDIVR |= (uint8_t)HSIPrescaler;
      008917 C6 50 C6         [ 1]  485 	ld	a, 0x50c6
      00891A 1A 01            [ 1]  486 	or	a, (0x01, sp)
      00891C C7 50 C6         [ 1]  487 	ld	0x50c6, a
                                    488 ;	lib/src/stm8s_clk.c: 425: }
      00891F 84               [ 1]  489 	pop	a
      008920 81               [ 4]  490 	ret
                                    491 ;	lib/src/stm8s_clk.c: 436: void CLK_CCOConfig(CLK_Output_TypeDef CLK_CCO)
                                    492 ;	-----------------------------------------
                                    493 ;	 function CLK_CCOConfig
                                    494 ;	-----------------------------------------
      008921                        495 _CLK_CCOConfig:
      008921 88               [ 1]  496 	push	a
      008922 6B 01            [ 1]  497 	ld	(0x01, sp), a
                                    498 ;	lib/src/stm8s_clk.c: 442: CLK->CCOR &= (uint8_t)(~CLK_CCOR_CCOSEL);
      008924 C6 50 C9         [ 1]  499 	ld	a, 0x50c9
      008927 A4 E1            [ 1]  500 	and	a, #0xe1
      008929 C7 50 C9         [ 1]  501 	ld	0x50c9, a
                                    502 ;	lib/src/stm8s_clk.c: 445: CLK->CCOR |= (uint8_t)CLK_CCO;
      00892C C6 50 C9         [ 1]  503 	ld	a, 0x50c9
      00892F 1A 01            [ 1]  504 	or	a, (0x01, sp)
      008931 C7 50 C9         [ 1]  505 	ld	0x50c9, a
                                    506 ;	lib/src/stm8s_clk.c: 448: CLK->CCOR |= CLK_CCOR_CCOEN;
      008934 72 10 50 C9      [ 1]  507 	bset	0x50c9, #0
                                    508 ;	lib/src/stm8s_clk.c: 449: }
      008938 84               [ 1]  509 	pop	a
      008939 81               [ 4]  510 	ret
                                    511 ;	lib/src/stm8s_clk.c: 459: void CLK_ITConfig(CLK_IT_TypeDef CLK_IT, FunctionalState NewState)
                                    512 ;	-----------------------------------------
                                    513 ;	 function CLK_ITConfig
                                    514 ;	-----------------------------------------
      00893A                        515 _CLK_ITConfig:
      00893A 88               [ 1]  516 	push	a
                                    517 ;	lib/src/stm8s_clk.c: 467: switch (CLK_IT)
      00893B A1 0C            [ 1]  518 	cp	a, #0x0c
      00893D 26 07            [ 1]  519 	jrne	00150$
      00893F 88               [ 1]  520 	push	a
      008940 A6 01            [ 1]  521 	ld	a, #0x01
      008942 6B 02            [ 1]  522 	ld	(0x02, sp), a
      008944 84               [ 1]  523 	pop	a
      008945 C5                     524 	.byte 0xc5
      008946                        525 00150$:
      008946 0F 01            [ 1]  526 	clr	(0x01, sp)
      008948                        527 00151$:
      008948 A0 1C            [ 1]  528 	sub	a, #0x1c
      00894A 26 02            [ 1]  529 	jrne	00153$
      00894C 4C               [ 1]  530 	inc	a
      00894D 21                     531 	.byte 0x21
      00894E                        532 00153$:
      00894E 4F               [ 1]  533 	clr	a
      00894F                        534 00154$:
                                    535 ;	lib/src/stm8s_clk.c: 465: if (NewState != DISABLE)
      00894F 0D 04            [ 1]  536 	tnz	(0x04, sp)
      008951 27 1B            [ 1]  537 	jreq	00110$
                                    538 ;	lib/src/stm8s_clk.c: 467: switch (CLK_IT)
      008953 0D 01            [ 1]  539 	tnz	(0x01, sp)
      008955 26 0D            [ 1]  540 	jrne	00102$
      008957 4D               [ 1]  541 	tnz	a
      008958 27 2D            [ 1]  542 	jreq	00112$
                                    543 ;	lib/src/stm8s_clk.c: 470: CLK->SWCR |= CLK_SWCR_SWIEN;
      00895A C6 50 C5         [ 1]  544 	ld	a, 0x50c5
      00895D AA 04            [ 1]  545 	or	a, #0x04
      00895F C7 50 C5         [ 1]  546 	ld	0x50c5, a
                                    547 ;	lib/src/stm8s_clk.c: 471: break;
      008962 20 23            [ 2]  548 	jra	00112$
                                    549 ;	lib/src/stm8s_clk.c: 472: case CLK_IT_CSSD: /* Enable the clock security system detection interrupt */
      008964                        550 00102$:
                                    551 ;	lib/src/stm8s_clk.c: 473: CLK->CSSR |= CLK_CSSR_CSSDIE;
      008964 C6 50 C8         [ 1]  552 	ld	a, 0x50c8
      008967 AA 04            [ 1]  553 	or	a, #0x04
      008969 C7 50 C8         [ 1]  554 	ld	0x50c8, a
                                    555 ;	lib/src/stm8s_clk.c: 474: break;
      00896C 20 19            [ 2]  556 	jra	00112$
                                    557 ;	lib/src/stm8s_clk.c: 477: }
      00896E                        558 00110$:
                                    559 ;	lib/src/stm8s_clk.c: 481: switch (CLK_IT)
      00896E 0D 01            [ 1]  560 	tnz	(0x01, sp)
      008970 26 0D            [ 1]  561 	jrne	00106$
      008972 4D               [ 1]  562 	tnz	a
      008973 27 12            [ 1]  563 	jreq	00112$
                                    564 ;	lib/src/stm8s_clk.c: 484: CLK->SWCR  &= (uint8_t)(~CLK_SWCR_SWIEN);
      008975 C6 50 C5         [ 1]  565 	ld	a, 0x50c5
      008978 A4 FB            [ 1]  566 	and	a, #0xfb
      00897A C7 50 C5         [ 1]  567 	ld	0x50c5, a
                                    568 ;	lib/src/stm8s_clk.c: 485: break;
      00897D 20 08            [ 2]  569 	jra	00112$
                                    570 ;	lib/src/stm8s_clk.c: 486: case CLK_IT_CSSD: /* Disable the clock security system detection interrupt */
      00897F                        571 00106$:
                                    572 ;	lib/src/stm8s_clk.c: 487: CLK->CSSR &= (uint8_t)(~CLK_CSSR_CSSDIE);
      00897F C6 50 C8         [ 1]  573 	ld	a, 0x50c8
      008982 A4 FB            [ 1]  574 	and	a, #0xfb
      008984 C7 50 C8         [ 1]  575 	ld	0x50c8, a
                                    576 ;	lib/src/stm8s_clk.c: 491: }
      008987                        577 00112$:
                                    578 ;	lib/src/stm8s_clk.c: 493: }
      008987 84               [ 1]  579 	pop	a
      008988 85               [ 2]  580 	popw	x
      008989 84               [ 1]  581 	pop	a
      00898A FC               [ 2]  582 	jp	(x)
                                    583 ;	lib/src/stm8s_clk.c: 500: void CLK_SYSCLKConfig(CLK_Prescaler_TypeDef CLK_Prescaler)
                                    584 ;	-----------------------------------------
                                    585 ;	 function CLK_SYSCLKConfig
                                    586 ;	-----------------------------------------
      00898B                        587 _CLK_SYSCLKConfig:
      00898B 88               [ 1]  588 	push	a
      00898C 95               [ 1]  589 	ld	xh, a
                                    590 ;	lib/src/stm8s_clk.c: 507: CLK->CKDIVR &= (uint8_t)(~CLK_CKDIVR_HSIDIV);
      00898D C6 50 C6         [ 1]  591 	ld	a, 0x50c6
                                    592 ;	lib/src/stm8s_clk.c: 505: if (((uint8_t)CLK_Prescaler & (uint8_t)0x80) == 0x00) /* Bit7 = 0 means HSI divider */
      008990 5D               [ 2]  593 	tnzw	x
      008991 2B 14            [ 1]  594 	jrmi	00102$
                                    595 ;	lib/src/stm8s_clk.c: 507: CLK->CKDIVR &= (uint8_t)(~CLK_CKDIVR_HSIDIV);
      008993 A4 E7            [ 1]  596 	and	a, #0xe7
      008995 C7 50 C6         [ 1]  597 	ld	0x50c6, a
                                    598 ;	lib/src/stm8s_clk.c: 508: CLK->CKDIVR |= (uint8_t)((uint8_t)CLK_Prescaler & (uint8_t)CLK_CKDIVR_HSIDIV);
      008998 C6 50 C6         [ 1]  599 	ld	a, 0x50c6
      00899B 6B 01            [ 1]  600 	ld	(0x01, sp), a
      00899D 9E               [ 1]  601 	ld	a, xh
      00899E A4 18            [ 1]  602 	and	a, #0x18
      0089A0 1A 01            [ 1]  603 	or	a, (0x01, sp)
      0089A2 C7 50 C6         [ 1]  604 	ld	0x50c6, a
      0089A5 20 12            [ 2]  605 	jra	00104$
      0089A7                        606 00102$:
                                    607 ;	lib/src/stm8s_clk.c: 512: CLK->CKDIVR &= (uint8_t)(~CLK_CKDIVR_CPUDIV);
      0089A7 A4 F8            [ 1]  608 	and	a, #0xf8
      0089A9 C7 50 C6         [ 1]  609 	ld	0x50c6, a
                                    610 ;	lib/src/stm8s_clk.c: 513: CLK->CKDIVR |= (uint8_t)((uint8_t)CLK_Prescaler & (uint8_t)CLK_CKDIVR_CPUDIV);
      0089AC C6 50 C6         [ 1]  611 	ld	a, 0x50c6
      0089AF 6B 01            [ 1]  612 	ld	(0x01, sp), a
      0089B1 9E               [ 1]  613 	ld	a, xh
      0089B2 A4 07            [ 1]  614 	and	a, #0x07
      0089B4 1A 01            [ 1]  615 	or	a, (0x01, sp)
      0089B6 C7 50 C6         [ 1]  616 	ld	0x50c6, a
      0089B9                        617 00104$:
                                    618 ;	lib/src/stm8s_clk.c: 515: }
      0089B9 84               [ 1]  619 	pop	a
      0089BA 81               [ 4]  620 	ret
                                    621 ;	lib/src/stm8s_clk.c: 523: void CLK_SWIMConfig(CLK_SWIMDivider_TypeDef CLK_SWIMDivider)
                                    622 ;	-----------------------------------------
                                    623 ;	 function CLK_SWIMConfig
                                    624 ;	-----------------------------------------
      0089BB                        625 _CLK_SWIMConfig:
      0089BB 88               [ 1]  626 	push	a
      0089BC 6B 01            [ 1]  627 	ld	(0x01, sp), a
                                    628 ;	lib/src/stm8s_clk.c: 531: CLK->SWIMCCR |= CLK_SWIMCCR_SWIMDIV;
      0089BE C6 50 CD         [ 1]  629 	ld	a, 0x50cd
                                    630 ;	lib/src/stm8s_clk.c: 528: if (CLK_SWIMDivider != CLK_SWIMDIVIDER_2)
      0089C1 0D 01            [ 1]  631 	tnz	(0x01, sp)
      0089C3 27 07            [ 1]  632 	jreq	00102$
                                    633 ;	lib/src/stm8s_clk.c: 531: CLK->SWIMCCR |= CLK_SWIMCCR_SWIMDIV;
      0089C5 AA 01            [ 1]  634 	or	a, #0x01
      0089C7 C7 50 CD         [ 1]  635 	ld	0x50cd, a
      0089CA 20 05            [ 2]  636 	jra	00104$
      0089CC                        637 00102$:
                                    638 ;	lib/src/stm8s_clk.c: 536: CLK->SWIMCCR &= (uint8_t)(~CLK_SWIMCCR_SWIMDIV);
      0089CC A4 FE            [ 1]  639 	and	a, #0xfe
      0089CE C7 50 CD         [ 1]  640 	ld	0x50cd, a
      0089D1                        641 00104$:
                                    642 ;	lib/src/stm8s_clk.c: 538: }
      0089D1 84               [ 1]  643 	pop	a
      0089D2 81               [ 4]  644 	ret
                                    645 ;	lib/src/stm8s_clk.c: 547: void CLK_ClockSecuritySystemEnable(void)
                                    646 ;	-----------------------------------------
                                    647 ;	 function CLK_ClockSecuritySystemEnable
                                    648 ;	-----------------------------------------
      0089D3                        649 _CLK_ClockSecuritySystemEnable:
                                    650 ;	lib/src/stm8s_clk.c: 550: CLK->CSSR |= CLK_CSSR_CSSEN;
      0089D3 72 10 50 C8      [ 1]  651 	bset	0x50c8, #0
                                    652 ;	lib/src/stm8s_clk.c: 551: }
      0089D7 81               [ 4]  653 	ret
                                    654 ;	lib/src/stm8s_clk.c: 559: CLK_Source_TypeDef CLK_GetSYSCLKSource(void)
                                    655 ;	-----------------------------------------
                                    656 ;	 function CLK_GetSYSCLKSource
                                    657 ;	-----------------------------------------
      0089D8                        658 _CLK_GetSYSCLKSource:
                                    659 ;	lib/src/stm8s_clk.c: 561: return((CLK_Source_TypeDef)CLK->CMSR);
      0089D8 C6 50 C3         [ 1]  660 	ld	a, 0x50c3
                                    661 ;	lib/src/stm8s_clk.c: 562: }
      0089DB 81               [ 4]  662 	ret
                                    663 ;	lib/src/stm8s_clk.c: 569: uint32_t CLK_GetClockFreq(void)
                                    664 ;	-----------------------------------------
                                    665 ;	 function CLK_GetClockFreq
                                    666 ;	-----------------------------------------
      0089DC                        667 _CLK_GetClockFreq:
      0089DC 52 04            [ 2]  668 	sub	sp, #4
                                    669 ;	lib/src/stm8s_clk.c: 576: clocksource = (CLK_Source_TypeDef)CLK->CMSR;
      0089DE C6 50 C3         [ 1]  670 	ld	a, 0x50c3
                                    671 ;	lib/src/stm8s_clk.c: 578: if (clocksource == CLK_SOURCE_HSI)
      0089E1 6B 04            [ 1]  672 	ld	(0x04, sp), a
      0089E3 A1 E1            [ 1]  673 	cp	a, #0xe1
      0089E5 26 21            [ 1]  674 	jrne	00105$
                                    675 ;	lib/src/stm8s_clk.c: 580: tmp = (uint8_t)(CLK->CKDIVR & CLK_CKDIVR_HSIDIV);
      0089E7 C6 50 C6         [ 1]  676 	ld	a, 0x50c6
      0089EA A4 18            [ 1]  677 	and	a, #0x18
                                    678 ;	lib/src/stm8s_clk.c: 581: tmp = (uint8_t)(tmp >> 3);
      0089EC 44               [ 1]  679 	srl	a
      0089ED 44               [ 1]  680 	srl	a
      0089EE 44               [ 1]  681 	srl	a
                                    682 ;	lib/src/stm8s_clk.c: 582: clockfrequency = HSI_VALUE >> HSIDivExp[tmp];
      0089EF 5F               [ 1]  683 	clrw	x
      0089F0 97               [ 1]  684 	ld	xl, a
      0089F1 D6 80 2D         [ 1]  685 	ld	a, (_HSIDivExp+0, x)
      0089F4 90 AE 24 00      [ 2]  686 	ldw	y, #0x2400
      0089F8 AE 00 F4         [ 2]  687 	ldw	x, #0x00f4
      0089FB 4D               [ 1]  688 	tnz	a
      0089FC 27 06            [ 1]  689 	jreq	00127$
      0089FE                        690 00126$:
      0089FE 54               [ 2]  691 	srlw	x
      0089FF 90 56            [ 2]  692 	rrcw	y
      008A01 4A               [ 1]  693 	dec	a
      008A02 26 FA            [ 1]  694 	jrne	00126$
      008A04                        695 00127$:
      008A04 17 03            [ 2]  696 	ldw	(0x03, sp), y
      008A06 20 17            [ 2]  697 	jra	00106$
      008A08                        698 00105$:
                                    699 ;	lib/src/stm8s_clk.c: 584: else if ( clocksource == CLK_SOURCE_LSI)
      008A08 7B 04            [ 1]  700 	ld	a, (0x04, sp)
      008A0A A1 D2            [ 1]  701 	cp	a, #0xd2
      008A0C 26 09            [ 1]  702 	jrne	00102$
                                    703 ;	lib/src/stm8s_clk.c: 586: clockfrequency = LSI_VALUE;
      008A0E AE F4 00         [ 2]  704 	ldw	x, #0xf400
      008A11 1F 03            [ 2]  705 	ldw	(0x03, sp), x
      008A13 5F               [ 1]  706 	clrw	x
      008A14 5C               [ 1]  707 	incw	x
      008A15 20 08            [ 2]  708 	jra	00106$
      008A17                        709 00102$:
                                    710 ;	lib/src/stm8s_clk.c: 590: clockfrequency = HSE_VALUE;
      008A17 AE 24 00         [ 2]  711 	ldw	x, #0x2400
      008A1A 1F 03            [ 2]  712 	ldw	(0x03, sp), x
      008A1C AE 00 F4         [ 2]  713 	ldw	x, #0x00f4
      008A1F                        714 00106$:
                                    715 ;	lib/src/stm8s_clk.c: 593: return((uint32_t)clockfrequency);
      008A1F 51               [ 1]  716 	exgw	x, y
      008A20 1E 03            [ 2]  717 	ldw	x, (0x03, sp)
                                    718 ;	lib/src/stm8s_clk.c: 594: }
      008A22 5B 04            [ 2]  719 	addw	sp, #4
      008A24 81               [ 4]  720 	ret
                                    721 ;	lib/src/stm8s_clk.c: 603: void CLK_AdjustHSICalibrationValue(CLK_HSITrimValue_TypeDef CLK_HSICalibrationValue)
                                    722 ;	-----------------------------------------
                                    723 ;	 function CLK_AdjustHSICalibrationValue
                                    724 ;	-----------------------------------------
      008A25                        725 _CLK_AdjustHSICalibrationValue:
      008A25 88               [ 1]  726 	push	a
      008A26 6B 01            [ 1]  727 	ld	(0x01, sp), a
                                    728 ;	lib/src/stm8s_clk.c: 609: CLK->HSITRIMR = (uint8_t)( (uint8_t)(CLK->HSITRIMR & (uint8_t)(~CLK_HSITRIMR_HSITRIM))|((uint8_t)CLK_HSICalibrationValue));
      008A28 C6 50 CC         [ 1]  729 	ld	a, 0x50cc
      008A2B A4 F8            [ 1]  730 	and	a, #0xf8
      008A2D 1A 01            [ 1]  731 	or	a, (0x01, sp)
      008A2F C7 50 CC         [ 1]  732 	ld	0x50cc, a
                                    733 ;	lib/src/stm8s_clk.c: 610: }
      008A32 84               [ 1]  734 	pop	a
      008A33 81               [ 4]  735 	ret
                                    736 ;	lib/src/stm8s_clk.c: 621: void CLK_SYSCLKEmergencyClear(void)
                                    737 ;	-----------------------------------------
                                    738 ;	 function CLK_SYSCLKEmergencyClear
                                    739 ;	-----------------------------------------
      008A34                        740 _CLK_SYSCLKEmergencyClear:
                                    741 ;	lib/src/stm8s_clk.c: 623: CLK->SWCR &= (uint8_t)(~CLK_SWCR_SWBSY);
      008A34 72 11 50 C5      [ 1]  742 	bres	0x50c5, #0
                                    743 ;	lib/src/stm8s_clk.c: 624: }
      008A38 81               [ 4]  744 	ret
                                    745 ;	lib/src/stm8s_clk.c: 633: FlagStatus CLK_GetFlagStatus(CLK_Flag_TypeDef CLK_FLAG)
                                    746 ;	-----------------------------------------
                                    747 ;	 function CLK_GetFlagStatus
                                    748 ;	-----------------------------------------
      008A39                        749 _CLK_GetFlagStatus:
      008A39 52 04            [ 2]  750 	sub	sp, #4
                                    751 ;	lib/src/stm8s_clk.c: 643: statusreg = (uint16_t)((uint16_t)CLK_FLAG & (uint16_t)0xFF00);
      008A3B 1F 03            [ 2]  752 	ldw	(0x03, sp), x
      008A3D 4F               [ 1]  753 	clr	a
      008A3E 97               [ 1]  754 	ld	xl, a
                                    755 ;	lib/src/stm8s_clk.c: 646: if (statusreg == 0x0100) /* The flag to check is in ICKRregister */
      008A3F 1F 01            [ 2]  756 	ldw	(0x01, sp), x
      008A41 A3 01 00         [ 2]  757 	cpw	x, #0x0100
      008A44 26 05            [ 1]  758 	jrne	00111$
                                    759 ;	lib/src/stm8s_clk.c: 648: tmpreg = CLK->ICKR;
      008A46 C6 50 C0         [ 1]  760 	ld	a, 0x50c0
      008A49 20 27            [ 2]  761 	jra	00112$
      008A4B                        762 00111$:
                                    763 ;	lib/src/stm8s_clk.c: 650: else if (statusreg == 0x0200) /* The flag to check is in ECKRregister */
      008A4B 1E 01            [ 2]  764 	ldw	x, (0x01, sp)
      008A4D A3 02 00         [ 2]  765 	cpw	x, #0x0200
      008A50 26 05            [ 1]  766 	jrne	00108$
                                    767 ;	lib/src/stm8s_clk.c: 652: tmpreg = CLK->ECKR;
      008A52 C6 50 C1         [ 1]  768 	ld	a, 0x50c1
      008A55 20 1B            [ 2]  769 	jra	00112$
      008A57                        770 00108$:
                                    771 ;	lib/src/stm8s_clk.c: 654: else if (statusreg == 0x0300) /* The flag to check is in SWIC register */
      008A57 1E 01            [ 2]  772 	ldw	x, (0x01, sp)
      008A59 A3 03 00         [ 2]  773 	cpw	x, #0x0300
      008A5C 26 05            [ 1]  774 	jrne	00105$
                                    775 ;	lib/src/stm8s_clk.c: 656: tmpreg = CLK->SWCR;
      008A5E C6 50 C5         [ 1]  776 	ld	a, 0x50c5
      008A61 20 0F            [ 2]  777 	jra	00112$
      008A63                        778 00105$:
                                    779 ;	lib/src/stm8s_clk.c: 658: else if (statusreg == 0x0400) /* The flag to check is in CSS register */
      008A63 1E 01            [ 2]  780 	ldw	x, (0x01, sp)
      008A65 A3 04 00         [ 2]  781 	cpw	x, #0x0400
      008A68 26 05            [ 1]  782 	jrne	00102$
                                    783 ;	lib/src/stm8s_clk.c: 660: tmpreg = CLK->CSSR;
      008A6A C6 50 C8         [ 1]  784 	ld	a, 0x50c8
      008A6D 20 03            [ 2]  785 	jra	00112$
      008A6F                        786 00102$:
                                    787 ;	lib/src/stm8s_clk.c: 664: tmpreg = CLK->CCOR;
      008A6F C6 50 C9         [ 1]  788 	ld	a, 0x50c9
      008A72                        789 00112$:
                                    790 ;	lib/src/stm8s_clk.c: 667: if ((tmpreg & (uint8_t)CLK_FLAG) != (uint8_t)RESET)
      008A72 88               [ 1]  791 	push	a
      008A73 7B 05            [ 1]  792 	ld	a, (0x05, sp)
      008A75 6B 03            [ 1]  793 	ld	(0x03, sp), a
      008A77 84               [ 1]  794 	pop	a
      008A78 14 02            [ 1]  795 	and	a, (0x02, sp)
      008A7A 27 03            [ 1]  796 	jreq	00114$
                                    797 ;	lib/src/stm8s_clk.c: 669: bitstatus = SET;
      008A7C A6 01            [ 1]  798 	ld	a, #0x01
                                    799 ;	lib/src/stm8s_clk.c: 673: bitstatus = RESET;
      008A7E 21                     800 	.byte 0x21
      008A7F                        801 00114$:
      008A7F 4F               [ 1]  802 	clr	a
      008A80                        803 00115$:
                                    804 ;	lib/src/stm8s_clk.c: 677: return((FlagStatus)bitstatus);
                                    805 ;	lib/src/stm8s_clk.c: 678: }
      008A80 5B 04            [ 2]  806 	addw	sp, #4
      008A82 81               [ 4]  807 	ret
                                    808 ;	lib/src/stm8s_clk.c: 686: ITStatus CLK_GetITStatus(CLK_IT_TypeDef CLK_IT)
                                    809 ;	-----------------------------------------
                                    810 ;	 function CLK_GetITStatus
                                    811 ;	-----------------------------------------
      008A83                        812 _CLK_GetITStatus:
      008A83 88               [ 1]  813 	push	a
                                    814 ;	lib/src/stm8s_clk.c: 693: if (CLK_IT == CLK_IT_SWIF)
      008A84 6B 01            [ 1]  815 	ld	(0x01, sp), a
      008A86 A1 1C            [ 1]  816 	cp	a, #0x1c
      008A88 26 0F            [ 1]  817 	jrne	00108$
                                    818 ;	lib/src/stm8s_clk.c: 696: if ((CLK->SWCR & (uint8_t)CLK_IT) == (uint8_t)0x0C)
      008A8A C6 50 C5         [ 1]  819 	ld	a, 0x50c5
      008A8D 14 01            [ 1]  820 	and	a, (0x01, sp)
                                    821 ;	lib/src/stm8s_clk.c: 698: bitstatus = SET;
      008A8F A0 0C            [ 1]  822 	sub	a, #0x0c
      008A91 26 03            [ 1]  823 	jrne	00102$
      008A93 4C               [ 1]  824 	inc	a
      008A94 20 0F            [ 2]  825 	jra	00109$
      008A96                        826 00102$:
                                    827 ;	lib/src/stm8s_clk.c: 702: bitstatus = RESET;
      008A96 4F               [ 1]  828 	clr	a
      008A97 20 0C            [ 2]  829 	jra	00109$
      008A99                        830 00108$:
                                    831 ;	lib/src/stm8s_clk.c: 708: if ((CLK->CSSR & (uint8_t)CLK_IT) == (uint8_t)0x0C)
      008A99 C6 50 C8         [ 1]  832 	ld	a, 0x50c8
      008A9C 14 01            [ 1]  833 	and	a, (0x01, sp)
                                    834 ;	lib/src/stm8s_clk.c: 710: bitstatus = SET;
      008A9E A0 0C            [ 1]  835 	sub	a, #0x0c
      008AA0 26 02            [ 1]  836 	jrne	00105$
      008AA2 4C               [ 1]  837 	inc	a
                                    838 ;	lib/src/stm8s_clk.c: 714: bitstatus = RESET;
      008AA3 21                     839 	.byte 0x21
      008AA4                        840 00105$:
      008AA4 4F               [ 1]  841 	clr	a
      008AA5                        842 00109$:
                                    843 ;	lib/src/stm8s_clk.c: 719: return bitstatus;
                                    844 ;	lib/src/stm8s_clk.c: 720: }
      008AA5 5B 01            [ 2]  845 	addw	sp, #1
      008AA7 81               [ 4]  846 	ret
                                    847 ;	lib/src/stm8s_clk.c: 728: void CLK_ClearITPendingBit(CLK_IT_TypeDef CLK_IT)
                                    848 ;	-----------------------------------------
                                    849 ;	 function CLK_ClearITPendingBit
                                    850 ;	-----------------------------------------
      008AA8                        851 _CLK_ClearITPendingBit:
                                    852 ;	lib/src/stm8s_clk.c: 733: if (CLK_IT == (uint8_t)CLK_IT_CSSD)
      008AA8 A1 0C            [ 1]  853 	cp	a, #0x0c
      008AAA 26 05            [ 1]  854 	jrne	00102$
                                    855 ;	lib/src/stm8s_clk.c: 736: CLK->CSSR &= (uint8_t)(~CLK_CSSR_CSSD);
      008AAC 72 17 50 C8      [ 1]  856 	bres	0x50c8, #3
      008AB0 81               [ 4]  857 	ret
      008AB1                        858 00102$:
                                    859 ;	lib/src/stm8s_clk.c: 741: CLK->SWCR &= (uint8_t)(~CLK_SWCR_SWIF);
      008AB1 72 17 50 C5      [ 1]  860 	bres	0x50c5, #3
                                    861 ;	lib/src/stm8s_clk.c: 744: }
      008AB5 81               [ 4]  862 	ret
                                    863 	.area CODE
                                    864 	.area CONST
                                    865 	.area CONST
      00802D                        866 _HSIDivExp:
      00802D 00                     867 	.db #0x00	; 0
      00802E 01                     868 	.db #0x01	; 1
      00802F 02                     869 	.db #0x02	; 2
      008030 03                     870 	.db #0x03	; 3
                                    871 	.area CODE
                                    872 	.area CONST
      008031                        873 _CLKPrescTable:
      008031 01                     874 	.db #0x01	; 1
      008032 02                     875 	.db #0x02	; 2
      008033 04                     876 	.db #0x04	; 4
      008034 08                     877 	.db #0x08	; 8
      008035 0A                     878 	.db #0x0a	; 10
      008036 10                     879 	.db #0x10	; 16
      008037 14                     880 	.db #0x14	; 20
      008038 28                     881 	.db #0x28	; 40
                                    882 	.area CODE
                                    883 	.area INITIALIZER
                                    884 	.area CABS (ABS)
