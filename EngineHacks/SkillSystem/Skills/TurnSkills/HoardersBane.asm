.thumb 
.macro blh to, reg=r3
  ldr \reg, =\to
  mov lr, \reg
  .short 0xf800
.endm
	.equ EventEngine, 0x800D07C
.equ ActionData, 0x203A958 
.global HoardersBane
.type HoardersBane, %function 
HoardersBane: 
push {r4-r5, lr} 
mov r4, r0 @ parent proc 
@b HoardersBane_False

mov r0, #2 
blh  0x0800BC50   @GetUnitFromEventParam	{U}
mov r5, r0 @ unit 

ldrb r1, [r0, #0x0B] @ deployment byte 
ldr r2, [r4, #0x34] @ end of what phase 
mov r3, #0xC0 
and r1, r3 
cmp r2, r1 
bne HoardersBane_False 


mov r1, #5 
strb r1, [r0, #0x13] @ current hp 
ldrb r1, [r0, #0x0B] @ deployment byte 
ldr r2, =ActionData 
strb r1, [r2, #0x0C] @ deployment byte 



ldr  r3, =0x30004B8	@MemorySlot	{U}
mov r0, #2 
str r0, [r3, #4] 
mov r0, #18 
str r0, [r3, #4*6] @ slot6 HealValue 

str r5, [r4, #0x3C] @ unit 

mov r0, r4 @ proc 
mov r1, r5 @ unit 
mov r2, #10 @ amount 
bl HealAnim 
@ldr r0, =HoardersBaneHealEvent 
@mov r1, #1 
@blh EventEngine 
@blh ASMC_HealLikeVulnerary

mov r0, #2 
blh  0x0800BC50   @GetUnitFromEventParam	{U}
@mov r1, #23 
@strb r1, [r0, #0x13] @ current hp 
@ldr r0, =0x03004E50
@str r5, [r0] 




HoardersBane_True: 
mov r0, #1 @ has a child proc 
b ExitHoardersBane 
HoardersBane_False: 
mov r0, #0 @ skipped this time 

ExitHoardersBane: 
pop {r4-r5} 
pop {r1} 
bx r1
.ltorg 

HealAnim:
	push {r4-r6, lr}

	mov  r4, r0 @ var r4 = proc
	mov  r5, r1 @ var r5 = unit
	mov r6, r2 @ var r6 = heal amount 
	ldrb r0, [r5, #0x13] @ curr hp 
	ldrb r1, [r5, #0x12] @ max hp 
	cmp r0, r1 
	bge Exit 

mov r1, r6 
	mov  r0 ,r5       @arg1: Unit
	                  @arg2: Heal value
	blh  0x08035804   @ExecFortSelfHealMotion	{U}
	@blh  0x08035904   @ExecFortSelfHealMotion	{J}

	@アニメーションが終わるまでイベントを待機させる
	ldr r0, =WaitForVulneraryEndProc
	mov r1 ,r4
	blh  0x08002ce0	@NewBlocking6C	@{U}
	@blh  0x08002C30	@NewBlocking6C	@{J}

	ldr r1, =0x89A3874	@MapAnimBattleWithMapEvents	{U}
	@ldr r1, =0x08A13EFC	@MapAnimBattleWithMapEvents	{J}
	str	r1, [r0, #0x44]
	
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
Exit: 
ldr r0, =0x202E4D8 @ Unit map	{U}
ldr r0, [r0] 
mov r1, #0
blh 0x080197E4 @ FillMap 
blh 0x08019FA0   @UpdateUnitMapAndVision
blh 0x0801A1A0   @UpdateTrapHiddenStates
blh  0x080271a0   @SMS_UpdateFromGameData
blh  0x08019c3c   @UpdateGameTilesGraphics
pop {r4-r6} 
pop {r0} 
bx r0 
.ltorg 




.type WaitForVulneraryEnd, %function 
.global WaitForVulneraryEnd 
WaitForVulneraryEnd:
push {r4,r5,r6,lr}
mov r4 ,r0

@ 0x2Cで指定しているアニメーションProcsが終わるまで待ちます
@ arg r0 = target proc 
ldr r0, [r4, #0x44]
blh 0x08002e9c	@Fin6C	{U}



@blh 0x08002DEC	@Fin6C	{J}
cmp r0 ,#0x0
bne ExitWait
	@ユニットが移動中のモーションが残ってしまうので消す
	blh 0x080790A4       @ClearMOVEUNITs	{U}
	@blh 0x0807B4B8       @ClearMOVEUNITs	{J}

	ldr  r6, =0x0203A4EC @BattleUnit@gBattleActor	{U}	戦闘アニメで右側.CopyUnit
	@ldr r6, =0x0203A4E8 @BattleUnit@gBattleActor	{J}	戦闘アニメで右側.CopyUnit
	ldrb r0, [r6, #0xb]
	blh 0x08019430       @GetUnitStruct	{U}
	@blh 0x08019108       @GetUnitStruct	{J}
	mov r5, r0	@Unit

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
ldr r0, =0x89A2C48 @gProc_MoveUnit
blh 0x8002E9C @ ProcFind 
cmp r0, #0 
beq SkipHidingInProc2
add r0, #0x40 @this is what MU_Hide does @MU_Hide, 0x80797D5
mov r1, #1 
strb r1, [r0] @ store back 0 to show active MMS again aka @MU_Show, 0x80797DD
SkipHidingInProc2: 
ldr r1, [r5, #0x0C] @ Unit state 
mov r2, #1 @ Hide 
bic r1, r2 @ Show SMS @
str r1, [r5, #0x0C] 
ldr r3, =0x03004E50 @CurrentUnit 
ldr r3, [r3]
cmp r3, #0 
beq NoActiveUnit2
ldr r1, [r3, #0x0C] @ unit state  
mov r2, #2 @ Acted 
orr r1, r2  
str r1, [r3, #0x0C] @ Active unit should be greyed out now. 
NoActiveUnit2:

ldr r0, =0x202E4D8 @ Unit map	{U}
ldr r0, [r0] 
mov r1, #0
blh 0x080197E4 @ FillMap 
blh 0x08019FA0   //UpdateUnitMapAndVision
blh 0x0801A1A0   //UpdateTrapHiddenStates
blh  0x080271a0   @SMS_UpdateFromGameData
blh  0x08019c3c   @UpdateGameTilesGraphics

ExitWait:
pop {r4,r5,r6}
pop {r0}
bx r0

.ltorg 
