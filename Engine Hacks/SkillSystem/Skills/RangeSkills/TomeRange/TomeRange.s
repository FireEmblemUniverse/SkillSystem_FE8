.thumb

.macro _blh to, reg=r3
	ldr \reg, =\to
	mov lr, \reg
	.short 0xF800
.endm

@arguments:
	@r0: unit pointer
	@r1: item id
	@r2: min max range word
@retuns
	@r0: updated min max range word
.set GetWeaponType, 0x8017548
.set BonusWeaponType1, 0x5 @Anima
.set BonusWeaponType2, 0x6 @Light
.set BonusWeaponType3, 0x7 @Dark
.set MaxRangeBonus, 0x1
push 	{ lr}
add 	sp, #-0x4
str 	r2, [sp]
mov 	r0, r1
_blh GetWeaponType
cmp 	r0, #BonusWeaponType1	@check if item is matching weapon type
beq AddRange
cmp 	r0, #BonusWeaponType2
beq AddRange
cmp 	r0, #BonusWeaponType3
beq AddRange
b End 	@ Not Matching weapon type
AddRange:
ldrh 	r0, [sp]
add 	r0, r0, #MaxRangeBonus
strh 	r0, [sp]
End:
ldr 	r0, [sp]
add 	sp, #0x4
pop 	{r3}
bx 	r3
.ltorg
.align
