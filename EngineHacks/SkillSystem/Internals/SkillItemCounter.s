.thumb

.global SkillItemCounter
.type SkillItemCounter, %function
.global GetItemPassiveSkill
.type GetItemPassiveSkill, %function
.global IsItemSkillPassive
.type IsItemSkillPassive, %function

.macro _blh to, reg=r3
	ldr \reg, =\to
	mov lr, \reg
	.short 0xF800
.endm

.set Item_GetData, 0x80177B0
.set Item_GetID, 0x80174EC
.set Item_GetAbilities, 0x801756C

@checks for passive item skills
@arguments:
	@r0 = ram data
	@r1 = skill id
@returns
	@r0 = amount of items unit has with the given skill
SkillItemCounter:
push 	{r4-r7,lr}
mov 	r6, r0
mov 	r7, r1
mov 	r5, #0x0 	@skill counter
mov 	r4, #0x0 	@item slot

ItemSkillLoop:
mov r0, #0x1E
add 	r0,r0,r4
ldrh 	r0,[r6,r0]
cmp 	r0,#0x0 	@check if unit has any more items
beq ItemSkillEnd
bl GetItemPassiveSkill	@check if it's alright to check this item for skills
cmp r0, r7
bne reloop
add 	r5,#0x1
reloop:
add 	r4,#0x2
cmp 	r4, #0x8
bls ItemSkillLoop
ItemSkillEnd:
mov 	r0,r5
pop 	{r4-r7}
pop 	{r1}
bx 	r1

GetItemPassiveSkill:
@arguments: r0 = item id
@returns: r0 = skill id of item, returns 0 if item cannot be checked
push {r4,lr}
mov 	r4, r0
@_blh Item_GetAbilities
@ldr 	r1, PassiveSkillFlag
@and 	r0, r1
@cmp r0, r1	@check for "is weapon" flag on item
bl IsItemSkillPassive
cmp r0,#0x0
beq SkipItem
mov 	r0, r4
bl GetItemSkill
b ItemCheckEnd
SkipItem:
mov 	r0, #0x0
ItemCheckEnd:
pop 	{r4}
pop 	{r1}
bx 	r1
.ltorg
.align

IsItemSkillPassive:
@arguments: r0 = item id
@returns: r1 = True/False
push 	{lr}
_blh Item_GetAbilities
ldr 	r1, PassiveSkillFlag
and 	r0, r1
mov 	r2, #0x0
cmp 	r0, r1	@check for "passive skill" flag on item
bne NotPassive
mov 	r2, #0x1
NotPassive:
mov 	r0, r2
pop 	{r1}
bx r1
.ltorg
.align

PassiveSkillFlag:
