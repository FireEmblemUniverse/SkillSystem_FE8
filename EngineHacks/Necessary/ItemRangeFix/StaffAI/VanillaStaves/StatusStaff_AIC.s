.thumb
.include "../_ItemAIDefinitions.h.s"
@parameters: 
	@r0 = stack pocket pointer
	@r1= active unit
	@r2= target unit
	
.set MinHitRate, 0x0 @minimum accuracy against unit to target them
.equ IsActiveUnitEnemy, OffsetList + 0x0

@default status staff targeting ai routine
push 	{r4-r6, lr}
mov 	r4, r2
mov 	r5, r1
mov 	r6, r0

cmp 	r4, r5
beq CantHit 	@stop unit from targeting itself

mov 	r0, r4
ldr 	r3, IsActiveUnitEnemy
_blr 	r3
@_blh 	AIAllegianceCheck
cmp 	r0, #0x0
beq CantHit

mov 	r0, r4
mov 	r1, #0x30
ldrb 	r1,[r0,r1]
mov 	r0, #0xF
and 	r0, r1
cmp 	r0, #0x0	@check if target already has a status effect
bne 	CantHit

mov 	r0, r5
mov 	r1, r4
_blh GetStaffAccuracy
cmp 	r0, #MinHitRate		@make sure hitrate is above minimum
ble 	CantHit

@set accuracy as priority value
@add thing here later for priority skills (Provoke,Shade,Shade+,etc.)
str 	r0, [r6,#spNewPriority]

@compare priority
ldr 	r1,[r6,#spPriority]
cmp 	r0,r1
blt CantHit

Usable:
mov 	r0, #0x3
b End

CantHit:
mov 	r0, #0x0
End:
pop 	{r4-r6}
pop 	{r1}
bx 	r1
.ltorg
.align
OffsetList:
