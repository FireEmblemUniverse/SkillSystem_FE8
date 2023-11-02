.thumb
.align
.macro blh to, reg=r3
  ldr \reg, =\to
  mov lr, \reg
  .short 0xf800
.endm

.equ SetEventId, 0x8083d80 
.equ UnsetEventId, 0x8083D94
.equ GetUnit, 0x8019430
.equ CheckEventId,0x8083da8
	
.global IsPeaceful
.type IsPeaceful, %function 
IsPeaceful:
push {r4-r5, lr}

ldr r5, =0x401000C
@ check for if peaceful map 

@ check for at least one valid enemy eg. unit ID that is not 0xE0 - 0xEF 
mov r4,#0x7F @ current deployment id
@mov r11, r11 
LoopThroughUnits:
add r4, #1 
cmp r4, #0xC0 
bge IsPeaceful_True
mov r0,r4
blh GetUnit @ 19430
cmp r0, #0
beq LoopThroughUnits
ldr r1, [r0]
cmp r1, #0 
beq LoopThroughUnits
ldr r1, [r0, #0x0C]
tst r1, r5 @ dead/undeployed 
bne LoopThroughUnits
ldr r1, [r0] @ char pointer 
ldrb r1, [r1, #4] @ char id 
cmp r1, #0xE0 
blt ValidEnemy
cmp r1, #0xEF 
bgt ValidEnemy
b LoopThroughUnits
ValidEnemy:
NotPeaceful:
mov r0, #0 
b Exit 

IsPeaceful_True:
mov r0, #1

Exit:

pop {r4-r5}
pop {r1}
bx r1

.ltorg 
.align 

.global AreAllPlayersSafe
.type AreAllPlayersSafe, %function 
AreAllPlayersSafe:
push {r4-r6, lr}
@ check if any unit is in danger 

@ldr r0, =AttackedThisTurnFlag @ Flag that prevents call 
@lsl r0, #24 
@lsr r0, #24 
@blh CheckEventId
@cmp r0, #0 
@bne InDanger
@
ldr r0, =CallCountdownFlag @ Flag that prevents call 
lsl r0, #24 
lsr r0, #24 
blh CheckEventId
cmp r0, #0 
bne InDanger

ldr r0, =PlayableCutsceneFlag @ Flag that prevents call 
lsl r0, #24 
lsr r0, #24 
blh CheckEventId
cmp r0, #0 
bne InDanger

ldr r0, =TrainerBattleActiveFlag @ Flag that prevents call 
lsl r0, #24 
lsr r0, #24 
blh CheckEventId
cmp r0, #0 
bne InDanger

ldr		r5,=0x202E4E8 @ fog
ldr		r5,[r5]	
ldr r6, =0x401000C

@ check for at least one valid enemy eg. unit ID that is not 0xE0 - 0xEF 
mov r4,#0x0 @ current deployment id
@mov r11, r11 
Loop:
add r4, #1 
cmp r4, #0x40
bge IsSafe
mov r0,r4
blh GetUnit @ 19430
cmp r0, #0
beq Loop
ldr r1, [r0]
cmp r1, #0 
beq Loop
ldr r1, [r0, #0x0C]
tst r1, r6 @ dead/undeployed 
bne Loop

ldrb r1, [r0, #0x11] @ y 
ldrb r0, [r0, #0x10] @ x 
mov 	r2, r5 
lsl		r1,#0x2			
add		r2,r1			
ldr		r2,[r2]			
add		r2,r0			
ldrb	r0,[r2]	
cmp r0, #0 
bne InDanger 

b Loop
InDanger:
mov r0, #0 
b End

IsSafe:
mov r0, #1

End:

pop {r4-r6}
pop {r1}
bx r1
.ltorg 



.global AreAllPlayersSafeToStartFMU
.type AreAllPlayersSafeToStartFMU, %function 
AreAllPlayersSafeToStartFMU:
push {r4-r6, lr}
@ check if any unit is in danger 

@ldr r0, =AttackedThisTurnFlag @ Flag that prevents call 
@lsl r0, #24 
@lsr r0, #24 
@blh CheckEventId
@cmp r0, #0 
@bne InDanger
@

ldr r0, =PlayableCutsceneFlag @ Flag that prevents call 
lsl r0, #24 
lsr r0, #24 
blh CheckEventId
cmp r0, #0 
bne InDanger2

ldr r0, =TrainerBattleActiveFlag @ Flag that prevents call 
lsl r0, #24 
lsr r0, #24 
blh CheckEventId
cmp r0, #0 
bne InDanger2

ldr		r5,=0x202E4E8 @ fog
ldr		r5,[r5]	
ldr r6, =0x401000C

@ check for at least one valid enemy eg. unit ID that is not 0xE0 - 0xEF 
mov r4,#0x0 @ current deployment id
@mov r11, r11 
Loop2:
add r4, #1 
cmp r4, #0x40
bge IsSafe2
mov r0,r4
blh GetUnit @ 19430
cmp r0, #0
beq Loop2
ldr r1, [r0]
cmp r1, #0 
beq Loop2
ldr r1, [r0, #0x0C]
tst r1, r6 @ dead/undeployed 
bne Loop2

ldrb r1, [r0, #0x11] @ y 
ldrb r0, [r0, #0x10] @ x 
mov 	r2, r5 
lsl		r1,#0x2			
add		r2,r1			
ldr		r2,[r2]			
add		r2,r0			
ldrb	r0,[r2]	
cmp r0, #0 
bne InDanger2 

b Loop2
InDanger2:
mov r0, #0 
b End2

IsSafe2:
mov r0, #1

End2:

pop {r4-r6}
pop {r1}
bx r1
.ltorg 


.global TurnOffBGMFlagIfPeaceful
.type TurnOffBGMFlagIfPeaceful, %function 
TurnOffBGMFlagIfPeaceful: 
push {lr} 

ldr r3, =0x202BCF0
ldrb r0, [r3, #0x0F] 
cmp r0, #0 
bne DoNothing @ non-player phase has no fog, so do nothing 

bl AreAllPlayersSafeToStartFMU
cmp r0, #0 
beq DoNothing 
ldr r0, =AltBGMFlag
lsl r0, #16 
lsr r0, #16 
blh UnsetEventId 

DoNothing: 
pop {r0} 
bx r0 
.ltorg 

.global TurnOnBGMFlag
.type TurnOnBGMFlag, %function 
TurnOnBGMFlag: 
push {lr} 
ldr r0, =AltBGMFlag
lsl r0, #16 
lsr r0, #16 
blh SetEventId 
pop {r0} 
bx r0 
.ltorg 






