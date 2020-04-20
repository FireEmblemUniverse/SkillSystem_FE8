.thumb
@.global GetItemSkill
@.type GetItemSkill, %function

.macro _blh to, reg=r3
	ldr \reg, =\to
	mov lr, \reg
	.short 0xF800
.endm

.set Item_GetData, 0x80177B0
.set Item_GetID, 0x80174EC

.set Item_SkillByte, 0x23 @35

@arguments:
	@r0 = item id
@returns:
	@r0 = skill id of item

GetItemSkill:
push {lr}
_blh Item_GetID
_blh Item_GetData
mov r1, #Item_SkillByte
ldrb r0,[r0,r1]
pop {r1}
bx r1
.ltorg
.align
