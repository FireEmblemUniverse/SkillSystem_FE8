.thumb
.equ SimpleRootsID, SkillTester+4

push {r4-r7, lr}
mov r4, r0 @atkr
mov r5, r1 @dfdr

mov r0,#0x1E
ldrb r1,[r4,r0]
ldrb r2,[r5,r0]
sub r1,#0x1
sub r2,#0x1
mov r3,#36
mul r1,r3
mul r2,r3
ldr r0,=0x8809B34
add r0,r1
mov r1,#28
ldrb r1,[r0,r1]
ldr r0,=0x8809B34
add r0,r2
mov r2,#28
ldrb r2,[r0,r1]

cmp r1,r2
ble End


@has SimpleRoots
ldr r0, SkillTester
mov lr, r0
mov r0, r4 @Attacker data
ldr r1, SimpleRootsID
.short 0xf800
cmp r0, #0
beq End

@Add stuff
mov r1, #0x5A
ldrh r0, [r4, r1]
add r0, #0x2
strh r0, [r4,r1]

mov r1, #0x60
ldrh r0, [r4, r1]
add r0, #15
strh r0, [r4,r1]

mov r1, #0x66
ldrh r0, [r4, r1]
add r0, #0x5
strh r0, [r4,r1]

End:
pop {r4-r7, r15}
.align
.ltorg
SkillTester:
@Poin SkillTester
@WORD SimpleRootsID
