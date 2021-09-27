	.cpu arm7tdmi
	.eabi_attribute 20, 1	@ Tag_ABI_FP_denormal
	.eabi_attribute 21, 1	@ Tag_ABI_FP_exceptions
	.eabi_attribute 23, 3	@ Tag_ABI_FP_number_model
	.eabi_attribute 24, 1	@ Tag_ABI_align8_needed
	.eabi_attribute 25, 1	@ Tag_ABI_align8_preserved
	.eabi_attribute 26, 1	@ Tag_ABI_enum_size
	.eabi_attribute 30, 4	@ Tag_ABI_optimization_goals
	.eabi_attribute 34, 0	@ Tag_CPU_unaligned_access
	.eabi_attribute 18, 4	@ Tag_ABI_PCS_wchar_t
	.file	"AuraSkillCheck.c"
@ GNU C17 (devkitARM release 54) version 10.1.0 (arm-none-eabi)
@	compiled by GNU C version 6.4.0, GMP version 6.0.0, MPFR version 3.1.2, MPC version 1.0.2, isl version none
@ GGC heuristics: --param ggc-min-expand=100 --param ggc-min-heapsize=131072
@ options passed:  -imultilib thumb
@ -iprefix c:\devkitpro\devkitarm\bin\../lib/gcc/arm-none-eabi/10.1.0/
@ -D__USES_INITFINI__ AuraSkillCheck.c -mcpu=arm7tdmi -mthumb
@ -mthumb-interwork -mtune=arm7tdmi -mlong-calls -march=armv4t
@ -auxbase-strip AuraSkillCheck.s -Os -Wall -fverbose-asm
@ options enabled:  -faggressive-loop-optimizations -fallocation-dce
@ -fauto-inc-dec -fbranch-count-reg -fcaller-saves -fcode-hoisting
@ -fcombine-stack-adjustments -fcompare-elim -fcprop-registers
@ -fcrossjumping -fcse-follow-jumps -fdefer-pop
@ -fdelete-null-pointer-checks -fdevirtualize -fdevirtualize-speculatively
@ -fdwarf2-cfi-asm -fearly-inlining -feliminate-unused-debug-symbols
@ -feliminate-unused-debug-types -fexpensive-optimizations
@ -fforward-propagate -ffp-int-builtin-inexact -ffunction-cse -fgcse
@ -fgcse-lm -fgnu-unique -fguess-branch-probability -fhoist-adjacent-loads
@ -fident -fif-conversion -fif-conversion2 -findirect-inlining -finline
@ -finline-atomics -finline-functions -finline-functions-called-once
@ -finline-small-functions -fipa-bit-cp -fipa-cp -fipa-icf
@ -fipa-icf-functions -fipa-icf-variables -fipa-profile -fipa-pure-const
@ -fipa-reference -fipa-reference-addressable -fipa-sra
@ -fipa-stack-alignment -fipa-vrp -fira-hoist-pressure
@ -fira-share-save-slots -fira-share-spill-slots
@ -fisolate-erroneous-paths-dereference -fivopts -fkeep-static-consts
@ -fleading-underscore -flifetime-dse -flra-remat -fmath-errno
@ -fmerge-constants -fmerge-debug-strings -fmove-loop-invariants
@ -fomit-frame-pointer -foptimize-sibling-calls -fpartial-inlining
@ -fpeephole -fpeephole2 -fplt -fprefetch-loop-arrays -freg-struct-return
@ -freorder-blocks -freorder-functions -frerun-cse-after-loop
@ -fsched-critical-path-heuristic -fsched-dep-count-heuristic
@ -fsched-group-heuristic -fsched-interblock -fsched-last-insn-heuristic
@ -fsched-pressure -fsched-rank-heuristic -fsched-spec
@ -fsched-spec-insn-heuristic -fsched-stalled-insns-dep -fschedule-insns2
@ -fsection-anchors -fsemantic-interposition -fshow-column -fshrink-wrap
@ -fshrink-wrap-separate -fsigned-zeros -fsplit-ivs-in-unroller
@ -fsplit-wide-types -fssa-backprop -fssa-phiopt -fstdarg-opt
@ -fstore-merging -fstrict-aliasing -fstrict-volatile-bitfields
@ -fsync-libcalls -fthread-jumps -ftoplevel-reorder -ftrapping-math
@ -ftree-bit-ccp -ftree-builtin-call-dce -ftree-ccp -ftree-ch
@ -ftree-coalesce-vars -ftree-copy-prop -ftree-cselim -ftree-dce
@ -ftree-dominator-opts -ftree-dse -ftree-forwprop -ftree-fre
@ -ftree-loop-distribute-patterns -ftree-loop-if-convert -ftree-loop-im
@ -ftree-loop-ivcanon -ftree-loop-optimize -ftree-parallelize-loops=
@ -ftree-phiprop -ftree-pre -ftree-pta -ftree-reassoc -ftree-scev-cprop
@ -ftree-sink -ftree-slsr -ftree-sra -ftree-switch-conversion
@ -ftree-tail-merge -ftree-ter -ftree-vrp -funit-at-a-time -fverbose-asm
@ -fzero-initialized-in-bss -mbe32 -mlittle-endian -mlong-calls
@ -mpic-data-is-text-relative -msched-prolog -mthumb -mthumb-interwork
@ -mvectorize-with-neon-quad

	.text
	.align	1
	.global	AuraSkillCheck
	.arch armv4t
	.syntax unified
	.code	16
	.thumb_func
	.fpu softvfp
	.type	AuraSkillCheck, %function
AuraSkillCheck:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, r7, lr}	@
	sub	sp, sp, #20	@,,
@ AuraSkillCheck.c:15: long long AuraSkillCheck(Unit* unit, int skill, int param, int maxRange) {
	str	r3, [sp, #12]	@ tmp188, %sfp
	ldr	r3, .L31	@ tmp150,
	str	r3, [sp, #8]	@ tmp150, %sfp
	movs	r3, r2	@ param, tmp187
	movs	r7, r1	@ skill, tmp186
	str	r0, [sp, #4]	@ tmp185, %sfp
	str	r2, [sp]	@ tmp187, %sfp
	lsls	r3, r3, #31	@ tmp193, param,
	bpl	.L3		@,
	ldr	r3, .L31+4	@ tmp150,
	str	r3, [sp, #8]	@ tmp150, %sfp
.L3:
@ AuraSkillCheck.c:19: 	for (int i = 0; i < 0x100; ++i) {
	movs	r5, #0	@ i,
@ AuraSkillCheck.c:17: 	int count = 0;
	movs	r6, r5	@ count, i
.L9:
@ AuraSkillCheck.c:20: 		if ((skill == 255)) { 
	cmp	r7, #255	@ skill,
	beq	.L21		@,
@ AuraSkillCheck.c:24: 		Unit* other = gUnitLookup[i];
	ldr	r3, .L31+8	@ tmp153,
	lsls	r2, r5, #2	@ tmp154, i,
	ldr	r4, [r2, r3]	@ other, gUnitLookup
@ AuraSkillCheck.c:26: 		if (!other)
	cmp	r4, #0	@ other,
	beq	.L4		@,
@ AuraSkillCheck.c:29: 		if (unit->index == i)
	movs	r0, #11	@ _2,
	ldr	r3, [sp, #4]	@ unit, %sfp
	ldrsb	r0, [r3, r0]	@ _2,* _2
@ AuraSkillCheck.c:29: 		if (unit->index == i)
	cmp	r0, r5	@ _2, i
	beq	.L4		@,
@ AuraSkillCheck.c:32: 		if (!other->pCharacterData)
	ldr	r3, [r4]	@ tmp200, other_31->pCharacterData
	cmp	r3, #0	@ tmp200,
	beq	.L4		@,
@ AuraSkillCheck.c:35: 		if (other->state & (US_RESCUED | US_NOT_DEPLOYED | US_DEAD | 0x00010000))
	ldr	r3, .L31+12	@ tmp158,
@ AuraSkillCheck.c:35: 		if (other->state & (US_RESCUED | US_NOT_DEPLOYED | US_DEAD | 0x00010000))
	ldr	r2, [r4, #12]	@ tmp201, other_31->state
	tst	r2, r3	@ tmp201, tmp158
	bne	.L4		@,
@ AuraSkillCheck.c:38: 		int distance = absolute(other->xPos - unit->xPos)
	movs	r3, #16	@ tmp159,
@ AuraSkillCheck.c:38: 		int distance = absolute(other->xPos - unit->xPos)
	ldr	r2, [sp, #4]	@ unit, %sfp
	ldrb	r2, [r2, #16]	@ tmp160,
@ AuraSkillCheck.c:38: 		int distance = absolute(other->xPos - unit->xPos)
	ldrsb	r3, [r4, r3]	@ tmp159,
@ AuraSkillCheck.c:38: 		int distance = absolute(other->xPos - unit->xPos)
	lsls	r2, r2, #24	@ tmp160, tmp160,
	asrs	r2, r2, #24	@ tmp160, tmp160,
@ AuraSkillCheck.c:38: 		int distance = absolute(other->xPos - unit->xPos)
	subs	r2, r3, r2	@ tmp161, tmp159, tmp160
@ AuraSkillCheck.c:11: static int absolute(int value) { return value < 0 ? -value : value; }
	asrs	r3, r2, #31	@ tmp194, tmp161,
	adds	r2, r2, r3	@ tmp162, tmp161, tmp194
	eors	r2, r3	@ tmp162, tmp194
@ AuraSkillCheck.c:39: 		             + absolute(other->yPos - unit->yPos);
	movs	r3, #17	@ tmp163,
@ AuraSkillCheck.c:39: 		             + absolute(other->yPos - unit->yPos);
	ldr	r1, [sp, #4]	@ unit, %sfp
	ldrb	r1, [r1, #17]	@ tmp164,
@ AuraSkillCheck.c:39: 		             + absolute(other->yPos - unit->yPos);
	ldrsb	r3, [r4, r3]	@ tmp163,
@ AuraSkillCheck.c:39: 		             + absolute(other->yPos - unit->yPos);
	lsls	r1, r1, #24	@ tmp164, tmp164,
	asrs	r1, r1, #24	@ tmp164, tmp164,
@ AuraSkillCheck.c:39: 		             + absolute(other->yPos - unit->yPos);
	subs	r3, r3, r1	@ tmp165, tmp163, tmp164
@ AuraSkillCheck.c:11: static int absolute(int value) { return value < 0 ? -value : value; }
	asrs	r1, r3, #31	@ tmp195, tmp165,
	adds	r3, r3, r1	@ tmp166, tmp165, tmp195
	eors	r3, r1	@ tmp166, tmp195
@ AuraSkillCheck.c:38: 		int distance = absolute(other->xPos - unit->xPos)
	adds	r3, r2, r3	@ distance, tmp162, tmp166
@ AuraSkillCheck.c:41: 		if ((distance <= maxRange) && AuraSkillTest(unit, other, skill, param))
	ldr	r2, [sp, #12]	@ maxRange, %sfp
	cmp	r3, r2	@ distance, maxRange
	bgt	.L4		@,
@ AuraSkillCheck.c:64: 	if (param == 4)
	ldr	r3, [sp]	@ param, %sfp
	cmp	r3, #4	@ param,
	bne	.L5		@,
.L30:
@ AuraSkillCheck.c:65: 		return SkillTester(other, skill);
	movs	r1, r7	@, skill
	movs	r0, r4	@, other
	ldr	r3, .L31+16	@ tmp168,
	bl	.L33		@
@ AuraSkillCheck.c:41: 		if ((distance <= maxRange) && AuraSkillTest(unit, other, skill, param))
	cmp	r0, #0	@ tmp189,
	beq	.L4		@,
@ AuraSkillCheck.c:42: 			gAuraUnitListOut[count++] = i;
	ldr	r3, .L31+20	@ tmp169,
	strb	r5, [r3, r6]	@ i, gAuraUnitListOut
@ AuraSkillCheck.c:42: 			gAuraUnitListOut[count++] = i;
	adds	r6, r6, #1	@ count,
.L4:
@ AuraSkillCheck.c:19: 	for (int i = 0; i < 0x100; ++i) {
	adds	r5, r5, #1	@ i,
@ AuraSkillCheck.c:19: 	for (int i = 0; i < 0x100; ++i) {
	cmp	r5, #255	@ i,
	ble	.L9		@,
.L21:
@ AuraSkillCheck.c:45: 	gAuraUnitListOut[count] = 0;
	movs	r3, #0	@ tmp176,
@ AuraSkillCheck.c:59: }
	movs	r0, r6	@, count
@ AuraSkillCheck.c:45: 	gAuraUnitListOut[count] = 0;
	ldr	r1, .L31+20	@ tmp175,
	strb	r3, [r1, r6]	@ tmp176, gAuraUnitListOut
@ AuraSkillCheck.c:59: }
	add	sp, sp, #20	@,,
	@ sp needed	@
	pop	{r4, r5, r6, r7}
	pop	{r2}
	bx	r2
.L5:
@ AuraSkillCheck.c:67: 	if (param > 4)
	ldr	r3, [sp]	@ param, %sfp
	cmp	r3, #4	@ param,
	bgt	.L4		@,
@ AuraSkillCheck.c:70: 	int check = pAllegianceChecker(unit->index, other->index);
	movs	r1, #11	@ tmp171,
	ldr	r3, [sp, #8]	@ tmp150, %sfp
	ldrsb	r1, [r4, r1]	@ tmp171,
	bl	.L33		@
@ AuraSkillCheck.c:72: 	if (param & 2)
	movs	r2, #2	@ tmp211,
	ldr	r3, [sp]	@ param, %sfp
	tst	r3, r2	@ param, tmp211
	beq	.L6		@,
@ AuraSkillCheck.c:75: 	return check && SkillTester(other, skill);
	cmp	r0, #0	@ check,
	bne	.L4		@,
	b	.L30		@
.L6:
	cmp	r0, #0	@ check,
	beq	.L4		@,
	b	.L30		@
.L32:
	.align	2
.L31:
	.word	AreAllegiancesAllied
	.word	AreAllegiancesEqual
	.word	gUnitLookup
	.word	65580
	.word	SkillTester
	.word	gAuraUnitListOut
	.size	AuraSkillCheck, .-AuraSkillCheck
	.ident	"GCC: (devkitARM release 54) 10.1.0"
	.code 16
	.align	1
.L33:
	bx	r3
