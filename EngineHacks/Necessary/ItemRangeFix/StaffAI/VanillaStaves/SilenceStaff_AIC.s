.thumb
.include "../_ItemAIDefinitions.h.s"
@parameters: 
	@r0 = stack pocket pointer
	@r1= active unit
	@r2= target unit
	
.set MinHitRate, 0x0 @minimum accuracy against unit to target them
.equ IsActiveUnitEnemy, OffsetList + 0x0

@Silence staff targeting ai routine
push 	{r4-r6, lr}
mov 	r4, r2
mov 	r5, r1
mov 	r6, r0

cmp 	r4, r5
beq CantHit 	@stop unit from targeting itself

mov 	r0, r4
ldr 	r3, IsActiveUnitEnemy
_blr 	r3
cmp 	r0, #0x0
beq CantHit

@check if target already has a status effect
mov 	r0, r4
mov 	r1, #0x30
ldrb 	r1,[r0,r1]
mov 	r0, #0xF
and 	r0, r1
cmp 	r0, #0x0
bne 	CantHit

@check if target has a usable staff or weapon
mov 	r0, r4
_blh HasUsableStaffOrWeapon
cmp 	r0, #0x0
beq CantHit

mov 	r0, r4
_blh AiSilencePriority

NewPriority:
@add thing here for priority skills (Provoke,Shade,Shade+,etc.)
@set accuracy as priority value
str 	r0, [r6,#spNewPriority]
ComparePriority:
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
