.thumb 
.macro blh to, reg=r3
  ldr \reg, =\to
  mov lr, \reg
  .short 0xf800
.endm

.global ProcessStatusEffects
.type ProcessStatusEffects, %function
ProcessStatusEffects:
push {r4, lr}
push {r0-r2}
mov r4, r0 @ Unit 
add r0, #0x36 @ Support5 
ldrb r1, [r0] 
mov r2, #1 
bic r1, r2 @ remove "not fully paralyzed" bitflag 
strb r1, [r0] 

ldrb r0, [r4, #0x0B] @ deployment byte 
cmp r0, #0x40 
blt End

mov r1, #0x30 
ldrb r0, [r4, r1] @ Status 
ldr r2, =FreezeStatusID_Link 
ldr r2, [r2] 
lsl r0, #28 
lsr r0, #28 
cmp r0, r2 
beq ActedAlready

mov r1, #0x30 
ldrb r0, [r4, r1] @ Status 
ldr r2, =ParalyzeStatusID_Link 
ldr r2, [r2] 
lsl r0, #28 
lsr r0, #28 
cmp r0, r2 
bne End 

blh 0x8000c64 @NextRN_100
ldr r1, =EnemyParalyzeChanceLink
ldr r1, [r1] 
cmp r0, r1
bgt End 

ActedAlready:
 
ldr r0, [r4, #0xC]
mov r1, #2 
orr r0, r1
str r0, [r4, #0x0C] @ acted already 
End: 

pop {r0-r2}
pop {r4}
pop {r3}
bx r3 

.ltorg 
.align


.global ProcessBuffs 
.type ProcessBuffs, %function 
ProcessBuffs: 
push {r4-r7, lr}
push {r0-r2}
mov r4, r0 @ Unit 

blh GetBuff 
mov r5, r0 @ ram address of buff 
mov r6, #32 @ Counter 
ldr r0, [r5]
cmp r0, #0 
beq ExitLoop 



Loop:
sub r6, #4 @ 4 bits each loop 
cmp r6, #0 
ble ExitLoop 

ldr r7, [r5]
mov r0, r7 
lsl r0, r6
@mov r2, #28 
@sub r2, r6 

mov r2, #28 
lsr r0, r2 
mov r1, r7 

mov r1, #0xF 
and r1, r0 
cmp r1, #0 
beq Loop 

ldr r2, =BuffDepletePerTurnAmountLink 
ldr r2, [r2] 
cmp r1, r2 
bge NoCap 
mov r1, r2 @ so r1 will be 0 
NoCap: 
sub r1, r2 @ -X from the buff per turn 


mov r2, #28
sub r2, r6

lsl r1, r2 @ back to the offset / stat 
mov r3, #0xF 
lsl r3, r2 

 
bic r7, r3 @ remove all bits at that offset 
orr r7, r1 @ turn on all new bits at that offset 
str r7, [r5] 
b Loop 

ExitLoop: 

pop {r0-r2}
pop {r4-r7}
pop {r3}
bx r3 

.align

