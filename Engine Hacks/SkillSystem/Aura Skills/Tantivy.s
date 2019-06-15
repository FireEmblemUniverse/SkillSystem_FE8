@Tantivy: +10 hit/avo if no allies in 3 tiles.
.equ AuraSkillCheck, SkillTester+4
.equ TantivyID, AuraSkillCheck+4
.thumb
push {r4-r7,lr}
@goes in the battle loop.
@r0 is the attacker
@r1 is the defender
mov r4, r0
mov r5, r1

CheckSkill:
@now check for the skill
ldr r0, SkillTester
mov lr, r0
mov r0, r4 @attacker
ldr r1, TantivyID
.short 0xf800
cmp r0, #0
beq Done

@Check if there are allies in 3 spaces
ldr r0, AuraSkillCheck
mov lr, r0
mov r0, r4 @attacker
mov r1, #0
mov r2, #0 @can_trade
mov r3, #3 @range
.short 0xf800
cmp r0, #0
bne Done

mov r0, r4
add     r0,#0x60    @Move to the attacker's hit.
ldrh    r3,[r0]     @Load the attacker's hit into r3.
add     r3,#10    @add 10 hit.
strh    r3,[r0]     @Store.

add r0, #2 @attacker's avoid
ldrh    r3,[r0]     @Load the attacker's avoid into r3.
add     r3,#10    @add 10 avoid.
strh    r3,[r0]     @Store.

Done:
pop {r4-r7}
pop {r0}
bx r0
.align
.ltorg
SkillTester:
@ POIN SkillTester
@ POIN AuraSkillCheck
@ WORD TantivyID
