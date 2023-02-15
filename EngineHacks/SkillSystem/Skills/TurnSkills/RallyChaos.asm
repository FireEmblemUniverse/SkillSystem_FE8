.macro blh to, reg=r3
  ldr \reg, =\to
  mov lr, \reg
  .short 0xf800
.endm
.thumb 
.equ GetUnit, 0x8019430
.equ ProcStartBlocking, 0x8002CE0 
.equ ProcGoto, 0x8002F24 
.equ ChapterData, 0x202BCF0 
.equ NextRN_N, 0x8000C80 

.global ShouldCallRallyChaos
.type ShouldCallRallyChaos, %function 
ShouldCallRallyChaos: 
ldr r1, =RallyChaosID_Link 
ldr r1, [r1] 
cmp r1, #0xFF 
beq NeverCallRallyChaos 
mov r0, #1 
b ExitShouldCallRallyChaos 

NeverCallRallyChaos: 
mov r0, #0
ExitShouldCallRallyChaos: 
bx lr 
.ltorg 

.global CallRallyChaosProc
.type CallRallyChaosProc, %function 
CallRallyChaosProc: 
push {lr} 
mov r1, r0 @ to block 
ldr r0, =RallyChaosProc
blh ProcStartBlocking 
mov r0, #1 @ has blocking proc 
pop {r1} 
bx r1 
.ltorg 


.global RallyChaosIdle
.type RallyChaosIdle, %function 
RallyChaosIdle: 
push {r4, lr} 
mov r4, r0 @ parent proc 
ldr r0, [r4, #0x30] 
cmp r0, #0 
bne Destruct 
bl FindMapAuraProc
cmp r0, #0 
bne ContinueIdle 
mov r0, r4 @ proc 
mov r1, #0 @ wait for rally anim 
blh ProcGoto 
@ProcGoto((Proc*)proc,1);
b ContinueIdle 
Destruct: 
mov r0, r4 @ proc 
mov r1, #1 @ label 
blh ProcGoto 

ContinueIdle:
pop {r4}  
pop {r0} 
bx r0 
.ltorg 

.global RallyChaosInit
.type RallyChaosInit, %function 
RallyChaosInit: 
mov r1, #0 
str r1, [r0, #0x2C] @ unit deployment byte 
str r1, [r0, #0x30] @ destructor = false 
str r1, [r0, #0x34] @ 
str r1, [r0, #0x38] @ 
str r1, [r0, #0x3C] @ 
bx lr 
.ltorg 


.global RallyChaosFunc
.type RallyChaosFunc, %function 
RallyChaosFunc: 
push {r4-r7, lr} 
mov r4, r0 @ parent proc 


ldr r3, =ChapterData 
ldrb r0, [r3, #0xF] @ phase 
mov r5, r0 @ starting unit deployment id 
mov r6, #0x40 @ ending point 
add r6, r5 @ only one allegiance 
ldr r1, [r4, #0x2C] @ stopping point 
add r5, r1 @ where to start our loop 

cmp r0, #0 
beq RallyChaos_Loop 
sub r5, #1 @ so we start at 0x40 / 0x80 while players start at 0x1 

RallyChaos_Loop: 
add r5, #1 
cmp r5, r6 
bge Break_RallyChaos 
mov r0, r5 
blh GetUnit 
mov r7, r0 @ unit 
bl IsUnitOnField 
cmp r0, #0 
beq RallyChaos_Loop 
mov r0, r7 @ unit 
ldr r1, =RallyChaosID_Link 
ldr r1, [r1] 
bl SkillTester 
cmp r0, #0 
beq RallyChaos_Loop 


mov r0, r7 @ unit 
mov r1, #0 @ can trade 
mov r2, #2 @ range 
bl GetUnitsInRange 
cmp r0, #0 
beq RallyChaos_Loop 
ldrb r1, [r0] 
cmp r1, #0 
beq RallyChaos_Loop @ next unit 

str r7, [r4, #0x3C] @ unit 

mov r0, r4 
mov r1, #2 @ label 
blh ProcGoto 


@bl StartBuffFx
@ now wait for rally before continuing the loop 
@bl RallyCommandEffect_NoneActive @ r0 = unit, r1 = rally bits 
@b RallyChaos_Loop 
str r5, [r4, #0x2C] @ where to continue our loop after the rally anim is done 
b Exit_RallyChaos 
Break_RallyChaos: 
mov r0, #1 @ destructor = true 
str r0, [r4, #0x30] 

Exit_RallyChaos: 

pop {r4-r7} 
pop {r0} 
bx r0
.ltorg 
.global RallyChaosExecute
.type RallyChaosExecute, %function 
RallyChaosExecute:
push {r4, lr} 
mov r4, r0 
mov r0, #8 
blh NextRN_N
mov r1, #1 
lsl r1, r0 @ some random rally bit to set  
ldr r0, [r4, #0x3C] @ unit 
bl RallyCommandEffect_NoneActive
pop {r4} 
pop {r0} 
bx r0 
.ltorg 




