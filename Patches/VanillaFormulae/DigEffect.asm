.thumb
.macro blh to, reg=r3
  ldr \reg, =\to
  mov lr, \reg
  .short 0xf800
.endm
	.equ CurrentUnit, 0x3004E50
	.equ MemorySlot, 0x30004B8
.global DigEffect
.type   DigEffect, function

DigEffect:	@Make
push {r4-r7, lr} 

ldr r4, =0x203A4EC 
ldr r5, =0x203A56C
ldr r6, =0x203A958 
@r4 = attacker, r5 = defender, r6 = action struct 

ldr r7, =CurrentUnit
ldr r7, [r7] 

ldrb r0, [r6, #0x11] 
cmp r0, #2 
bne Exit @ only do stuff if attacked this turn 
mov r0, r4 
add r0, #0x4A @ weapon 
ldrb r0, [r0] 
ldr r6, =DigItemList
sub r6, #1 
Loop:
add r6, #1 
ldrb r1, [r6] 
cmp r1, #0 
beq Exit 
cmp r0, r1 
bne Loop 
@ it was equal, so now we teleport the unit 

@ check that we are at least 1 tile away, as no reason to teleport if we aren't farther away 

ldrh r0, [r4, #0x10] @ XXYY 
push {r0} 
ldrh r0, [r5, #0x10] 
strh r0, [r4, #0x10] 

mov r0, r4 @ Unit to place 
ldr r1, =MemorySlot 
add r1, #4*0x0A @ XX in sA
add r2, r1, #4 @ YY in sB 
ldr r3, =0xFFFFFFFF @ (-1) as failed value 
str r3, [r1]
str r3, [r2] 
bl FindFreeTile @FindFreeTile(struct Unit *unit, int* xOut, int* yOut)

ldr r3, =MemorySlot 
add r3, #4*0x0A @ sA 
ldr r1, [r3] @ X
ldr r2, [r3, #4] @ Y 
pop {r0} @ original coords 

lsr r3, r1, #8 
cmp r3, #0 @ if we failed to find a proper place for the called unit, put them at -1x, 0y 
beq Store


strh r0, [r6, #0x10] @ store original coords back if failed 

b Next

Store: 
strb r1, [r4, #0x10] @ X
strb r2, [r4, #0x11] @ Y
strb r1, [r7, #0x10]
strb r2, [r7, #0x11]

Next: 

Exit: 

pop {r4-r7} 
pop {r0} 
bx r0 
.ltorg 


