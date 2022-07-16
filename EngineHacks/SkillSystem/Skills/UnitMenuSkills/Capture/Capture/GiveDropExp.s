.thumb
.macro blh to, reg=r3
  ldr \reg, =\to
  mov lr, \reg
  .short 0xf800
.endm

@Hook 0x32264

ldr	r0, [r5]
cmp	r0, #0
bne	Exit

ldr	r0, =0x0203A4EC @BattleUnit@gBattleActor @FE8U
ldr	r1, =0x03004E50 @CurrentUnit @FE8U
ldr	r1, [r1]

blh 0x0802a584 @CopyUnitToBattleStruct
mov	r0, r6
ldr r1, DropEXP
bl	nin_i_exp

blh 0x080790a4	@ClearMOVEUNITs

bl	effect

bl	clear_double_battleanime

Exit:
mov	r0, #0
pop	{r4, r5, r6}
pop	{r1}
bx	r1

@二重に描画されるマップアニメを消す
@このルーチンはかなりイケていない。 
@ただ、最初に見つかったアニメは二重に描画されるアニメである可能性が高いので、それをとりあえず消す.
clear_double_battleanime:
	push	{lr}

	ldr r0, =0x089A2C48	@(Procs MoveUnit )
	ldr r3, =0x08002e9c	@Find6C
	mov	r14, r3
	@dcw	0xF800

	ldr r3, =0x08002d6c	@Delete6C
	mov	r14, r3
	@dcw	0xF800

	pop	{r0}
	bx	r0

@任意の経験値
nin_i_exp:
	push	{r4,r5,r6,lr}
	mov		r5, r0
	mov		r6, r1

	cmp		r1,#0x0
	beq		noexp

@	ldr	r4, =0x0203a4e8    @Unit@戦闘アニメで右側。 {J}
	ldr	r4, =0x0203A4EC    @Unit@戦闘アニメで右側。 {U}
	mov	r0, #0xB
	ldsb	r0, [r4, r0]
	mov	r1, #0xC0
	and	r0, r1
	cmp	r0, #0
	bne	noexp

	mov	r0, r4
@	blh	0x0802B93C          @CanUnitNotLevelUp	{J}
	blh	0x0802b9f4          @CanUnitNotLevelUp	{U}

	lsl	r0, r0, #0x18
	cmp	r0, #0
	beq	noexp

@	ldr	r0, =0x0202bcec     @(gChapterData ) {J}
	ldr	r0, =0x0202BCF0     @(gChapterData ) {U}
	ldrb	r1, [r0, #0x14]
	mov	r0, #0x80
	and	r0, r1
	cmp	r0, #0
	bne	noexp

@	ldr	r2, =0x0203a4e8    @Unit@戦闘アニメで右側。 {J}
	ldr	r2, =0x0203A4EC    @Unit@戦闘アニメで右側。 {U}
	mov r1, r2
	add	r1, #0x6E
	mov	r0, r6				@経験値を追加
	strb	r0, [r1, #0x0]
	ldrb	r0, [r2, #0x9]
	add	r0, r6				@やはりここも置き換えないとダメかなあ 
	strb	r0, [r2, #0x9]
	mov	r0, r2

@	blh 0x0802B970          @CheckForLevelUp	{J}
	blh 0x0802ba28          @CheckForLevelUp	{U}
	noexp:

@	ldr r0,=0x085C3FA4       @Procs	Exp Bar Graph {J}
	ldr r0,=0x0859BAC4       @Procs	Exp Bar Graph {U}

	mov	r1, r5
@	blh	0x08002C30       @NewBlocking6C	{J}
	blh	0x08002ce0       @NewBlocking6C	{U}

	pop	{r4,r5,r6}
	pop	{r1}
	bx	r1

effect:
	push	{lr}
	ldr	r0, =0x0203A4EC @BattleUnit@gBattleActor @FE8U
	mov	r2, r0
	add	r2, #74
	mov	r3, #0
	mov	r1, #79
	strh	r1, [r2, #0]
	ldr	r1, =0x0203e1f0 @MapAnimStruct@gMapAnimStruct @FE8U
	mov	r12, r1
	add	r1, #95
	strb	r3, [r1, #0]
	mov	r2, r12
	add	r2, #98
	mov	r1, #2
	strb	r1, [r2, #0]
	mov	r1, r12
	add	r1, #94
	mov	r2, #1
	strb	r2, [r1, #0]
	sub	r1, #6
	strb	r3, [r1, #0]
	add	r1, #1
	strb	r2, [r1, #0]
	ldr	r1, =0x0203A56C @BattleUnit@gBattleTarget @FE8U
	ldr	r2, =0x0203a5ec @BattleRound@gRoundArray  @FE8U

	blh 0x0807b900	@SetupMapBattleAnim	@FE8U
	ldr r0, EffectProc
	mov	r1, #3

	blh 0x08002c7c	@New6C		@FE8U
	pop	{r0}
	bx r0

.ltorg
.align 4
DropEXP:
.equ EffectProc, DropEXP + 0x4
