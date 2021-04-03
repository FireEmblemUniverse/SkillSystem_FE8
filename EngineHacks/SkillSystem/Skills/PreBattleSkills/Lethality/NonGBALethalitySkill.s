@if you want the original gba lethality just remove this from the battle calculations, you do NOT need to make any other changes
@change the mov r5 and add r5 below to customize the chance of lethality
@lethality skill, does pretty much the same as vanilla one but calls skill getter and uses skill to calculate chance
@character/class ability "crit +15" (ability 1 value 0x40) no longer gives lethality chance, it now makes the unit immune to lethality
@r4 has either attacker or defendant (the skill user)
@r5 has the other one

.thumb

push {r4-r6,r14}
mov	r6,#0x00
mov	r0, r4		@load character data in ram pointer
mov	r5,#0x01	@change 0x01 to 0x02 to have skill/4% chance, or to 0x01 to have skill/2% chance
add	r4,#0x6C	@pointer to lethality chance
ldrb	r1,[r4]		@get chance
cmp	r1,#0x00	@if there's no chance either the unit doesn't have the skill or the enemy is immune (set by LethalitySkill)
beq	End
cmp	r1,#0x19	@if a boss, halve chance (by default)
bne	NoBoss
add	r5,#0x01	@change 0x01 to 0x00 to not halve chance of lethality against bosses, set it to 0x08 to make bosses immune, you can also give them the "crit +15" ability (which now gives immunity to lethality) if you only want certain bosses to be immune

NoBoss:			@rng roll is done in the procloopparent
mov	r6,#0xFF	@set to 100% chance of getting lethality (will trigger even if the unit doesn't crit), if you want it to only trigger if the unit crits, set it to 0x64
sub	r6,r5		@saves modifier to lethality chance (to be used in the procloopparent)

End:
strb	r6,[r4]		@store lethality chance, having a modifier of more than 0x64 will make things not work right (and is pointless, any modifier bigger than 0x10 will set the skill short to 0)
pop	{r4-r6}
pop	{r0}
bx	r0

.align
