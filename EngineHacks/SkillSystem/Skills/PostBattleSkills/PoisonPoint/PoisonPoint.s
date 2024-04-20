.equ PoisonPointID, SkillTester+4
.equ BattleBuffer, 0x203A4D4

.thumb
push {r4-r7,lr}
mov  r6, r4           @copy over the first character struct
mov  r7, r5           @copy over the second character struct

@check if dead
ldrb	r0, [r4,#0x13]
cmp	r0, #0x00
beq	End

@check for skill for the attacker
mov	r0, r4
ldr	r1, PoisonPointID
ldr	r3, SkillTester
mov	lr, r3
.short	0xf800
cmp	r0,#0x00
beq	CheckOtherUnit    @the first unit didn't have the skill, so now we'll check the second

@check to see if the attack was at melee range
ldr r0,=BattleBuffer  @load the battle buffer
ldrb r0,[r0,#2]       @load the value at the second byte (range of attack)
cmp r0, #1            @check to see if it was a 1 (melee)
bne End               @if not, we branch to the end

@check to see if the unit already has a status
mov r3,#0x30          @get the status byte
ldrb r0,[r5,r3]       @load the status byte for the defender
mov r1,#0xF
and r0,r1             @we perform a bitmask operation to isolate the right side nibble that holds the status
cmp r2, #0            @now compare the status nibble to an empty status (0)
bne End               @if they're not equal, the defender already has a status and cannot be poisoned. So we exit

@apply the poison status
mov r0,#0x31          @apply the poison status for 3 turns
strb r0,[r5,r3]

@check for skill for the defender
CheckOtherUnit:
mov r0, r7
ldr	r1, PoisonPointID 
ldr	r3, SkillTester
mov	lr, r3
.short	0xf800
cmp	r0,#0x00
beq	End

@check to see if the unit already has a status
mov r3,#0x30          @get the status byte
ldrb r0,[r6,r3]       @load the status byte for the attacker
mov r1,#0xF
and r0,r1             @we perform a bitmask operation to isolate the right side nibble that holds the status
cmp r2, #0            @now compare the status nibble to an empty status (0)
bne End               @if they're not equal, the attacker already has a status and cannot be poisoned. So we exit

@apply the poison status
mov r0,#0x31          @apply the poison status for 3 turns
strb r0,[r6,r3]

End:
pop	{r4-r7}
pop	{r0}
bx	r0
.ltorg
.align
SkillTester:
@POIN SkillTester
@WORD PoisonPointID
