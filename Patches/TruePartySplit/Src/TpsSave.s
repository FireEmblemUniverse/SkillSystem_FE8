	.cpu arm7tdmi
	.eabi_attribute 20, 1	@ Tag_ABI_FP_denormal
	.eabi_attribute 21, 1	@ Tag_ABI_FP_exceptions
	.eabi_attribute 23, 3	@ Tag_ABI_FP_number_model
	.eabi_attribute 24, 1	@ Tag_ABI_align8_needed
	.eabi_attribute 25, 1	@ Tag_ABI_align8_preserved
	.eabi_attribute 26, 1	@ Tag_ABI_enum_size
	.eabi_attribute 30, 2	@ Tag_ABI_optimization_goals
	.eabi_attribute 34, 0	@ Tag_CPU_unaligned_access
	.eabi_attribute 18, 4	@ Tag_ABI_PCS_wchar_t
	.file	"TpsSave.c"
@ GNU C17 (devkitARM release 56) version 11.1.0 (arm-none-eabi)
@	compiled by GNU C version 10.3.0, GMP version 6.2.1, MPFR version 4.1.0, MPC version 1.2.1, isl version isl-0.18-GMP

@ GGC heuristics: --param ggc-min-expand=100 --param ggc-min-heapsize=131072
@ options passed: -mcpu=arm7tdmi -mthumb -mthumb-interwork -mtune=arm7tdmi -mlong-calls -march=armv4t -O2
	.text
	.align	1
	.p2align 2,,3
	.global	TpsSave
	.arch armv4t
	.syntax unified
	.code	16
	.thumb_func
	.fpu softvfp
	.type	TpsSave, %function
TpsSave:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, lr}	@
@ TpsSave.c:5: {
	movs	r4, r0	@ target, tmp127
@ TpsSave.c:8: }
	@ sp needed	@
@ TpsSave.c:5: {
	movs	r5, r1	@ size, tmp128
@ TpsSave.c:6:     WriteSramFast(g_tps_current_party, target, 1);
	ldr	r3, .L3	@ tmp119,
	ldr	r6, .L3+4	@ tmp121,
	movs	r1, r4	@, target
	ldr	r0, [r3]	@ g_tps_current_party, g_tps_current_party
	movs	r2, #1	@,
	bl	.L5		@
@ TpsSave.c:7:     WriteSramFast(g_tps_party_array, target+1, size-1);
	ldr	r3, .L3+8	@ tmp124,
	subs	r2, r5, #1	@ tmp122, size,
	ldr	r0, [r3]	@ g_tps_party_array, g_tps_party_array
	adds	r1, r4, #1	@ tmp123, target,
	bl	.L5		@
@ TpsSave.c:8: }
	pop	{r4, r5, r6}
	pop	{r0}
	bx	r0
.L4:
	.align	2
.L3:
	.word	g_tps_current_party
	.word	WriteSramFast
	.word	g_tps_party_array
	.size	TpsSave, .-TpsSave
	.align	1
	.p2align 2,,3
	.global	TpsLoad
	.syntax unified
	.code	16
	.thumb_func
	.fpu softvfp
	.type	TpsLoad, %function
TpsLoad:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, lr}	@
@ TpsSave.c:11: {
	movs	r5, r1	@ size, tmp132
@ TpsSave.c:14: }
	@ sp needed	@
@ TpsSave.c:11: {
	movs	r4, r0	@ source, tmp131
@ TpsSave.c:12:     ReadSramFast(source, g_tps_current_party, 1);
	ldr	r6, .L7	@ tmp123,
	ldr	r3, .L7+4	@ tmp121,
	movs	r2, #1	@,
	ldr	r1, [r3]	@ g_tps_current_party, g_tps_current_party
	ldr	r3, [r6]	@ ReadSramFast, ReadSramFast
	bl	.L9		@
@ TpsSave.c:13:     ReadSramFast(source+1, g_tps_party_array, size-1);
	ldr	r3, .L7+8	@ tmp126,
	subs	r2, r5, #1	@ tmp125, size,
	ldr	r1, [r3]	@ g_tps_party_array, g_tps_party_array
@ TpsSave.c:13:     ReadSramFast(source+1, g_tps_party_array, size-1);
	adds	r0, r4, #1	@ tmp128, source,
@ TpsSave.c:13:     ReadSramFast(source+1, g_tps_party_array, size-1);
	ldr	r3, [r6]	@ ReadSramFast, ReadSramFast
	bl	.L9		@
@ TpsSave.c:14: }
	pop	{r4, r5, r6}
	pop	{r0}
	bx	r0
.L8:
	.align	2
.L7:
	.word	ReadSramFast
	.word	g_tps_current_party
	.word	g_tps_party_array
	.size	TpsLoad, .-TpsLoad
	.ident	"GCC: (devkitARM release 56) 11.1.0"
	.code 16
	.align	1
.L9:
	bx	r3
.L5:
	bx	r6
