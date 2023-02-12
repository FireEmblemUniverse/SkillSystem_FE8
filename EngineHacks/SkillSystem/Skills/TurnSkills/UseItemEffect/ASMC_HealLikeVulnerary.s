.thumb
.macro blh to, reg=r3
  ldr \reg, =\to
  mov lr, \reg
  .short 0xf800
.endm

HealLikeVulnerary:
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
	ldrb r0, [r5, #0x13] @ curr hp 
	ldrb r1, [r5, #0x12] @ max hp 
	cmp r0, r1 
	bge Exit 
	@アニメーションを表示するので、一時的にマップ上の該当ユニットを消す
	mov  r0, r5	 @ arg r0 = Unit
	@blh  0x0802810c   @HideUnitSMS	{U}
	@blh  0x080280A0   @HideUnitSMS	{J}




	@回復量を取得
	ldr  r3, =0x30004B8	@MemorySlot	{U}
	@ldr  r3, =0x030004B0	@MemorySlot	{J}
	ldr  r1, [r3, #4*0x06] @ s6 as healing amount in r1 
	mov  r0 ,r5       @arg1: Unit
	                  @arg2: Heal value
	blh  0x08035804   @ExecFortSelfHealMotion	{U}
	@blh  0x08035904   @ExecFortSelfHealMotion	{J}

	@アニメーションが終わるまでイベントを待機させる
	ldr r0, WaitForMotionEndProc
	mov r1 ,r4
	blh  0x08002ce0	@NewBlocking6C	@{U}
	@blh  0x08002C30	@NewBlocking6C	@{J}

	ldr r1, =0x89A3874	@MapAnimBattleWithMapEvents	{U}
	@ldr r1, =0x08A13EFC	@MapAnimBattleWithMapEvents	{J}
	str	r1, [r0, #0x2c]
	
	mov r0, r5 
	blh 0x8028130 @ ShowUnitSMS

ldr r0, =0x89A2C48 @gProc_MoveUnit
blh 0x8002E9C @ ProcFind 
cmp r0, #0 
beq SkipHidingInProc
add r0, #0x40 @this is what MU_Hide does @MU_Hide, 0x80797D4
mov r1, #1 
strb r1, [r0] @ store back 0 to show active MMS again aka @MU_Show, 0x80797DC
SkipHidingInProc: 
ldr r1, [r5, #0x0C] @ Unit state 
mov r2, #1 @ Hide 
bic r1, r2 @ Show SMS @ 
str r1, [r5, #0x0C] 

	
ldr r3, =0x03004E50 @CurrentUnit 
ldr r3, [r3] 
cmp r3, #0 
beq NoActiveUnit

ldr r1, [r3, #0x0C] @ Unit state 
mov r2, #0x3 @ Hide, Acted
bic r1, r2 @ Show SMS @ 
str r1, [r3, #0x0C] 
	@mov r0, r3 @ I don't think this part is needed? 
	@blh 0x8028130 @ ShowUnitSMS
NoActiveUnit:

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
.align 
WaitForMotionEndProc:
