	.cpu arm7tdmi
	.arch armv4t
	.fpu softvfp
	.eabi_attribute 20, 1	@ Tag_ABI_FP_denormal
	.eabi_attribute 21, 1	@ Tag_ABI_FP_exceptions
	.eabi_attribute 23, 3	@ Tag_ABI_FP_number_model
	.eabi_attribute 24, 1	@ Tag_ABI_align8_needed
	.eabi_attribute 25, 1	@ Tag_ABI_align8_preserved
	.eabi_attribute 26, 1	@ Tag_ABI_enum_size
	.eabi_attribute 30, 2	@ Tag_ABI_optimization_goals
	.eabi_attribute 34, 0	@ Tag_CPU_unaligned_access
	.eabi_attribute 18, 4	@ Tag_ABI_PCS_wchar_t
	.file	"C_Code.c"
@ GNU C17 (devkitARM release 59) version 12.2.0 (arm-none-eabi)
@	compiled by GNU C version 10.3.0, GMP version 6.2.1, MPFR version 4.1.0, MPC version 1.2.1, isl version isl-0.18-GMP

@ GGC heuristics: --param ggc-min-expand=100 --param ggc-min-heapsize=131072
@ options passed: -mcpu=arm7tdmi -mthumb -mthumb-interwork -mtune=arm7tdmi -mlong-calls -march=armv4t -O2
	.text
	.align	1
	.p2align 2,,3
	.syntax unified
	.code	16
	.thumb_func
	.type	HashByte_Global.part.0, %function
HashByte_Global.part.0:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
@ C_Code.c:43:   hash = ((hash << 5) + hash) ^ number;
	ldr	r3, .L9	@ tmp135,
	eors	r3, r0	@ hash, tmp157
	lsls	r0, r3, #5	@ tmp137, hash,
	adds	r0, r0, r3	@ tmp138, tmp137, hash
@ C_Code.c:44:   hash = ((hash << 5) + hash) ^ *StartTimeSeedRamLabel;
	ldr	r3, .L9+4	@ tmp140,
	ldr	r3, [r3]	@ StartTimeSeedRamLabel, StartTimeSeedRamLabel
@ C_Code.c:44:   hash = ((hash << 5) + hash) ^ *StartTimeSeedRamLabel;
	ldr	r3, [r3]	@ *StartTimeSeedRamLabel.3_5, *StartTimeSeedRamLabel.3_5
	eors	r0, r3	@ hash, *StartTimeSeedRamLabel.3_5
	lsls	r3, r0, #5	@ tmp144, hash,
	adds	r3, r3, r0	@ tmp145, tmp144, hash
@ C_Code.c:40: u8 HashByte_Global(u8 number, int max, int variance){
	push	{r4, r5, r6, lr}	@
@ C_Code.c:45:   hash = ((hash << 5) + hash) ^ variance; 
	eors	r2, r3	@ hash, tmp145
@ C_Code.c:46:   for (int i = 0; i < 9; ++i){
	ldr	r5, .L9+8	@ tmp156,
@ C_Code.c:45:   hash = ((hash << 5) + hash) ^ variance; 
	ldr	r3, .L9+12	@ ivtmp.25,
.L3:
@ C_Code.c:47:     if (TacticianName[i]==0) break;
	ldrb	r0, [r3]	@ _15, *_14
@ C_Code.c:47:     if (TacticianName[i]==0) break;
	cmp	r0, #0	@ _15,
	beq	.L2		@,
	lsls	r4, r2, #5	@ tmp147, hash,
	adds	r2, r4, r2	@ tmp148, tmp147, hash
@ C_Code.c:46:   for (int i = 0; i < 9; ++i){
	adds	r3, r3, #1	@ ivtmp.25,
@ C_Code.c:48:     hash = ((hash << 5) + hash) ^ TacticianName[i];
	eors	r2, r0	@ hash, _15
@ C_Code.c:46:   for (int i = 0; i < 9; ++i){
	cmp	r3, r5	@ ivtmp.25, tmp156
	bne	.L3		@,
.L2:
@ C_Code.c:52: };
	@ sp needed	@
@ C_Code.c:50:   hash = Mod((u16)hash, max); 
	lsls	r2, r2, #16	@ tmp151, hash,
	ldr	r3, .L9+16	@ tmp152,
	lsrs	r0, r2, #16	@ tmp150, tmp151,
	bl	.L11		@
@ C_Code.c:52: };
	lsls	r0, r0, #24	@ tmp155, tmp160,
	lsrs	r0, r0, #24	@ tmp154, tmp155,
	pop	{r4, r5, r6}
	pop	{r1}
	bx	r1
.L10:
	.align	2
.L9:
	.word	177573
	.word	StartTimeSeedRamLabel
	.word	33733913
	.word	33733904
	.word	Mod
	.size	HashByte_Global.part.0, .-HashByte_Global.part.0
	.align	1
	.p2align 2,,3
	.global	HashByte_N
	.syntax unified
	.code	16
	.thumb_func
	.type	HashByte_N, %function
HashByte_N:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, lr}	@
@ C_Code.c:28:   if (max==0) return 0;
	cmp	r1, #0	@ max,
	beq	.L16		@,
@ C_Code.c:30:   hash = ((hash << 5) + hash) ^ number;
	ldr	r3, .L21	@ tmp135,
	eors	r3, r0	@ hash, number
	lsls	r2, r3, #5	@ tmp137, hash,
	adds	r2, r2, r3	@ tmp138, tmp137, hash
@ C_Code.c:31:   hash = ((hash << 5) + hash) ^ gPlaySt.chapterIndex;
	ldr	r3, .L21+4	@ tmp139,
	ldrb	r3, [r3, #14]	@ tmp140,
	lsls	r3, r3, #24	@ tmp140, tmp140,
	asrs	r3, r3, #24	@ tmp140, tmp140,
@ C_Code.c:31:   hash = ((hash << 5) + hash) ^ gPlaySt.chapterIndex;
	eors	r3, r2	@ hash, tmp138
	lsls	r0, r3, #5	@ tmp143, hash,
	adds	r0, r0, r3	@ tmp144, tmp143, hash
@ C_Code.c:32:   hash = ((hash << 5) + hash) ^ *StartTimeSeedRamLabel;
	ldr	r3, .L21+8	@ tmp146,
	ldr	r3, [r3]	@ StartTimeSeedRamLabel, StartTimeSeedRamLabel
@ C_Code.c:32:   hash = ((hash << 5) + hash) ^ *StartTimeSeedRamLabel;
	ldr	r3, [r3]	@ *StartTimeSeedRamLabel.0_6, *StartTimeSeedRamLabel.0_6
@ C_Code.c:33:   for (int i = 0; i < 9; ++i){
	ldr	r5, .L21+12	@ tmp157,
@ C_Code.c:32:   hash = ((hash << 5) + hash) ^ *StartTimeSeedRamLabel;
	eors	r0, r3	@ hash, *StartTimeSeedRamLabel.0_6
	ldr	r3, .L21+16	@ ivtmp.36,
.L15:
@ C_Code.c:34:     if (TacticianName[i]==0) break;
	ldrb	r2, [r3]	@ _10, *_9
@ C_Code.c:34:     if (TacticianName[i]==0) break;
	cmp	r2, #0	@ _10,
	beq	.L14		@,
	lsls	r4, r0, #5	@ tmp149, hash,
	adds	r0, r4, r0	@ tmp150, tmp149, hash
@ C_Code.c:33:   for (int i = 0; i < 9; ++i){
	adds	r3, r3, #1	@ ivtmp.36,
@ C_Code.c:35:     hash = ((hash << 5) + hash) ^ TacticianName[i];
	eors	r0, r2	@ hash, _10
@ C_Code.c:33:   for (int i = 0; i < 9; ++i){
	cmp	r3, r5	@ ivtmp.36, tmp157
	bne	.L15		@,
.L14:
@ C_Code.c:37:   return Mod((u16)hash, max);
	lsls	r0, r0, #16	@ tmp153, hash,
	ldr	r3, .L21+20	@ tmp154,
	lsrs	r0, r0, #16	@ tmp152, tmp153,
	bl	.L11		@
	lsls	r0, r0, #24	@ tmp155, tmp160,
	lsrs	r0, r0, #24	@ <retval>, tmp155,
.L13:
@ C_Code.c:38: };
	@ sp needed	@
	pop	{r4, r5, r6}
	pop	{r1}
	bx	r1
.L16:
@ C_Code.c:28:   if (max==0) return 0;
	movs	r0, #0	@ <retval>,
	b	.L13		@
.L22:
	.align	2
.L21:
	.word	177573
	.word	gPlaySt
	.word	StartTimeSeedRamLabel
	.word	33733913
	.word	33733904
	.word	Mod
	.size	HashByte_N, .-HashByte_N
	.align	1
	.p2align 2,,3
	.global	HashByte_Global
	.syntax unified
	.code	16
	.thumb_func
	.type	HashByte_Global, %function
HashByte_Global:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, lr}	@
@ C_Code.c:41:   if (max==0) return 0;
	cmp	r1, #0	@ max,
	beq	.L25		@,
	bl	HashByte_Global.part.0		@
.L24:
@ C_Code.c:52: };
	@ sp needed	@
	pop	{r4}
	pop	{r1}
	bx	r1
.L25:
@ C_Code.c:41:   if (max==0) return 0;
	movs	r0, #0	@ <retval>,
	b	.L24		@
	.size	HashByte_Global, .-HashByte_Global
	.align	1
	.p2align 2,,3
	.global	GetItemMight
	.syntax unified
	.code	16
	.thumb_func
	.type	GetItemMight, %function
GetItemMight:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, lr}	@
@ C_Code.c:55: 	item &= 0xFF; 
	movs	r5, #255	@ tmp123,
	ands	r5, r0	@ item, tmp135
@ C_Code.c:56: 	int might = GetItemData(item)->might;
	ldr	r3, .L31	@ tmp124,
	movs	r0, r5	@, item
	bl	.L11		@
@ C_Code.c:57: 	if (!CheckFlag(RandomizeWeaponStatsFlag_Link)) return might; 
	ldr	r3, .L31+4	@ tmp125,
@ C_Code.c:56: 	int might = GetItemData(item)->might;
	ldrb	r4, [r0, #21]	@ <retval>,
@ C_Code.c:57: 	if (!CheckFlag(RandomizeWeaponStatsFlag_Link)) return might; 
	ldr	r0, [r3]	@ RandomizeWeaponStatsFlag_Link, RandomizeWeaponStatsFlag_Link
	ldr	r3, .L31+8	@ tmp127,
	bl	.L11		@
@ C_Code.c:57: 	if (!CheckFlag(RandomizeWeaponStatsFlag_Link)) return might; 
	cmp	r0, #0	@ tmp137,
	beq	.L26		@,
@ C_Code.c:58: 	might = HashByte_Global(might, might*2+8, item); 
	adds	r1, r4, #4	@ tmp130, <retval>,
	movs	r0, r4	@, <retval>
	movs	r2, r5	@, item
@ C_Code.c:58: 	might = HashByte_Global(might, might*2+8, item); 
	lsls	r1, r1, #1	@ tmp131, tmp130,
	bl	HashByte_Global.part.0		@
	movs	r4, r0	@ <retval>, tmp138
.L26:
@ C_Code.c:61: }
	@ sp needed	@
	movs	r0, r4	@, <retval>
	pop	{r4, r5, r6}
	pop	{r1}
	bx	r1
.L32:
	.align	2
.L31:
	.word	GetItemData
	.word	RandomizeWeaponStatsFlag_Link
	.word	CheckFlag
	.size	GetItemMight, .-GetItemMight
	.align	1
	.p2align 2,,3
	.global	GetItemHit
	.syntax unified
	.code	16
	.thumb_func
	.type	GetItemHit, %function
GetItemHit:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, lr}	@
@ C_Code.c:64: 	item &= 0xFF; 
	movs	r4, #255	@ tmp118,
@ C_Code.c:68: }
	@ sp needed	@
@ C_Code.c:64: 	item &= 0xFF; 
	ands	r4, r0	@ item, tmp122
@ C_Code.c:65: 	int hit = GetItemData(item&0xFF)->hit;
	ldr	r5, .L34	@ tmp119,
	movs	r0, r4	@, item
	bl	.L36		@
@ C_Code.c:66:     return GetItemData(item&0xFF)->hit;
	movs	r0, r4	@, item
	bl	.L36		@
@ C_Code.c:66:     return GetItemData(item&0xFF)->hit;
	ldrb	r0, [r0, #22]	@ tmp121,
@ C_Code.c:68: }
	pop	{r4, r5, r6}
	pop	{r1}
	bx	r1
.L35:
	.align	2
.L34:
	.word	GetItemData
	.size	GetItemHit, .-GetItemHit
	.align	1
	.p2align 2,,3
	.global	GetItemCrit
	.syntax unified
	.code	16
	.thumb_func
	.type	GetItemCrit, %function
GetItemCrit:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, lr}	@
@ C_Code.c:72: 	item &= 0xFF; 
	movs	r4, #255	@ tmp118,
@ C_Code.c:76: }
	@ sp needed	@
@ C_Code.c:72: 	item &= 0xFF; 
	ands	r4, r0	@ item, tmp122
@ C_Code.c:73: 	int crit = GetItemData(item&0xFF)->crit;
	ldr	r5, .L38	@ tmp119,
	movs	r0, r4	@, item
	bl	.L36		@
@ C_Code.c:74:     return GetItemData(item&0xFF)->crit;
	movs	r0, r4	@, item
	bl	.L36		@
@ C_Code.c:74:     return GetItemData(item&0xFF)->crit;
	ldrb	r0, [r0, #24]	@ tmp121,
@ C_Code.c:76: }
	pop	{r4, r5, r6}
	pop	{r1}
	bx	r1
.L39:
	.align	2
.L38:
	.word	GetItemData
	.size	GetItemCrit, .-GetItemCrit
	.align	1
	.p2align 2,,3
	.global	ShouldUnitBeRandomized
	.syntax unified
	.code	16
	.thumb_func
	.type	ShouldUnitBeRandomized, %function
ShouldUnitBeRandomized:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r3, r4, r5, r6, r7, lr}	@
@ C_Code.c:80: 	int unitID = unit->pCharacterData->number; 
	ldr	r3, [r0]	@ unit_29(D)->pCharacterData, unit_29(D)->pCharacterData
@ C_Code.c:80: 	int unitID = unit->pCharacterData->number; 
	ldrb	r6, [r3, #4]	@ unitID,
@ C_Code.c:81: 	if ((CheckFlag(RandomizeClassesFlag_Link)) && (unitID < 0xA0)) return true; 
	ldr	r3, .L79	@ tmp153,
@ C_Code.c:79: int ShouldUnitBeRandomized(struct Unit* unit) { 
	movs	r4, r0	@ unit, tmp236
@ C_Code.c:81: 	if ((CheckFlag(RandomizeClassesFlag_Link)) && (unitID < 0xA0)) return true; 
	ldr	r7, .L79+4	@ tmp230,
	ldr	r0, [r3]	@ RandomizeClassesFlag_Link, RandomizeClassesFlag_Link
	bl	.L81		@
@ C_Code.c:81: 	if ((CheckFlag(RandomizeClassesFlag_Link)) && (unitID < 0xA0)) return true; 
	cmp	r6, #159	@ unitID,
	bhi	.L41		@,
	cmp	r0, #0	@ tmp156,
	bne	.L44		@,
.L41:
@ C_Code.c:82: 	int randomizeBosses = CheckFlag(RandomizeBossClassesFlag_Link); 
	ldr	r3, .L79+8	@ tmp170,
	ldr	r0, [r3]	@ RandomizeBossClassesFlag_Link, RandomizeBossClassesFlag_Link
	bl	.L81		@
	movs	r5, r0	@ tmp173, tmp238
@ C_Code.c:83: 	int randomizeTrainers = CheckFlag(RandomizeTrainerClassesFlag_Link); 
	ldr	r3, .L79+12	@ tmp175,
	ldr	r0, [r3]	@ RandomizeTrainerClassesFlag_Link, RandomizeTrainerClassesFlag_Link
	bl	.L81		@
@ C_Code.c:85: 	if ((randomizeBosses) && (randomizeTrainers) && (unitID >= 0xA0)) return true; 
	movs	r3, r5	@ _9, tmp173
@ C_Code.c:83: 	int randomizeTrainers = CheckFlag(RandomizeTrainerClassesFlag_Link); 
	movs	r1, r0	@ tmp178, <retval>
@ C_Code.c:85: 	if ((randomizeBosses) && (randomizeTrainers) && (unitID >= 0xA0)) return true; 
	subs	r2, r3, #1	@ tmp182, _9
	sbcs	r3, r3, r2	@ _9, _9, tmp182
@ C_Code.c:85: 	if ((randomizeBosses) && (randomizeTrainers) && (unitID >= 0xA0)) return true; 
	cmp	r0, #0	@ <retval>,
	beq	.L43		@,
	cmp	r3, #0	@ _9,
	beq	.L43		@,
@ C_Code.c:85: 	if ((randomizeBosses) && (randomizeTrainers) && (unitID >= 0xA0)) return true; 
	cmp	r6, #159	@ unitID,
	bgt	.L44		@,
@ C_Code.c:86: 	int isBoss = unit->pCharacterData->attributes & CA_BOSS; // class doesn't exist yet 
	ldr	r3, [r4]	@ unit_29(D)->pCharacterData, unit_29(D)->pCharacterData
@ C_Code.c:87: 	if ((randomizeBosses) && (isBoss)) return true; 
	ldr	r0, [r3, #40]	@ _37->attributes, _37->attributes
	lsls	r0, r0, #16	@ tmp192, _37->attributes,
	lsrs	r0, r0, #31	@ <retval>, tmp192,
.L40:
@ C_Code.c:101: } 
	@ sp needed	@
	pop	{r3, r4, r5, r6, r7}
	pop	{r1}
	bx	r1
.L43:
@ C_Code.c:86: 	int isBoss = unit->pCharacterData->attributes & CA_BOSS; // class doesn't exist yet 
	ldr	r2, [r4]	@ unit_29(D)->pCharacterData, unit_29(D)->pCharacterData
@ C_Code.c:87: 	if ((randomizeBosses) && (isBoss)) return true; 
	ldr	r2, [r2, #40]	@ _12->attributes, _12->attributes
@ C_Code.c:87: 	if ((randomizeBosses) && (isBoss)) return true; 
	lsls	r2, r2, #16	@ tmp245, _12->attributes,
	bpl	.L49		@,
	cmp	r3, #0	@ _9,
	beq	.L49		@,
.L44:
@ C_Code.c:81: 	if ((CheckFlag(RandomizeClassesFlag_Link)) && (unitID < 0xA0)) return true; 
	movs	r0, #1	@ <retval>,
	b	.L40		@
.L49:
@ C_Code.c:90: 		if ((unitID >= 0xA0) && (randomizeBosses) && (BossChapterTable2[gPlaySt.chapterIndex])) return true; 
	movs	r2, #1	@ tmp205,
	cmp	r6, #159	@ unitID,
	ble	.L78		@,
.L46:
	lsls	r2, r2, #24	@ tmp209, tmp205,
	lsrs	r2, r2, #24	@ _50, tmp209,
@ C_Code.c:89: 	if (!randomizeTrainers) { 
	cmp	r1, #0	@ tmp178,
	bne	.L47		@,
@ C_Code.c:90: 		if ((unitID >= 0xA0) && (randomizeBosses) && (BossChapterTable2[gPlaySt.chapterIndex])) return true; 
	cmp	r3, #0	@ _9,
	beq	.L40		@,
	cmp	r2, #0	@ _50,
	beq	.L40		@,
@ C_Code.c:90: 		if ((unitID >= 0xA0) && (randomizeBosses) && (BossChapterTable2[gPlaySt.chapterIndex])) return true; 
	ldr	r2, .L79+16	@ tmp211,
	ldrb	r2, [r2, #14]	@ tmp212,
@ C_Code.c:90: 		if ((unitID >= 0xA0) && (randomizeBosses) && (BossChapterTable2[gPlaySt.chapterIndex])) return true; 
	ldr	r3, .L79+20	@ tmp210,
@ C_Code.c:90: 		if ((unitID >= 0xA0) && (randomizeBosses) && (BossChapterTable2[gPlaySt.chapterIndex])) return true; 
	lsls	r2, r2, #24	@ tmp212, tmp212,
	asrs	r2, r2, #24	@ tmp212, tmp212,
@ C_Code.c:90: 		if ((unitID >= 0xA0) && (randomizeBosses) && (BossChapterTable2[gPlaySt.chapterIndex])) return true; 
	ldrb	r0, [r3, r2]	@ tmp214, BossChapterTable2
	subs	r3, r0, #1	@ tmp216, tmp214
	sbcs	r0, r0, r3	@ <retval>, tmp214, tmp216
	b	.L40		@
.L78:
@ C_Code.c:90: 		if ((unitID >= 0xA0) && (randomizeBosses) && (BossChapterTable2[gPlaySt.chapterIndex])) return true; 
	movs	r2, #0	@ tmp205,
	b	.L46		@
.L47:
@ C_Code.c:95: 		if ((unitID >= 0xA0) && (randomizeTrainers) && (!BossChapterTable2[gPlaySt.chapterIndex])) return true; 
	cmp	r5, #0	@ tmp173,
	bne	.L48		@,
	cmp	r2, #0	@ _50,
	beq	.L48		@,
@ C_Code.c:95: 		if ((unitID >= 0xA0) && (randomizeTrainers) && (!BossChapterTable2[gPlaySt.chapterIndex])) return true; 
	ldr	r2, .L79+16	@ tmp223,
	ldrb	r2, [r2, #14]	@ tmp224,
@ C_Code.c:95: 		if ((unitID >= 0xA0) && (randomizeTrainers) && (!BossChapterTable2[gPlaySt.chapterIndex])) return true; 
	ldr	r3, .L79+20	@ tmp222,
@ C_Code.c:95: 		if ((unitID >= 0xA0) && (randomizeTrainers) && (!BossChapterTable2[gPlaySt.chapterIndex])) return true; 
	lsls	r2, r2, #24	@ tmp224, tmp224,
	asrs	r2, r2, #24	@ tmp224, tmp224,
@ C_Code.c:95: 		if ((unitID >= 0xA0) && (randomizeTrainers) && (!BossChapterTable2[gPlaySt.chapterIndex])) return true; 
	ldrb	r0, [r3, r2]	@ tmp226, BossChapterTable2
	rsbs	r3, r0, #0	@ tmp228, tmp226
	adcs	r0, r0, r3	@ <retval>, tmp226, tmp228
	b	.L40		@
.L48:
@ C_Code.c:91: 		return false; 
	movs	r0, #0	@ <retval>,
	b	.L40		@
.L80:
	.align	2
.L79:
	.word	RandomizeClassesFlag_Link
	.word	CheckFlag
	.word	RandomizeBossClassesFlag_Link
	.word	RandomizeTrainerClassesFlag_Link
	.word	gPlaySt
	.word	BossChapterTable2
	.size	ShouldUnitBeRandomized, .-ShouldUnitBeRandomized
	.global	gEkrBg2QuakeVec
	.bss
	.align	2
	.type	gEkrBg2QuakeVec, %object
	.size	gEkrBg2QuakeVec, 4
gEkrBg2QuakeVec:
	.space	4
	.ident	"GCC: (devkitARM release 59) 12.2.0"
	.text
	.code 16
	.align	1
.L11:
	bx	r3
.L36:
	bx	r5
.L81:
	bx	r7
