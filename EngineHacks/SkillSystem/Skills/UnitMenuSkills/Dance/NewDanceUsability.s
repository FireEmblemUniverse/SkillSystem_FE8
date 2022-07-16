.thumb
.align

.equ DanceID,SkillTester+4
.equ AlsoUseVanillaCheck,DanceID+4

.equ gActiveUnit,0x3004E50
.equ gGameState,0x202BCB0
.equ GetDancerTargetResult,0x80230F1

.macro blh to, reg=r3
	ldr \reg, =\to
	mov lr, \reg
	.short 0xF800
.endm

@old at 8023194

push {r4,r14}
mov r3,r0


ldr r0,=gActiveUnit
ldr r0,[r0]

ldr r1, SkillTester
mov lr, r1
ldr r1, DanceID
.short 0xf800
cmp r0, #1
beq CheckTargetList

ldr r1,AlsoUseVanillaCheck
cmp r1,#0
beq ReturnFalse

@vanilla dancer bit check
ldr r0,=gActiveUnit
ldr r0,[r0]

ldr r1,[r0]
ldr r2,[r0,#4]
ldr r0,[r1,#0x28]
ldr r1,[r2,#0x28]
orr r0,r1
mov r1,#0x10
and r0,r1
cmp r0,#0
beq ReturnFalse

CheckTargetList:
ldr r1,=gGameState
mov r0,#0xA5
strh r0,[r1,#0x2C]
mov r0,r3
blh GetDancerTargetResult,r4 
b GoBack

ReturnFalse:
mov r0,#3

GoBack:
pop {r4}
pop {r1}
bx r1 


.ltorg
.align

SkillTester:
@POIN SkillTester
@WORD DanceID
@WORD AlsoUseVanillaCheck
