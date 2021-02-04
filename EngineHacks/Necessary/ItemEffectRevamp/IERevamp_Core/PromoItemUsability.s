.thumb

.macro _blh to, reg=r3
	ldr \reg, =\to
	mov lr, \reg
	.short 0xF800
.endm

.macro _blr reg
	mov lr, \reg
	.short 0xF800
.endm

@arguments
	@r0 = unit pointer
	@r1 = item id

.equ PromoItemTable, OffsetList + 0x0

push 	{r4-r7,lr}
mov 	r7, r0
mov 	r6, r1
mov 	r4, #0x0
mov 	r0, r6
bl 	Item_GetID
ldr 	r2, =#0xFFFF	@marks end of table
ldr 	r5, PromoItemTable
reloop:
ldrh	r1,[r5]
cmp 	r1, r2
beq 	Unusable
cmp 	r1,r0
beq 	SpecialPromoCheck
add 	r5, #0xC
b 	reloop

SpecialPromoCheck:
ldr 	r3, [r5,#0x8]
cmp 	r3, #0x0
beq 	PromoLevelCheck
mov 	r0, r7
mov 	r1, r6
mov 	r2, r5
bl 	bl_to_bx_r3
mov 	r1, r0
mov 	r0, #0x1
and 	r0, r1
cmp 	r0, #0x0
beq 	Unusable
mov 	r0, #0x2
and 	r0, r1
cmp 	r0, #0x0
beq 	Skip
mov 	r6, #0x0
Skip:
mov 	r0, #0x4
and 	r0, r1
cmp 	r0, #0x0
beq 	PromoLevelCheck
mov 	r5, #0x0

@NOT FINISHED YET
PromoLevelCheck:
mov 	r0, r6
cmp 	r0, #0x0
beq PromoClassListCheck 	@skip this check
bl 	Item_GetStat_EPV_Jump
mov 	r1, #0x8
ldsb 	r1, [r7,r1]
cmp 	r1, r0
blt 	Unusable

PromoClassListCheck:
cmp 	r5, #0x0
beq 	Usable	@skip this check
ldr 	r3, [r5, #0x4]
cmp 	r3, #0x0
beq 	Unusable
ldr 	r1, [r7, #0x4]
ldrb 	r2, [r1, #0x4]	@get unit's class id
loop:
ldrb 	r1, [r3]
cmp 	r1, #0x0	@check if unit's class is in the list of promotable classes
beq Unusable
cmp 	r1, r2
beq Usable
add 	r3, r3, #0x1
b loop

Usable:
mov 	r4, #0x1
Unusable:
mov 	r0, r4
End:
pop 	{r4-r7}
pop 	{r1}
bx 	r1
.ltorg
.align

OffsetList:
