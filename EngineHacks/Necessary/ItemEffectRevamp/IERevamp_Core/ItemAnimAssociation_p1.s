.thumb
.global IER_GetItemAnimation
.type IER_GetItemAnimation, %function

@arguments:
	@r0 = item id durability short
@returns
	@r0 = pointer to anim table entry

.equ ActionStruct, 0x203A958
.equ WeaponAnimTable, OffsetList + 0x0
.equ EffectAnimTable, OffsetList + 0x4

IER_GetItemAnimation:
push	{r14}
bl Item_GetID
ldr 	r1, =ActionStruct
ldrb 	r2, [r1,#0x11]
cmp 	r2, #0x2 	@check if unit is attacking with a weapon
beq 	WeaponAnims
EffectAnims:
@bl	Item_GetStat_EffectID
ldr 	r1, EffectAnimTable
bl IER_GetEffectAnimLoop
b End
WeaponAnims:
ldr 	r1, WeaponAnimTable
GetTableEntry:
bl IER_GetSpellAnimLoop
End:
pop 	{r3}
bx	r3
.align
.ltorg
OffsetList:
