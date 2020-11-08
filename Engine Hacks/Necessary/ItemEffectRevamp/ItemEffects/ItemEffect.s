.thumb
.include "_ItemEffectDefinitions.s"

@arguments:
	@r0 = proc pointer
	@r1 = item effect routine

push	{r4-r6, r14}
mov 	r6, r0
mov 	r5, r1
ldr 	r4, =ActionStruct
ldrb 	r0, [r4, #0xC]		@get deployment id of attacker

ldr 	r3, =RamUnitByID|1
bl		jump				@get char pointer of attacker

ldrb 	r1, [r4, #0x12] 	@get the used item slot

ldr 	r3, =BActingUnitUpdate|1
bl  	jump				@update attacker data in ram

@update defender if necessary
ldrb 	r0, [r4, #0xD]
cmp 	r0, #0x0
beq 	skipDefender
ldr 	r3, =RamUnitByID|1
bl  	jump
ldr 	r3, =BTargetUnitUpdate|1
bl jump
skipDefender:

@the actual item effect
mov 	r0, r6
mov 	r3, r5
bl		jump
@mov 	r14, r5
@.short 0xf800

@update exp and item durability
mov 	r0, r6
ldr 	r3, Expthing
bl		jump 		@give exp to units and handle level ups

pop  	{r4-r6}
pop  	{r0}
bx  	r0

jump:
bx r3

.ltorg
.align
Expthing:
.long 0x802CC54 | 1
@ItemGraphics: @removed since items should be able to have hardcoded animations
@.long 0x802CA14 | 1
