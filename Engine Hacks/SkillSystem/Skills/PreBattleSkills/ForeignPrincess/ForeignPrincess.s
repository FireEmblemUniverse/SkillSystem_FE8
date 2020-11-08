.thumb
.align

@Foreign Princess: Foreign army units take -2/+2 damage dealt/taken.
@this description is vague but in Fates refers to My Castle opponents
@therefore, this skill will only have an effect in the Link Arena because fuck you

.equ ForeignPrincessID, SkillTester+4
.equ CheckGameLinkArenaBit,0x8042e98


push {r4-r5,r14}

mov r4,r0 @attacker
mov r5,r1 @defender


@are we in link arena mode?

ldr r0,=CheckGameLinkArenaBit
mov r14,r0
.short 0xF800
cmp r0,#1
bne GoBack

@we are in link arena mode, does attacker have this skill?
ldr r0,SkillTester
mov r14,r0
mov r0,r4
ldr r1,ForeignPrincessID
.short 0xF800
cmp r0,#0
beq GoBack

@yes, so -2 def and -2 atk on defender

mov r0,r5
add r0,#0x5A @attack
ldrh r1,[r0]
sub r1,#2
strh r1,[r0]
add r0,#2 @defense
ldrh r1,[r0]
sub r1,#2
strh r1,[r0]


GoBack:
pop {r4-r5}
pop {r0}
bx r0

.ltorg
.align


SkillTester:
@POIN SkillTester
@WORD ForeignPrincessID
