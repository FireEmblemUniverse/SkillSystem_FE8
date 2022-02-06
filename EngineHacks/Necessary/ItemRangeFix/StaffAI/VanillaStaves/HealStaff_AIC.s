.thumb
.include "../_ItemAIDefinitions.h.s"
@parameters: 
	@r0 = stack pocket pointer
	@r1= active unit
	@r2= target unit
	
.set MaxPercent, 100	@target is healable if below this percent of hp
.equ IsActiveUnitEnemy, OffsetList + 0x0
.equ GetHpPercent, OffsetList + 0x4

push 	{r4-r6, lr}
mov 	r4, r2
mov 	r5, r1
mov 	r6, r0

cmp 	r4, r5
beq CantHit 	@stop unit from targeting itself
	
@check if target has recovery mode flag
ldrb 	r1, [r4,#0xA]
mov 	r0, #0x1
and 	r0, r1
cmp 	r0, #0x0
beq CantHit

mov 	r0, r4
ldr 	r3, IsActiveUnitEnemy
_blr 	r3
@_blh 	AIAllegianceCheck
cmp 	r0, #0x0
bne CantHit

mov 	r0, r4
ldr 	r3, GetHpPercent
_blr 	r3
@_blh GetHpPercent
mov 	r1, #MaxPercent
cmp 	r0, r1
bhs 	CantHit
@set hp percentage as priority value
str 	r0, [r6,#spNewPriority]

@compare priority
ldr 	r1,[r6,#spPriority]
cmp 	r1, #0x0
blt 	Usable
cmp 	r0,r1
bgt 	CantHit

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
