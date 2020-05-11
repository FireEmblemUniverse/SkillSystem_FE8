.thumb
@draw alternate icon if top bit of halfword set
@hook at 8003730
@r2 contains icon to draw
ldr r5, =0x6010000
ldr r0, =0x3ff
and r0, r1
lsl r0, #5
add r5, r0
cmp r2, #0
blt NoIcon
mov r0, #0x80
lsl r0, #8
tst r2, r0 @if top bit not set, set zero flag
beq NormalIcon
@otherwise load the alternate pointer
ldr r0, =0x7FFF
and r2, r0
ldr r4, SkillIcons
ldr r0, =0x8003763
bx r0
NormalIcon:
ldr r0, =0x8003761
bx r0
NoIcon:
ldr r0, =0x800373f
bx r0

.ltorg
SkillIcons:
@POIN SkillIconsGraphics
