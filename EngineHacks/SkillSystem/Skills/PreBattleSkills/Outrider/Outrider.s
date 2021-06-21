.thumb
.equ DominateID, SkillTester+4

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
cmp r0,#0xFF
beq End

@has Charge
ldr r0, SkillTester
mov lr, r0
mov r0, r4 @Attacker data
ldr r1, DominateID
.short 0xf800
cmp r0, #0
beq End

@Add damage

ldr r3,=0x203a968 @Spaces Moved
ldrb r2,[r3]
mov r1, #0x5C @Def
ldrh r0, [r4, r1]
mov r3,#0x1
mul r3,r2
add r0, r3
strh r0, [r4,r1]

mov r1, #0x66 @crit
ldrh r0, [r4, r1]
mov r3,#0x3
mul r3,r2
add r0, r3
strh r0, [r4,r1]

End:
pop {r4-r7, r15}
.align
.ltorg
SkillTester:
@Poin SkillTester
@WORD DominateID
