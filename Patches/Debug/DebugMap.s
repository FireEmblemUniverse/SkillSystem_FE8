	.cpu arm7tdmi
	.eabi_attribute 20, 1	@ Tag_ABI_FP_denormal
	.eabi_attribute 21, 1	@ Tag_ABI_FP_exceptions
	.eabi_attribute 23, 3	@ Tag_ABI_FP_number_model
	.eabi_attribute 24, 1	@ Tag_ABI_align8_needed
	.eabi_attribute 25, 1	@ Tag_ABI_align8_preserved
	.eabi_attribute 26, 1	@ Tag_ABI_enum_size
	.eabi_attribute 30, 6	@ Tag_ABI_optimization_goals
	.eabi_attribute 34, 0	@ Tag_CPU_unaligned_access
	.eabi_attribute 18, 4	@ Tag_ABI_PCS_wchar_t
	.file	"DebugMap.c"
@ GNU C17 (devkitARM release 56) version 11.1.0 (arm-none-eabi)
@	compiled by GNU C version 10.3.0, GMP version 6.2.1, MPFR version 4.1.0, MPC version 1.2.1, isl version isl-0.18-GMP

@ GGC heuristics: --param ggc-min-expand=100 --param ggc-min-heapsize=131072
@ options passed: -mcpu=arm7tdmi -mthumb -mthumb-interwork -mtune=arm7tdmi -mlong-calls -march=armv4t
	.text
	.align	1
	.global	DebugMap_ASMC
	.arch armv4t
	.syntax unified
	.code	16
	.thumb_func
	.fpu softvfp
	.type	DebugMap_ASMC, %function
DebugMap_ASMC:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{r7, lr}	@
	sub	sp, sp, #16	@,,
	add	r7, sp, #0	@,,
	str	r0, [r7, #4]	@ dst, dst
@ DebugMap.c:39: 	asm("mov r11, r11");
	.syntax divided
@ 39 "DebugMap.c" 1
	mov r11, r11
@ 0 "" 2
@ DebugMap.c:40: 	for (int i = 1; i<300; i++)
	.thumb
	.syntax unified
	movs	r3, #1	@ tmp116,
	str	r3, [r7, #12]	@ tmp116, i
@ DebugMap.c:40: 	for (int i = 1; i<300; i++)
	b	.L2		@
.L3:
@ DebugMap.c:42: 		dst[i] = 0x4; 
	ldr	r3, [r7, #12]	@ i.0_1, i
	lsls	r3, r3, #1	@ _2, i.0_1,
	ldr	r2, [r7, #4]	@ tmp117, dst
	adds	r3, r2, r3	@ _3, tmp117, _2
@ DebugMap.c:42: 		dst[i] = 0x4; 
	movs	r2, #4	@ tmp118,
	strh	r2, [r3]	@ tmp119, *_3
@ DebugMap.c:40: 	for (int i = 1; i<300; i++)
	ldr	r3, [r7, #12]	@ tmp121, i
	adds	r3, r3, #1	@ tmp120,
	str	r3, [r7, #12]	@ tmp120, i
.L2:
@ DebugMap.c:40: 	for (int i = 1; i<300; i++)
	ldr	r2, [r7, #12]	@ tmp122, i
	movs	r3, #150	@ tmp124,
	lsls	r3, r3, #1	@ tmp123, tmp124,
	cmp	r2, r3	@ tmp122, tmp123
	blt	.L3		@,
@ DebugMap.c:44: 	asm("mov r11, r11");
	.syntax divided
@ 44 "DebugMap.c" 1
	mov r11, r11
@ 0 "" 2
@ DebugMap.c:46: }
	.thumb
	.syntax unified
	nop	
	mov	sp, r7	@,
	add	sp, sp, #16	@,,
	@ sp needed	@
	pop	{r7}
	pop	{r0}
	bx	r0
	.size	DebugMap_ASMC, .-DebugMap_ASMC
	.ident	"GCC: (devkitARM release 56) 11.1.0"
