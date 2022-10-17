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

.global AutoLevelSummonedUnit
.type AutoLevelSummonedUnit, %function 
AutoLevelSummonedUnit: 
push {r4-r7, lr} 

mov r6, #0xFF @ so we don't repeat 
mov r5, r0 @ unit 
mov r7, r1 @ levels 

b Start 


	.global AutoLevelUnits
	.type   AutoLevelUnits, function

AutoLevelUnits:
	push {r4-r7, lr}	

@ r5 as valid coordinates 
@ r6 as valid terrain types 

ldr r0, =MemorySlot 
mov r6, #0x0 
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


ldr r2, =MemorySlot 
ldr r1, [r2, #4*0x05] @ Mem slot 5 
cmp r1, #0 
beq AnyCoordinate
lsl r2, r1, #8 
lsr r2, #24 @ YY 
lsl r1, #24 
lsr r1, #24 @ XX 
ldrb r3, [r0, #0x10] 
cmp r3, r1 
bne NextUnit 
ldrb r3, [r0, #0x11] 
cmp r3, r2 
bne NextUnit 

@ Coordinate matches, so go ahead 


AnyCoordinate: 
mov r5, r0 @unit to autolevel 

ldr		r2, =MemorySlot @
ldr 	r1, [r2, #4*0x04]	@valid unit ID 


cmp 	r1, #0
beq 	Start 	@00=ANY 
cmp 	r1, #0xFF
beq 	Start @0xFF=ANY 
ldr 	r3, [r5] 
ldrb 	r2, [ r3, #0x04 ] @ r2 now has your character ID.
lsr 	r0, r1, #0x8 
cmp 	r0, #0 
beq 	Check_exact_unit_match 

cmp 	r2, r0 @ current unit ID, unit id lower bound 
blt 	NextUnit 
lsl 	r0, r1, #24 
lsr 	r0, #24 
cmp 	r2, r0 
bgt 	NextUnit 
b 		Start

Check_exact_unit_match: 
cmp 	r1, r2 
bne 	NextUnit 


b Start



Start: 
mov r0, r5
mov r1, r7 
ldr r2, =Get_Hp_Growth
mov r3, #0x1B 
bl Get_Growth_With_Evolutions

ldr r2, =MemorySlot 
ldr r2, [r2, #4*0x03] 
lsl r2, #30
lsr r2, #30 
sub r2, #1 
mov r3, #1 
and r2, r3 
lsl r2, #1 @ to 1/4 
lsr r0, r2 @ if autolevels are hidden, 1/4 Def/Res/Spd/Hp growths 

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





LevelStrength:
mov r0, r5
mov r1, r7 
ldr r2, =Get_Str_Growth
mov r3, #0x1c 
bl Get_Growth_With_Evolutions

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
mov r1, r7 
ldr r2, =Get_Skl_Growth
mov r3, #0x1d
bl Get_Growth_With_Evolutions
@ 90bef74
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
mov r1, r7 
ldr r2, =Get_Spd_Growth
mov r3, #0x1e 
bl Get_Growth_With_Evolutions

ldr r2, =MemorySlot 
ldr r2, [r2, #4*0x03] 
lsl r2, #30
lsr r2, #30 
sub r2, #1 
mov r3, #1 
and r2, r3 
@lsl r2, #1 @ to 1/4 
lsr r0, r2 @ if autolevels are hidden, 1/4 Def/Res/Spd/Hp growths 

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
mov r1, r7 
ldr r2, =Get_Def_Growth
mov r3, #0x1f
bl Get_Growth_With_Evolutions

ldr r2, =MemorySlot 
ldr r2, [r2, #4*0x03] 
lsl r2, #30
lsr r2, #30 
sub r2, #1 
mov r3, #1 
and r2, r3 
@lsl r2, #1 @ to 1/4 
lsr r0, r2 @ if autolevels are hidden, 1/4 Def/Res/Spd/Hp growths 

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
mov r1, r7 
ldr r2, =Get_Res_Growth
mov r3, #0x20
bl Get_Growth_With_Evolutions

ldr r2, =MemorySlot 
ldr r2, [r2, #4*0x03] 
lsl r2, #30
lsr r2, #30 
sub r2, #1 
mov r3, #1 
and r2, r3 
@lsl r2, #1 @ to 1/4 
lsr r0, r2 @ if autolevels are hidden, 1/4 Def/Res/Spd/Hp growths 

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
mov r1, r7 
ldr r2, =Get_Luk_Growth
mov r3, #0x21
bl Get_Growth_With_Evolutions

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
mov r1, r7 
ldr r2, =Get_Mag_Growth
mov r3, #0x3a @ Special case for 0x3a. Not actually loading class data at this byte for the growth. 
bl Get_Growth_With_Evolutions
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




@IncreaseShownLevel:
ldr r0, =MemorySlot 
ldr r0, [r0, #4*0x03] 
cmp r0, #0 
beq SkipIncreaseShownLevel

ldrb r1, [r5, #0x08] @Level 
add r1, r1, r7 
cmp r1, #100
ble StoreLevel
mov r1, #100 
StoreLevel:
strb r1, [r5, #0x08] 
SkipIncreaseShownLevel:


mov r0, r5 
blh CheckCaps 
mov r0, r5 

blh AutolevelSpells
b NextUnit 



.ltorg
.align 


Get_Growth_With_Evolutions:
push {r4-r7, lr}
mov r4, r8
mov r5, r9 
mov r6, r10 
push {r4-r5} 
mov r4, r0 @ unit struct 


mov r5, r1 @ levels 
@r2 as growth getter function 
mov r9, r3 @ class stat growth offset 


ldrb r1, [r4, #8] @ add current level
add r5, r1 @ final expected level 


@r0 as unit struct 
mov lr, r2 @ growth getter function given as a parameter 
.short 0xf800 @ blh to the growth getter function 
mov r7, r0 @ natural growth in final class



ldr r3, =AutolevelTable 
ldr r0, [r4, #4] @ Class pointer 
ldrb r0, [r0, #4] @ Class ID 

lsl r0, #2 
add r3, r0 @ Class entry on autolevelling that we want 
mov r8, r3 

ldr r0, [r3] 
cmp r0, #0 
beq FullGrowth

ldr r0, [r4, #4] @ Class pointer 
mov r2, r9 @ growth offset byte 

cmp r2, #0x3a 
bne NotMag0
ldrb r0, [r0, #4] @ Class ID of current class 
lsl r0, #2 @ 4 bytes per entry in mag table 
ldr r3, =MagClassTable 
add r0, r3 @ Class entry we want 
mov r2, #1 @ Magic growth byte

NotMag0: 

ldrb r0, [r0, r2] @ class growth of the stat we're checking 
sub r7, r0 @ growths without current class bonuses (eg. only unit growths left) 
cmp r7, #0
bge DontPreventNegativeGrowths
mov r7, #0 
DontPreventNegativeGrowths:



mov r3, r8 @ table 
ldrb r0, [r3, #2] 
cmp r0, #0 
beq No2ndClass
blh 0x8019444 @GetClassData
@ r0 as class data pointer for 2nd class 
mov r2, r9 @ growth offset byte 

cmp r2, #0x3a @ 202d04c
bne NotMag1
mov r3, r8 @ table 
ldrb r0, [r3, #2] @ 1st stage 'mon 
lsl r0, #2 @ 4 bytes per entry in mag table 
ldr r3, =MagClassTable 
add r0, r3 @ Class entry we want 
mov r2, #1 @ Magic growth byte

NotMag1: 


ldrb r0, [r0, r2] @ this growth until 
add r0, r7 @ growth bonuses 
mov r3, r8 @ table 
ldrb r1, [r3, #3] 	@ this level 
cmp r1, #1 
blt NoSub
sub r1, #1 @ No level-up from level 0 to 1. 
NoSub: 
mul r0, r1 @ Levels * growth 
mov r6, r0 

@ r5 as final expected level 
@ eg. 42 
@ Venusaur: 42-32 = 10. 10 levels as final evolution 
@ 32 - 16 = 16. 16 levels as ivysaur 
@ 16-1 = 15. 15 levels as bulbasaur 


No2ndClass:
mov r3, r8 @ table 
ldrb r0, [r3] @ Pre-evolved 'mon 
blh 0x8019444 @GetClassData
@ r0 as class data pointer for pre-evolved class 
mov r2, r9 @ growth offset byte 

cmp r2, #0x3a 
bne NotMag2
mov r3, r8 @ table 
ldrb r0, [r3] @ Pre-evolved 'mon 
lsl r0, #2 @ 4 bytes per entry in mag table 
ldr r3, =MagClassTable 
add r0, r3 @ Class entry we want 
mov r2, #1 @ Magic growth byte

NotMag2: 
ldrb r0, [r0, r2] @ this growth until 
add r0, r7 @ growth bonuses 
mov r3, r8 @ table 
ldrb r1, [r3, #1] 	@ this level 
ldrb r2, [r3, #3] @ always 0 if no 2nd pre-evolution 
cmp r1, r5 
ble NoCapOnLevels1 
mov r1, r5 @ 
NoCapOnLevels1: 
cmp r1, r2 
bge LevelsInPenultimateForm 
mov r2, r1 @ 0 levels in this form if we're lower level than evolution level 
LevelsInPenultimateForm: 
sub r1, r2 @ X levels as penultimate form 
mul r0, r1 @ levels * growth 
mov r2, r6 @ current levels * growth 
add r2, r0 
mov r6, r2 
@ get levels in class * growth% 

@ current class 
ldr r0, [r4, #4] @ Class pointer 
mov r2, r9 

cmp r2, #0x3a 
bne NotMag3
ldrb r0, [r0, #4] @ Class ID of current class 
lsl r0, #2 @ 4 bytes per entry in mag table 
ldr r3, =MagClassTable 
add r0, r3 @ Class entry we want 
mov r2, #1 @ Magic growth byte

NotMag3: 


ldrb r0, [r0, r2] @ some Growth 
add r0, r7 @ growth bonuses 
mov r1, r5 @ final expected level 
mov r3, r8 @ table 
ldrb r2, [r3, #1] @ always 0 if no pre-evolution 
cmp r1, r5 
ble NoCapOnLevels2
mov r1, r5 @ 
NoCapOnLevels2: 
cmp r1, r2 
bge LevelsInCurrentForm 
mov r2, r1 @ 0 levels in this form if we're lower level than evolution level, thereby having levels only in pre-evo stage 
LevelsInCurrentForm: 

sub r1, r2 @ Number of levels in current stage 
mul r0, r1 @ levels * growth 
mov r2, r6 @ current levels * growth 
add r2, r0 
mov r6, r2 

@ divide by number of levels to get final average growth 
mov r0, r6 @ growths*levels in various stages 
mov r1, r5 @ number of levels to gain 
cmp r1, #1
blt NoSub2 
sub r1, #1 @ no level-up for level 0 to 1 
NoSub2: 
swi 6 @ divide 
mov r7, r0 @ average growth 


FullGrowth:
mov r0, r7 @ Growth 
cmp r0, #200  
blt NoBreak 
cmp r0, #0 
bge NoBreak 
mov r11, r11 @ if you hit this break point, then you have negative growths which will break things 
mov r0, #0 
NoBreak: 

pop {r4-r5} 
mov r8, r4
mov r9, r5 
pop {r4-r7} 
pop {r1}
bx r1 
.ltorg 
.align 








