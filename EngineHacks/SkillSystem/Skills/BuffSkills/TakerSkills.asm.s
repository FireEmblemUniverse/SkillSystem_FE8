
.thumb 

.macro blh to, reg=r3
  ldr \reg, =\to
  mov lr, \reg
  .short 0xf800
.endm
.equ ActionStruct, 0x203A958 
.equ EventEngine, 0x800D07C
.equ MemorySlot,0x30004B8
.equ StrAnim, 0x01 
.equ SklAnim, 0x02 
.equ SpdAnim, 0x04 
.equ DefAnim, 0x08 
.equ ResAnim, 0x10 
.equ LukAnim, 0x20 
.equ MovAnim, 0x40 
.equ SpecAnim, 0x80 
.equ MagAnim, 0x1 @ <<8 

@ After defeating an enemy, gain +X Str. 
@ Config for amount
@ each function looks identical to this except with the relevant skill, so they're lower down 
.global StrTaker 
.type StrTaker, %function 
StrTaker: 
push {lr} 
mov r0, r4 @ unit 
ldr r1, =StrTakerID @ skill ID 
sub sp, #12 
mov r3, sp 
str r5, [r3, #0]
ldr r2, =StrTakerBuffAmount_Link
ldr r2, [r2] 
str r2, [r3, #4] 
mov r2, #StrAnim 
str r2, [r3, #8] 

ldr r2, =DebuffStatBitOffset_Str @ bit offset 
ldr r2, [r2] 
bl PossiblyApplyTaker 
add sp, #12 
End_StrTaker:  
pop {r0} 
bx r0 
.ltorg 

PossiblyApplyTaker: 
push {r4-r7, lr} 
mov r7, r8 
push {r7} 

mov r4, r0 @ unit struct A 
lsl r5, r1, #24 
lsr r5, #24 @ skill id 
mov r6, r2 @ bit offset 
ldr r2, [r3, #8] @ animation to use 
mov r8, r2 @ save for later 

ldr r7, [r3, #4] @ buff amount 

@mov r0, r4 @ unit struct A 
ldr r1, [r3, #0] @ unit struct B
ldr r2, =ActionStruct 
bl PostBattleFunc_Killed
cmp r0, #0 
beq EndTaker 

@ Could add a relic check here 

mov r0, r4 @ unit 
mov r1, r5 @ skill id 
bl SkillTester 
cmp r0, #0 
beq EndTaker

mov r0, r4 
bl GetUnitDebuffEntry 
mov r4, r0 @ debuff entry 

mov r0, #0 
ldr r1, =TakerSkillsStackable_Link
ldr r1, [r1] 
cmp r1, #1 
bne OverwriteAmount

mov r1, r6 @ bit offset 
ldr r2, =DebuffStatNumberOfBits_Link
ldr r2, [r2] 
mov r0, r4 @ debuff entry 
bl UnpackData_Signed
OverwriteAmount: 
mov r3, r7 @ buff amount 
add r3, r0 @ r0 as either 0 or the unpacked data 
ldr r2, =TakerMaxBuff_Link 
ldr r2, [r2] 
cmp r3, r2 
ble NoCap 
mov r3, r2 
NoCap: 

mov r1, r6 @ bit offset 
ldr r2, =DebuffStatNumberOfBits_Link
ldr r2, [r2] 
mov r0, r4 @ debuff entry 
bl PackData_Signed 

ldr r3, =MemorySlot 
mov r2, r8 @ anim 
str r2, [r3, #4*3] @ s3 as anim to show 

ldr r0, =ShowBuffEvent 
mov r1, #1 @ EV_TYPE_CUTSCENE 
blh EventEngine 

EndTaker: 
pop {r7} 
mov r8, r7 
pop {r4-r7} 
pop {r0} 
bx r0 
.ltorg 

@ Return False if we did not KO an enemy 
@ r0 = unit struct A 
@ r1 = unit struct B 
@ r2 = action struct 
.global PostBattleFunc_Killed 
.type PostBattleFunc_Killed, %function 
PostBattleFunc_Killed: @ all the post battle functions seem to do this 
@ idk why we don't just put this at the start of the loop *shrugs* 
@check if dead
ldrb	r3, [r0,#0x13]
cmp	r3, #0x00
beq	RetFalse

@check if killed enemy
ldrb	r3, [r1,#0x13]	@currhp
cmp	r3, #0
bne	RetFalse

@check if attacked this turn
ldrb 	r3, [r2,#0x11]	@action taken this turn
cmp	r3, #0x2 @attack
bne	RetFalse
ldrb 	r3, [r2,#0x0C]	@allegiance byte of the current character taking action
ldrb	r2, [r0,#0x0B]	@allegiance byte of the character we are checking
cmp	r3, r2		@check if same character
bne	RetFalse 
mov r0, #1 @ True 
b Exit 
RetFalse: 
mov r0, #0 
Exit: 
bx lr 
.ltorg 


.global SklTaker 
.type SklTaker, %function 
SklTaker: 
push {lr} 
mov r0, r4 @ unit 
ldr r1, =SklTakerID @ skill ID 
sub sp, #12 
mov r3, sp 
str r5, [r3, #0]
ldr r2, =SklTakerBuffAmount_Link
ldr r2, [r2] 
str r2, [r3, #4] 
mov r2, #SklAnim 
str r2, [r3, #8] 
ldr r2, =DebuffStatBitOffset_Skl @ bit offset 
ldr r2, [r2] 
bl PossiblyApplyTaker 
add sp, #12 
End_SklTaker:  
pop {r0} 
bx r0 
.ltorg 

.global SpdTaker 
.type SpdTaker, %function 
SpdTaker: 
push {lr} 
mov r0, r4 @ unit 
ldr r1, =SpdTakerID @ skill ID 
sub sp, #12 
mov r3, sp 
str r5, [r3, #0]
ldr r2, =SpdTakerBuffAmount_Link
ldr r2, [r2] 
str r2, [r3, #4] 
mov r2, #SpdAnim 
str r2, [r3, #8] 
ldr r2, =DebuffStatBitOffset_Spd @ bit offset 
ldr r2, [r2] 
bl PossiblyApplyTaker 
add sp, #12 
End_SpdTaker:  
pop {r0} 
bx r0 
.ltorg 

.global DefTaker 
.type DefTaker, %function 
DefTaker: 
push {lr} 
mov r0, r4 @ unit 
ldr r1, =DefTakerID @ skill ID 
sub sp, #12 
mov r3, sp 
str r5, [r3, #0]
ldr r2, =DefTakerBuffAmount_Link
ldr r2, [r2] 
str r2, [r3, #4] 
mov r2, #DefAnim 
str r2, [r3, #8] 
ldr r2, =DebuffStatBitOffset_Def @ bit offset 
ldr r2, [r2] 
bl PossiblyApplyTaker 
add sp, #12 
End_DefTaker:  
pop {r0} 
bx r0 
.ltorg 


.global ResTaker 
.type ResTaker, %function 
ResTaker: 
push {lr} 
mov r0, r4 @ unit 
ldr r1, =ResTakerID @ skill ID 
sub sp, #12 
mov r3, sp 
str r5, [r3, #0]
ldr r2, =ResTakerBuffAmount_Link
ldr r2, [r2] 
str r2, [r3, #4] 
mov r2, #ResAnim 
str r2, [r3, #8] 
ldr r2, =DebuffStatBitOffset_Res @ bit offset 
ldr r2, [r2] 
bl PossiblyApplyTaker 
add sp, #12 
End_ResTaker:  
pop {r0} 
bx r0 
.ltorg 


.global LukTaker 
.type LukTaker, %function 
LukTaker: 
push {lr} 
mov r0, r4 @ unit 
ldr r1, =LukTakerID @ skill ID 
sub sp, #12 
mov r3, sp 
str r5, [r3, #0]
ldr r2, =LukTakerBuffAmount_Link
ldr r2, [r2] 
str r2, [r3, #4] 
mov r2, #LukAnim 
str r2, [r3, #8] 
ldr r2, =DebuffStatBitOffset_Luk @ bit offset 
ldr r2, [r2] 
bl PossiblyApplyTaker 
add sp, #12 
End_LukTaker:  
pop {r0} 
bx r0 
.ltorg 


.global MagTaker 
.type MagTaker, %function 
MagTaker: 
push {lr} 
mov r0, r4 @ unit 
ldr r1, =MagTakerID @ skill ID 
sub sp, #12 
mov r3, sp 
str r5, [r3, #0]
ldr r2, =MagTakerBuffAmount_Link
ldr r2, [r2] 
str r2, [r3, #4] 
mov r2, #MagAnim 
lsl r2, #8 @ 0x100 
str r2, [r3, #8] 
ldr r2, =DebuffStatBitOffset_Mag @ bit offset 
ldr r2, [r2] 
bl PossiblyApplyTaker 
add sp, #12 
End_MagTaker:  
pop {r0} 
bx r0 
.ltorg 

.global MovTaker 
.type MovTaker, %function 
MovTaker: 
push {lr} 
mov r0, r4 @ unit 
ldr r1, =MovTakerID @ skill ID 
sub sp, #12 
mov r3, sp 
str r5, [r3, #0]
ldr r2, =MovTakerBuffAmount_Link
ldr r2, [r2] 
str r2, [r3, #4] 
mov r2, #MovAnim 
str r2, [r3, #8] 
ldr r2, =DebuffStatBitOffset_Mov @ bit offset 
ldr r2, [r2] 
bl PossiblyApplyTaker 
add sp, #12 
End_MovTaker:  
pop {r0} 
bx r0 
.ltorg 


