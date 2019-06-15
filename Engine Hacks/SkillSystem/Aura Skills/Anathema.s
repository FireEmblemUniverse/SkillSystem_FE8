@Anathema: enemies in 2 spaces get -10 avoid
.equ AnathemaID, AuraSkillCheck+4
.thumb
push {r4-r7,lr}
@goes in the battle loop.
@r0 is the attacker
@r1 is the defender
mov r4, r0
mov r5, r1

@now check for the skill
ldr r0, AuraSkillCheck
mov lr, r0
mov r0, r4 @attacker
ldr r1, AnathemaID
mov r2, #3 @are enemies
mov r3, #3 @range
.short 0xf800
cmp r0, #0
beq Done

mov r0, r4
add     r0,#0x62    @Move to the attacker's avoid.
ldrh    r3,[r0]     @Load the attacker's avoid into r3.
sub     r3,#10    @subtract 10 from the attacker's avoid
strh    r3,[r0]     @Store attacker avoid

add r0, #6 @crit avoid
ldrh    r3,[r0]     @Load the attacker's avoid into r3.
sub     r3,#10    @subtract 10 from the attacker's avoid
strh    r3,[r0]     @Store attacker avoid

Done:
pop {r4-r7}
pop {r0}
bx r0
.align
.ltorg
AuraSkillCheck:
@ POIN AuraSkillCheck
@ WORD AnathemaID
