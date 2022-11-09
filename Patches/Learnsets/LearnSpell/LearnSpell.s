.thumb
.align

.macro blh to, reg=r3
    ldr \reg, =\to
    mov lr, \reg
    .short 0xF800
.endm

.equ ActiveChar,0x3004E50

.global LearnNewSpell
.type LearnNewSpell, %function 

@ r0 = ram unit 
@ r1 = spell to learn 

LearnNewSpell: 
push {r4-r5,lr}
mov r4, r0 
mov r5, r1 


mov r2, #0x27 
CheckIfAlreadyLearnedLoop:
add r2, #1 
cmp r2, #0x2D 
bge Continue 
ldrb r0, [r4, r2] 
cmp r0, r5 
beq False 
b CheckIfAlreadyLearnedLoop 

Continue: 
mov r2, #0x27 

FindEmptyWEXPLoop:
add r2, #1 
cmp r2, #0x2D @ We use first 5 ranks only 
bge SetForForgetting 
ldrb r0, [r4, r2]
cmp r0, #0 
bne FindEmptyWEXPLoop 

@ should probably prevent them from learning a spell they already know here 
@ oh well lol 


strb r5, [r4, r2] 
b True 

SetForForgetting:
@ r1 = (0x8000 | Skill Index) (top bit set to denote it is indeed a skill to be learned)
mov  r1, #0x80
lsl  r1, #8
orr  r1, r5

mov r1, r5

@ store
ldr  r0, =0x0202BCDE @ pExtraItemOrSkill, used by vanilla for when it tries to send an item to convoy
@strh r1, [r0]

b False 

True:

@blh  0x08019c3c   @UpdateGameTilesGraphics

mov r0, #1
b End

False: @ No spell learned 
mov r0, #0



End:
mov r1, r4 @ Ram unit 
mov r2, r5 @ Spell to learn 
pop {r4-r5}
pop {r3}
bx r3


.ltorg 

