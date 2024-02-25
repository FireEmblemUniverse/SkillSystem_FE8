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
	.file	"C_Code.c"
@ GNU C17 (devkitARM release 56) version 11.1.0 (arm-none-eabi)
@	compiled by GNU C version 10.3.0, GMP version 6.2.1, MPFR version 4.1.0, MPC version 1.2.1, isl version isl-0.18-GMP

@ GGC heuristics: --param ggc-min-expand=100 --param ggc-min-heapsize=131072
@ options passed: -mcpu=arm7tdmi -mthumb -mthumb-interwork -mtune=arm7tdmi -mlong-calls -march=armv4t -O2
	.text
	.align	1
	.p2align 2,,3
	.arch armv4t
	.syntax unified
	.code	16
	.thumb_func
	.fpu softvfp
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
	ldr	r3, .L9+12	@ ivtmp.31,
.L3:
@ C_Code.c:47:     if (TacticianName[i]==0) break;
	ldrb	r0, [r3]	@ _15, *_14
@ C_Code.c:47:     if (TacticianName[i]==0) break;
	cmp	r0, #0	@ _15,
	beq	.L2		@,
	lsls	r4, r2, #5	@ tmp147, hash,
	adds	r2, r4, r2	@ tmp148, tmp147, hash
@ C_Code.c:46:   for (int i = 0; i < 9; ++i){
	adds	r3, r3, #1	@ ivtmp.31,
@ C_Code.c:48:     hash = ((hash << 5) + hash) ^ TacticianName[i];
	eors	r2, r0	@ hash, _15
@ C_Code.c:46:   for (int i = 0; i < 9; ++i){
	cmp	r3, r5	@ ivtmp.31, tmp156
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
	.fpu softvfp
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
	ldr	r3, .L21+16	@ ivtmp.41,
.L15:
@ C_Code.c:34:     if (TacticianName[i]==0) break;
	ldrb	r2, [r3]	@ _10, *_9
@ C_Code.c:34:     if (TacticianName[i]==0) break;
	cmp	r2, #0	@ _10,
	beq	.L14		@,
	lsls	r4, r0, #5	@ tmp149, hash,
	adds	r0, r4, r0	@ tmp150, tmp149, hash
@ C_Code.c:33:   for (int i = 0; i < 9; ++i){
	adds	r3, r3, #1	@ ivtmp.41,
@ C_Code.c:35:     hash = ((hash << 5) + hash) ^ TacticianName[i];
	eors	r0, r2	@ hash, _10
@ C_Code.c:33:   for (int i = 0; i < 9; ++i){
	cmp	r3, r5	@ ivtmp.41, tmp157
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
	.fpu softvfp
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
	.global	HashShort_Simple
	.syntax unified
	.code	16
	.thumb_func
	.fpu softvfp
	.type	HashShort_Simple, %function
HashShort_Simple:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, lr}	@
@ C_Code.c:55:   if (max==0) return 0;
	cmp	r1, #0	@ max,
	beq	.L30		@,
@ C_Code.c:57:   hash = ((hash << 5) + hash) ^ number;
	ldr	r3, .L35	@ tmp135,
	eors	r3, r0	@ hash, number
	lsls	r0, r3, #5	@ tmp137, hash,
	adds	r0, r0, r3	@ tmp138, tmp137, hash
@ C_Code.c:58:   hash = ((hash << 5) + hash) ^ *StartTimeSeedRamLabel;
	ldr	r3, .L35+4	@ tmp140,
	ldr	r3, [r3]	@ StartTimeSeedRamLabel, StartTimeSeedRamLabel
@ C_Code.c:58:   hash = ((hash << 5) + hash) ^ *StartTimeSeedRamLabel;
	ldr	r3, [r3]	@ *StartTimeSeedRamLabel.7_4, *StartTimeSeedRamLabel.7_4
	eors	r0, r3	@ hash, *StartTimeSeedRamLabel.7_4
	lsls	r3, r0, #5	@ tmp144, hash,
	adds	r3, r3, r0	@ tmp145, tmp144, hash
@ C_Code.c:59:   hash = ((hash << 5) + hash) ^ variance; 
	eors	r2, r3	@ hash, tmp145
@ C_Code.c:60:   for (int i = 0; i < 9; ++i){
	ldr	r5, .L35+8	@ tmp155,
@ C_Code.c:59:   hash = ((hash << 5) + hash) ^ variance; 
	ldr	r3, .L35+12	@ ivtmp.53,
.L29:
@ C_Code.c:61:     if (TacticianName[i]==0) break;
	ldrb	r0, [r3]	@ _9, *_8
@ C_Code.c:61:     if (TacticianName[i]==0) break;
	cmp	r0, #0	@ _9,
	beq	.L28		@,
	lsls	r4, r2, #5	@ tmp147, hash,
	adds	r2, r4, r2	@ tmp148, tmp147, hash
@ C_Code.c:60:   for (int i = 0; i < 9; ++i){
	adds	r3, r3, #1	@ ivtmp.53,
@ C_Code.c:62:     hash = ((hash << 5) + hash) ^ TacticianName[i];
	eors	r2, r0	@ hash, _9
@ C_Code.c:60:   for (int i = 0; i < 9; ++i){
	cmp	r3, r5	@ ivtmp.53, tmp155
	bne	.L29		@,
.L28:
@ C_Code.c:64:   hash = Mod((u16)hash, max); 
	lsls	r2, r2, #16	@ tmp151, hash,
	ldr	r3, .L35+16	@ tmp152,
	lsrs	r0, r2, #16	@ tmp150, tmp151,
	bl	.L11		@
@ C_Code.c:65:   return hash;
	lsls	r0, r0, #16	@ tmp153, tmp159,
	lsrs	r0, r0, #16	@ <retval>, tmp153,
.L27:
@ C_Code.c:66: };
	@ sp needed	@
	pop	{r4, r5, r6}
	pop	{r1}
	bx	r1
.L30:
@ C_Code.c:55:   if (max==0) return 0;
	movs	r0, #0	@ <retval>,
	b	.L27		@
.L36:
	.align	2
.L35:
	.word	177573
	.word	StartTimeSeedRamLabel
	.word	33733913
	.word	33733904
	.word	Mod
	.size	HashShort_Simple, .-HashShort_Simple
	.align	1
	.p2align 2,,3
	.global	GetItemMight
	.syntax unified
	.code	16
	.thumb_func
	.fpu softvfp
	.type	GetItemMight, %function
GetItemMight:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, lr}	@
@ C_Code.c:70: 	item &= 0xFF; 
	movs	r6, #255	@ tmp129,
	ands	r6, r0	@ item, tmp147
@ C_Code.c:71: 	int might = GetItemData(item)->might;
	ldr	r3, .L43	@ tmp130,
	movs	r0, r6	@, item
	bl	.L11		@
@ C_Code.c:72: 	if (!CheckFlag(RandomizeWeaponStatsFlag_Link)) return might; 
	ldr	r3, .L43+4	@ tmp131,
@ C_Code.c:71: 	int might = GetItemData(item)->might;
	ldrb	r4, [r0, #21]	@ <retval>,
@ C_Code.c:72: 	if (!CheckFlag(RandomizeWeaponStatsFlag_Link)) return might; 
	ldr	r0, [r3]	@ RandomizeWeaponStatsFlag_Link, RandomizeWeaponStatsFlag_Link
	ldr	r3, .L43+8	@ tmp133,
	bl	.L11		@
@ C_Code.c:72: 	if (!CheckFlag(RandomizeWeaponStatsFlag_Link)) return might; 
	cmp	r0, #0	@ tmp149,
	beq	.L37		@,
@ C_Code.c:73: 	int max = ((might*3)/2)+5;
	lsls	r5, r4, #1	@ tmp137, <retval>,
	adds	r5, r5, r4	@ tmp138, tmp137, <retval>
@ C_Code.c:73: 	int max = ((might*3)/2)+5;
	asrs	r5, r5, #1	@ tmp139, tmp138,
@ C_Code.c:73: 	int max = ((might*3)/2)+5;
	adds	r5, r5, #5	@ max,
	movs	r0, r4	@, <retval>
	movs	r2, r6	@, item
	movs	r1, r5	@, max
	bl	HashByte_Global.part.0		@
@ C_Code.c:75: 	if (abs(newMight - might) < 3) { // encourage it to be at least 3 or more points different than normal 
	subs	r3, r0, r4	@ tmp142, tmp140, <retval>
@ C_Code.c:75: 	if (abs(newMight - might) < 3) { // encourage it to be at least 3 or more points different than normal 
	adds	r3, r3, #2	@ tmp143,
@ C_Code.c:74: 	int newMight = HashByte_Global(might, max, item);
	movs	r4, r0	@ <retval>, tmp140
@ C_Code.c:75: 	if (abs(newMight - might) < 3) { // encourage it to be at least 3 or more points different than normal 
	cmp	r3, #4	@ tmp143,
	bhi	.L37		@,
	movs	r2, r0	@, <retval>
	movs	r1, r5	@, max
	bl	HashByte_Global.part.0		@
	movs	r4, r0	@ <retval>, tmp151
.L37:
@ C_Code.c:79: }
	@ sp needed	@
	movs	r0, r4	@, <retval>
	pop	{r4, r5, r6}
	pop	{r1}
	bx	r1
.L44:
	.align	2
.L43:
	.word	GetItemData
	.word	RandomizeWeaponStatsFlag_Link
	.word	CheckFlag
	.size	GetItemMight, .-GetItemMight
	.global	__aeabi_uidiv
	.global	__aeabi_idiv
	.align	1
	.p2align 2,,3
	.global	GetItemHit
	.syntax unified
	.code	16
	.thumb_func
	.fpu softvfp
	.type	GetItemHit, %function
GetItemHit:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, lr}	@
@ C_Code.c:82: 	item &= 0xFF; 
	movs	r4, #255	@ tmp129,
	ands	r4, r0	@ item, tmp154
@ C_Code.c:83: 	int hit = GetItemData(item)->hit;
	movs	r0, r4	@, item
	ldr	r6, .L51	@ tmp130,
	bl	.L53		@
@ C_Code.c:84: 	if (!CheckFlag(RandomizeWeaponStatsFlag_Link)) return GetItemData(item)->hit;
	ldr	r3, .L51+4	@ tmp131,
@ C_Code.c:83: 	int hit = GetItemData(item)->hit;
	ldrb	r5, [r0, #22]	@ _2,
@ C_Code.c:84: 	if (!CheckFlag(RandomizeWeaponStatsFlag_Link)) return GetItemData(item)->hit;
	ldr	r0, [r3]	@ RandomizeWeaponStatsFlag_Link, RandomizeWeaponStatsFlag_Link
	ldr	r3, .L51+8	@ tmp133,
	bl	.L11		@
@ C_Code.c:84: 	if (!CheckFlag(RandomizeWeaponStatsFlag_Link)) return GetItemData(item)->hit;
	cmp	r0, #0	@ tmp156,
	beq	.L49		@,
@ C_Code.c:85: 	int newHit = (HashByte_Global(hit, (hit+50)/5, item) * 5) + 20; 
	movs	r0, r5	@ tmp137, _2
@ C_Code.c:85: 	int newHit = (HashByte_Global(hit, (hit+50)/5, item) * 5) + 20; 
	ldr	r3, .L51+12	@ tmp146,
	movs	r1, #5	@,
@ C_Code.c:85: 	int newHit = (HashByte_Global(hit, (hit+50)/5, item) * 5) + 20; 
	adds	r0, r0, #50	@ tmp137,
@ C_Code.c:85: 	int newHit = (HashByte_Global(hit, (hit+50)/5, item) * 5) + 20; 
	bl	.L11		@
	movs	r2, r4	@, item
	movs	r1, r0	@ tmp147, tmp158
	movs	r0, r5	@, _2
	bl	HashByte_Global.part.0		@
@ C_Code.c:85: 	int newHit = (HashByte_Global(hit, (hit+50)/5, item) * 5) + 20; 
	lsls	r3, r0, #2	@ tmp151, tmp159,
	adds	r0, r3, r0	@ tmp152, tmp151, tmp159
@ C_Code.c:85: 	int newHit = (HashByte_Global(hit, (hit+50)/5, item) * 5) + 20; 
	adds	r0, r0, #20	@ <retval>,
	cmp	r0, #250	@ <retval>,
	bgt	.L50		@,
.L45:
@ C_Code.c:88: }
	@ sp needed	@
	pop	{r4, r5, r6}
	pop	{r1}
	bx	r1
.L50:
	movs	r0, #250	@ <retval>,
	b	.L45		@
.L49:
@ C_Code.c:84: 	if (!CheckFlag(RandomizeWeaponStatsFlag_Link)) return GetItemData(item)->hit;
	movs	r0, r4	@, item
	bl	.L53		@
@ C_Code.c:84: 	if (!CheckFlag(RandomizeWeaponStatsFlag_Link)) return GetItemData(item)->hit;
	ldrb	r0, [r0, #22]	@ <retval>,
	b	.L45		@
.L52:
	.align	2
.L51:
	.word	GetItemData
	.word	RandomizeWeaponStatsFlag_Link
	.word	CheckFlag
	.word	__aeabi_idiv
	.size	GetItemHit, .-GetItemHit
	.align	1
	.p2align 2,,3
	.global	GetItemCrit
	.syntax unified
	.code	16
	.thumb_func
	.fpu softvfp
	.type	GetItemCrit, %function
GetItemCrit:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, lr}	@
@ C_Code.c:92: 	item &= 0xFF; 
	movs	r4, #255	@ tmp129,
	ands	r4, r0	@ item, tmp155
@ C_Code.c:93: 	int crit = GetItemData(item)->crit;
	movs	r0, r4	@, item
	ldr	r6, .L60	@ tmp130,
	bl	.L53		@
@ C_Code.c:94: 	if (!CheckFlag(RandomizeWeaponStatsFlag_Link)) return GetItemData(item)->crit;
	ldr	r3, .L60+4	@ tmp131,
@ C_Code.c:93: 	int crit = GetItemData(item)->crit;
	ldrb	r5, [r0, #24]	@ _2,
@ C_Code.c:94: 	if (!CheckFlag(RandomizeWeaponStatsFlag_Link)) return GetItemData(item)->crit;
	ldr	r0, [r3]	@ RandomizeWeaponStatsFlag_Link, RandomizeWeaponStatsFlag_Link
	ldr	r3, .L60+8	@ tmp133,
	bl	.L11		@
@ C_Code.c:94: 	if (!CheckFlag(RandomizeWeaponStatsFlag_Link)) return GetItemData(item)->crit;
	cmp	r0, #0	@ tmp157,
	beq	.L58		@,
@ C_Code.c:95: 	int newCrit = HashByte_Global(crit, ((crit*2)+40)/5, item) * 5; 
	movs	r0, r5	@ tmp137, _2
	adds	r0, r0, #20	@ tmp137,
@ C_Code.c:95: 	int newCrit = HashByte_Global(crit, ((crit*2)+40)/5, item) * 5; 
	ldr	r3, .L60+12	@ tmp147,
	movs	r1, #5	@,
@ C_Code.c:95: 	int newCrit = HashByte_Global(crit, ((crit*2)+40)/5, item) * 5; 
	lsls	r0, r0, #1	@ tmp138, tmp137,
@ C_Code.c:95: 	int newCrit = HashByte_Global(crit, ((crit*2)+40)/5, item) * 5; 
	bl	.L11		@
	movs	r2, r4	@, item
	movs	r1, r0	@ tmp148, tmp159
	movs	r0, r5	@, _2
	bl	HashByte_Global.part.0		@
@ C_Code.c:95: 	int newCrit = HashByte_Global(crit, ((crit*2)+40)/5, item) * 5; 
	lsls	r3, r0, #2	@ tmp152, tmp160,
	adds	r0, r3, r0	@ <retval>, tmp152, tmp160
	cmp	r0, #250	@ <retval>,
	bgt	.L59		@,
.L54:
@ C_Code.c:98: }
	@ sp needed	@
	pop	{r4, r5, r6}
	pop	{r1}
	bx	r1
.L59:
	movs	r0, #250	@ <retval>,
	b	.L54		@
.L58:
@ C_Code.c:94: 	if (!CheckFlag(RandomizeWeaponStatsFlag_Link)) return GetItemData(item)->crit;
	movs	r0, r4	@, item
	bl	.L53		@
@ C_Code.c:94: 	if (!CheckFlag(RandomizeWeaponStatsFlag_Link)) return GetItemData(item)->crit;
	ldrb	r0, [r0, #24]	@ <retval>,
	b	.L54		@
.L61:
	.align	2
.L60:
	.word	GetItemData
	.word	RandomizeWeaponStatsFlag_Link
	.word	CheckFlag
	.word	__aeabi_idiv
	.size	GetItemCrit, .-GetItemCrit
	.align	1
	.p2align 2,,3
	.global	ShouldUnitBeRandomized
	.syntax unified
	.code	16
	.thumb_func
	.fpu softvfp
	.type	ShouldUnitBeRandomized, %function
ShouldUnitBeRandomized:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r3, r4, r5, r6, r7, lr}	@
@ C_Code.c:102: 	int unitID = unit->pCharacterData->number; 
	ldr	r3, [r0]	@ unit_30(D)->pCharacterData, unit_30(D)->pCharacterData
@ C_Code.c:102: 	int unitID = unit->pCharacterData->number; 
	ldrb	r6, [r3, #4]	@ unitID,
@ C_Code.c:103: 	if ((CheckFlag(RandomizeClassesFlag_Link)) && (unitID < 0xA0)) return true; 
	ldr	r3, .L105	@ tmp152,
@ C_Code.c:101: int ShouldUnitBeRandomized(struct Unit* unit) { 
	movs	r4, r0	@ unit, tmp260
@ C_Code.c:103: 	if ((CheckFlag(RandomizeClassesFlag_Link)) && (unitID < 0xA0)) return true; 
	ldr	r7, .L105+4	@ tmp154,
	ldr	r0, [r3]	@ RandomizeClassesFlag_Link, RandomizeClassesFlag_Link
	bl	.L107		@
@ C_Code.c:103: 	if ((CheckFlag(RandomizeClassesFlag_Link)) && (unitID < 0xA0)) return true; 
	cmp	r0, #0	@ tmp261,
	beq	.L63		@,
@ C_Code.c:103: 	if ((CheckFlag(RandomizeClassesFlag_Link)) && (unitID < 0xA0)) return true; 
	cmp	r6, #159	@ unitID,
	ble	.L66		@,
@ C_Code.c:104: 	int randomizeBosses = CheckFlag(RandomizeBossClassesFlag_Link); 
	ldr	r3, .L105+8	@ tmp217,
	ldr	r0, [r3]	@ RandomizeBossClassesFlag_Link, RandomizeBossClassesFlag_Link
	bl	.L107		@
	movs	r5, r0	@ randomizeBosses, tmp264
@ C_Code.c:105: 	int randomizeTrainers = CheckFlag(RandomizeTrainerClassesFlag_Link); 
	ldr	r3, .L105+12	@ tmp222,
	ldr	r0, [r3]	@ RandomizeTrainerClassesFlag_Link, RandomizeTrainerClassesFlag_Link
	bl	.L107		@
@ C_Code.c:107: 	if ((randomizeBosses) && (randomizeTrainers) && (unitID >= 0xA0)) return true; 
	movs	r3, r5	@ _9, randomizeBosses
@ C_Code.c:107: 	if ((randomizeBosses) && (randomizeTrainers) && (unitID >= 0xA0)) return true; 
	movs	r1, r0	@ _10, <retval>
@ C_Code.c:107: 	if ((randomizeBosses) && (randomizeTrainers) && (unitID >= 0xA0)) return true; 
	subs	r2, r3, #1	@ tmp229, _9
	sbcs	r3, r3, r2	@ _9, _9, tmp229
@ C_Code.c:107: 	if ((randomizeBosses) && (randomizeTrainers) && (unitID >= 0xA0)) return true; 
	subs	r2, r1, #1	@ tmp233, _10
	sbcs	r1, r1, r2	@ _10, _10, tmp233
@ C_Code.c:107: 	if ((randomizeBosses) && (randomizeTrainers) && (unitID >= 0xA0)) return true; 
	cmp	r3, #0	@ _9,
	beq	.L74		@,
	cmp	r1, #0	@ _10,
	bne	.L66		@,
.L74:
@ C_Code.c:108: 	int isBoss = unit->pCharacterData->attributes & CA_BOSS; // class doesn't exist yet 
	ldr	r2, [r4]	@ unit_30(D)->pCharacterData, unit_30(D)->pCharacterData
@ C_Code.c:109: 	if ((randomizeBosses) && (isBoss)) return true; 
	ldr	r2, [r2, #40]	@ _12->attributes, _12->attributes
@ C_Code.c:109: 	if ((randomizeBosses) && (isBoss)) return true; 
	lsls	r2, r2, #16	@ tmp281, _12->attributes,
	bpl	.L77		@,
	cmp	r3, #0	@ _9,
	bne	.L66		@,
.L77:
@ C_Code.c:111: 	if (!randomizeTrainers) { 
	cmp	r0, #0	@ <retval>,
	bne	.L70		@,
@ C_Code.c:112: 		if ((unitID >= 0xA0) && (randomizeBosses) && (BossChapterTable2[gPlaySt.chapterIndex])) return true; 
	movs	r2, #1	@ tmp196,
	cmp	r6, #159	@ unitID,
	ble	.L103		@,
@ C_Code.c:112: 		if ((unitID >= 0xA0) && (randomizeBosses) && (BossChapterTable2[gPlaySt.chapterIndex])) return true; 
	lsls	r2, r2, #24	@ tmp201, tmp196,
	beq	.L62		@,
.L104:
	cmp	r3, #0	@ _9,
	beq	.L62		@,
@ C_Code.c:112: 		if ((unitID >= 0xA0) && (randomizeBosses) && (BossChapterTable2[gPlaySt.chapterIndex])) return true; 
	ldr	r2, .L105+16	@ tmp203,
	ldrb	r2, [r2, #14]	@ tmp204,
@ C_Code.c:112: 		if ((unitID >= 0xA0) && (randomizeBosses) && (BossChapterTable2[gPlaySt.chapterIndex])) return true; 
	ldr	r3, .L105+20	@ tmp202,
@ C_Code.c:112: 		if ((unitID >= 0xA0) && (randomizeBosses) && (BossChapterTable2[gPlaySt.chapterIndex])) return true; 
	lsls	r2, r2, #24	@ tmp204, tmp204,
	asrs	r2, r2, #24	@ tmp204, tmp204,
@ C_Code.c:112: 		if ((unitID >= 0xA0) && (randomizeBosses) && (BossChapterTable2[gPlaySt.chapterIndex])) return true; 
	ldrb	r3, [r3, r2]	@ tmp205, BossChapterTable2
	cmp	r3, #0	@ tmp205,
	beq	.L62		@,
.L66:
@ C_Code.c:103: 	if ((CheckFlag(RandomizeClassesFlag_Link)) && (unitID < 0xA0)) return true; 
	movs	r0, #1	@ <retval>,
.L62:
@ C_Code.c:123: } 
	@ sp needed	@
	pop	{r3, r4, r5, r6, r7}
	pop	{r1}
	bx	r1
.L63:
@ C_Code.c:104: 	int randomizeBosses = CheckFlag(RandomizeBossClassesFlag_Link); 
	ldr	r3, .L105+8	@ tmp157,
	ldr	r0, [r3]	@ RandomizeBossClassesFlag_Link, RandomizeBossClassesFlag_Link
	bl	.L107		@
@ C_Code.c:105: 	int randomizeTrainers = CheckFlag(RandomizeTrainerClassesFlag_Link); 
	ldr	r3, .L105+12	@ tmp162,
@ C_Code.c:104: 	int randomizeBosses = CheckFlag(RandomizeBossClassesFlag_Link); 
	movs	r5, r0	@ randomizeBosses, tmp262
@ C_Code.c:105: 	int randomizeTrainers = CheckFlag(RandomizeTrainerClassesFlag_Link); 
	ldr	r0, [r3]	@ RandomizeTrainerClassesFlag_Link, RandomizeTrainerClassesFlag_Link
	bl	.L107		@
@ C_Code.c:107: 	if ((randomizeBosses) && (randomizeTrainers) && (unitID >= 0xA0)) return true; 
	movs	r3, r5	@ _9, randomizeBosses
@ C_Code.c:107: 	if ((randomizeBosses) && (randomizeTrainers) && (unitID >= 0xA0)) return true; 
	movs	r1, r0	@ _10, <retval>
@ C_Code.c:107: 	if ((randomizeBosses) && (randomizeTrainers) && (unitID >= 0xA0)) return true; 
	subs	r2, r3, #1	@ tmp169, _9
	sbcs	r3, r3, r2	@ _9, _9, tmp169
@ C_Code.c:107: 	if ((randomizeBosses) && (randomizeTrainers) && (unitID >= 0xA0)) return true; 
	subs	r2, r1, #1	@ tmp173, _10
	sbcs	r1, r1, r2	@ _10, _10, tmp173
@ C_Code.c:107: 	if ((randomizeBosses) && (randomizeTrainers) && (unitID >= 0xA0)) return true; 
	tst	r1, r3	@ _10, _9
	beq	.L74		@,
	movs	r2, #1	@ tmp179,
	cmp	r6, #159	@ unitID,
	bgt	.L68		@,
	movs	r2, #0	@ tmp179,
.L68:
	lsls	r2, r2, #24	@ tmp184, tmp179,
	beq	.L74		@,
	b	.L66		@
.L70:
@ C_Code.c:113: 		return false; 
	movs	r0, #0	@ <retval>,
@ C_Code.c:116: 	if (!randomizeBosses) { // if not boss chapter, return true 
	cmp	r5, #0	@ randomizeBosses,
	bne	.L62		@,
@ C_Code.c:117: 		if ((unitID >= 0xA0) && (randomizeTrainers) && (!BossChapterTable2[gPlaySt.chapterIndex])) return true; 
	movs	r3, #1	@ tmp206,
	cmp	r6, #159	@ unitID,
	bgt	.L72		@,
	movs	r3, #0	@ tmp206,
.L72:
@ C_Code.c:117: 		if ((unitID >= 0xA0) && (randomizeTrainers) && (!BossChapterTable2[gPlaySt.chapterIndex])) return true; 
	lsls	r3, r3, #24	@ tmp211, tmp206,
	beq	.L76		@,
	cmp	r1, #0	@ _10,
	beq	.L76		@,
@ C_Code.c:117: 		if ((unitID >= 0xA0) && (randomizeTrainers) && (!BossChapterTable2[gPlaySt.chapterIndex])) return true; 
	ldr	r2, .L105+16	@ tmp213,
	ldrb	r2, [r2, #14]	@ tmp214,
@ C_Code.c:117: 		if ((unitID >= 0xA0) && (randomizeTrainers) && (!BossChapterTable2[gPlaySt.chapterIndex])) return true; 
	ldr	r3, .L105+20	@ tmp212,
@ C_Code.c:117: 		if ((unitID >= 0xA0) && (randomizeTrainers) && (!BossChapterTable2[gPlaySt.chapterIndex])) return true; 
	lsls	r2, r2, #24	@ tmp214, tmp214,
	asrs	r2, r2, #24	@ tmp214, tmp214,
@ C_Code.c:117: 		if ((unitID >= 0xA0) && (randomizeTrainers) && (!BossChapterTable2[gPlaySt.chapterIndex])) return true; 
	ldrb	r3, [r3, r2]	@ tmp215, BossChapterTable2
	cmp	r3, #0	@ tmp215,
	beq	.L66		@,
.L76:
@ C_Code.c:113: 		return false; 
	movs	r0, #0	@ <retval>,
	b	.L62		@
.L103:
@ C_Code.c:112: 		if ((unitID >= 0xA0) && (randomizeBosses) && (BossChapterTable2[gPlaySt.chapterIndex])) return true; 
	movs	r2, #0	@ tmp196,
@ C_Code.c:112: 		if ((unitID >= 0xA0) && (randomizeBosses) && (BossChapterTable2[gPlaySt.chapterIndex])) return true; 
	lsls	r2, r2, #24	@ tmp201, tmp196,
	bne	.L104		@,
	b	.L62		@
.L106:
	.align	2
.L105:
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
	.ident	"GCC: (devkitARM release 56) 11.1.0"
	.text
	.code 16
	.align	1
.L11:
	bx	r3
.L53:
	bx	r6
.L107:
	bx	r7
