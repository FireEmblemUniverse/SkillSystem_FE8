.thumb
.align 4

.equ ActiveChar,0x3004E50
.equ SkillID,SkillTester+4

@push {r14}

@char struct is in r4, item halfword is in r5; lsr by 8 to get just uses

@checks go here, ReturnFalse if checks fail, do nothing if checks succeed

mov r0,r4
ldr r0,[r0]
ldrb r0,[r0,#4]

ldrb r1,SkillID

ldr 	r3, SkillTester @r0 = char ID, r1 = skill ID; returns true/false in r0
mov 	lr, r3
.short 	0xF800
cmp r0,#1
beq ReturnFalse

mov r0,#1
b GoBack

ReturnFalse:
mov r0,#0

GoBack:
pop {r4,r5}
pop {r1}
bx r1

.ltorg
.align 4

SkillTester:
@POIN SkillTester
@WORD SkillID
