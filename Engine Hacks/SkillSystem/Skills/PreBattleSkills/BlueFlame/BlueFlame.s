.thumb
.equ BlueFlameID, SkillTester+4

push {r4-r7, lr}
mov r4, r0 @attacker
mov r5, r1 @defender

ldr r0, SkillTester
mov lr, r0
mov r0, r4 @defender data
ldr r1, BlueFlameID
.short 0xf800
cmp r0, #0
beq End

@Blue Flame: Attack +2. If adjacent to an ally, Attack +4.

@in this part, only add 2.

mov r0,#0x5A
add r0,r4
ldrb r1,[r0]
add r1,#2
strb r1,[r0]

@A separate function will add 2 more if we are adjacent to an ally.

End:
pop {r4-r7, r15}
.align
.ltorg
SkillTester:
@Poin SkillTester
@WORD BlueFlameID
