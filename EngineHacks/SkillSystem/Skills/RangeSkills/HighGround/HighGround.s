.thumb
.align

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
.set BonusWeaponType1, 0x3 @Bows
.set BonusWeaponType2, 0x5 @Anima
.set BonusWeaponType3, 0x6 @Light
.set BonusWeaponType4, 0x7 @Dark
.set MaxRangeBonus, 0x2
.equ HighGroundID,SkillTester+4
.equ HighGroundList,HighGroundID+4
.equ gMapTerrain, 0x202E4DC

push 	{r4-r7,lr}
add 	sp, #-0x4
str 	r2, [sp]
mov 	r0, r1

_blh GetWeaponType
cmp 	r0, #BonusWeaponType1	@check if item is matching weapon type
beq TerrainCheck
cmp 	r0, #BonusWeaponType2
beq TerrainCheck
cmp 	r0, #BonusWeaponType3
beq TerrainCheck
cmp 	r0, #BonusWeaponType4
beq TerrainCheck
b End @if not matching any weapon type

TerrainCheck:
ldrb r0,[r4,#0x10] @r0=x pos
ldrb r1,[r4,#0x11] @r1=y pos
ldr		r2,=gMapTerrain	@Load the location in the table of tables of the map you want
ldr		r2,[r2]			@Offset of map's table of row pointers
lsl		r1,#0x2			@multiply y coordinate by 4
add		r2,r1			@so that we can get the correct row pointer
ldr		r2,[r2]			@Now we're at the beginning of the row data
add		r2,r0			@add x coordinate
ldrb	r6,[r2]			@load datum at those coordinates

ldr r7,HighGroundList
LoopStart:
ldrb r0,[r7]
cmp r0,#0
beq End
cmp r0,r6
beq AddRange
add r7,#1
b LoopStart


AddRange:
mov 	r2, sp
ldrh 	r0, [r2]
add 	r0, r0, #MaxRangeBonus

@prevent the maximum range from going over 15
cmp 	r0, #0xF
bls NotOverMax
mov 	r0, #0xF
NotOverMax:
strh 	r0, [r2]

End:
ldr 	r0, [sp]
add 	sp, #0x4
pop {r4-r7}
pop 	{r3}
bx 	r3
.ltorg
.align

SkillTester:
@POIN SkillTester
@WORD HighGroundID
@POIN HighGroundList

