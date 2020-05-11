.thumb
.align

@8 byte hook @ B5240
@r5 = unit struct
@r4 = current item price

.equ UnitHasItem,0x80179F9
.equ BargainID,SkillTester+4
.equ SilverCardList,BargainID+4
.equ DoesBargainStack,SilverCardList+4

.macro blh to, reg
    ldr \reg, =\to
    mov lr, \reg
    .short 0xF800
.endm

@while we're at it, let's let you make a bunch of silver cards

push {r6-r7}

ldr r0, SkillTester
mov lr, r0
mov r0, r5
ldr r1, BargainID
.short 0xf800
cmp r0, #0
beq SilverCardCheck
lsr r4,#1 @halve price of item
ldr r0, DoesBargainStack
cmp r0,#1
bne GoBack

SilverCardCheck:
ldr r6,SilverCardList
LoopStart:
mov r0,r5
ldrb r1,[r6]
cmp r1,#0
beq GoBack
blh UnitHasItem,r7
cmp r0,#1
beq LoopEnd
add r6,#1
b LoopStart
LoopEnd:
lsr r4,#1 @halve price of item


GoBack:
mov r0,r4

pop {r6-r7}
pop {r4-r5}
pop {r1}
bx r1

.ltorg
.align
SkillTester:
@POIN SkillTester
@WORD BargainID
@POIN SilverCardList
@WORD DoesBargainStack
