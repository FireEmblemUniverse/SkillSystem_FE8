.thumb
.macro blh to, reg=r3
  ldr \reg, =\to
  mov lr, \reg
  .short 0xf800
.endm

ASMC_SelfDamageLikeBomb:
	push {r4-r5, lr}

	mov  r4, r0 @ var r4 = proc

	ldr  r3, =0x30004B8	@MemorySlot	{U}
	@ldr  r3, =0x030004B0	@MemorySlot	{J}
	ldr  r0, [r3, #4*0x01] @slot 1 as unit 

	blh  0x0800BC50   @GetUnitFromEventParam	{U}
	@blh  0x0800BF3C   @GetUnitFromEventParam	{J}
	cmp  r0, #0x0
	beq  Exit

	@UnitIDの保存
	mov  r5, r0 @ var r5 = unit


	

	mov r0, r5 @ unit 
	blh 0x8079BB8 @ MU_GetByUnit(struct Unit* unit);
	blh 0x80790B4 @ mu_end 

ldr r1, [r5, #0x0C] @ Unit state 
mov r2, #1 @ Hide 
orr r1, r2 @ Hide SMS @ 
str r1, [r5, #0x0C] 
	@アニメーションを表示するので、一時的にマップ上の該当ユニットを消す
	mov  r0, r5	 @ arg r0 = Unit
	blh  0x0802810c   @HideUnitSMS	{U}
	@blh  0x080280A0   @HideUnitSMS	{J}

	ldr  r1, =0x0203A958	@ActionData	{U}
	@ldr r1, =0x0203A954	@ActionData	{J}
	mov  r0, #0xa
	strb r0, [r1, #0x15]	@ActionData@gActionData.trapType

	@ダメージ量を取得
	ldr  r3, =0x30004B8	@MemorySlot	{U}
	@ldr  r3, =0x030004B0	@MemorySlot	{J}
	ldr  r1, [r3, #4*0x06] @ s6 as healing amount in r1 
	cmp  r1, #0xFF
	bne  Exec
		@HP1で踏みとどまる
		ldrb  r1, [r5,#0x13]
		cmp   r1, #0x0
		beq   Exit     @死んでいるから不可能
		sub   r1, #0x1 @HPを1だけ残すので残りHP-1のダメージを与える
Exec:
	mov  r0 ,r5       @arg1: Unit
	                  @arg2: Damage value
	blh  0x0803592c   @ExecSelfDamage	{U}
	@blh  0x08035A2C   @ExecSelfDamage	{J}

	@アニメーションが終わるまでイベントを待機させる
	ldr r0, WaitForMotionEndProc
	mov r1 ,r4
	blh  0x08002ce0	@NewBlocking6C	@{U}
	@blh  0x08002C30	@NewBlocking6C	@{J}

	ldr r1, =0x089A3288	@SelfDamageMapAnim	{U}
	@ldr r1, =0x08A13910	@SelfDamageMapAnim	{J}
	str	r1, [r0, #0x2c]


ldr r0, =0x202E4D8 @ Unit map	{U}
ldr r0, [r0] 
mov r1, #0
blh 0x080197E4 @ FillMap 
blh 0x08019FA0   @UpdateUnitMapAndVision
blh 0x0801A1A0   @UpdateTrapHiddenStates
blh  0x080271a0   @SMS_UpdateFromGameData
blh  0x08019c3c   @UpdateGameTilesGraphics




Exit:
	pop  {r4-r5}
	pop  {r0}
	bx   r0

.ltorg
WaitForMotionEndProc:
