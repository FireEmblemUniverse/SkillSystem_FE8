.align 4
.macro blh to, reg=r3
  ldr \reg, =\to
  mov lr, \reg
  .short 0xf800
.endm
	.thumb

	.equ MemorySlot, 0x30004B8 
	.equ RamUnitTable, 0x859A5D0 @0th entry
	.equ UnitMap, 0x202E4D8 
	.equ GetUnit, 0x8019430
	.equ GetUnitByEventParameter, 0x0800BC50
@ [802BF24]!!?


	.equ RefreshFogAndUnitMaps, 0x0801a1f4  
	.equ SMS_UpdateFromGameData, 0x080271a0   
	.equ UpdateGameTilesGraphics, 0x08019c3c   

	.equ EnemyAutoLevel, 0x802B9C4
	.equ CheckCaps, 0x80181C8 
	@.equ CheckCaps, 0x802BF24 @This one is used after leveling up 
	.equ AttackerStruct, 0x203A4EC
	.equ DefenderStruct, 0x203A56C 
	.equ CurrentUnitStruct, 0x3004E50
	

	.equ Rolld100, 0x8000c64
	.equ CharacterTable, 0x8803D30 @0th entry 
	.equ MemorySlot3,0x30004C4    @item ID to give @[0x30004C4]!!?
	.equ DivisionRoutine, 0x080D18FC

	.global AutoLevelUnits
	.type   AutoLevelUnits, function

AutoLevelUnits:
	push {r4-r7, lr}	

@ r5 as valid coordinates 
@ r6 as valid terrain types 

ldr r0, =MemorySlot 

mov r6, #0x80 
ldr r7, [r0, #4*0x01] @r7 / s1 as number of levels 
@mov r7, #21 

LoopThroughUnits:
mov r0,r6
blh GetUnit @ 19430
cmp r0,#0
beq NextUnit
ldr r3,[r0]
cmp r3,#0
beq NextUnit
ldr r1,[r0,#0xC] @ condition word
mov r2,#0xC @ benched/dead
tst r1,r2
bne NextUnit
mov r5, r0 @unit to autolevel 
b Start



Start: 
mov r0, r5
blh Get_Hp_Growth
mov r1, r7 
blh EnemyAutoLevel @takes r1 as # of levels and r0 as growth for that level 
@r0 now has # of levels in X stat to add 
mov r2, #0x12 
ldrb r1, [r5, r2] @current stat to increase 
add r1, r0, r1  

cmp r1, #99 
ble StoreMaxHp 
mov r1, #99
StoreMaxHp: 

strb r1, [r5, r2] 
ldrb r1, [r5, #0x13] @current stat to increase 
add r1, r0, r1  

cmp r1, #99 
ble StoreCurrentHp 
mov r1, #99 
StoreCurrentHp:
strb r1, [r5, #0x13] @current hp 

ldrb r1, [r5, #0x08] @Level 
add r1, r1, r7 
cmp r1, #100
ble StoreLevel
mov r1, #100 
StoreLevel:
strb r1, [r5, #0x08] 

mov r0, r5
blh Get_Str_Growth

mov r1, r7 
blh EnemyAutoLevel @takes r1 as # of levels and r0 as growth for that level 
mov r2, #0x14 
ldrb r1, [r5, r2] @current stat to increase 
add r0, r1 
cmp r0, #0x7F
ble StoreStr
mov r0, #0x7F 
StoreStr:
strb r0, [r5, r2] 
b SkillNow

NextUnit:
add r6,#1
cmp r6,#0xAF
ble LoopThroughUnits
End_LoopThroughUnits:
pop {r4-r7}
pop {r0}
bx r0


SkillNow: 
mov r0, r5
blh Get_Skl_Growth

mov r1, r7 
blh EnemyAutoLevel @takes r1 as # of levels and r0 as growth for that level 
mov r2, #0x15
ldrb r1, [r5, r2] @current stat to increase 
add r0, r1 
cmp r0, #0x7F
ble StoreSkl
mov r0, #0x7F 
StoreSkl:
strb r0, [r5, r2] 

mov r0, r5
blh Get_Spd_Growth

mov r1, r7 
blh EnemyAutoLevel @takes r1 as # of levels and r0 as growth for that level 
mov r2, #0x16 
ldrb r1, [r5, r2] @current stat to increase 
add r0, r1 
cmp r0, #0x7F
ble StoreSpd
mov r0, #0x7F 
StoreSpd:
strb r0, [r5, r2] 

mov r0, r5 
blh Get_Def_Growth

mov r1, r7 
blh EnemyAutoLevel @takes r1 as # of levels and r0 as growth for that level 
mov r2, #0x17 
ldrb r1, [r5, r2] @current stat to increase 
add r0, r1 
cmp r0, #0x7F
ble StoreDef
mov r0, #0x7F 
StoreDef:
strb r0, [r5, r2] 

mov r0, r5 
blh Get_Res_Growth

mov r1, r7 
blh EnemyAutoLevel @takes r1 as # of levels and r0 as growth for that level 
mov r2, #0x18 
ldrb r1, [r5, r2] @current stat to increase 
add r0, r1 
cmp r0, #0x7F
ble StoreRes
mov r0, #0x7F 
StoreRes:
strb r0, [r5, r2] 

mov r0, r5 
blh Get_Luk_Growth

mov r1, r7 
blh EnemyAutoLevel @takes r1 as # of levels and r0 as growth for that level 
mov r2, #0x19 
ldrb r1, [r5, r2] @current stat to increase 
add r0, r1 
cmp r0, #0x7F
ble StoreLuk
mov r0, #0x7F 
StoreLuk:
strb r0, [r5, r2] 

mov r0, r5 
blh Get_Mag_Growth
mov r1, r7 
blh EnemyAutoLevel @takes r1 as # of levels and r0 as growth for that level 
mov r2, #0x3A 
ldrb r1, [r5, r2] @current stat to increase 
add r0, r1 
cmp r0, #0x7F
ble StoreMag
mov r0, #0x7F 
StoreMag:
strb r0, [r5, r2] 

mov r0, r5 
blh CheckCaps 
b NextUnit 



.ltorg









