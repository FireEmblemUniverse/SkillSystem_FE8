.thumb
.equ DominateID, SkillTester+4
.equ GetUnit,0x8019430

push {r4-r7, lr}
ldr     r5,=0x203a4ec @attacker
cmp     r0,r5
bne     End
mov r4, r0 @atkr
mov r5, r1 @dfdr

@not at stat screen
ldr r1, [r5,#4] @class data ptr
cmp r1, #0 @if 0, this is stat screen
beq End

@not broken movement map
ldr r0,=0x203a968
ldrb r0,[r0]
cmp r0,#0x80
bge End

@has Charge
ldr r0, SkillTester
mov lr, r0
mov r0, r4 @Attacker data
ldr r1, DominateID
.short 0xf800
cmp r0, #0
beq End

@Add damage

@How we get damage to add depends on allegiance of the unit

mov r0,r4 @attacker
ldrb r0,[r0,#0xB] @allegiance byte
lsr r0,#6 @just the allegiance
cmp r0,#0
bne AltMovementCheck
@fast, but only works for player units
ldr r3,=0x203a968 @Spaces Moved
ldrb r2,[r3]
b FinishCharge


AltMovementCheck:
@we need trigonometry to get our movement distance since we can't use spaces moved
@this only works assuming straight lines but not many reasonable other options
ldr r6,=#0x202BE48 @active unit position (has starting coords)
@sqrt( (x2-x1)^2 + (y2-y1)^2 )
@sqrt can be done with swi 8

ldrb r0,[r4,#0x10] @x1
ldrh r1,[r6] @x2
sub r1,r0 @x2-x1
mul r1,r1 @^2
mov r2,r1
ldrb r0,[r4,#0x11] @y1
ldrh r1,[r6,#0x2] @y2
sub r1,r0 @y2-y1
mul r1,r1 @^2
add r0,r1,r2 @(x2-x1)^2 + (y2-y1)^2
swi 8 @sqrt
mov r2,r0 @for consistency in finishing

FinishCharge:
lsr r2,#0x1
mov r1, #0x5A
ldrh r0, [r4, r1]
add r0, r2
strh r0, [r4,r1]

End:
pop {r4-r7, r15}
.align
.ltorg
SkillTester:
@Poin SkillTester
@WORD DominateID
