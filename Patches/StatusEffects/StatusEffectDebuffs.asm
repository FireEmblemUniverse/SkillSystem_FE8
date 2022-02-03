.thumb

.macro blh to, reg=r3
	ldr \reg, =\to
	mov lr, \reg
	.short 0xF800
.endm

GetDebuffs = EALiterals+0x0

.global BurnStatus
.type BurnStatus, %function 

.global ParalyzeStatus
.type ParalyzeStatus, %function 

.global SleepStatus
.type SleepStatus, %function 

.global PoisonStatus
.type PoisonStatus, %function 

.global FreezeStatus
.type FreezeStatus, %function 

.type IsTargetTypeImmune, %function 
.global IsTargetTypeImmune
IsTargetTypeImmune:
push {r4-r6, lr}
mov r6, r0 @ Status type 
mov r4, r1 @ Atkr 
mov r5, r2 @ Dfdr 

ldr r0, =FireType
lsl r0, #8 
lsr r0, #8 
ldr r1, =BurnStatusID_Link 
ldr r1, [r1] 
cmp r6, r1 
beq TestTypeNow

ldr r0, =ElectricType
lsl r0, #8 
lsr r0, #8 
ldr r1, =ParalyzeStatusID_Link 
ldr r1, [r1] 
cmp r6, r1 
beq TestTypeNow

ldr r0, =PoisonType
lsl r0, #8 
lsr r0, #8 
ldr r1, =PoisonStatusID_Link 
ldr r1, [r1] 
cmp r6, r1 
beq TestTypeNow

ldr r0, =IceType
ldr r3, =FireType
orr r0, r3 @ Fire and Ice types as immune to freeze. 
lsl r3, #8 
lsr r3, #8 
ldr r1, =FreezeStatusID_Link 
ldr r1, [r1] 
cmp r6, r1 
beq TestTypeNow
b TypeImmuneFalse

TestTypeNow:
ldr r1, [r5, #4] @ Class pointer 
mov r2, #0x50 
ldr r1, [r1, r2] @ Effectiveness bitfield 
and r0, r1 @ does the target's typing match the status effect move type? 
cmp r0, #0 
beq TypeImmuneFalse 

mov r0, #1 
b EndTypeImmune 

TypeImmuneFalse:
mov r0, #0 

EndTypeImmune: 

pop {r4-r6}
pop {r3}
bx r3 
.ltorg
.align



BurnStatus:
push {r4-r5, lr}
mov r5, r0 @stat
mov r4, r1 @unit
cmp r0, #0 
blt End_TestBurn


mov r0,r4
ldr r1, =BurnStatusID_Link 
ldr r1, [r1] 
bl IsStatusApplicable 
cmp r0, #1 
bne End_TestBurn 
add r5, #1 
lsr r5, #1 @ halved stat 

End_TestBurn:
mov r0, r5
mov r1, r4
pop {r4-r5}
pop {r3}
bx r3 
.ltorg
.align

ParalyzeStatus:
push {r4-r5, lr}
mov r5, r0 @stat
mov r4, r1 @unit
cmp r0, #0 
blt End_TestParalyze
mov r0,r4
ldr r1, =ParalyzeStatusID_Link 
ldr r1, [r1] 
bl IsStatusApplicable 
cmp r0, #1 
bne End_TestParalyze
add r5, #1 
lsr r5, #1 @ halved stat 

End_TestParalyze:
mov r0, r5
mov r1, r4
pop {r4-r5}
pop {r3}
bx r3 
.ltorg
.align

SleepStatus:
push {r4-r5, lr}
mov r5, r0 @stat
mov r4, r1 @unit
cmp r0, #0 
blt End_TestSleep 
mov r0,r4
ldr r1, =SleepStatusID_Link 
ldr r1, [r1] 
bl IsStatusApplicable 
cmp r0, #1 
bne End_TestSleep 
add r5, #1 
lsr r5, #1 @ halved stat 

End_TestSleep:
mov r0, r5
mov r1, r4
pop {r4-r5}
pop {r3}
bx r3 
.ltorg
.align

PoisonStatus:
push {r4-r5, lr}
mov r5, r0 @stat
mov r4, r1 @unit
cmp r0, #0 
blt End_TestPoison
mov r0,r4
ldr r1, =PoisonStatusID_Link 
ldr r1, [r1] 
bl IsStatusApplicable 
cmp r0, #1 
bne End_TestPoison
add r5, #1 
lsr r5, #1 @ halved stat 

End_TestPoison:
mov r0, r5
mov r1, r4
pop {r4-r5}
pop {r3}
bx r3 
.ltorg
.align

FreezeStatus:
push {r4-r5, lr}
mov r5, r0 @stat
mov r4, r1 @unit
cmp r0, #0 
blt End_TestFreeze
mov r0,r4
ldr r1, =FreezeStatusID_Link 
ldr r1, [r1] 
bl IsStatusApplicable 
cmp r0, #1 
bne End_TestFreeze 
add r5, #1 
lsr r5, #1 @ halved stat 

End_TestFreeze:
mov r0, r5
mov r1, r4
pop {r4-r5}
pop {r3}
bx r3 
.ltorg
.align

.type IsStatusApplicable, %function 
.global IsStatusApplicable 

IsStatusApplicable:
push {lr} 
@ given r0 = unit struct 
@ r1 = required status type 
mov r2, #0x30 
ldrb r2, [r0, r2] @ Unit's status byte 
mov r3, #0xF0 
and r3, r2 @ Duration 
cmp r3, #0 
beq ReturnFalse 
mov r3, #0x0F @ Type of status 
and r3, r2 
cmp r3, r1 
bne ReturnFalse 
mov r0, #1 @ True 
b Return

ReturnFalse:
mov r0, #0 
Return:

pop {r1}
bx r1 

.ltorg
.align



