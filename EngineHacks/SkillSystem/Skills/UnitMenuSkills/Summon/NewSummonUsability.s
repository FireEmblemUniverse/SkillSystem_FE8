.thumb
.align

.equ SummonID,SkillTester+4
.equ AlsoUseVanillaCheck,SummonID+4

.equ gActiveUnit,0x3004E50
.equ ListSummonTargets,0x8025CA5
.equ GetTargetListSize,0x804FD29
.equ GetUnit,0x8019431

.macro blh to, reg=r3
	ldr \reg, =\to
	mov lr, \reg
	.short 0xF800
.endm

@old at 80243D8

push {r4-r6,r14}
ldr r5,=gActiveUnit
ldr r2,[r5]


ldr r0, SkillTester
mov lr, r0
mov r0, r2
ldr r1, SummonID
.short  0xf800
cmp r0, #1
beq CantoCheck

ldr r1,AlsoUseVanillaCheck
cmp r1,#0
beq ReturnFalse


@vanilla summon flag check
ldr r5,=gActiveUnit
ldr r2,[r5]

ldr r0,[r2]
ldr r1,[r2,#4]
ldr r0,[r0,#0x28]
ldr r1,[r1,#0x28]
orr r0,r1
mov r1,#0x80
lsl r1,r1,#20
and r0,r1
cmp r0,#0
beq ReturnFalse


CantoCheck:
ldr r0,[r2,#0xC]
mov r1,#0x40
and r0,r1
cmp r0,#0
bne ReturnFalse

@target list check
mov r0,r2
blh ListSummonTargets,r6
blh GetTargetListSize,r6
cmp r0,#0
beq ReturnFalse

@summon char ID config check
ldr r4,=0xFFFF
mov r2,#0
ldr r0,[r5]
ldr r0,[r0]
ldr r1,=0x0802442C
ldr r1,[r1]   @Get SummonTable
ldrb r0,[r0,#4]
mov r3,r1
ldrb r1,[r3]
cmp r0,r1
bne LoopStart
mov r4,#0
b PostLoop

ReturnFalse:
mov r0,#3
b GoBack

.ltorg

AltRetTrueCondition:
@ldr r0,=0xFFFEFFF3
@and r1,r0
@str r1,[r2,#0xC]
b ReturnTrue

LoopStart:
add r2,#1
cmp r2,#2
bhi PostLoop

ldr r0,=gActiveUnit
ldr r0,[r0]
ldr r1,[r0]
lsl r0,r2,#1
add r0,r3
ldrb r1,[r1,#4]
ldrb r0,[r0]
cmp r1,r0
bne LoopStart
mov r4,r2

PostLoop:
mov r1,r4
mov r0,#1
neg r0,r0
cmp r1,r0
bne ExistingPhantomCheck
b ReturnFalse

.ltorg

ExistingPhantomCheck:
mov r4,#1
lsl r1,#1
ldr r0,=0x0802442C
ldr r0,[r0]   @Get SummonTable
add r0,#0x1   @SummonTable+1
add r5,r1,r0
GetSummonUnit:
mov r0,r4
blh GetUnit,r6
mov r2,r0
cmp r2,#0
beq CheckNextUnit

ldr r0,[r2]
cmp r0,#0
beq CheckNextUnit

ldrb r0,[r0,#4]
ldrb r1,[r5]
cmp r0,r1
bne CheckNextUnit
ldr r1,[r2,#0xC]
ldr r0,=0x1000C
and r0,r1
cmp r0,#0
bne AltRetTrueCondition
b ReturnFalse

.ltorg

CheckNextUnit:
add r4,#1
cmp r4,#0xAF @ For compatibility with Pikmin's npc/enemy summons hack
ble GetSummonUnit

ReturnTrue:
mov r0,#1

GoBack:
pop {r4-r6}
pop {r1}
bx r1

.ltorg
.align

SkillTester:
@POIN SkillTester
@WORD SummonID
@WORD AlsoUseVanillaCheck
