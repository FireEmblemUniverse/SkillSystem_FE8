
.thumb
.macro blh to, reg=r3
  ldr \reg, =\to
  mov lr, \reg
  .short 0xf800
.endm

WaitForMotionEnd:
push {r4,r5,r6,lr}
mov r4 ,r0

@ 0x2Cで指定しているアニメーションProcsが終わるまで待ちます
@ arg r0 = target proc 
ldr r0, [r4, #0x2c]
blh 0x08002e9c	@Fin6C	{U}



@ kill MU all 
@ start new MU with specific unit 
@ when MU ends, kill our proc 

@ instead:
@ save unit to proc 
@ find MU by unit 
@ if no MU, kill our proc 

@blh 0x08002DEC	@Fin6C	{J}
cmp r0 ,#0x0
bne Exit



	ldr  r6, =0x0203A4EC @BattleUnit@gBattleActor	{U}	戦闘アニメで右側.CopyUnit
	@ldr r6, =0x0203A4E8 @BattleUnit@gBattleActor	{J}	戦闘アニメで右側.CopyUnit
	ldrb r0, [r6, #0xb]
	blh 0x08019430       @GetUnitStruct	{U}
	@blh 0x08019108       @GetUnitStruct	{J}
	mov r5, r0	@Unit
	

	
	mov r0, r5 @ unit 
	blh 0x8079BB8 @ MU_GetByUnit(struct Unit* unit);
	blh 0x80790B4 @ mu_end 
	@ユニットが移動中のモーションが残ってしまうので消す
	@blh 0x080790A4       @ClearMOVEUNITs	{U}
	@blh 0x0807B4B8       @ClearMOVEUNITs	{J}

ldr r1, [r6, #0x0C] @ Unit state 
mov r2, #0x1 @ Hide
bic r1, r2 @ Show SMS @ 
str r1, [r6, #0x0C] 
	
	mov r0, r6 
	blh 0x8028130 @ ShowUnitSMS

	@回復やダメージの結果をRAMUnitに書き戻して確定させます
	mov r0, r5       @Arg1: Unit
	mov r1, r6       @Arg2: 戦闘アニメで右側.CopyUnit
	blh 0x0802c1ec   @SaveUnitFromBattle	{U}
	@blh 0x0802C134   @SaveUnitFromBattle	{J}

	@もしユニットのHPが0になってしまっているなら死亡させる
	mov r0, r5       @Arg1 Unit
	blh 0x08032750   @KillUnitIfNoHealth	{U}
	@blh 0x0803269C   @KillUnitIfNoHealth	{J}

	blh 0x080321C8   @UpdateMapAndUnit	{U}
	@blh 0x08032114   @UpdateMapAndUnit	{J}

	@マップアニメーションが終わったのでループを抜ける
	mov r0 ,r4
	blh 0x08002e94   @Break6CLoop	{U}
	@blh 0x08002DE4   @Break6CLoop	{J}
	



NoActiveUnit:

@ldr r0, =0x202E4D8 @ Unit map	{U}
@ldr r0, [r0] 
@mov r1, #0
@blh 0x080197E4 @ FillMap 
@blh 0x08019FA0   @UpdateUnitMapAndVision
@blh 0x0801A1A0   @UpdateTrapHiddenStates
@blh  0x080271a0   @SMS_UpdateFromGameData
@blh  0x08019c3c   @UpdateGameTilesGraphics


Exit:
pop {r4,r5,r6}
pop {r0}
bx r0
