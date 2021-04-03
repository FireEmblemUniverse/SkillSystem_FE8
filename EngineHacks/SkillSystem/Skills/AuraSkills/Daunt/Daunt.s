@Daunt: enemies in 3 spaces get -5 hit and -5 crit
.equ DauntID, AuraSkillCheck+4
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
ldr r1, DauntID
mov r2, #3 @are enemies
mov r3, #4 @range
.short 0xf800
cmp r0, #0
beq Done

mov r0, r4
add     r0,#0x60    @Move to the attacker's hit.
ldrh    r3,[r0]     @Load the attacker's hit into r3.
sub     r3,#5      @subtract 5 from the attacker's hit
cmp 	r3,#0
bgt		StoreHitAsIs
mov 	r3,#0
StoreHitAsIs:
strh    r3,[r0]     @Store attacker avoid

add r0, #6 			@crit
ldrh    r3,[r0]     @Load the attacker's crit into r3.
sub     r3,#5    	@subtract 5 from the attacker's crit
cmp 	r3,#0
bgt		StoreCritAsIs
mov 	r3,#0
StoreCritAsIs:
strh    r3,[r0]     @Store attacker crit

Done:
pop {r4-r7}
pop {r0}
bx r0
.align
.ltorg
AuraSkillCheck:
@ POIN AuraSkillCheck
@ WORD DauntID
