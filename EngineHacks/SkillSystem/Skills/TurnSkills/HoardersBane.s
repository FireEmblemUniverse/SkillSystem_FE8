.thumb 
.macro blh to, reg=r3
  ldr \reg, =\to
  mov lr, \reg
  .short 0xf800
.endm
.equ EventEngine, 0x800D07C
.equ ActionData, 0x203A958 
.equ VulneraryHealAmount, 0x802FEC6 
.equ ProcStartBlocking, 0x8002CE0 
.equ ProcGoto, 0x8002F24 
.equ GetUnit, 0x8019430
.equ HasConvoyAccess, 0x803161c 
.equ ConvoySize, 0x80315bc 
.equ ConvoyPointer, 0x80315b4 
.equ GetItemAfterUse, 0x8016aec
.equ RemoveUnitBlankItems, 0x8017984 

.equ DeployByte, 			0  @ 0x2c 
.equ FuncCoun, 				1  @ 0x2d 
.equ Destructor, 			2  @ 0x2e 
.equ TryPhaseBool, 			3  @ 0x2f 
.equ EndOfDeployByte, 		4  @ 0x30 
.equ SkillBufferCounter, 	5  @ 0x31 
.equ healAmount, 			7  @ 0x32 
.equ SkillBuffer, 			8  @ 0x34 
.equ pUnit, 				12 @ 0x38 
.equ FirstFunc, 			16 @ 0x3c 


.global CallEndOfTurnHealLoop
.type CallEndOfTurnHealLoop, %function 
CallEndOfTurnHealLoop: 
push {r4, lr} 
mov r4, r0 @ proc 
mov r1, r4 @ to block 
ldr r0, =EndOfTurnHealLoopProc
blh ProcStartBlocking 
add r0, #0x2c 
add r4, #0x2c 

ldrb r1, [r4, #DeployByte] 
strb r1, [r0, #DeployByte] 
ldrb r1, [r4, #FuncCoun] 
strb r1, [r0, #FuncCoun] 
ldrb r1, [r4, #Destructor] 
strb r1, [r0, #Destructor] 
ldrb r1, [r4, #TryPhaseBool] 
strb r1, [r0, #TryPhaseBool] 
ldrb r1, [r4, #EndOfDeployByte] 
strb r1, [r0, #EndOfDeployByte] 
ldrb r1, [r4, #SkillBufferCounter] 
strb r1, [r0, #SkillBufferCounter] 
ldr r1, [r4, #SkillBuffer] 
str r1, [r0, #SkillBuffer] 
ldr r1, [r4, #pUnit] 
str r1, [r0, #pUnit] 
ldr r1, [r4, #FirstFunc] 
str r1, [r0, #FirstFunc] 

mov r1, #0 
strb r1, [r0, #healAmount] 



pop {r4} 
pop {r0} 
bx r0 
.ltorg 

.global EndOfTurnCalcLoop_CanUnitHeal
.type EndOfTurnCalcLoop_CanUnitHeal, %function 
EndOfTurnCalcLoop_CanUnitHeal:
@ given r0 = valid unit 
ldrb r1, [r0, #0x13] @ curr hp 
ldrb r2, [r0, #0x12] @ max 
cmp r1, r2 
bge CannotHeal 
mov r0, #1 @ can heal 
b Exit_CanUnitHeal 

CannotHeal: 
mov r0, #0 
Exit_CanUnitHeal: 
bx lr 
.ltorg 

FindItemInInv:
@ r0 = unit 
@ r1 = item ID 
mov r2, #0x1C @ inv - 2
InvLoop: 
add r2, #2 
cmp r2, #0x28 @ wexp start 
bge BreakInvLoop2 
ldrh r3, [r0, r2] 
cmp r3, #0 
beq BreakInvLoop2 
lsl r3, #24 
lsr r3, #24 @ item id only 
cmp r1, r3
bne InvLoop 
mov r0, r2 @ unit offset 
b ExitFindItemInInv

BreakInvLoop2: 
mov r0, #0 @ no item 

ExitFindItemInInv: 
bx lr 
.ltorg 


FindItemInConvoy: 
@ r0 = item ID 
ldr  r3, =ConvoySize 	
ldrb r3, [r3] @normally 0x63
ldr  r2, =ConvoyPointer	
ldr  r2, [r2]
lsl  r3, #0x01            @end = size*2 + convoy
add  r3, r2
sub r2, #2 
ConvoyLoop: 
add r2, #2 
cmp r2, r3 
bge NoItemFoundInConvoy 
ldrb r1, [r2] 
cmp r1, r0 
bne ConvoyLoop 
ldr r0, =ConvoyPointer @pointer to convoy	
ldr r0, [r0] 
sub r2, r0 @ offset 
mov r0, r2 
b ExitFoundInConvoy


NoItemFoundInConvoy: 
mov r0, #0 
sub r0, #1 
ExitFoundInConvoy: 
bx lr 
.ltorg 




.global HoardersBane_CanUnitHeal 
.type HoardersBane_CanUnitHeal, %function 
HoardersBane_CanUnitHeal: 
push {r4-r6, lr} 
@ given r0 = valid unit with the skill 
@ check if they meet any other requirements (eg. have vulneraries in supply & aren't at full hp) 

mov r4, r0 @ unit 
ldr r5, =VulneraryItemID_Link 
ldr r5, [r5] 
mov r1, r5 
bl FindItemInInv 
cmp r0, #0 
bne HoardersBaneUsability_True

BreakInvLoop: 
ldrb r3, [r4, #0x0B] @ NPCs / Enemies cannot access the supply 
lsr r3, #6 
cmp r3, #0 
bne HoardersBaneUsability_False 
ldr r3, HoardersBane_UseConvoyLink 
cmp r3, #0 
beq HoardersBaneUsability_False

mov r0, r4 @ unit 
blh HasConvoyAccess 
cmp r0, #0 
beq HoardersBaneUsability_False 
@ search convoy for vulnerary 
mov r0, r5 @ vuln item ID 
bl FindItemInConvoy
mov r1, #0 
sub r1, #1 
cmp r0, r1
bne HoardersBaneUsability_True

HoardersBaneUsability_False:
mov r0, #0 
b HoardersBaneUsability_Exit

HoardersBaneUsability_True:
mov r0, #1 

HoardersBaneUsability_Exit: 

pop {r4-r6} 
pop {r1} 
bx r1 
.ltorg 


.global HoardersBane_HealAmount
.type HoardersBane_HealAmount, %function 
HoardersBane_HealAmount: 
push {r4-r6, lr} 
@ remove 1 use of vulnerary, wherever it may be 
mov r4, r0 @ unit id 
ldr r5, =VulneraryItemID_Link 
ldr r5, [r5] 
mov r1, r5 
bl FindItemInInv 
cmp r0, #0 
beq TrySupply 
mov r6, r0 @ item offset 
ldrh r0, [r4, r6] 
blh GetItemAfterUse 
strh r0, [r4, r6] 
cmp r0, #0 
bne NoPack 
mov r0, r4 
blh RemoveUnitBlankItems 
NoPack: 
b Exit_HoardersBane_HealAmount 
TrySupply: 
mov r0, r5 @ vuln 
bl FindItemInConvoy @ returns offset in convoy if found, 0xFFFFFFFF otherwise 
mov r1, #0 
sub r1, #1 
cmp r0, r1
beq Exit_HoardersBane_HealAmount 
mov r6, r0 
ldr r5, =ConvoyPointer 
ldr r5, [r5] 
ldrh r0, [r5, r6] 
blh GetItemAfterUse 
strh r0, [r5, r6] 
cmp r0, #0 
bne NoPackSupply 

ldr r4, =ConvoySize 
ldrb r4, [r4] 
lsl r4, #1 @ 2 bytes per entry 
add r4, r5 @ end of convoy 
add r5, r6 @ where to start 
PackSupplyLoop: 

ldrh r0, [r5, #2]
strh r0, [r5] 
add r5, #2  
cmp r5, r4 
bge NoPackSupply 
b PackSupplyLoop 
NoPackSupply: 

Exit_HoardersBane_HealAmount: 
@ this is the only part the parent cares about 
ldr r0, =VulneraryHealAmount 
ldrb r0, [r0] 
pop {r4-r6}
pop {r1} 
bx r1 
.ltorg 

.global EndOfTurn_HealLoop_FindNextValidUnit
.type EndOfTurn_HealLoop_FindNextValidUnit, %function 
EndOfTurn_HealLoop_FindNextValidUnit: 
push {r4-r7, lr} 
@ given r0 = deployment byte to search from, 
@ r1 = deployment byte to stop at 
@ find the next unit meeting the criteria 

mov r4, r0 @ deployment byte 

@ r5 = unit 
mov r6, r1 @ where to stop 

mov r7, r2 @ proc + 0x2c 

UnitLoop: 
mov r5, #0 
strb r5, [r7, #healAmount] 
strb r5, [r7, #SkillBufferCounter] 
mov r0, r4 @ deployment byte 
add r4, #1 
cmp r0, r6
bge NoValidUnit 

blh GetUnit
mov r5, r0 @ unit 

mov r0, r5 @ unit 
bl IsUnitOnField 
cmp r0, #1 
bne UnitLoop 
mov r0, r5 @ unit 
bl EndOfTurnCalcLoop_CanUnitHeal
cmp r0, #0 
beq UnitLoop 

mov r0, r5 @ unit 
ldr r1, [r7, #SkillBuffer]
bl MakeSkillBuffer 

SkillBufferLoop: 
ldr r1, [r7, #SkillBuffer] 
ldrb r2, [r7, #SkillBufferCounter] 
add r2, #1 
strb r2, [r7, #SkillBufferCounter] 
ldrb r0, [r1, r2] @ current skill 
cmp r0, #0 
beq MaybeHeal 
ldr r3, =EndOfTurn_HealSkillTable
lsl r0, #3 @ 8 bytes per 
add r3, r0 
ldr r0, [r3] @ usability 
cmp r0, #0 
beq SkillBufferLoop 
mov lr, r0 
mov r0, r5 @ unit 
push {r3} 
.short 0xf800 @ returns if usable or not 
pop {r3} 
cmp r0, #0 
beq SkillBufferLoop
ldr r0, [r3, #4] @ returns amount to heal 
mov lr, r0 
mov r0, r5 @ unit (in case it matters fsr) 
.short 0xf800 
cmp r0, #0 
beq SkillBufferLoop 
@r0 = amount to heal 


@ r5 has a valid unit 
ldrb r1, [r7, #healAmount] 
add r1, r0 
cmp r1, #127 
blt NoCap 
mov r1, #127 
NoCap: 
strb r1, [r7, #healAmount] 
b SkillBufferLoop 
MaybeHeal: 
ldrb r0, [r7, #healAmount] 
cmp r0, #0 
beq UnitLoop 

NoValidUnit: 
mov r0, r5 

pop {r4-r7} 
pop {r1} 
bx r1
.ltorg 


.global ExecuteFirstUnitHeal 
.type ExecuteFirstUnitHeal, %function 
ExecuteFirstUnitHeal: 
push {lr} 
mov r3, #0x2C 
add r3, r0
ldrb r2, [r3, #healAmount] 
mov r1, #0 
strb r1, [r3, #healAmount] 
ldr r1, [r3, #pUnit] 
bl HealAnim @ starts a blocking proc 

mov r0, #0 @ always yield 
pop {r1} 
bx r1 
.ltorg 

.global EndOfTurn_HealLoop_End
.type EndOfTurn_HealLoop_End, %function 
EndOfTurn_HealLoop_End: 
ldr r1, [r0, #0x14] @ parent proc 
add r1, #0x2c 
ldrb r2, [r1, #FuncCoun] 
add r2, #2 @ we finished this function 
strb r2, [r1, #FuncCoun] 
bx lr 
.ltorg 

.global EndOfTurn_HealLoop_IterateLoop
.type EndOfTurn_HealLoop_IterateLoop, %function 
EndOfTurn_HealLoop_IterateLoop: 
push {r4-r5, lr}  
mov r4, r0 @ parent proc 
add r4, #0x2C 
ldrb r0, [r4, #DeployByte] 
ldrb r1, [r4, #EndOfDeployByte] 
mov r2, r4 @ parent proc + 0x2c 
bl EndOfTurn_HealLoop_FindNextValidUnit
cmp r0, #0 
beq BreakHoardersBane 
ldrb r1, [r0, #0x0B] @ deployment byte 
strb r1, [r4, #DeployByte] @ next search will start +1 higher 
str r0, [r4, #pUnit] @ unit +0x3C 
mov r5, r0 @ unit 
mov r0, r4 @ proc 
mov r1, #0x2C 
sub r0, r1 
mov r1, r5 @ unit 
ldrb r2, [r4, #healAmount] 
bl HealAnim @ starts a blocking proc 
ldrb r0, [r4, #DeployByte] 
add r0, #1 
strb r0, [r4, #DeployByte] 
b HoardersBane_True 


BreakHoardersBane: 
mov r0, r4 
sub r0, #0x2C 
mov r1, #1 @ label 
blh ProcGoto 
mov r0, #1
b HoardersBane_False @ don't yield for a frame 


HoardersBane_True: 
mov r0, #0 @ has a child proc, so yield for a frame (0) 
b ExitHoardersBane 
HoardersBane_False: 
mov r0, #1 @ skipped this time 

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
	add r0, #0x2c 
	str	r1, [r0, #FirstFunc]
	str	r5, [r0, #pUnit]
	
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
mov r2, #0x1 @ Hide
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
add r0, #0x2c 
ldr r0, [r0, #FirstFunc]
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
@ldr r1, [r3, #0x0C] @ unit state  
@mov r2, #2 @ Acted 
@orr r1, r2  
@str r1, [r3, #0x0C] @ Active unit should be greyed out now. 
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
HoardersBane_UseConvoyLink: 
