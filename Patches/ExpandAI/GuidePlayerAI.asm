.thumb
.macro blh to, reg=r3
  ldr \reg, =\to
  mov lr, \reg
  .short 0xf800
.endm

	.equ GetUnitByEventParameter, 0x0800BC50
	.equ CurrentUnit, 0x3004E50
	.equ AiTryMoveTowards, 0x803BA08 
	
@ if within 10 tiles of party leader, attack if able or move towards coord XXYY if not able to 
@ if farther than that, move towards party leader 
.type GuidePlayerAIFunc, %function 
.global GuidePlayerAIFunc

GuidePlayerAIFunc:
push {r4-r5, lr}




mov r0, #0 @ Party leader 
blh GetUnitByEventParameter
cmp r0, #0 
beq ReorderListAndTryAgain
ldr r1, [r0, #0xC]
mov r2, #0xC @ Undeployed/dead 
and r1, r2 
cmp r1, #0 
bne ReorderListAndTryAgain @ if the party leader has retreated/died
b FoundLeader



ReorderListAndTryAgain:
blh 0x080956d8 @ReorderPlayerUnitsBasedOnDeployment
mov r0, #0
blh GetUnitByEventParameter
cmp r0, #0 
beq Error
ldr r1, [r0, #0xC]
mov r2, #0xC @ Undeployed/dead 
and r1, r2 
cmp r1, #0 
bne Error 
b FoundLeader

FoundLeader:

mov r4, r0 
ldr r5, =CurrentUnit 
ldr r5, [r5] 
cmp r5, #0 
beq Error 
ldrb r0, [r4, #0x10]
ldrb r1, [r4, #0x11]
ldrb r2, [r5, #0x10]
ldrb r3, [r5, #0x11]
sub   r0, r2 @ X difference 
sub   r1, r3 @ Y difference 

@ Take coordinates'
@ absolute values.				
asr r3, r0, #31
add r0, r0, r3
eor r0, r3

asr r3, r1, #31
add r1, r1, r3
eor r1, r3

add r0, r1 
cmp r0, #10 
bge MoveTowardsLeader 

@ldr r3, =0x30017CC
@mov r2, #0 
@str r2, [r3] @ We are ai1 
@mov r11, r11 
@ldr r3, =0x30017D0 
@ldr r2, =0x85a91e4 @ POIN gAiScript1 
@ldr r2, [r2] @ POIN AiScript1FirstEntry 
@ldr r2, [r2] @ 
@str r2, [r3] 


bl AnyTargetWithinRange 
cmp r0, #1 
bne MoveTowardsTarget
bl Call_AiScriptCmd_05_DoStandardAction
b True 

MoveTowardsLeader:

ldrb r0, [r4, #0x10] @ Leader's XX 
ldrb r1, [r4, #0x11] @ Leader's YY 
b MoveTowardsCoords

MoveTowardsTarget:

@ r0 = XX 
@ r1 = YY 
mov r0, #6
mov r1, #10 @ VF north sign 

MoveTowardsCoords:
sub sp, #8 
@ r0 = XX 
@ r1 = YY 
@ r2 = 0
mov r2, #0 
str r2, [sp, #4] @ Dunno if even used 
mov r3, #1 
str r3, [sp] @ 1 
ldr r3, =0x30017D0
ldrb r3, [r3, #2] @ dunno 

blh AiTryMoveTowards, r4 
add sp, #8 

b True 





True:
mov r0, #1 

Error: @ r0 as 0 if jumped here 

pop {r4-r5}
pop {r1}
bx r1 
.ltorg 
.align 




