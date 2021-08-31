.align 4
.thumb
.macro blh to, reg=r3
  ldr \reg, =\to
  mov lr, \reg
  .short 0xf800
.endm

	.equ MemorySlot, 0x30004B8
	.equ AIScript12_Move_Towards_Enemy, 0x803ce18 
	.equ AiSetDecision, 0x8039C21 
	.equ CurrentUnit, 0x3004E50
	.equ EventEngine, 0x800D07C

.global TrainerSummonTeamAIFunc
.type TrainerSummonTeamAIFunc, %function 

TrainerSummonTeamAIFunc:
push {r4-r6, lr} 
mov r6, #1 @ Yes we move 
b TrainerSummonTeamStart 

.global StationaryTrainerSummonTeamAIFunc
.type StationaryTrainerSummonTeamAIFunc, %function 

StationaryTrainerSummonTeamAIFunc:
push {r4-r6, lr} 
mov r6, #0 @ Do not move 
b TrainerSummonTeamStart


TrainerSummonTeamStart:





@mov r11, r11 

blh ShouldTrainerSummonTeam 
cmp r0, #0 
beq DontSummonStuff


bl AnyTargetWithinRange
cmp r0, #0 
beq DontSummonStuff 
b SummonStuff 

@ Don't summon anything 
DontSummonStuff:
ldr r3, =CurrentUnit
ldr r3, [r3] 
ldrb r0, [r3, #0x10] 
ldrb r1, [r3, #0x11] 
mov r2, #0 @ Wait 
bl SetAIToWaitAtCoords 
b ReturnTrue 

SummonStuff: 

ldr r3, =CurrentUnit 
ldr r3, [r3] 
mov r0, #0
mov r1, #0x1E @ Weapon  
strh r0, [r3, r1]


cmp r6, #1
beq MoveTowardsEnemyNow
@ Do not move 
ldrb r0, [r3, #0x10] 
ldrb r1, [r3, #0x11] 
b SetMovementDecision

MoveTowardsEnemyNow:
mov r0, r3 
add r0, #0x45 

blh AIScript12_Move_Towards_Enemy @0x803ce18 
ldr r3, =0x203AA96 @ AI decision +0x92 (XX) 
ldrb r0, [r3, #0x0] @ XX 
ldrb r1, [r3, #0x1] @ YY 

SetMovementDecision:
mov r2, #5 @ Wait 
bl SetAIToWaitAtCoords 


ldr r3, =0x203AA96 @ AI decision +0x92 (XX) 
ldrb r0, [r3, #0x0] @ XX 
ldrb r1, [r3, #0x1] @ YY 
ldr r3, =MemorySlot
add r3, #4*0x0B @ Slot B 
strh r0, [r3, #0] 
strh r1, [r3, #2] 
bl CallWaitUntilAIMovesProc


ReturnTrue: 
mov r0, #1 @ True that we made an AI decision 

ExitTrainerSummonAI:
pop {r4-r6}
pop {r1} 
bx r1 

.global TrainerSpotsYouFunction
.type TrainerSpotsYouFunction, %function 

TrainerSpotsYouFunction:
push {r4-r7, lr}


ldr r3, =CurrentUnit
ldr r3, [r3] 




ldr r0, =TrainerSpotsYouEvent 
mov r1, #1 
blh EventEngine 

pop {r4-r7}
pop {r1}
bx r1 


