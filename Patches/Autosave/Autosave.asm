.macro blh to, reg=r3
  ldr \reg, =\to
  mov lr, \reg
  .short 0xf800
.endm
.thumb 
.equ AutosaveNobodyDiedWithinTurns, QuicksaveToggleFlag+4
	.equ CheckEventId,0x8083da8
@ function based on $154F4 
.global AutosaveFunc
.type AutosaveFunc, %function 
AutosaveFunc: 




push {r4, lr} 
ldr r0, =0x202BCF0 
ldrb r0, [r0, #0xF] 
cmp r0, #0 
bne Exit 

bl CountDeployedPlayerUnits 
ldr r2, CurrentPartySize_Link 
ldrb r4, [r2] 
mov r3, #0x3F 
and r3, r4 
cmp r3, r0 
beq Continue @ save game if number is the same 

ldr r1, AutosaveNobodyDiedWithinTurns @ turns til save again 
mov r3, #0xC0 
and r3, r4 
cmp r3, r1 
beq UpdateNumberAlive 
lsr r3, r4, #6 @ top 3 bits 
add r3, #1 
lsl r3, #6 @ top 3 bits 
mov r1, #0x3F 
and r1, r4 
orr r1, r3 
strb r1, [r2] @ didn't update number alive, but incremented counter 
b Exit 

UpdateNumberAlive: 
strb r0, [r2] @ number alive is updated 
@ and autosave now 
@b Exit
@ 6 -> 0x86 -> 0x46 -> 0x5 
@ turn we die: set to 0x46 
@ next turn: to 0x86 
@ final turn: if & 0x80, set to 0x5 



Continue: 
strb r0, [r2]
ldr r0, QuicksaveToggleFlag 
cmp r0, #0 
beq Skip 
blh CheckEventId 
cmp r0, #0 
bne Exit 
Skip: 
ldr r1, =0x203A958 
mov r0, #9 
strb r0, [r1, #0x16] 
mov r0, #3 
blh 0x80A5A48 @SaveSuspendedGame

Exit: 
pop {r4} 
pop {r0} 
bx r0 
.ltorg 

	.equ GetUnit, 0x8019430
CountDeployedPlayerUnits: 
	push {r4-r6, lr}	

mov r4,#1 @ deployment id
mov r5,#0 @ counter

mov r6, #50 @50th deployed valid unit - we don't count past this 

LoopThroughUnits:
mov r0,r4
blh GetUnit @ 19430
cmp r0,#0
beq NextUnit
ldr r3,[r0]
cmp r3,#0
beq NextUnit
ldr r1,[r0,#0xC] @ condition word
ldr r2, =#0x401000C @ escaped, benched/dead
tst r1,r2
bne NextUnit
@ if you got here, unit exists and is not dead or undeployed, so go ham

add r5,#1
cmp r5,r6
bge End_LoopThroughUnits
NextUnit:
add r4,#1
cmp r4,#0x3F
ble LoopThroughUnits
End_LoopThroughUnits:
mov r0, r5 
pop {r4-r6}
pop {r1}
bx r1

.ltorg
.equ QuicksaveToggleFlag, CurrentPartySize_Link+4 
.align 
CurrentPartySize_Link: 















