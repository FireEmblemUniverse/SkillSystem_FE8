.thumb
.align

.equ DefiantSkillID,SkillTester+4

.macro blh to, reg=r3
	ldr \reg, =\to
	mov lr, \reg
	.short 0xF800
.endm

@goes in stat getters

push {r4-r6, lr}
mov r4, r0 @stat
mov r5, r1 @unit

ldrb r0,[r5,#0x12]
ldrb r1,[r5,#0x13]
lsl r1,r1,#2
cmp r1,r0
bgt GoBack

ldr r0, SkillTester
mov lr, r0
mov r0, r5
ldr r1, DefiantSkillID
.short 0xf800
cmp r0, #0
beq GoBack

mov r0,r4
add r0,#4
mov r4,r0 


GoBack:
mov r0, r4
mov r1, r5
pop {r4-r6,pc}


.ltorg
.align

SkillTester:
@POIN SkillTester
@WORD DefiantSkillID
