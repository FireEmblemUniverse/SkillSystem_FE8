.equ PastelVeilID, AuraSkillCheck+4
.equ GetUnit, 0x8019430

.thumb
push {r4-r7,lr}
@goes in the battle loop.
@r0 is the attacker
@r1 is the defender
mov r4, r0
mov r5, r1

CheckSkill:
@now check for the skill
ldr r0, AuraSkillCheck
mov lr, r0
mov r0, r4 @attacker
ldr r1, PastelVeilID
mov r2, #0 @can_trade
mov r3, #3 @range
.short 0xf800
cmp r0, #0
beq End

ldrb r0, [r4, #0x0B]    @deployment byte of attacker
ldr	r1,=GetUnit	        @get the unit struct from the deployment byte
mov	lr,r1               @now move the address in r1 into the link register
.short	0xf800		    @now branch to the address, r0 = pointer to unit in ram      
mov r1,#0x30            @get the status byte
ldrb r2,[r0,r1]         @load the status byte
mov r3,#0xF
and r2,r3               @isolate the last bit (which stores the status effect)
cmp r2,#1               @compare the value to the value for the poison status
bne End                 @if the ally isn't poisoned, then branch to the end

mov r2,#0               @otherwise, set their status to netural
strb r2,[r0,r1]         @and store the new value

End:
pop {r4-r7}
pop {r0}
bx r0
.align
.ltorg
AuraSkillCheck:
@ POIN AuraSkillCheck
@ WORD PastelVeilID
