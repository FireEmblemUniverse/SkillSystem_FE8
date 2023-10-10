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
	.file	"CheckBattleUnitLevelUp.c"
@ GNU C17 (devkitARM release 56) version 11.1.0 (arm-none-eabi)
@	compiled by GNU C version 10.3.0, GMP version 6.2.1, MPFR version 4.1.0, MPC version 1.2.1, isl version isl-0.18-GMP

@ GGC heuristics: --param ggc-min-expand=100 --param ggc-min-heapsize=131072
@ options passed: -mcpu=arm7tdmi -mthumb -mthumb-interwork -mtune=arm7tdmi -mlong-calls -march=armv4t -O2
	.text
	.align	1
	.p2align 2,,3
	.global	GetUnitPromotionLevel
	.arch armv4t
	.syntax unified
	.code	16
	.thumb_func
	.fpu softvfp
	.type	GetUnitPromotionLevel, %function
GetUnitPromotionLevel:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
@ CheckBattleUnitLevelUp.c:18: {
	movs	r3, r0	@ unit, tmp146
@ CheckBattleUnitLevelUp.c:20: 	int maxLevel = Class_Level_Cap_Table[unit->pClassData->number]; 
	ldr	r1, [r0, #4]	@ unit_15(D)->pClassData, unit_15(D)->pClassData
@ CheckBattleUnitLevelUp.c:21: 	int uid = unit->pCharacterData->number;
	ldr	r3, [r3]	@ unit_15(D)->pCharacterData, unit_15(D)->pCharacterData
@ CheckBattleUnitLevelUp.c:20: 	int maxLevel = Class_Level_Cap_Table[unit->pClassData->number]; 
	ldr	r2, .L7	@ tmp127,
@ CheckBattleUnitLevelUp.c:20: 	int maxLevel = Class_Level_Cap_Table[unit->pClassData->number]; 
	ldrb	r1, [r1, #4]	@ tmp129,
@ CheckBattleUnitLevelUp.c:21: 	int uid = unit->pCharacterData->number;
	ldrb	r3, [r3, #4]	@ uid,
@ CheckBattleUnitLevelUp.c:20: 	int maxLevel = Class_Level_Cap_Table[unit->pClassData->number]; 
	ldrb	r0, [r2, r1]	@ <retval>, Class_Level_Cap_Table
@ CheckBattleUnitLevelUp.c:22: 	if (uid > 0x45) { return maxLevel; }
	cmp	r3, #69	@ uid,
	bgt	.L2		@,
@ CheckBattleUnitLevelUp.c:23: 	int result = *(gBWLDataStorage + 0x10 * (uid - 1) + 8); // repurpose bwl->moveAmt into bwl->promotionLvl 
	ldr	r2, .L7+4	@ tmp134,
@ CheckBattleUnitLevelUp.c:23: 	int result = *(gBWLDataStorage + 0x10 * (uid - 1) + 8); // repurpose bwl->moveAmt into bwl->promotionLvl 
	subs	r3, r3, #1	@ tmp131,
@ CheckBattleUnitLevelUp.c:23: 	int result = *(gBWLDataStorage + 0x10 * (uid - 1) + 8); // repurpose bwl->moveAmt into bwl->promotionLvl 
	lsls	r3, r3, #4	@ tmp132, tmp131,
	ldrb	r2, [r2, r3]	@ _12, *_11
@ CheckBattleUnitLevelUp.c:24: 	if (result < 10) { return 10; } 
	cmp	r2, #9	@ _12,
	bls	.L4		@,
	adds	r3, r0, #0	@ <retval>, <retval>
	cmp	r0, r2	@ <retval>, _12
	bhi	.L6		@,
.L3:
	lsls	r3, r3, #24	@ tmp143, <retval>,
	lsrs	r0, r3, #24	@ <retval>, tmp143,
.L2:
@ CheckBattleUnitLevelUp.c:28: }
	@ sp needed	@
	bx	lr
.L6:
	adds	r3, r2, #0	@ <retval>, _12
	b	.L3		@
.L4:
@ CheckBattleUnitLevelUp.c:24: 	if (result < 10) { return 10; } 
	movs	r0, #10	@ <retval>,
	b	.L2		@
.L8:
	.align	2
.L7:
	.word	Class_Level_Cap_Table
	.word	gBWLDataStorage+8
	.size	GetUnitPromotionLevel, .-GetUnitPromotionLevel
	.align	1
	.p2align 2,,3
	.global	SetUnitPromotionLevel
	.syntax unified
	.code	16
	.thumb_func
	.fpu softvfp
	.type	SetUnitPromotionLevel, %function
SetUnitPromotionLevel:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
@ CheckBattleUnitLevelUp.c:34: 	int uid = unit->pCharacterData->number;
	ldr	r3, [r0]	@ unit_9(D)->pCharacterData, unit_9(D)->pCharacterData
@ CheckBattleUnitLevelUp.c:34: 	int uid = unit->pCharacterData->number;
	ldrb	r3, [r3, #4]	@ uid,
@ CheckBattleUnitLevelUp.c:35: 	if (uid > 0x45) { return; }
	cmp	r3, #69	@ uid,
	bgt	.L9		@,
@ CheckBattleUnitLevelUp.c:36:     gBWLDataStorage[(0x10 * (uid - 1)) + 8] = level; // repurpose bwl->moveAmt into bwl->promotionLvl 
	ldr	r2, .L11	@ tmp123,
@ CheckBattleUnitLevelUp.c:36:     gBWLDataStorage[(0x10 * (uid - 1)) + 8] = level; // repurpose bwl->moveAmt into bwl->promotionLvl 
	subs	r3, r3, #1	@ tmp124,
@ CheckBattleUnitLevelUp.c:36:     gBWLDataStorage[(0x10 * (uid - 1)) + 8] = level; // repurpose bwl->moveAmt into bwl->promotionLvl 
	lsls	r3, r3, #4	@ tmp125, tmp124,
	adds	r2, r2, r3	@ tmp126, tmp123, tmp125
	strb	r1, [r2, #8]	@ level, gBWLDataStorage[_5]
.L9:
@ CheckBattleUnitLevelUp.c:37: }
	@ sp needed	@
	bx	lr
.L12:
	.align	2
.L11:
	.word	gBWLDataStorage
	.size	SetUnitPromotionLevel, .-SetUnitPromotionLevel
	.align	1
	.p2align 2,,3
	.global	NewPromoHandler_SetInitStat
	.syntax unified
	.code	16
	.thumb_func
	.fpu softvfp
	.type	NewPromoHandler_SetInitStat, %function
NewPromoHandler_SetInitStat:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
@ CheckBattleUnitLevelUp.c:41:     proc->stat = PROMO_HANDLER_STAT_INIT;
	movs	r2, #0	@ tmp125,
	movs	r3, #48	@ tmp124,
	strb	r2, [r0, r3]	@ tmp125, proc_5(D)->stat
@ CheckBattleUnitLevelUp.c:42: 	if (proc->unit) { 
	ldr	r2, [r0, #56]	@ _1, proc_5(D)->unit
@ CheckBattleUnitLevelUp.c:42: 	if (proc->unit) { 
	cmp	r2, #0	@ _1,
	beq	.L14		@,
@ CheckBattleUnitLevelUp.c:34: 	int uid = unit->pCharacterData->number;
	ldr	r3, [r2]	@ _1->pCharacterData, _1->pCharacterData
@ CheckBattleUnitLevelUp.c:34: 	int uid = unit->pCharacterData->number;
	ldrb	r3, [r3, #4]	@ uid,
@ CheckBattleUnitLevelUp.c:35: 	if (uid > 0x45) { return; }
	cmp	r3, #69	@ uid,
	bgt	.L14		@,
@ CheckBattleUnitLevelUp.c:36:     gBWLDataStorage[(0x10 * (uid - 1)) + 8] = level; // repurpose bwl->moveAmt into bwl->promotionLvl 
	ldr	r1, .L18	@ tmp128,
@ CheckBattleUnitLevelUp.c:36:     gBWLDataStorage[(0x10 * (uid - 1)) + 8] = level; // repurpose bwl->moveAmt into bwl->promotionLvl 
	subs	r3, r3, #1	@ tmp129,
@ CheckBattleUnitLevelUp.c:36:     gBWLDataStorage[(0x10 * (uid - 1)) + 8] = level; // repurpose bwl->moveAmt into bwl->promotionLvl 
	lsls	r3, r3, #4	@ tmp130, tmp129,
	adds	r1, r1, r3	@ tmp131, tmp128, tmp130
	ldrb	r3, [r2, #8]	@ tmp133,
	strb	r3, [r1, #8]	@ tmp133, gBWLDataStorage[_12]
.L14:
@ CheckBattleUnitLevelUp.c:46: }
	@ sp needed	@
	movs	r0, #0	@,
	bx	lr
.L19:
	.align	2
.L18:
	.word	gBWLDataStorage
	.size	NewPromoHandler_SetInitStat, .-NewPromoHandler_SetInitStat
	.align	1
	.p2align 2,,3
	.global	GetStatFromDefinition
	.syntax unified
	.code	16
	.thumb_func
	.fpu softvfp
	.type	GetStatFromDefinition, %function
GetStatFromDefinition:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
@ CheckBattleUnitLevelUp.c:76: 	switch (id) { 
	cmp	r0, #7	@ id,
	bhi	.L31		@,
	ldr	r3, .L32	@ tmp126,
	lsls	r0, r0, #2	@ tmp124, id,
	ldr	r3, [r3, r0]	@ tmp127,
	mov	pc, r3	@ tmp127
	.section	.rodata
	.align	2
.L23:
	.word	.L30
	.word	.L29
	.word	.L28
	.word	.L27
	.word	.L26
	.word	.L25
	.word	.L24
	.word	.L22
	.text
.L24:
@ CheckBattleUnitLevelUp.c:83: 	case lukStat: return unit->lck; 
	movs	r0, #25	@ <retval>,
	ldrsb	r0, [r1, r0]	@ <retval>,* <retval>
.L20:
@ CheckBattleUnitLevelUp.c:87: } 
	@ sp needed	@
	bx	lr
.L22:
@ CheckBattleUnitLevelUp.c:84: 	case magStat: return unit->_u3A; // mag 
	movs	r3, #58	@ tmp128,
	ldrb	r0, [r1, r3]	@ <retval>,
	b	.L20		@
.L30:
@ CheckBattleUnitLevelUp.c:77: 	case hpStat: return unit->maxHP; 
	movs	r0, #18	@ <retval>,
	ldrsb	r0, [r1, r0]	@ <retval>,* <retval>
	b	.L20		@
.L29:
@ CheckBattleUnitLevelUp.c:78: 	case strStat: return unit->pow; 
	movs	r0, #20	@ <retval>,
	ldrsb	r0, [r1, r0]	@ <retval>,* <retval>
	b	.L20		@
.L28:
@ CheckBattleUnitLevelUp.c:79: 	case sklStat: return unit->skl; 
	movs	r0, #21	@ <retval>,
	ldrsb	r0, [r1, r0]	@ <retval>,* <retval>
	b	.L20		@
.L27:
@ CheckBattleUnitLevelUp.c:80: 	case spdStat: return unit->spd; 
	movs	r0, #22	@ <retval>,
	ldrsb	r0, [r1, r0]	@ <retval>,* <retval>
	b	.L20		@
.L26:
@ CheckBattleUnitLevelUp.c:81: 	case defStat: return unit->def; 
	movs	r0, #23	@ <retval>,
	ldrsb	r0, [r1, r0]	@ <retval>,* <retval>
	b	.L20		@
.L25:
@ CheckBattleUnitLevelUp.c:82: 	case resStat: return unit->res; 
	movs	r0, #24	@ <retval>,
	ldrsb	r0, [r1, r0]	@ <retval>,* <retval>
	b	.L20		@
.L31:
@ CheckBattleUnitLevelUp.c:76: 	switch (id) { 
	movs	r0, #0	@ <retval>,
	b	.L20		@
.L33:
	.align	2
.L32:
	.word	.L23
	.size	GetStatFromDefinition, .-GetStatFromDefinition
	.align	1
	.p2align 2,,3
	.global	GetBaseStatFromDefinition
	.syntax unified
	.code	16
	.thumb_func
	.fpu softvfp
	.type	GetBaseStatFromDefinition, %function
GetBaseStatFromDefinition:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
@ CheckBattleUnitLevelUp.c:90: 	switch (id) { 
	cmp	r0, #7	@ id,
	bhi	.L45		@,
	ldr	r3, .L46	@ tmp166,
	lsls	r0, r0, #2	@ tmp164, id,
	ldr	r3, [r3, r0]	@ tmp167,
	mov	pc, r3	@ tmp167
	.section	.rodata
	.align	2
.L37:
	.word	.L44
	.word	.L43
	.word	.L42
	.word	.L41
	.word	.L40
	.word	.L39
	.word	.L38
	.word	.L36
	.text
.L38:
@ CheckBattleUnitLevelUp.c:97: 	case lukStat: return unit->pCharacterData->baseLck; // classes do not have base luck + unit->pClassData->baseLck; 
	movs	r0, #18	@ <retval>,
	ldr	r3, [r1]	@ unit_52(D)->pCharacterData, unit_52(D)->pCharacterData
	ldrsb	r0, [r3, r0]	@ <retval>,* <retval>
.L34:
@ CheckBattleUnitLevelUp.c:101: } 
	@ sp needed	@
	bx	lr
.L36:
@ CheckBattleUnitLevelUp.c:98: 	case magStat: return MagCharTable[unit->pCharacterData->number].base + MagClassTable[unit->pClassData->number].base; 
	ldr	r2, [r1]	@ unit_52(D)->pCharacterData, unit_52(D)->pCharacterData
	ldrb	r2, [r2, #4]	@ tmp195,
@ CheckBattleUnitLevelUp.c:98: 	case magStat: return MagCharTable[unit->pCharacterData->number].base + MagClassTable[unit->pClassData->number].base; 
	ldr	r3, .L46+4	@ tmp193,
	lsls	r2, r2, #1	@ tmp196, tmp195,
	ldrb	r0, [r2, r3]	@ tmp197, MagCharTable
@ CheckBattleUnitLevelUp.c:98: 	case magStat: return MagCharTable[unit->pCharacterData->number].base + MagClassTable[unit->pClassData->number].base; 
	ldr	r2, [r1, #4]	@ unit_52(D)->pClassData, unit_52(D)->pClassData
	ldrb	r2, [r2, #4]	@ tmp200,
@ CheckBattleUnitLevelUp.c:98: 	case magStat: return MagCharTable[unit->pCharacterData->number].base + MagClassTable[unit->pClassData->number].base; 
	ldr	r3, .L46+8	@ tmp198,
	lsls	r2, r2, #2	@ tmp201, tmp200,
	ldrb	r3, [r2, r3]	@ tmp202, MagClassTable
@ CheckBattleUnitLevelUp.c:98: 	case magStat: return MagCharTable[unit->pCharacterData->number].base + MagClassTable[unit->pClassData->number].base; 
	adds	r0, r0, r3	@ <retval>, tmp197, tmp202
	b	.L34		@
.L44:
@ CheckBattleUnitLevelUp.c:91: 	case hpStat: return unit->pCharacterData->baseHP + unit->pClassData->baseHP; 
	movs	r0, #12	@ tmp169,
	ldr	r3, [r1]	@ unit_52(D)->pCharacterData, unit_52(D)->pCharacterData
	ldrsb	r0, [r3, r0]	@ tmp169,
@ CheckBattleUnitLevelUp.c:91: 	case hpStat: return unit->pCharacterData->baseHP + unit->pClassData->baseHP; 
	ldr	r3, [r1, #4]	@ unit_52(D)->pClassData, unit_52(D)->pClassData
	ldrb	r3, [r3, #11]	@ tmp171,
	lsls	r3, r3, #24	@ tmp171, tmp171,
	asrs	r3, r3, #24	@ tmp171, tmp171,
@ CheckBattleUnitLevelUp.c:91: 	case hpStat: return unit->pCharacterData->baseHP + unit->pClassData->baseHP; 
	adds	r0, r0, r3	@ <retval>, tmp169, tmp171
	b	.L34		@
.L43:
@ CheckBattleUnitLevelUp.c:92: 	case strStat: return unit->pCharacterData->basePow + unit->pClassData->basePow; 
	movs	r0, #13	@ tmp173,
	ldr	r3, [r1]	@ unit_52(D)->pCharacterData, unit_52(D)->pCharacterData
	ldrsb	r0, [r3, r0]	@ tmp173,
@ CheckBattleUnitLevelUp.c:92: 	case strStat: return unit->pCharacterData->basePow + unit->pClassData->basePow; 
	ldr	r3, [r1, #4]	@ unit_52(D)->pClassData, unit_52(D)->pClassData
	ldrb	r3, [r3, #12]	@ tmp175,
	lsls	r3, r3, #24	@ tmp175, tmp175,
	asrs	r3, r3, #24	@ tmp175, tmp175,
@ CheckBattleUnitLevelUp.c:92: 	case strStat: return unit->pCharacterData->basePow + unit->pClassData->basePow; 
	adds	r0, r0, r3	@ <retval>, tmp173, tmp175
	b	.L34		@
.L42:
@ CheckBattleUnitLevelUp.c:93: 	case sklStat: return unit->pCharacterData->baseSkl + unit->pClassData->baseSkl; 
	movs	r0, #14	@ tmp177,
	ldr	r3, [r1]	@ unit_52(D)->pCharacterData, unit_52(D)->pCharacterData
	ldrsb	r0, [r3, r0]	@ tmp177,
@ CheckBattleUnitLevelUp.c:93: 	case sklStat: return unit->pCharacterData->baseSkl + unit->pClassData->baseSkl; 
	ldr	r3, [r1, #4]	@ unit_52(D)->pClassData, unit_52(D)->pClassData
	ldrb	r3, [r3, #13]	@ tmp179,
	lsls	r3, r3, #24	@ tmp179, tmp179,
	asrs	r3, r3, #24	@ tmp179, tmp179,
@ CheckBattleUnitLevelUp.c:93: 	case sklStat: return unit->pCharacterData->baseSkl + unit->pClassData->baseSkl; 
	adds	r0, r0, r3	@ <retval>, tmp177, tmp179
	b	.L34		@
.L41:
@ CheckBattleUnitLevelUp.c:94: 	case spdStat: return unit->pCharacterData->baseSpd + unit->pClassData->baseSpd; 
	movs	r0, #15	@ tmp181,
	ldr	r3, [r1]	@ unit_52(D)->pCharacterData, unit_52(D)->pCharacterData
	ldrsb	r0, [r3, r0]	@ tmp181,
@ CheckBattleUnitLevelUp.c:94: 	case spdStat: return unit->pCharacterData->baseSpd + unit->pClassData->baseSpd; 
	ldr	r3, [r1, #4]	@ unit_52(D)->pClassData, unit_52(D)->pClassData
	ldrb	r3, [r3, #14]	@ tmp183,
	lsls	r3, r3, #24	@ tmp183, tmp183,
	asrs	r3, r3, #24	@ tmp183, tmp183,
@ CheckBattleUnitLevelUp.c:94: 	case spdStat: return unit->pCharacterData->baseSpd + unit->pClassData->baseSpd; 
	adds	r0, r0, r3	@ <retval>, tmp181, tmp183
	b	.L34		@
.L40:
@ CheckBattleUnitLevelUp.c:95: 	case defStat: return unit->pCharacterData->baseDef + unit->pClassData->baseDef; 
	movs	r0, #16	@ tmp185,
	ldr	r3, [r1]	@ unit_52(D)->pCharacterData, unit_52(D)->pCharacterData
	ldrsb	r0, [r3, r0]	@ tmp185,
@ CheckBattleUnitLevelUp.c:95: 	case defStat: return unit->pCharacterData->baseDef + unit->pClassData->baseDef; 
	ldr	r3, [r1, #4]	@ unit_52(D)->pClassData, unit_52(D)->pClassData
	ldrb	r3, [r3, #15]	@ tmp187,
	lsls	r3, r3, #24	@ tmp187, tmp187,
	asrs	r3, r3, #24	@ tmp187, tmp187,
@ CheckBattleUnitLevelUp.c:95: 	case defStat: return unit->pCharacterData->baseDef + unit->pClassData->baseDef; 
	adds	r0, r0, r3	@ <retval>, tmp185, tmp187
	b	.L34		@
.L39:
@ CheckBattleUnitLevelUp.c:96: 	case resStat: return unit->pCharacterData->baseRes + unit->pClassData->baseRes; 
	movs	r0, #17	@ tmp189,
	ldr	r3, [r1]	@ unit_52(D)->pCharacterData, unit_52(D)->pCharacterData
	ldrsb	r0, [r3, r0]	@ tmp189,
@ CheckBattleUnitLevelUp.c:96: 	case resStat: return unit->pCharacterData->baseRes + unit->pClassData->baseRes; 
	ldr	r3, [r1, #4]	@ unit_52(D)->pClassData, unit_52(D)->pClassData
	ldrb	r3, [r3, #16]	@ tmp191,
	lsls	r3, r3, #24	@ tmp191, tmp191,
	asrs	r3, r3, #24	@ tmp191, tmp191,
@ CheckBattleUnitLevelUp.c:96: 	case resStat: return unit->pCharacterData->baseRes + unit->pClassData->baseRes; 
	adds	r0, r0, r3	@ <retval>, tmp189, tmp191
	b	.L34		@
.L45:
@ CheckBattleUnitLevelUp.c:90: 	switch (id) { 
	movs	r0, #0	@ <retval>,
	b	.L34		@
.L47:
	.align	2
.L46:
	.word	.L37
	.word	MagCharTable
	.word	MagClassTable
	.size	GetBaseStatFromDefinition, .-GetBaseStatFromDefinition
	.global	__aeabi_idiv
	.align	1
	.p2align 2,,3
	.global	GetAverageStat
	.syntax unified
	.code	16
	.thumb_func
	.fpu softvfp
	.type	GetAverageStat, %function
GetAverageStat:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, lr}	@
@ CheckBattleUnitLevelUp.c:49: int GetAverageStat(int growth, int stat, struct Unit* unit, int levels) { // unit required because bunit includes stats from temp boosters (eg. weapon provides +5 str) in their raw stats 
	movs	r6, r0	@ growth, tmp128
@ CheckBattleUnitLevelUp.c:73: } 
	@ sp needed	@
@ CheckBattleUnitLevelUp.c:49: int GetAverageStat(int growth, int stat, struct Unit* unit, int levels) { // unit required because bunit includes stats from temp boosters (eg. weapon provides +5 str) in their raw stats 
	movs	r0, r1	@ stat, tmp129
	movs	r1, r2	@ unit, tmp130
	movs	r4, r3	@ levels, tmp131
@ CheckBattleUnitLevelUp.c:57: 	int baseStat = GetBaseStatFromDefinition(stat, unit); 
	bl	GetBaseStatFromDefinition		@
@ CheckBattleUnitLevelUp.c:62: 	result = ((growth * levels) / 100) + baseStat; 
	movs	r1, #100	@,
@ CheckBattleUnitLevelUp.c:57: 	int baseStat = GetBaseStatFromDefinition(stat, unit); 
	movs	r5, r0	@ baseStat, tmp132
@ CheckBattleUnitLevelUp.c:62: 	result = ((growth * levels) / 100) + baseStat; 
	ldr	r3, .L49	@ tmp126,
@ CheckBattleUnitLevelUp.c:62: 	result = ((growth * levels) / 100) + baseStat; 
	movs	r0, r4	@ tmp122, levels
	muls	r0, r6	@ tmp122, growth
@ CheckBattleUnitLevelUp.c:62: 	result = ((growth * levels) / 100) + baseStat; 
	bl	.L51		@
@ CheckBattleUnitLevelUp.c:62: 	result = ((growth * levels) / 100) + baseStat; 
	adds	r0, r0, r5	@ result, tmp133, baseStat
@ CheckBattleUnitLevelUp.c:73: } 
	pop	{r4, r5, r6}
	pop	{r1}
	bx	r1
.L50:
	.align	2
.L49:
	.word	__aeabi_idiv
	.size	GetAverageStat, .-GetAverageStat
	.align	1
	.p2align 2,,3
	.global	GetMaxStatFromDefinition
	.syntax unified
	.code	16
	.thumb_func
	.fpu softvfp
	.type	GetMaxStatFromDefinition, %function
GetMaxStatFromDefinition:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
@ CheckBattleUnitLevelUp.c:104: 	switch (id) { 
	cmp	r0, #7	@ id,
	bhi	.L61		@,
	ldr	r3, .L62	@ tmp132,
	lsls	r0, r0, #2	@ tmp130, id,
	ldr	r3, [r3, r0]	@ tmp133,
	mov	pc, r3	@ tmp133
	.section	.rodata
	.align	2
.L55:
	.word	.L61
	.word	.L60
	.word	.L59
	.word	.L58
	.word	.L57
	.word	.L56
	.word	.L61
	.word	.L54
	.text
.L54:
@ CheckBattleUnitLevelUp.c:112: 	case magStat: return MagClassTable[unit->pClassData->number].cap; 
	ldr	r2, [r1, #4]	@ unit_18(D)->pClassData, unit_18(D)->pClassData
	ldrb	r2, [r2, #4]	@ tmp141,
@ CheckBattleUnitLevelUp.c:112: 	case magStat: return MagClassTable[unit->pClassData->number].cap; 
	ldr	r3, .L62+4	@ tmp139,
	lsls	r2, r2, #2	@ tmp142, tmp141,
	adds	r3, r3, r2	@ tmp143, tmp139, tmp142
	ldrb	r0, [r3, #2]	@ <retval>, MagClassTable
.L52:
@ CheckBattleUnitLevelUp.c:115: } 
	@ sp needed	@
	bx	lr
.L60:
@ CheckBattleUnitLevelUp.c:106: 	case strStat: return unit->pClassData->maxPow; 
	movs	r0, #20	@ <retval>,
	ldr	r3, [r1, #4]	@ unit_18(D)->pClassData, unit_18(D)->pClassData
	ldrsb	r0, [r3, r0]	@ <retval>,* <retval>
	b	.L52		@
.L59:
@ CheckBattleUnitLevelUp.c:107: 	case sklStat: return unit->pClassData->maxSkl; 
	movs	r0, #21	@ <retval>,
	ldr	r3, [r1, #4]	@ unit_18(D)->pClassData, unit_18(D)->pClassData
	ldrsb	r0, [r3, r0]	@ <retval>,* <retval>
	b	.L52		@
.L58:
@ CheckBattleUnitLevelUp.c:108: 	case spdStat: return unit->pClassData->maxSpd; 
	movs	r0, #22	@ <retval>,
	ldr	r3, [r1, #4]	@ unit_18(D)->pClassData, unit_18(D)->pClassData
	ldrsb	r0, [r3, r0]	@ <retval>,* <retval>
	b	.L52		@
.L57:
@ CheckBattleUnitLevelUp.c:109: 	case defStat: return unit->pClassData->maxDef; 
	movs	r0, #23	@ <retval>,
	ldr	r3, [r1, #4]	@ unit_18(D)->pClassData, unit_18(D)->pClassData
	ldrsb	r0, [r3, r0]	@ <retval>,* <retval>
	b	.L52		@
.L56:
@ CheckBattleUnitLevelUp.c:110: 	case resStat: return unit->pClassData->maxRes; 
	movs	r0, #24	@ <retval>,
	ldr	r3, [r1, #4]	@ unit_18(D)->pClassData, unit_18(D)->pClassData
	ldrsb	r0, [r3, r0]	@ <retval>,* <retval>
	b	.L52		@
.L61:
@ CheckBattleUnitLevelUp.c:104: 	switch (id) { 
	movs	r0, #255	@ <retval>,
	b	.L52		@
.L63:
	.align	2
.L62:
	.word	.L55
	.word	MagClassTable
	.size	GetMaxStatFromDefinition, .-GetMaxStatFromDefinition
	.align	1
	.p2align 2,,3
	.global	GetNumberOfLevelUps
	.syntax unified
	.code	16
	.thumb_func
	.fpu softvfp
	.type	GetNumberOfLevelUps, %function
GetNumberOfLevelUps:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
@ CheckBattleUnitLevelUp.c:118: 	int numberOfLevels = bu->unit.level - 1; 
	movs	r3, #8	@ _2,
@ CheckBattleUnitLevelUp.c:117: int GetNumberOfLevelUps(struct BattleUnit* bu) { // This doesn't really account for trainees, but there isn't much we can do about that 
	push	{r4, lr}	@
@ CheckBattleUnitLevelUp.c:126: 	if (GrowthOptions_Link.BRACKETING_USE_BASE_LEVEL) { 
	ldr	r2, .L84	@ tmp142,
	ldrb	r2, [r2]	@ GrowthOptions_Link, GrowthOptions_Link
@ CheckBattleUnitLevelUp.c:118: 	int numberOfLevels = bu->unit.level - 1; 
	ldrsb	r3, [r0, r3]	@ _2,* _2
@ CheckBattleUnitLevelUp.c:127: 		numberOfLevels -= (bu->unit.pCharacterData->baseLevel) - 1; 
	ldr	r1, [r0]	@ pretmp_50, bu_22(D)->unit.pCharacterData
@ CheckBattleUnitLevelUp.c:126: 	if (GrowthOptions_Link.BRACKETING_USE_BASE_LEVEL) { 
	lsls	r2, r2, #25	@ tmp182, GrowthOptions_Link,
	bmi	.L65		@,
@ CheckBattleUnitLevelUp.c:118: 	int numberOfLevels = bu->unit.level - 1; 
	subs	r3, r3, #1	@ numberOfLevels,
.L66:
@ CheckBattleUnitLevelUp.c:131: 	if ((bu->unit.pCharacterData->attributes | bu->unit.pClassData->attributes) & CA_PROMOTED) { 
	ldr	r0, [r0, #4]	@ _11, bu_22(D)->unit.pClassData
@ CheckBattleUnitLevelUp.c:131: 	if ((bu->unit.pCharacterData->attributes | bu->unit.pClassData->attributes) & CA_PROMOTED) { 
	ldr	r2, [r1, #40]	@ pretmp_50->attributes, pretmp_50->attributes
	ldr	r4, [r0, #40]	@ _11->attributes, _11->attributes
	orrs	r2, r4	@ tmp153, _11->attributes
@ CheckBattleUnitLevelUp.c:131: 	if ((bu->unit.pCharacterData->attributes | bu->unit.pClassData->attributes) & CA_PROMOTED) { 
	lsls	r2, r2, #23	@ tmp183, tmp153,
	bpl	.L68		@,
@ CheckBattleUnitLevelUp.c:20: 	int maxLevel = Class_Level_Cap_Table[unit->pClassData->number]; 
	ldr	r2, .L84+4	@ tmp158,
@ CheckBattleUnitLevelUp.c:20: 	int maxLevel = Class_Level_Cap_Table[unit->pClassData->number]; 
	ldrb	r0, [r0, #4]	@ tmp159,
@ CheckBattleUnitLevelUp.c:20: 	int maxLevel = Class_Level_Cap_Table[unit->pClassData->number]; 
	ldrb	r0, [r2, r0]	@ _31, Class_Level_Cap_Table
@ CheckBattleUnitLevelUp.c:21: 	int uid = unit->pCharacterData->number;
	ldrb	r2, [r1, #4]	@ uid,
@ CheckBattleUnitLevelUp.c:22: 	if (uid > 0x45) { return maxLevel; }
	cmp	r2, #69	@ uid,
	bgt	.L69		@,
@ CheckBattleUnitLevelUp.c:23: 	int result = *(gBWLDataStorage + 0x10 * (uid - 1) + 8); // repurpose bwl->moveAmt into bwl->promotionLvl 
	ldr	r1, .L84+8	@ tmp163,
@ CheckBattleUnitLevelUp.c:23: 	int result = *(gBWLDataStorage + 0x10 * (uid - 1) + 8); // repurpose bwl->moveAmt into bwl->promotionLvl 
	subs	r2, r2, #1	@ tmp160,
@ CheckBattleUnitLevelUp.c:23: 	int result = *(gBWLDataStorage + 0x10 * (uid - 1) + 8); // repurpose bwl->moveAmt into bwl->promotionLvl 
	lsls	r2, r2, #4	@ tmp161, tmp160,
	ldrb	r1, [r1, r2]	@ _40, *_39
@ CheckBattleUnitLevelUp.c:24: 	if (result < 10) { return 10; } 
	cmp	r1, #9	@ _40,
	bls	.L74		@,
	adds	r2, r0, #0	@ _31, _31
	cmp	r0, r1	@ _31, _40
	bhi	.L82		@,
	lsls	r2, r2, #24	@ tmp172, _31,
	lsrs	r0, r2, #24	@ _31, tmp172,
.L69:
@ CheckBattleUnitLevelUp.c:133: 		if (promLevel > 0) { promLevel--; } 
	cmp	r0, #0	@ _31,
	bne	.L83		@,
.L68:
@ CheckBattleUnitLevelUp.c:138: } 
	@ sp needed	@
	mvns	r0, r3	@ tmp178, numberOfLevels
	asrs	r0, r0, #31	@ tmp177, tmp178,
	ands	r0, r3	@ numberOfLevels, numberOfLevels
	pop	{r4}
	pop	{r1}
	bx	r1
.L65:
@ CheckBattleUnitLevelUp.c:127: 		numberOfLevels -= (bu->unit.pCharacterData->baseLevel) - 1; 
	movs	r2, #11	@ tmp152,
	ldrsb	r2, [r1, r2]	@ tmp152,
@ CheckBattleUnitLevelUp.c:127: 		numberOfLevels -= (bu->unit.pCharacterData->baseLevel) - 1; 
	subs	r3, r3, r2	@ numberOfLevels, _2, tmp152
	mvns	r2, r3	@ tmp175, numberOfLevels
	asrs	r2, r2, #31	@ tmp174, tmp175,
	ands	r3, r2	@ numberOfLevels, tmp174
	b	.L66		@
.L83:
@ CheckBattleUnitLevelUp.c:133: 		if (promLevel > 0) { promLevel--; } 
	subs	r0, r0, #1	@ prephitmp_28,
@ CheckBattleUnitLevelUp.c:134: 		numberOfLevels +=  promLevel; 
	adds	r3, r3, r0	@ numberOfLevels, numberOfLevels, prephitmp_28
	b	.L68		@
.L82:
	adds	r2, r1, #0	@ _31, _40
	lsls	r2, r2, #24	@ tmp172, _31,
	lsrs	r0, r2, #24	@ _31, tmp172,
	b	.L69		@
.L74:
	movs	r0, #9	@ prephitmp_28,
	adds	r3, r3, r0	@ numberOfLevels, numberOfLevels, prephitmp_28
	b	.L68		@
.L85:
	.align	2
.L84:
	.word	GrowthOptions_Link
	.word	Class_Level_Cap_Table
	.word	gBWLDataStorage+8
	.size	GetNumberOfLevelUps, .-GetNumberOfLevelUps
	.align	1
	.p2align 2,,3
	.global	NewGetStatIncrease
	.syntax unified
	.code	16
	.thumb_func
	.fpu softvfp
	.type	NewGetStatIncrease, %function
NewGetStatIncrease:
	@ Function supports interworking.
	@ args = 4, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, r7, lr}	@
	mov	lr, r8	@,
	push	{lr}	@
@ CheckBattleUnitLevelUp.c:140: int NewGetStatIncrease(int growth, int mode, int stat, struct BattleUnit* bu,  struct Unit* unit) { 
	movs	r4, r0	@ growth, tmp172
	mov	r8, r1	@ mode, tmp173
@ CheckBattleUnitLevelUp.c:142: 	int currentStat = GetStatFromDefinition(stat, unit); 
	movs	r0, r2	@, stat
	ldr	r1, [sp, #24]	@, unit
@ CheckBattleUnitLevelUp.c:140: int NewGetStatIncrease(int growth, int mode, int stat, struct BattleUnit* bu,  struct Unit* unit) { 
	movs	r5, r2	@ stat, tmp174
	movs	r7, r3	@ bu, tmp175
@ CheckBattleUnitLevelUp.c:142: 	int currentStat = GetStatFromDefinition(stat, unit); 
	bl	GetStatFromDefinition		@
@ CheckBattleUnitLevelUp.c:143: 	if (GetMaxStatFromDefinition(stat, unit) < currentStat+1) { return 0; } // no point trying to raise a stat if we've hit the caps. This'll improve our rerolled statups when caps have been hit 
	ldr	r1, [sp, #24]	@, unit
@ CheckBattleUnitLevelUp.c:142: 	int currentStat = GetStatFromDefinition(stat, unit); 
	movs	r6, r0	@ currentStat, tmp176
@ CheckBattleUnitLevelUp.c:143: 	if (GetMaxStatFromDefinition(stat, unit) < currentStat+1) { return 0; } // no point trying to raise a stat if we've hit the caps. This'll improve our rerolled statups when caps have been hit 
	movs	r0, r5	@, stat
	bl	GetMaxStatFromDefinition		@
@ CheckBattleUnitLevelUp.c:143: 	if (GetMaxStatFromDefinition(stat, unit) < currentStat+1) { return 0; } // no point trying to raise a stat if we've hit the caps. This'll improve our rerolled statups when caps have been hit 
	cmp	r0, r6	@ tmp177, currentStat
	ble	.L97		@,
@ CheckBattleUnitLevelUp.c:145: 	if (mode == fixedGrowths) { 
	mov	r3, r8	@ mode, mode
	cmp	r3, #1	@ mode,
	beq	.L110		@,
@ CheckBattleUnitLevelUp.c:157: 	if (mode == bracketedGrowths) { 
	cmp	r3, #2	@ mode,
	beq	.L91		@,
@ CheckBattleUnitLevelUp.c:141:     int result = 0;
	movs	r5, #0	@ <retval>,
@ CheckBattleUnitLevelUp.c:176:     while (growth > 100) {
	cmp	r4, #100	@ growth,
	ble	.L93		@,
.L92:
@ CheckBattleUnitLevelUp.c:178:         growth -= 100;
	subs	r4, r4, #100	@ growth,
@ CheckBattleUnitLevelUp.c:177:         result++;
	adds	r5, r5, #1	@ <retval>,
@ CheckBattleUnitLevelUp.c:176:     while (growth > 100) {
	cmp	r4, #100	@ growth,
	bgt	.L92		@,
.L93:
@ CheckBattleUnitLevelUp.c:181:     if (Roll1RN(growth))
	ldr	r3, .L111	@ tmp158,
	movs	r0, r4	@, growth
	bl	.L51		@
@ CheckBattleUnitLevelUp.c:182:         result++;
	subs	r3, r0, #1	@ tmp169, tmp185
	sbcs	r0, r0, r3	@ tmp168, tmp185, tmp169
	adds	r5, r5, r0	@ <retval>, <retval>, tmp168
.L86:
@ CheckBattleUnitLevelUp.c:185: }
	movs	r0, r5	@, <retval>
	@ sp needed	@
	pop	{r7}
	mov	r8, r7
	pop	{r4, r5, r6, r7}
	pop	{r1}
	bx	r1
.L97:
@ CheckBattleUnitLevelUp.c:143: 	if (GetMaxStatFromDefinition(stat, unit) < currentStat+1) { return 0; } // no point trying to raise a stat if we've hit the caps. This'll improve our rerolled statups when caps have been hit 
	movs	r5, #0	@ <retval>,
	b	.L86		@
.L91:
@ CheckBattleUnitLevelUp.c:158: 		int averageStat = GetAverageStat(growth, stat, unit, GetNumberOfLevelUps(bu)); 
	movs	r0, r7	@, bu
	bl	GetNumberOfLevelUps		@
@ CheckBattleUnitLevelUp.c:57: 	int baseStat = GetBaseStatFromDefinition(stat, unit); 
	ldr	r1, [sp, #24]	@, unit
@ CheckBattleUnitLevelUp.c:158: 		int averageStat = GetAverageStat(growth, stat, unit, GetNumberOfLevelUps(bu)); 
	movs	r7, r0	@ _3, tmp181
@ CheckBattleUnitLevelUp.c:57: 	int baseStat = GetBaseStatFromDefinition(stat, unit); 
	movs	r0, r5	@, stat
	bl	GetBaseStatFromDefinition		@
@ CheckBattleUnitLevelUp.c:62: 	result = ((growth * levels) / 100) + baseStat; 
	movs	r1, #100	@,
@ CheckBattleUnitLevelUp.c:57: 	int baseStat = GetBaseStatFromDefinition(stat, unit); 
	movs	r5, r0	@ baseStat, tmp182
@ CheckBattleUnitLevelUp.c:62: 	result = ((growth * levels) / 100) + baseStat; 
	ldr	r3, .L111+4	@ tmp147,
@ CheckBattleUnitLevelUp.c:62: 	result = ((growth * levels) / 100) + baseStat; 
	movs	r0, r4	@ tmp143, growth
	muls	r0, r7	@ tmp143, _3
@ CheckBattleUnitLevelUp.c:62: 	result = ((growth * levels) / 100) + baseStat; 
	bl	.L51		@
@ CheckBattleUnitLevelUp.c:62: 	result = ((growth * levels) / 100) + baseStat; 
	adds	r0, r0, r5	@ result, tmp183, baseStat
@ CheckBattleUnitLevelUp.c:141:     int result = 0;
	movs	r5, #0	@ <retval>,
@ CheckBattleUnitLevelUp.c:159: 		while (growth > 100) {
	cmp	r4, #100	@ growth,
	ble	.L94		@,
.L95:
@ CheckBattleUnitLevelUp.c:161: 			growth -= 100;
	subs	r4, r4, #100	@ growth,
@ CheckBattleUnitLevelUp.c:160: 			result++;
	adds	r5, r5, #1	@ <retval>,
@ CheckBattleUnitLevelUp.c:159: 		while (growth > 100) {
	cmp	r4, #100	@ growth,
	bgt	.L95		@,
.L94:
@ CheckBattleUnitLevelUp.c:163: 		if (currentStat >= (averageStat + PreventWhenAboveAverageBy_Link)) { 
	ldr	r3, .L111+8	@ tmp149,
	ldr	r3, [r3]	@ PreventWhenAboveAverageBy_Link, PreventWhenAboveAverageBy_Link
	adds	r3, r0, r3	@ tmp150, result, PreventWhenAboveAverageBy_Link
@ CheckBattleUnitLevelUp.c:163: 		if (currentStat >= (averageStat + PreventWhenAboveAverageBy_Link)) { 
	cmp	r3, r6	@ tmp150, currentStat
	ble	.L86		@,
@ CheckBattleUnitLevelUp.c:166: 		if ((currentStat + ForceWhenBelowAverageBy_Link) < averageStat) { 
	ldr	r3, .L111+12	@ tmp152,
	ldr	r3, [r3]	@ ForceWhenBelowAverageBy_Link, ForceWhenBelowAverageBy_Link
	adds	r6, r6, r3	@ tmp153, currentStat, ForceWhenBelowAverageBy_Link
@ CheckBattleUnitLevelUp.c:166: 		if ((currentStat + ForceWhenBelowAverageBy_Link) < averageStat) { 
	cmp	r6, r0	@ tmp153, result
	bge	.L93		@,
@ CheckBattleUnitLevelUp.c:167: 		result++; 
	adds	r5, r5, #1	@ <retval>,
	b	.L86		@
.L110:
@ CheckBattleUnitLevelUp.c:146: 		int averageStat = GetAverageStat(growth, stat, unit, GetNumberOfLevelUps(bu)); 
	movs	r0, r7	@, bu
	bl	GetNumberOfLevelUps		@
@ CheckBattleUnitLevelUp.c:57: 	int baseStat = GetBaseStatFromDefinition(stat, unit); 
	ldr	r1, [sp, #24]	@, unit
@ CheckBattleUnitLevelUp.c:146: 		int averageStat = GetAverageStat(growth, stat, unit, GetNumberOfLevelUps(bu)); 
	movs	r7, r0	@ _2, tmp178
@ CheckBattleUnitLevelUp.c:57: 	int baseStat = GetBaseStatFromDefinition(stat, unit); 
	movs	r0, r5	@, stat
	bl	GetBaseStatFromDefinition		@
@ CheckBattleUnitLevelUp.c:62: 	result = ((growth * levels) / 100) + baseStat; 
	movs	r1, #100	@,
@ CheckBattleUnitLevelUp.c:57: 	int baseStat = GetBaseStatFromDefinition(stat, unit); 
	movs	r5, r0	@ baseStat, tmp179
@ CheckBattleUnitLevelUp.c:62: 	result = ((growth * levels) / 100) + baseStat; 
	ldr	r3, .L111+4	@ tmp141,
@ CheckBattleUnitLevelUp.c:62: 	result = ((growth * levels) / 100) + baseStat; 
	movs	r0, r4	@ tmp137, growth
	muls	r0, r7	@ tmp137, _2
@ CheckBattleUnitLevelUp.c:62: 	result = ((growth * levels) / 100) + baseStat; 
	bl	.L51		@
@ CheckBattleUnitLevelUp.c:62: 	result = ((growth * levels) / 100) + baseStat; 
	adds	r0, r0, r5	@ result, tmp180, baseStat
@ CheckBattleUnitLevelUp.c:141:     int result = 0;
	movs	r5, #0	@ <retval>,
@ CheckBattleUnitLevelUp.c:147: 		while (growth > 100) {
	cmp	r4, #100	@ growth,
	ble	.L89		@,
.L90:
@ CheckBattleUnitLevelUp.c:149: 			growth -= 100;
	subs	r4, r4, #100	@ growth,
@ CheckBattleUnitLevelUp.c:148: 			result++;
	adds	r5, r5, #1	@ <retval>,
@ CheckBattleUnitLevelUp.c:147: 		while (growth > 100) {
	cmp	r4, #100	@ growth,
	bgt	.L90		@,
.L89:
@ CheckBattleUnitLevelUp.c:151: 		if (currentStat < averageStat) { 
	cmp	r6, r0	@ currentStat, result
	bge	.L86		@,
@ CheckBattleUnitLevelUp.c:167: 		result++; 
	adds	r5, r5, #1	@ <retval>,
	b	.L86		@
.L112:
	.align	2
.L111:
	.word	Roll1RN
	.word	__aeabi_idiv
	.word	PreventWhenAboveAverageBy_Link
	.word	ForceWhenBelowAverageBy_Link
	.size	NewGetStatIncrease, .-NewGetStatIncrease
	.align	1
	.p2align 2,,3
	.global	CheckBattleUnitLevelUp
	.syntax unified
	.code	16
	.thumb_func
	.fpu softvfp
	.type	CheckBattleUnitLevelUp, %function
CheckBattleUnitLevelUp:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 32
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, r7, lr}	@
	mov	lr, fp	@,
	mov	r7, r10	@,
	mov	r6, r9	@,
	mov	r5, r8	@,
	push	{r5, r6, r7, lr}	@
@ CheckBattleUnitLevelUp.c:197:     if (CanBattleUnitGainLevels(bu) && bu->unit.exp >= 100) {
	ldr	r3, .L172	@ tmp252,
@ CheckBattleUnitLevelUp.c:196: void CheckBattleUnitLevelUp(struct BattleUnit* bu) {
	sub	sp, sp, #44	@,,
@ CheckBattleUnitLevelUp.c:196: void CheckBattleUnitLevelUp(struct BattleUnit* bu) {
	movs	r4, r0	@ bu, tmp460
@ CheckBattleUnitLevelUp.c:197:     if (CanBattleUnitGainLevels(bu) && bu->unit.exp >= 100) {
	bl	.L51		@
@ CheckBattleUnitLevelUp.c:197:     if (CanBattleUnitGainLevels(bu) && bu->unit.exp >= 100) {
	cmp	r0, #0	@ tmp461,
	beq	.L113		@,
@ CheckBattleUnitLevelUp.c:197:     if (CanBattleUnitGainLevels(bu) && bu->unit.exp >= 100) {
	ldrb	r3, [r4, #9]	@ tmp257,
	cmp	r3, #99	@ tmp257,
	bhi	.L161		@,
.L113:
@ CheckBattleUnitLevelUp.c:334: }
	add	sp, sp, #44	@,,
	@ sp needed	@
	pop	{r4, r5, r6, r7}
	mov	fp, r7
	mov	r10, r6
	mov	r9, r5
	mov	r8, r4
	pop	{r4, r5, r6, r7}
	pop	{r0}
	bx	r0
.L161:
@ CheckBattleUnitLevelUp.c:199: 		struct Unit* unit = GetUnit(bu->unit.index); // required because bunit includes stats from temp boosters (eg. weapon provides +5 str) in their raw stats 
	movs	r0, #11	@ tmp258,
	ldr	r3, .L172+4	@ tmp447,
	ldrsb	r0, [r4, r0]	@ tmp258,
	str	r3, [sp, #36]	@ tmp447, %sfp
	bl	.L51		@
@ CheckBattleUnitLevelUp.c:200: 		if (GrowthOptions_Link.FIXED_GROWTHS_MODE) { 
	ldr	r6, .L172+8	@ tmp446,
	ldrb	r3, [r6]	@ _5, GrowthOptions_Link
@ CheckBattleUnitLevelUp.c:199: 		struct Unit* unit = GetUnit(bu->unit.index); // required because bunit includes stats from temp boosters (eg. weapon provides +5 str) in their raw stats 
	movs	r5, r0	@ unit, tmp462
@ CheckBattleUnitLevelUp.c:198: 		int mode = regularGrowths; // default  
	movs	r7, #0	@ mode,
@ CheckBattleUnitLevelUp.c:200: 		if (GrowthOptions_Link.FIXED_GROWTHS_MODE) { 
	lsls	r2, r3, #31	@ tmp495, _5,
	bpl	.LCB730	@
	b	.L162	@long jump	@
.LCB730:
.L115:
@ CheckBattleUnitLevelUp.c:205: 		if (GrowthOptions_Link.STAT_BRACKETING_EXISTS) { 
	lsls	r3, r3, #26	@ tmp496, _5,
	bpl	.LCB737	@
	b	.L117	@long jump	@
.LCB737:
.L159:
@ CheckBattleUnitLevelUp.c:268:         if ((statGainTotal < minStatGain_Link) && (mode != fixedGrowths)) {
	movs	r3, #1	@ tmp295,
	bics	r3, r7	@ tmp295, mode
	mov	r10, r3	@ _261, tmp295
.L118:
@ CheckBattleUnitLevelUp.c:214:         bu->unit.exp -= 100;
	ldrb	r2, [r4, #9]	@ tmp304,
@ CheckBattleUnitLevelUp.c:215:         bu->unit.level++;
	ldrb	r3, [r4, #8]	@ tmp309,
@ CheckBattleUnitLevelUp.c:214:         bu->unit.exp -= 100;
	subs	r2, r2, #100	@ tmp305,
@ CheckBattleUnitLevelUp.c:215:         bu->unit.level++;
	adds	r3, r3, #1	@ tmp310,
@ CheckBattleUnitLevelUp.c:214:         bu->unit.exp -= 100;
	lsls	r2, r2, #24	@ tmp306, tmp305,
@ CheckBattleUnitLevelUp.c:215:         bu->unit.level++;
	lsls	r3, r3, #24	@ tmp311, tmp310,
@ CheckBattleUnitLevelUp.c:214:         bu->unit.exp -= 100;
	lsrs	r2, r2, #24	@ _17, tmp306,
@ CheckBattleUnitLevelUp.c:215:         bu->unit.level++;
	asrs	r3, r3, #24	@ _21, tmp311,
@ CheckBattleUnitLevelUp.c:214:         bu->unit.exp -= 100;
	strb	r2, [r4, #9]	@ _17, bu_147(D)->unit.exp
@ CheckBattleUnitLevelUp.c:215:         bu->unit.level++;
	strb	r3, [r4, #8]	@ _21, bu_147(D)->unit.level
@ CheckBattleUnitLevelUp.c:217:         if (UNIT_CATTRIBUTES(&bu->unit) & CA_MAXLEVEL10) {
	ldr	r0, [r4, #4]	@ _24, bu_147(D)->unit.pClassData
	ldr	r1, [r4]	@ bu_147(D)->unit.pCharacterData, bu_147(D)->unit.pCharacterData
	ldr	r6, [r0, #40]	@ _24->attributes, _24->attributes
	ldr	r1, [r1, #40]	@ _22->attributes, _22->attributes
	orrs	r1, r6	@ tmp314, _24->attributes
@ CheckBattleUnitLevelUp.c:217:         if (UNIT_CATTRIBUTES(&bu->unit) & CA_MAXLEVEL10) {
	lsls	r1, r1, #12	@ tmp497, tmp314,
	bmi	.LCB765	@
	b	.L119	@long jump	@
.LCB765:
@ CheckBattleUnitLevelUp.c:218:             if (bu->unit.level == 10) {
	cmp	r3, #10	@ _21,
	bne	.LCB767	@
	b	.L160	@long jump	@
.LCB767:
.L120:
@ CheckBattleUnitLevelUp.c:234: 		int hpGrowth =  gGet_Hp_Growth(unit); 
	ldr	r3, .L172+12	@ tmp338,
	movs	r0, r5	@, unit
	ldr	r3, [r3]	@ gGet_Hp_Growth, gGet_Hp_Growth
	bl	.L51		@
@ CheckBattleUnitLevelUp.c:235: 		int strGrowth = gGet_Str_Growth(unit); 
	ldr	r3, .L172+16	@ tmp340,
@ CheckBattleUnitLevelUp.c:234: 		int hpGrowth =  gGet_Hp_Growth(unit); 
	str	r0, [sp, #28]	@ tmp465, %sfp
@ CheckBattleUnitLevelUp.c:235: 		int strGrowth = gGet_Str_Growth(unit); 
	ldr	r3, [r3]	@ gGet_Str_Growth, gGet_Str_Growth
	movs	r0, r5	@, unit
	bl	.L51		@
@ CheckBattleUnitLevelUp.c:236: 		int sklGrowth = gGet_Skl_Growth(unit); 
	ldr	r3, .L172+20	@ tmp342,
@ CheckBattleUnitLevelUp.c:235: 		int strGrowth = gGet_Str_Growth(unit); 
	mov	r9, r0	@ strGrowth, tmp466
@ CheckBattleUnitLevelUp.c:236: 		int sklGrowth = gGet_Skl_Growth(unit); 
	ldr	r3, [r3]	@ gGet_Skl_Growth, gGet_Skl_Growth
	movs	r0, r5	@, unit
	bl	.L51		@
@ CheckBattleUnitLevelUp.c:237: 		int spdGrowth = gGet_Spd_Growth(unit); 
	ldr	r3, .L172+24	@ tmp344,
@ CheckBattleUnitLevelUp.c:236: 		int sklGrowth = gGet_Skl_Growth(unit); 
	str	r0, [sp, #32]	@ tmp467, %sfp
@ CheckBattleUnitLevelUp.c:237: 		int spdGrowth = gGet_Spd_Growth(unit); 
	ldr	r3, [r3]	@ gGet_Spd_Growth, gGet_Spd_Growth
	movs	r0, r5	@, unit
	bl	.L51		@
@ CheckBattleUnitLevelUp.c:238: 		int defGrowth = gGet_Def_Growth(unit); 
	ldr	r3, .L172+28	@ tmp346,
@ CheckBattleUnitLevelUp.c:237: 		int spdGrowth = gGet_Spd_Growth(unit); 
	str	r0, [sp, #8]	@ tmp468, %sfp
@ CheckBattleUnitLevelUp.c:238: 		int defGrowth = gGet_Def_Growth(unit); 
	ldr	r3, [r3]	@ gGet_Def_Growth, gGet_Def_Growth
	movs	r0, r5	@, unit
	bl	.L51		@
@ CheckBattleUnitLevelUp.c:239: 		int resGrowth = gGet_Res_Growth(unit); 
	ldr	r3, .L172+32	@ tmp348,
@ CheckBattleUnitLevelUp.c:238: 		int defGrowth = gGet_Def_Growth(unit); 
	str	r0, [sp, #12]	@ tmp469, %sfp
@ CheckBattleUnitLevelUp.c:239: 		int resGrowth = gGet_Res_Growth(unit); 
	ldr	r3, [r3]	@ gGet_Res_Growth, gGet_Res_Growth
	movs	r0, r5	@, unit
	bl	.L51		@
@ CheckBattleUnitLevelUp.c:240: 		int lukGrowth = gGet_Luk_Growth(unit); 
	ldr	r3, .L172+36	@ tmp350,
@ CheckBattleUnitLevelUp.c:239: 		int resGrowth = gGet_Res_Growth(unit); 
	str	r0, [sp, #20]	@ tmp470, %sfp
@ CheckBattleUnitLevelUp.c:240: 		int lukGrowth = gGet_Luk_Growth(unit); 
	ldr	r3, [r3]	@ gGet_Luk_Growth, gGet_Luk_Growth
	movs	r0, r5	@, unit
	bl	.L51		@
@ CheckBattleUnitLevelUp.c:242: 		if (gMagGrowth) { magGrowth = gMagGrowth(&bu->unit); } 
	ldr	r3, .L172+40	@ tmp352,
	ldr	r3, [r3]	@ gMagGrowth.11_48, gMagGrowth
@ CheckBattleUnitLevelUp.c:240: 		int lukGrowth = gGet_Luk_Growth(unit); 
	str	r0, [sp, #24]	@ tmp471, %sfp
@ CheckBattleUnitLevelUp.c:242: 		if (gMagGrowth) { magGrowth = gMagGrowth(&bu->unit); } 
	cmp	r3, #0	@ gMagGrowth.11_48,
	bne	.LCB807	@
	b	.L137	@long jump	@
.LCB807:
@ CheckBattleUnitLevelUp.c:242: 		if (gMagGrowth) { magGrowth = gMagGrowth(&bu->unit); } 
	movs	r0, r4	@, bu
	bl	.L51		@
	str	r0, [sp, #16]	@ tmp472, %sfp
.L121:
@ CheckBattleUnitLevelUp.c:244:         bu->changeHP  = NewGetStatIncrease(hpGrowth, mode, hpStat, bu, unit);
	movs	r3, r4	@, bu
	movs	r2, #0	@,
	movs	r1, r7	@, mode
	str	r5, [sp]	@ unit,
	ldr	r0, [sp, #28]	@, %sfp
	bl	NewGetStatIncrease		@
@ CheckBattleUnitLevelUp.c:244:         bu->changeHP  = NewGetStatIncrease(hpGrowth, mode, hpStat, bu, unit);
	movs	r3, #115	@ tmp354,
	lsls	r6, r0, #24	@ tmp353, tmp473,
	asrs	r6, r6, #24	@ _51, tmp353,
	strb	r6, [r4, r3]	@ _51, bu_147(D)->changeHP
@ CheckBattleUnitLevelUp.c:247:         bu->changePow = NewGetStatIncrease(strGrowth, mode, strStat, bu, unit);
	movs	r2, #1	@,
	movs	r3, r4	@, bu
	movs	r1, r7	@, mode
	mov	r0, r9	@, strGrowth
	str	r5, [sp]	@ unit,
	bl	NewGetStatIncrease		@
@ CheckBattleUnitLevelUp.c:247:         bu->changePow = NewGetStatIncrease(strGrowth, mode, strStat, bu, unit);
	movs	r3, #116	@ tmp357,
	lsls	r0, r0, #24	@ tmp356, tmp474,
	asrs	r0, r0, #24	@ _54, tmp356,
	strb	r0, [r4, r3]	@ _54, bu_147(D)->changePow
@ CheckBattleUnitLevelUp.c:250:         bu->changeSkl = NewGetStatIncrease(sklGrowth, mode, sklStat, bu, unit);
	movs	r2, #2	@,
	movs	r3, r4	@, bu
	movs	r1, r7	@, mode
@ CheckBattleUnitLevelUp.c:248:         statGainTotal += bu->changePow;
	adds	r6, r6, r0	@ statGainTotal, _51, _54
@ CheckBattleUnitLevelUp.c:250:         bu->changeSkl = NewGetStatIncrease(sklGrowth, mode, sklStat, bu, unit);
	str	r5, [sp]	@ unit,
	ldr	r0, [sp, #32]	@, %sfp
	bl	NewGetStatIncrease		@
@ CheckBattleUnitLevelUp.c:250:         bu->changeSkl = NewGetStatIncrease(sklGrowth, mode, sklStat, bu, unit);
	movs	r3, #117	@ tmp360,
	lsls	r0, r0, #24	@ tmp359, tmp475,
	asrs	r0, r0, #24	@ _57, tmp359,
	strb	r0, [r4, r3]	@ _57, bu_147(D)->changeSkl
@ CheckBattleUnitLevelUp.c:253:         bu->changeSpd = NewGetStatIncrease(spdGrowth, mode, spdStat, bu, unit);
	movs	r2, #3	@,
	movs	r3, r4	@, bu
	movs	r1, r7	@, mode
@ CheckBattleUnitLevelUp.c:251:         statGainTotal += bu->changeSkl;
	adds	r6, r0, r6	@ statGainTotal, _57, statGainTotal
@ CheckBattleUnitLevelUp.c:253:         bu->changeSpd = NewGetStatIncrease(spdGrowth, mode, spdStat, bu, unit);
	str	r5, [sp]	@ unit,
	ldr	r0, [sp, #8]	@, %sfp
	bl	NewGetStatIncrease		@
@ CheckBattleUnitLevelUp.c:253:         bu->changeSpd = NewGetStatIncrease(spdGrowth, mode, spdStat, bu, unit);
	movs	r3, #118	@ tmp363,
	lsls	r0, r0, #24	@ tmp362, tmp476,
	asrs	r0, r0, #24	@ _60, tmp362,
	strb	r0, [r4, r3]	@ _60, bu_147(D)->changeSpd
@ CheckBattleUnitLevelUp.c:256:         bu->changeDef = NewGetStatIncrease(defGrowth, mode, defStat, bu, unit);
	movs	r2, #4	@,
	movs	r3, r4	@, bu
	movs	r1, r7	@, mode
@ CheckBattleUnitLevelUp.c:254:         statGainTotal += bu->changeSpd;
	adds	r6, r0, r6	@ statGainTotal, _60, statGainTotal
@ CheckBattleUnitLevelUp.c:256:         bu->changeDef = NewGetStatIncrease(defGrowth, mode, defStat, bu, unit);
	str	r5, [sp]	@ unit,
	ldr	r0, [sp, #12]	@, %sfp
	bl	NewGetStatIncrease		@
@ CheckBattleUnitLevelUp.c:256:         bu->changeDef = NewGetStatIncrease(defGrowth, mode, defStat, bu, unit);
	movs	r3, #119	@ tmp366,
	lsls	r0, r0, #24	@ tmp365, tmp477,
	asrs	r0, r0, #24	@ _63, tmp365,
	strb	r0, [r4, r3]	@ _63, bu_147(D)->changeDef
@ CheckBattleUnitLevelUp.c:259:         bu->changeRes = NewGetStatIncrease(resGrowth, mode, resStat, bu, unit);
	movs	r2, #5	@,
	movs	r3, r4	@, bu
	movs	r1, r7	@, mode
@ CheckBattleUnitLevelUp.c:257:         statGainTotal += bu->changeDef;
	adds	r6, r0, r6	@ statGainTotal, _63, statGainTotal
@ CheckBattleUnitLevelUp.c:259:         bu->changeRes = NewGetStatIncrease(resGrowth, mode, resStat, bu, unit);
	str	r5, [sp]	@ unit,
	ldr	r0, [sp, #20]	@, %sfp
	bl	NewGetStatIncrease		@
@ CheckBattleUnitLevelUp.c:259:         bu->changeRes = NewGetStatIncrease(resGrowth, mode, resStat, bu, unit);
	movs	r3, #120	@ tmp369,
	lsls	r0, r0, #24	@ tmp368, tmp478,
	asrs	r0, r0, #24	@ _66, tmp368,
	strb	r0, [r4, r3]	@ _66, bu_147(D)->changeRes
@ CheckBattleUnitLevelUp.c:262:         bu->changeLck = NewGetStatIncrease(lukGrowth, mode, lukStat, bu, unit);
	movs	r2, #6	@,
	movs	r3, r4	@, bu
	movs	r1, r7	@, mode
@ CheckBattleUnitLevelUp.c:260:         statGainTotal += bu->changeRes;
	adds	r6, r0, r6	@ statGainTotal, _66, statGainTotal
@ CheckBattleUnitLevelUp.c:262:         bu->changeLck = NewGetStatIncrease(lukGrowth, mode, lukStat, bu, unit);
	str	r5, [sp]	@ unit,
	ldr	r0, [sp, #24]	@, %sfp
	bl	NewGetStatIncrease		@
@ CheckBattleUnitLevelUp.c:262:         bu->changeLck = NewGetStatIncrease(lukGrowth, mode, lukStat, bu, unit);
	movs	r3, #121	@ tmp372,
	lsls	r0, r0, #24	@ tmp371, tmp479,
	asrs	r0, r0, #24	@ _69, tmp371,
	strb	r0, [r4, r3]	@ _69, bu_147(D)->changeLck
@ CheckBattleUnitLevelUp.c:265: 		bu->changeCon = NewGetStatIncrease(magGrowth, mode, magStat, bu, unit); // mag uses the changeCon byte (and always has) 
	movs	r2, #7	@,
	movs	r3, r4	@, bu
@ CheckBattleUnitLevelUp.c:263:         statGainTotal += bu->changeLck;
	adds	r6, r0, r6	@ statGainTotal, _69, statGainTotal
@ CheckBattleUnitLevelUp.c:265: 		bu->changeCon = NewGetStatIncrease(magGrowth, mode, magStat, bu, unit); // mag uses the changeCon byte (and always has) 
	movs	r1, r7	@, mode
	str	r5, [sp]	@ unit,
	ldr	r0, [sp, #16]	@, %sfp
	bl	NewGetStatIncrease		@
@ CheckBattleUnitLevelUp.c:265: 		bu->changeCon = NewGetStatIncrease(magGrowth, mode, magStat, bu, unit); // mag uses the changeCon byte (and always has) 
	movs	r3, #122	@ tmp375,
	lsls	r0, r0, #24	@ tmp374, tmp480,
	asrs	r0, r0, #24	@ _72, tmp374,
	strb	r0, [r4, r3]	@ _72, bu_147(D)->changeCon
@ CheckBattleUnitLevelUp.c:268:         if ((statGainTotal < minStatGain_Link) && (mode != fixedGrowths)) {
	ldr	r3, .L172+44	@ tmp445,
	mov	r8, r3	@ tmp445, tmp445
@ CheckBattleUnitLevelUp.c:268:         if ((statGainTotal < minStatGain_Link) && (mode != fixedGrowths)) {
	mov	r2, r8	@ tmp445, tmp445
	ldr	r2, [r2]	@ minStatGain_Link, minStatGain_Link
@ CheckBattleUnitLevelUp.c:266:         statGainTotal += bu->changeCon;
	adds	r6, r0, r6	@ statGainTotal, _72, statGainTotal
@ CheckBattleUnitLevelUp.c:268:         if ((statGainTotal < minStatGain_Link) && (mode != fixedGrowths)) {
	movs	r3, #1	@ tmp378,
	cmp	r2, r6	@ minStatGain_Link, statGainTotal
	bgt	.L124		@,
	movs	r3, #0	@ tmp378,
.L124:
@ CheckBattleUnitLevelUp.c:268:         if ((statGainTotal < minStatGain_Link) && (mode != fixedGrowths)) {
	lsls	r3, r3, #24	@ tmp385, tmp378,
	beq	.L126		@,
	mov	r3, r10	@ _261, _261
	cmp	r3, #0	@ _261,
	beq	.L126		@,
	movs	r3, #5	@ ivtmp_144,
	mov	r10, r3	@ ivtmp_144, ivtmp_144
@ CheckBattleUnitLevelUp.c:288: 				if (!bu->changeSpd) { 
	movs	r3, r5	@ unit, unit
	mov	r5, r10	@ ivtmp_144, ivtmp_144
	mov	r10, r3	@ unit, unit
.L122:
@ CheckBattleUnitLevelUp.c:275: 				if (!bu->changePow) { // don't count changePow multiple times in statGainTotal 
	movs	r3, #116	@ tmp521,
	ldrsb	r3, [r4, r3]	@ tmp390,
	cmp	r3, #0	@ tmp390,
	beq	.L163		@,
.L125:
@ CheckBattleUnitLevelUp.c:281: 				if (!bu->changeCon) { 
	movs	r3, #122	@ tmp525,
	ldrsb	r3, [r4, r3]	@ tmp397,
	cmp	r3, #0	@ tmp397,
	beq	.L164		@,
.L127:
@ CheckBattleUnitLevelUp.c:288: 				if (!bu->changeSpd) { 
	movs	r3, #118	@ tmp529,
	ldrsb	r3, [r4, r3]	@ tmp404,
	cmp	r3, #0	@ tmp404,
	beq	.L165		@,
.L128:
@ CheckBattleUnitLevelUp.c:295: 				if (!bu->changeDef) { 
	movs	r3, #119	@ tmp410,
	mov	fp, r3	@ tmp410, tmp410
@ CheckBattleUnitLevelUp.c:295: 				if (!bu->changeDef) { 
	ldrsb	r3, [r4, r3]	@ tmp411,
	cmp	r3, #0	@ tmp411,
	beq	.L166		@,
.L129:
@ CheckBattleUnitLevelUp.c:302: 				if (!bu->changeRes) { 
	movs	r3, #120	@ tmp417,
	mov	fp, r3	@ tmp417, tmp417
@ CheckBattleUnitLevelUp.c:302: 				if (!bu->changeRes) { 
	ldrsb	r3, [r4, r3]	@ tmp418,
	cmp	r3, #0	@ tmp418,
	beq	.L167		@,
.L130:
@ CheckBattleUnitLevelUp.c:309: 				if (!bu->changeLck) { 
	movs	r3, #121	@ tmp424,
	mov	fp, r3	@ tmp424, tmp424
@ CheckBattleUnitLevelUp.c:309: 				if (!bu->changeLck) { 
	ldrsb	r3, [r4, r3]	@ tmp425,
	cmp	r3, #0	@ tmp425,
	bne	.LCB967	@
	b	.L168	@long jump	@
.LCB967:
.L131:
@ CheckBattleUnitLevelUp.c:316: 				if (!bu->changeHP) { 
	movs	r3, #115	@ tmp431,
	mov	fp, r3	@ tmp431, tmp431
@ CheckBattleUnitLevelUp.c:316: 				if (!bu->changeHP) { 
	ldrsb	r3, [r4, r3]	@ tmp432,
	cmp	r3, #0	@ tmp432,
	bne	.LCB973	@
	b	.L169	@long jump	@
.LCB973:
.L132:
@ CheckBattleUnitLevelUp.c:322: 				if (!bu->changeSkl) { 
	movs	r3, #117	@ tmp438,
	mov	fp, r3	@ tmp438, tmp438
@ CheckBattleUnitLevelUp.c:322: 				if (!bu->changeSkl) { 
	ldrsb	r3, [r4, r3]	@ tmp439,
	cmp	r3, #0	@ tmp439,
	bne	.LCB979	@
	b	.L170	@long jump	@
.LCB979:
.L133:
@ CheckBattleUnitLevelUp.c:269:             for (int attempts = 0; attempts < 5; attempts++) {
	subs	r5, r5, #1	@ ivtmp_144,
	cmp	r5, #0	@ ivtmp_144,
	bne	.L122		@,
.L126:
@ CheckBattleUnitLevelUp.c:332:         CheckBattleUnitStatCaps(GetUnit(bu->unit.index), bu);
	movs	r0, #11	@ tmp386,
	ldr	r3, [sp, #36]	@ tmp447, %sfp
	ldrsb	r0, [r4, r0]	@ tmp386,
	bl	.L51		@
	movs	r1, r4	@, bu
	ldr	r3, .L172+48	@ tmp388,
	bl	.L51		@
	b	.L113		@
.L119:
@ CheckBattleUnitLevelUp.c:222:         } else if (bu->unit.level >= Class_Level_Cap_Table[bu->unit.pClassData->number]) {
	ldr	r1, .L172+52	@ tmp327,
@ CheckBattleUnitLevelUp.c:222:         } else if (bu->unit.level >= Class_Level_Cap_Table[bu->unit.pClassData->number]) {
	ldrb	r0, [r0, #4]	@ tmp328,
@ CheckBattleUnitLevelUp.c:222:         } else if (bu->unit.level >= Class_Level_Cap_Table[bu->unit.pClassData->number]) {
	ldrb	r1, [r1, r0]	@ tmp329, Class_Level_Cap_Table
@ CheckBattleUnitLevelUp.c:222:         } else if (bu->unit.level >= Class_Level_Cap_Table[bu->unit.pClassData->number]) {
	cmp	r3, r1	@ _21, tmp329
	bge	.LCB1000	@
	b	.L120	@long jump	@
.LCB1000:
.L160:
@ CheckBattleUnitLevelUp.c:223:             bu->expGain -= bu->unit.exp;
	movs	r1, #110	@ tmp330,
	ldrb	r3, [r4, r1]	@ tmp332,
	subs	r3, r3, r2	@ tmp333, tmp332, _17
	strb	r3, [r4, r1]	@ tmp333, bu_147(D)->expGain
@ CheckBattleUnitLevelUp.c:224:             bu->unit.exp = UNIT_EXP_DISABLED;
	movs	r3, #255	@ tmp336,
	strb	r3, [r4, #9]	@ tmp336, bu_147(D)->unit.exp
	b	.L120		@
.L163:
@ CheckBattleUnitLevelUp.c:276: 					bu->changePow = NewGetStatIncrease(strGrowth, mode, strStat, bu, unit);
	mov	r3, r10	@ unit, unit
	movs	r2, #1	@,
	str	r3, [sp]	@ unit,
	movs	r1, r7	@, mode
	movs	r3, r4	@, bu
	mov	r0, r9	@, strGrowth
	bl	NewGetStatIncrease		@
@ CheckBattleUnitLevelUp.c:276: 					bu->changePow = NewGetStatIncrease(strGrowth, mode, strStat, bu, unit);
	movs	r3, #116	@ tmp523,
	lsls	r0, r0, #24	@ tmp391, tmp482,
	asrs	r0, r0, #24	@ _77, tmp391,
	strb	r0, [r4, r3]	@ _77, bu_147(D)->changePow
@ CheckBattleUnitLevelUp.c:278: 					if (statGainTotal >= minStatGain_Link)
	mov	r3, r8	@ tmp445, tmp445
	ldr	r3, [r3]	@ minStatGain_Link, minStatGain_Link
@ CheckBattleUnitLevelUp.c:277: 					statGainTotal += bu->changePow;
	adds	r6, r6, r0	@ statGainTotal, statGainTotal, _77
@ CheckBattleUnitLevelUp.c:278: 					if (statGainTotal >= minStatGain_Link)
	cmp	r3, r6	@ minStatGain_Link, statGainTotal
	bgt	.L125		@,
	b	.L126		@
.L164:
@ CheckBattleUnitLevelUp.c:282: 					bu->changeCon = NewGetStatIncrease(magGrowth, mode, magStat, bu, unit); // mag uses the changeCon byte (and always has) 
	mov	r3, r10	@ unit, unit
	movs	r2, #7	@,
	str	r3, [sp]	@ unit,
	movs	r1, r7	@, mode
	movs	r3, r4	@, bu
	ldr	r0, [sp, #16]	@, %sfp
	bl	NewGetStatIncrease		@
@ CheckBattleUnitLevelUp.c:282: 					bu->changeCon = NewGetStatIncrease(magGrowth, mode, magStat, bu, unit); // mag uses the changeCon byte (and always has) 
	movs	r3, #122	@ tmp527,
	lsls	r0, r0, #24	@ tmp398, tmp483,
	asrs	r0, r0, #24	@ _82, tmp398,
	strb	r0, [r4, r3]	@ _82, bu_147(D)->changeCon
@ CheckBattleUnitLevelUp.c:284: 					if (statGainTotal >= minStatGain_Link)
	mov	r3, r8	@ tmp445, tmp445
	ldr	r3, [r3]	@ minStatGain_Link, minStatGain_Link
@ CheckBattleUnitLevelUp.c:283: 					statGainTotal += bu->changeCon;
	adds	r6, r6, r0	@ statGainTotal, statGainTotal, _82
@ CheckBattleUnitLevelUp.c:284: 					if (statGainTotal >= minStatGain_Link)
	cmp	r3, r6	@ minStatGain_Link, statGainTotal
	bgt	.L127		@,
	b	.L126		@
.L165:
@ CheckBattleUnitLevelUp.c:289: 					bu->changeSpd = NewGetStatIncrease(spdGrowth, mode, spdStat, bu, unit);
	mov	r3, r10	@ unit, unit
	movs	r2, #3	@,
	str	r3, [sp]	@ unit,
	movs	r1, r7	@, mode
	movs	r3, r4	@, bu
	ldr	r0, [sp, #8]	@, %sfp
	bl	NewGetStatIncrease		@
@ CheckBattleUnitLevelUp.c:289: 					bu->changeSpd = NewGetStatIncrease(spdGrowth, mode, spdStat, bu, unit);
	movs	r3, #118	@ tmp531,
	lsls	r0, r0, #24	@ tmp405, tmp484,
	asrs	r0, r0, #24	@ _87, tmp405,
	strb	r0, [r4, r3]	@ _87, bu_147(D)->changeSpd
@ CheckBattleUnitLevelUp.c:291: 					if (statGainTotal >= minStatGain_Link)
	mov	r3, r8	@ tmp445, tmp445
	ldr	r3, [r3]	@ minStatGain_Link, minStatGain_Link
@ CheckBattleUnitLevelUp.c:290: 					statGainTotal += bu->changeSpd;
	adds	r6, r6, r0	@ statGainTotal, statGainTotal, _87
@ CheckBattleUnitLevelUp.c:291: 					if (statGainTotal >= minStatGain_Link)
	cmp	r3, r6	@ minStatGain_Link, statGainTotal
	bgt	.L128		@,
	b	.L126		@
.L166:
@ CheckBattleUnitLevelUp.c:296: 					bu->changeDef = NewGetStatIncrease(defGrowth, mode, defStat, bu, unit);
	mov	r3, r10	@ unit, unit
	movs	r2, #4	@,
	str	r3, [sp]	@ unit,
	movs	r1, r7	@, mode
	movs	r3, r4	@, bu
	ldr	r0, [sp, #12]	@, %sfp
	bl	NewGetStatIncrease		@
@ CheckBattleUnitLevelUp.c:296: 					bu->changeDef = NewGetStatIncrease(defGrowth, mode, defStat, bu, unit);
	mov	r3, fp	@ tmp410, tmp410
	lsls	r0, r0, #24	@ tmp412, tmp485,
	asrs	r0, r0, #24	@ _92, tmp412,
	strb	r0, [r4, r3]	@ _92, bu_147(D)->changeDef
@ CheckBattleUnitLevelUp.c:298: 					if (statGainTotal >= minStatGain_Link)
	mov	r3, r8	@ tmp445, tmp445
	ldr	r3, [r3]	@ minStatGain_Link, minStatGain_Link
@ CheckBattleUnitLevelUp.c:297: 					statGainTotal += bu->changeDef;
	adds	r6, r6, r0	@ statGainTotal, statGainTotal, _92
@ CheckBattleUnitLevelUp.c:298: 					if (statGainTotal >= minStatGain_Link)
	cmp	r3, r6	@ minStatGain_Link, statGainTotal
	ble	.LCB1091	@
	b	.L129	@long jump	@
.LCB1091:
	b	.L126		@
.L167:
@ CheckBattleUnitLevelUp.c:303: 					bu->changeRes = NewGetStatIncrease(resGrowth, mode, resStat, bu, unit);
	mov	r3, r10	@ unit, unit
	movs	r2, #5	@,
	str	r3, [sp]	@ unit,
	movs	r1, r7	@, mode
	movs	r3, r4	@, bu
	ldr	r0, [sp, #20]	@, %sfp
	bl	NewGetStatIncrease		@
@ CheckBattleUnitLevelUp.c:303: 					bu->changeRes = NewGetStatIncrease(resGrowth, mode, resStat, bu, unit);
	mov	r3, fp	@ tmp417, tmp417
	lsls	r0, r0, #24	@ tmp419, tmp486,
	asrs	r0, r0, #24	@ _97, tmp419,
	strb	r0, [r4, r3]	@ _97, bu_147(D)->changeRes
@ CheckBattleUnitLevelUp.c:305: 					if (statGainTotal >= minStatGain_Link)
	mov	r3, r8	@ tmp445, tmp445
	ldr	r3, [r3]	@ minStatGain_Link, minStatGain_Link
@ CheckBattleUnitLevelUp.c:304: 					statGainTotal += bu->changeRes;
	adds	r6, r6, r0	@ statGainTotal, statGainTotal, _97
@ CheckBattleUnitLevelUp.c:305: 					if (statGainTotal >= minStatGain_Link)
	cmp	r3, r6	@ minStatGain_Link, statGainTotal
	ble	.LCB1112	@
	b	.L130	@long jump	@
.LCB1112:
	b	.L126		@
.L168:
@ CheckBattleUnitLevelUp.c:310: 					bu->changeLck = NewGetStatIncrease(lukGrowth, mode, lukStat, bu, unit);
	mov	r3, r10	@ unit, unit
	movs	r2, #6	@,
	str	r3, [sp]	@ unit,
	movs	r1, r7	@, mode
	movs	r3, r4	@, bu
	ldr	r0, [sp, #24]	@, %sfp
	bl	NewGetStatIncrease		@
@ CheckBattleUnitLevelUp.c:310: 					bu->changeLck = NewGetStatIncrease(lukGrowth, mode, lukStat, bu, unit);
	mov	r3, fp	@ tmp424, tmp424
	lsls	r0, r0, #24	@ tmp426, tmp487,
	asrs	r0, r0, #24	@ _102, tmp426,
	strb	r0, [r4, r3]	@ _102, bu_147(D)->changeLck
@ CheckBattleUnitLevelUp.c:312: 					if (statGainTotal >= minStatGain_Link)
	mov	r3, r8	@ tmp445, tmp445
	ldr	r3, [r3]	@ minStatGain_Link, minStatGain_Link
@ CheckBattleUnitLevelUp.c:311: 					statGainTotal += bu->changeLck;
	adds	r6, r6, r0	@ statGainTotal, statGainTotal, _102
@ CheckBattleUnitLevelUp.c:312: 					if (statGainTotal >= minStatGain_Link)
	cmp	r3, r6	@ minStatGain_Link, statGainTotal
	ble	.LCB1133	@
	b	.L131	@long jump	@
.LCB1133:
	b	.L126		@
.L169:
@ CheckBattleUnitLevelUp.c:317: 					bu->changeHP  = NewGetStatIncrease(hpGrowth, mode, hpStat, bu, unit);
	mov	r3, r10	@ unit, unit
	movs	r2, #0	@,
	str	r3, [sp]	@ unit,
	movs	r1, r7	@, mode
	movs	r3, r4	@, bu
	ldr	r0, [sp, #28]	@, %sfp
	bl	NewGetStatIncrease		@
@ CheckBattleUnitLevelUp.c:317: 					bu->changeHP  = NewGetStatIncrease(hpGrowth, mode, hpStat, bu, unit);
	mov	r3, fp	@ tmp431, tmp431
	lsls	r0, r0, #24	@ tmp433, tmp488,
	asrs	r0, r0, #24	@ _107, tmp433,
	strb	r0, [r4, r3]	@ _107, bu_147(D)->changeHP
@ CheckBattleUnitLevelUp.c:319: 					if (statGainTotal >= minStatGain_Link)
	mov	r3, r8	@ tmp445, tmp445
	ldr	r3, [r3]	@ minStatGain_Link, minStatGain_Link
@ CheckBattleUnitLevelUp.c:318: 					statGainTotal += bu->changeHP;
	adds	r6, r6, r0	@ statGainTotal, statGainTotal, _107
@ CheckBattleUnitLevelUp.c:319: 					if (statGainTotal >= minStatGain_Link)
	cmp	r3, r6	@ minStatGain_Link, statGainTotal
	ble	.LCB1154	@
	b	.L132	@long jump	@
.LCB1154:
	b	.L126		@
.L173:
	.align	2
.L172:
	.word	CanBattleUnitGainLevels
	.word	GetUnit
	.word	GrowthOptions_Link
	.word	gGet_Hp_Growth
	.word	gGet_Str_Growth
	.word	gGet_Skl_Growth
	.word	gGet_Spd_Growth
	.word	gGet_Def_Growth
	.word	gGet_Res_Growth
	.word	gGet_Luk_Growth
	.word	gMagGrowth
	.word	minStatGain_Link
	.word	CheckBattleUnitStatCaps
	.word	Class_Level_Cap_Table
.L170:
@ CheckBattleUnitLevelUp.c:323: 					bu->changeSkl = NewGetStatIncrease(sklGrowth, mode, sklStat, bu, unit);
	mov	r3, r10	@ unit, unit
	movs	r2, #2	@,
	str	r3, [sp]	@ unit,
	movs	r1, r7	@, mode
	movs	r3, r4	@, bu
	ldr	r0, [sp, #32]	@, %sfp
	bl	NewGetStatIncrease		@
@ CheckBattleUnitLevelUp.c:323: 					bu->changeSkl = NewGetStatIncrease(sklGrowth, mode, sklStat, bu, unit);
	mov	r3, fp	@ tmp438, tmp438
	lsls	r0, r0, #24	@ tmp440, tmp489,
	asrs	r0, r0, #24	@ _112, tmp440,
	strb	r0, [r4, r3]	@ _112, bu_147(D)->changeSkl
@ CheckBattleUnitLevelUp.c:325: 					if (statGainTotal >= minStatGain_Link)
	mov	r3, r8	@ tmp445, tmp445
	ldr	r3, [r3]	@ minStatGain_Link, minStatGain_Link
@ CheckBattleUnitLevelUp.c:324: 					statGainTotal += bu->changeSkl;
	adds	r6, r6, r0	@ statGainTotal, statGainTotal, _112
@ CheckBattleUnitLevelUp.c:325: 					if (statGainTotal >= minStatGain_Link)
	cmp	r3, r6	@ minStatGain_Link, statGainTotal
	ble	.LCB1194	@
	b	.L133	@long jump	@
.LCB1194:
	b	.L126		@
.L117:
@ CheckBattleUnitLevelUp.c:206: 			if (CheckEventId(BRACKETED_GROWTHS_FLAG_ID_Link) || (!BRACKETED_GROWTHS_FLAG_ID_Link)) { 
	ldr	r6, .L174	@ tmp290,
	ldr	r3, .L174+4	@ tmp292,
	ldr	r0, [r6]	@ BRACKETED_GROWTHS_FLAG_ID_Link, BRACKETED_GROWTHS_FLAG_ID_Link
	bl	.L51		@
@ CheckBattleUnitLevelUp.c:206: 			if (CheckEventId(BRACKETED_GROWTHS_FLAG_ID_Link) || (!BRACKETED_GROWTHS_FLAG_ID_Link)) { 
	cmp	r0, #0	@ tmp464,
	beq	.L171		@,
.L136:
	movs	r3, #1	@ _261,
@ CheckBattleUnitLevelUp.c:207: 			mode = bracketedGrowths; 
	movs	r7, #2	@ mode,
	mov	r10, r3	@ _261, _261
	b	.L118		@
.L162:
@ CheckBattleUnitLevelUp.c:201: 			if (CheckEventId(GrowthOptions_Link.FIXED_GROWTHS_FLAG_ID) || (!GrowthOptions_Link.FIXED_GROWTHS_FLAG_ID)) { 
	ldrh	r0, [r6, #2]	@ tmp269,
	ldr	r3, .L174+4	@ tmp270,
	bl	.L51		@
	subs	r7, r0, #0	@ mode, tmp463,
@ CheckBattleUnitLevelUp.c:201: 			if (CheckEventId(GrowthOptions_Link.FIXED_GROWTHS_FLAG_ID) || (!GrowthOptions_Link.FIXED_GROWTHS_FLAG_ID)) { 
	bne	.L116		@,
@ CheckBattleUnitLevelUp.c:201: 			if (CheckEventId(GrowthOptions_Link.FIXED_GROWTHS_FLAG_ID) || (!GrowthOptions_Link.FIXED_GROWTHS_FLAG_ID)) { 
	ldrh	r3, [r6, #2]	@ tmp272,
	cmp	r3, #0	@ tmp272,
	beq	.L116		@,
@ CheckBattleUnitLevelUp.c:205: 		if (GrowthOptions_Link.STAT_BRACKETING_EXISTS) { 
	ldrb	r3, [r6]	@ _5, GrowthOptions_Link
	b	.L115		@
.L116:
@ CheckBattleUnitLevelUp.c:202: 			mode = fixedGrowths; 
	movs	r7, #1	@ mode,
@ CheckBattleUnitLevelUp.c:205: 		if (GrowthOptions_Link.STAT_BRACKETING_EXISTS) { 
	ldrb	r3, [r6]	@ _5, GrowthOptions_Link
	b	.L115		@
.L171:
@ CheckBattleUnitLevelUp.c:206: 			if (CheckEventId(BRACKETED_GROWTHS_FLAG_ID_Link) || (!BRACKETED_GROWTHS_FLAG_ID_Link)) { 
	ldr	r3, [r6]	@ BRACKETED_GROWTHS_FLAG_ID_Link, BRACKETED_GROWTHS_FLAG_ID_Link
	cmp	r3, #0	@ BRACKETED_GROWTHS_FLAG_ID_Link,
	beq	.L136		@,
	b	.L159		@
.L137:
@ CheckBattleUnitLevelUp.c:241: 		int magGrowth = 0; 
	movs	r3, #0	@ magGrowth,
	str	r3, [sp, #16]	@ magGrowth, %sfp
	b	.L121		@
.L175:
	.align	2
.L174:
	.word	BRACKETED_GROWTHS_FLAG_ID_Link
	.word	CheckEventId
	.size	CheckBattleUnitLevelUp, .-CheckBattleUnitLevelUp
	.ident	"GCC: (devkitARM release 56) 11.1.0"
	.code 16
	.align	1
.L51:
	bx	r3
