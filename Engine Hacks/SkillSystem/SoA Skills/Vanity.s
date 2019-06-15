.thumb
.equ VanityID, SkillTester+4

push {r4-r7, lr}
mov r4, r0 @atkr
mov r5, r1 @dfdr


@has Vanity
ldr r0, SkillTester
mov lr, r0
mov r0, r4 @Attacker data
ldr r1, VanityID
.short 0xf800
cmp r0, #0
beq End


mov r1,#0x10
ldrb r0,[r4,r1]
ldrb r1,[r5,r1]

cmp r0,r1
bge PX

sub r1,r0
mov r0,r1
b Y

PX:
sub r0,r1

Y:
mov r2,#0x11
ldrb r1,[r4,r2]
ldrb r2,[r5,r2]
cmp r1,r2
bge PY

sub r2,r1
mov r1,r2
b Check

PY:
sub r1,r2

Check:

add r0,r1
cmp r0,#0x2
bne End


mov r1, #0x5a @Damage
ldrh r0, [r4, r1]
add r0, #2
strh r0, [r4,r1]

mov r1, #0x60 @Hit
ldrh r0, [r4, r1]
add r0, #10
strh r0, [r4,r1]

End:
pop {r4-r7, r15}
.align
.ltorg
SkillTester:
@Poin SkillTester
@WORD VanityID
