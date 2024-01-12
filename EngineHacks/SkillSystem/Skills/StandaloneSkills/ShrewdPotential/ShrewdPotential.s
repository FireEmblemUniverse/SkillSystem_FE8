.thumb 

@ org 0x2F840 

@ r0 = table of stat boosts to add to stats 
@ r4 = unit 

@ 0x802F890 as return address 
.equ Return, 0x802F891
.global ShrewdPotential 
.type ShrewdPotential, %function  
ShrewdPotential: 
push {r5, lr} 
mov r5, r0 @ table of stat boosts to add to stats 

mov r0, r4 @ unit 
ldr r1, =ShrewdPotentialID_Link 
ldr r1, [r1] 
bl SkillTester 
mov r1, r5 @ table of stat boosts 
mov r5, #0 
cmp r0, #0 
beq NoBoost 
ldr r5, =ShrewdPotentialAmount_Link 
ldr r5, [r5] 
NoBoost: 
mov r0, r1 @ table of stat boosts 

LDRB r1, [r0, #0x0]
cmp r1, #0 
beq NoAdd_1
add r1, r5
NoAdd_1: 

LDRB r2, [r4, #0x12]
ADD r1 ,r1, R2
STRB r1, [r4, #0x12]
LDRB r1, [r0, #0x0]
cmp r1, #0 
beq NoAdd_2
add r1, r5
NoAdd_2: 
LDRB r2, [r4, #0x13]
ADD r1 ,r1, R2
STRB r1, [r4, #0x13]
LDRB r1, [r0, #0x1]
cmp r1, #0 
beq NoAdd_3
add r1, r5
NoAdd_3: 
LDRB r2, [r4, #0x14]
ADD r1 ,r1, R2
STRB r1, [r4, #0x14]
LDRB r1, [r0, #0x2]
cmp r1, #0 
beq NoAdd_4
add r1, r5
NoAdd_4: 
LDRB r2, [r4, #0x15]
ADD r1 ,r1, R2
STRB r1, [r4, #0x15]
LDRB r1, [r0, #0x3]
cmp r1, #0 
beq NoAdd_5
add r1, r5
NoAdd_5: 
LDRB r2, [r4, #0x16]
ADD r1 ,r1, R2
STRB r1, [r4, #0x16]
LDRB r1, [r0, #0x4]
cmp r1, #0 
beq NoAdd_6
add r1, r5
NoAdd_6: 
LDRB r2, [r4, #0x17]
ADD r1 ,r1, R2
STRB r1, [r4, #0x17]
LDRB r1, [r0, #0x5]
cmp r1, #0 
beq NoAdd_7
add r1, r5
NoAdd_7: 
LDRB r2, [r4, #0x18]
ADD r1 ,r1, R2
STRB r1, [r4, #0x18]
LDRB r1, [r0, #0x6]
cmp r1, #0 
beq NoAdd_8
add r1, r5
NoAdd_8: 
LDRB r2, [r4, #0x19]
ADD r1 ,r1, R2
STRB r1, [r4, #0x19]
LDRB r1, [r0, #0x7]
cmp r1, #0 
beq NoAdd_9
add r1, r5
NoAdd_9: 
LDRB r2, [r4, #0x1D]

@ MagStatBoosterIncrementer.s 
add		r1,r1,r2
strb	r1,[r4,#0x1D]
ldrb	r2,[r0,#0x8]

ldrb	r1,[r4,#0x1A]
add		r2,r2,r1
strb	r2,[r4,#0x1A]
mov		r1,r4
add		r1,#0x3A
ldrb	r2,[r1]
ldrb	r3,[r0,#0x9]		@mag bonus
cmp r3, #0 
beq NoAdd_10
add r3, r5
NoAdd_10: 
add		r2,r2,r3
strb	r2,[r1]
mov		r0,r4
pop {r5} 
pop {r3} 
ldr r3, =Return 
bx r3 
.ltorg 



