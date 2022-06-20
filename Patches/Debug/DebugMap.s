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
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{r7, lr}	@
	sub	sp, sp, #8	@,,
	add	r7, sp, #0	@,,
	str	r0, [r7, #4]	@ proc, proc
@ DebugMap.c:11: 	asm("mov r11, r11");
	.syntax divided
@ 11 "DebugMap.c" 1
	mov r11, r11
@ 0 "" 2
@ DebugMap.c:12: 	memcpy(MyMapBuffer, DebugMapLabel, 660); // dst, src, size 
	.thumb
	.syntax unified
	movs	r3, #165	@ tmp117,
	lsls	r2, r3, #2	@ tmp113, tmp117,
	ldr	r1, .L2	@ tmp114,
	ldr	r3, .L2+4	@ tmp115,
	movs	r0, r3	@, tmp115
	ldr	r3, .L2+8	@ tmp116,
	bl	.L4		@
@ DebugMap.c:14: 	asm("mov r11, r11");
	.syntax divided
@ 14 "DebugMap.c" 1
	mov r11, r11
@ 0 "" 2
@ DebugMap.c:15: }
	.thumb
	.syntax unified
	nop	
	mov	sp, r7	@,
	add	sp, sp, #8	@,,
	@ sp needed	@
	pop	{r7}
	pop	{r0}
	bx	r0
.L3:
	.align	2
.L2:
	.word	DebugMapLabel
	.word	MyMapBuffer
	.word	memcpy
	.size	DebugMap_ASMC, .-DebugMap_ASMC
	.ident	"GCC: (devkitARM release 56) 11.1.0"
	.code 16
	.align	1
.L4:
	bx	r3
