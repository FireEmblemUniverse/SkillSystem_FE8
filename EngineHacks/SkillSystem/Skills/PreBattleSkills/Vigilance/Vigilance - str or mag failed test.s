.align 4
.macro blh to, reg=r3
  ldr \reg, =\to
  mov lr, \reg
  .short 0xf800
.endm
	.thumb

.equ VigilanceID,SkillTester+4
	.equ MemorySlot, 0x30004B8 

push {r4-r7,lr}
@goes in the battle loop.
@r0 is the attacker
@r1 is the defender
mov r4, r0
mov r5, r1

ldr r0, SkillTester
mov lr, r0
mov r0, r4
ldr r1, VigilanceID
.short 0xf800
cmp r0, #0
beq GoBack

ldr r2, =MemorySlot @[0x30004C4]!!?
str r0, [r2, #4*0x03]

mov r0, r4
add r0,#0x4C
ldrb r3,[r0]
mov r2, #0x42 
orr r3, r2, r3 
strb r3,[r0]

GoBack:
pop {r4-r7}
pop {r0}
bx r0
.align
.ltorg

SkillTester:
@POIN SkillTester
@WORD VigilanceID
@.ltorg 
