.thumb
.align

@old at 8023F64

.equ SupplyID,SkillTester+4
.equ AlsoUseVanillaCheck,SupplyID+4
.equ HasConvoyAccess,0x803161D
.equ CheckSomethingSupplyRelated,0x8023EF1

.equ gActiveUnit,0x3004E50

.macro blh to, reg=r3
	ldr \reg, =\to
	mov lr, \reg
	.short 0xF800
.endm

push {r4,r14}
ldr r0, SkillTester
mov lr, r0
ldr r1, =gActiveUnit
ldr r0, [r1]
ldr r1, SupplyID
.short  0xf800
cmp r0, #1
beq ActiveUnitCheck

ldr r1,AlsoUseVanillaCheck
cmp r1,#0
beq ReturnFalse

@vanilla has convoy access call
blh HasConvoyAccess,r4
cmp r0,#0
@beq ReturnFalse @there's a fix that nops out this line in the original function

ActiveUnitCheck:
ldr r1,=gActiveUnit
ldr r0,[r1]
ldr r0,[r0,#4]
ldrb r0,[r0,#4]
cmp r0,#0x51
beq ReturnFalse

ldr r0,=gChapterData
ldrb r0,[r0,#0x1B]
cmp r0,#2
beq Point1
cmp r0,#3
beq Point2

Point1:
mov r2,#1
b Point3

Point2:
mov r2,#0xF

Point3:
ldr r0,[r1]
ldr r0,[r0]
ldrb r0,[r0,#4]
cmp r0,r2
beq ReturnTrue
mov r0,r2
blh CheckSomethingSupplyRelated,r4
cmp r0,#0
bne ReturnTrue
b GoBack

ReturnFalse:
mov r0,#3
b GoBack

ReturnTrue:
mov r0,#1

GoBack:
pop {r4}
pop {r1}
bx r1


.ltorg
.align

SkillTester:
@POIN SkillTester
@WORD SupplyID
@WORD AlsoUseVanillaCheck

