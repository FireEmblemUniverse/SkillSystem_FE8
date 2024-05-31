.thumb
.include "_ItemEffectDefinitions.s"

@ arguemnts: 
	@r0= proc pointer
	@r1= heal calc routine
	@r2= pointer to animation proc (removed)
.equ HealingItem, 0x6C

.equ HealHPUpdate, OffsetList + 0x0
push 	{r4-r7, lr}
mov 	r6, r0
@mov 	r7, r2
mov 	r3, r1
bl		jump	@should return amount to be healed in r0
mov 	r4, r0
ldr 	r3, =ActionStruct
ldrb 	r0, [r3, #0xC]
_blh 	RamUnitByID
mov 	r5, r0
mov 	r1, r4
ldr 	r3, HealHPUpdate
bl		jump
mov 	r0, r5
_blh Unit_GetCurHP
ldr 	r1, =#0x203A608	
ldr 	r2, [r1]
ldr 	r4, =BattleActingUnit
ldrb 	r1, [r4, #0x13]
sub 	r1, r1, r0
strb 	r1, [r2, #0x3]
mov 	r0, r5
_blh Unit_GetCurHP
strb 	r0, [r4,#0x13]
add 	r4, #0x4A
mov 	r0, #HealingItem
strh 	r0, [r4]

_blh #0x802CA14
@mov 	r0, r7
@mov 	r1, r6
@_blh New6CBlocking
pop 	{r4-r7}
pop 	{r3}
jump:
bx	r3
.ltorg
.align
OffsetList:
.long 0x080193A4 | 1
