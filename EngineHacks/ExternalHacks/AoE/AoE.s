.thumb
.align 4

.include "_TargetSelectionDefinitions.s"
.include "Definitions.s"


.macro blh to, reg=r3
  ldr \reg, =\to
  mov lr, \reg
  .short 0xf800
.endm

	
.align 4
.global AoE_Usability 
.type AoE_Usability, %function 

AoE_Usability:
push {r4-r7, lr} 
@ given r0 = specific AoE table entry we want 
mov r4, r0 




ldr r3, =AoE_SkillTester 
ldr r3, [r3] @ word 0 if skill tester doesn't exist 
cmp r3, #0 
beq SkipSkillTester
ldrb r1, [r4, #SkillByte]
cmp r1, #0 
beq SkipSkillTester
cmp r1, #255 
beq SkipSkillTester
ldr r0, =CurrentUnit 
ldr r0, [r0] 
mov lr, r3 
.short 0xf800 
cmp r0, #0 
beq ReturnFalseLadder
b SkipSkillTester
ReturnFalseLadder: 
b ReturnFalse 

SkipSkillTester:

@ given r0 = unit struct, r1 = move ID, return T/F whether unit knows this move 
ldr r3, =AoE_Pokemblem_MoveTester 
ldr r3, [r3] @ word 0 if move tester doesn't exist 
cmp r3, #0 
beq SkipMoveTester
ldrb r1, [r4, #GaidenSpellWexpByte]
cmp r1, #0 
beq SkipMoveTester
cmp r1, #255 
beq SkipMoveTester
ldr r0, =CurrentUnit 
ldr r0, [r0] 
mov lr, r3 
.short 0xf800 
cmp r0, #0 
beq ReturnFalse

SkipMoveTester:



ldrb r1, [r4, #ConfigByte] @ Stationary bool 
mov r0, #UsableOnlyIfStationaryBool
tst r0, r1 
beq SkipStationaryCheck
ldr r3, =pActionStruct 
ldrb r0, [r3, #0x10] @ squares moved this turn 
cmp r0, #0 
bne ReturnFalse 



SkipStationaryCheck: 
ldr r3, =CurrentUnit 
ldr r5, [r3] @ unit struct ram pointer 

ldrb r0, [r4, #UnitByte] @ Unit ID 


cmp r0, #0x00 
beq ValidUnit
ldr r1, [r5] @ Char 
ldrb r1, [r1, #4] @ unit id 
cmp r0, r1 
bne ReturnFalse

ValidUnit:

ldrb r0, [r4, #ClassByte] @ class 
cmp r0, #0 
beq ValidClass
ldr r1, [r5, #4] @ class 
ldrb r1, [r1, #4] @ class id 
cmp r0, r1 
bne ReturnFalse

ValidClass:

@ check lvl 
ldrb r0, [r4, #LevelByte] 
cmp r0, #0 
beq ValidLevel
ldrb r1, [r5, #8] @ level ? 
cmp r0, r1 
bgt ReturnFalse

ValidLevel:
ldrh r0, [r4, #FlagShort]
cmp r0, #0 
beq ValidFlag
blh CheckEventId
cmp r0, #1 
bne ReturnFalse

ValidFlag:
ldrb r0, [r4, #ItemByte] @ Req Item 
cmp r0, #0 
beq ValidItem
mov r1, #0x1C 
InventoryLoop: 
add r1, #2 
cmp r1, #0x28 
bge ReturnFalse
ldrb r2, [r5, r1] 
cmp r2, #0 
beq ReturnFalse
cmp r2, r0 
bne InventoryLoop
@ They have said item, so check if can wield / is staff 
ldrh r6, [r5, r1] @ item SHORT 
mov r0, r6 
blh GetItemAttributes
mov r1, #5 @ Equippable / Staff 
tst r0, r1 
beq ValidItem 

mov r1, #4 @ Staff 
tst r0, r1 
bne IsStaff

mov r0, r5 @ unit 
mov r1, r6 @ item 
blh CanUnitUseWeapon
cmp r0, #1 
beq ValidItem 
b ReturnFalse 


IsStaff: 

mov r0, r5 
mov r1, r6 
blh CanUnitUseStaff
cmp r0, #1 
beq ValidItem 
b ReturnFalse 

ValidItem:

@CheckHPCost
ldrb r0, [r4, #HpCostByte] @ Hp Cost 
cmp r0, #0 
beq ValidHPCost

ldrb r1, [r5, #0x13] @ Curr HP
cmp r1, r0 
ble ReturnFalse
ValidHPCost:

ldrb r0, [r4, #WeaponType] @ usable if you have this weapon type in inventory 
cmp r0, #0xFF 
beq ValidWeaponType 

mov r7, #0x1c @ almost items 
WeaponTypeLoop: 
add r7, #2 
cmp r7, #0x26 
bgt ReturnFalse 
ldrh r6, [r5, r7] 
mov r0, r6 @ weapon ID 
blh GetItemType
ldrb r1, [r4, #WeaponType] 
cmp r0, r1 
bne WeaponTypeLoop 
@ weapon type is the same, but can we use this weapon? 

mov r0, r5 @ unit 
mov r1, r6 @ weapon ID 
blh CanUnitUseWeapon
cmp r0, #1 
bne WeaponTypeLoop 
mov r0, r6 @ weapon ID 
blh GetItemRequiredExp
ldrb r1, [r4, #WEXP_Req]
cmp r0, r1 
blt WeaponTypeLoop @ the weapon is a lower rank than what we require 
b ValidWeaponType 

ValidWeaponType: 
ReturnTrue: 
mov r0, #1 
b Finish_Usability 


ReturnFalse: 
mov r0, #3 


Finish_Usability: 
pop {r4-r7}
pop {r1} 
bx r1 
.ltorg 


.align 4
.global AoE_ClearBG2
.type AoE_ClearBG2, %function 
AoE_ClearBG2:
push {lr}
ldr r0, =0x02024cb0 @gBg2MapTarget	@{U}
@ldr r0, =0x02024CB0 @gBg2MapTarget	@{J}
ldr r0, [r0]
mov r1, #0 
blh 0x8001220 @FillBgMap	@FillBgMap(gBg2MapBuffer,0);	@{U}
@blh 0x80011D0 @FillBgMap	@FillBgMap(gBg2MapBuffer,0);	@{J}
pop {r0}
bx r0 


.align 4
.global AoE_CallDisplayDamageArea
.type AoE_CallDisplayDamageArea, %function 

AoE_CallDisplayDamageArea:
push {r4-r6, lr}

mov r4, r0 
mov r5, r1 
mov r6, r2 @ rotation byte 
bl AoE_GetTableEntryPointer
mov r2, r0 
mov r0, r4 
mov r1, r5 
mov r3, r6 @ rotation byte 
bl AoE_DisplayDamageArea

pop {r4-r6} 
pop {r0}
bx r0 

.ltorg 
.global AoE_DrawDamageDealt
.type AoE_DrawDamageDealt, %function 
AoE_DrawDamageDealt: 
push {r4-r7, lr} 
mov r4, r8 
push {r4} 
mov r5, r9
push {r5} 
mov r6, r10 
push {r6} 
mov r8, r0 @ aoe table entry 

bl Draw_LoadNumbers @ so palette etc will be ready 

@ find all affected tiles in movement map and display a number there 
ldr r4, =MovementMap @ Movement Map	@{U}
ldr r4, [r4] 
mov r9, r4 

ldr r3, =0x202E4D4 @ Map Size	@{U}
@ldr r3, =0x202E4D0 @ Map Size	@{J}
ldrh r6, [r3] @ XX Boundary size 
ldrh r7, [r3, #2] @ YY Boundary size 



mov r5, #0 @ Y coord 
sub r5, #1 

DamageDealt_YLoop:
add r5, #1 
cmp r5, r7 
bge BreakDamageDealtLoop

mov r4, #0 
sub r4, #1 
DamageDealt_XLoop:
lsl r0, r5, #2 @ 4 times Y coord 
mov r3, r9 @ movement map 
ldr r1, [r3, r0] @ beginning of Y row 

DamageDealt_XLoop_2:
add r4, #1 
cmp r4, r6 
bge DamageDealt_YLoop @ Finished the row, so +1 to Y coord 
ldrb r0, [r1, r4] @ Xcoord to check 
cmp r0, #0xFF 
beq DamageDealt_XLoop_2

@ We found a valid tile 
mov r0, r4 @ XX 
mov r1, r5 @ YY



ldr 	r2, =UnitMapRows
ldr		r2,[r2]			@Offset of map's table of row pointers
lsl		r1,#0x2			@multiply y coordinate by 4
add		r2,r1			@so that we can get the correct row pointer
ldr		r2,[r2]			@Now we're at the beginning of the row data
add		r2,r0			@add x coordinate
ldrb	r0,[r2]			@deployment byte 
cmp r0, #0 
beq DamageDealt_XLoop 
blh GetUnit 
cmp r0, #0 
beq DamageDealt_XLoop 
mov r10, r0 @ Target 

@ drawing part 
ldr r0, =CurrentUnit 
ldr r0, [r0] @ actor 
mov r1, r10 @ target 

mov r3, r8 @ table 
ldrb r3, [r3, #ConfigByte]
mov r2, #HealBool
tst r3, r2 
beq PreviewDamage
mov r2, r8 @ table 
mov r3, #1 @ always return minimum damage / highest possible hp left 
bl AoE_HealedTargetFinalHp
mov r3, r10 @ target 
ldrb r3, [r3, #0x12] @ Max HP 
cmp r0, r3 
ble ContinuePreviewHpBars 
mov r0, r3 
b ContinuePreviewHpBars


PreviewDamage: 
mov r2, r8 @ table 
mov r3, #1 @ always return minimum damage / highest possible hp left 
bl AoE_CalcTargetRemainingHP
cmp r0, #0 
bge ContinuePreviewHpBars 
mov r0, #0 

ContinuePreviewHpBars:
mov r3, r10 @ target 
ldrb r3, [r3, #0x12] @ Max HP 
cmp r3, r0 
beq DamageDealt_ShowFull 
cmp r0, #0 
beq DamageDealt_ShowEmpty 

sub r3, r0 @ damage

@mov r0, r4 @ XX 
@mov r1, r5 @ YY
@ r0 = xx coord 
@ r1 = yy coord 
@mov r2, #0 @ frames since started 
@ r3 = damage to deal 
@bl Draw_NumberDuringAoE

@ r0 as remaining hp 
mov r3, r10 @ target 
ldrb r1, [r3, #0x12] @ Max HP 
mov r3, r1 
sub r3, r0 @ max hp - final hp = damage taken 
mov r0, r3 

mov r2, #11
mul r0, r2 
mov r3, r10 @ target 

cmp r1, #0 @ max hp 
beq DamageDealt_XLoop @ do not divide by 0 
swi #6 @ @damage*12/maxHP
mov r2, r0 @ fraction of hp bar to be damaged by 
b CallDrawHpBar 

DamageDealt_ShowEmpty:
mov r2, #11 
b CallDrawHpBar 
DamageDealt_ShowFull:
mov r2, #12
b CallDrawHpBar 


CallDrawHpBar: 
mov r0, r4 @ XX 
mov r1, r5 @ YY

bl Draw_HPBar_AoE

b DamageDealt_XLoop 


BreakDamageDealtLoop: 
pop {r6}
mov r10, r6 
pop {r5}
mov r9, r5 
pop {r4} 
mov r8, r4 
pop {r4-r7} 
pop {r0} 
bx r0 
.ltorg 


.global AoE_DrawNumber
.type AoE_DrawNumber, %function 
AoE_DrawNumber: 
push {r4-r7, lr} 
mov r4, r8 
push {r4} 
mov r5, r9
push {r5} 
mov r6, r10 
push {r6} 
mov r7, r11 
push {r7} 
mov r8, r0 @ aoe table entry 
mov r11, r1 @ parent proc 


ldrb r0, [r0, #ConfigByte]
mov r1, #HealBool
tst r0, r1 
beq Yellow
bl LoadBlueNumbers @ healing uses blue numbers 
b DoneLoadingNumbers 

Yellow: 
bl Draw_LoadNumbers @ so palette etc will be ready 

DoneLoadingNumbers: 

@ find all affected tiles in movement map and display a number there 
ldr r4, =MovementMap @ Movement Map	@{U}
ldr r4, [r4] 
mov r9, r4 

ldr r3, =0x202E4D4 @ Map Size	@{U}
@ldr r3, =0x202E4D0 @ Map Size	@{J}
ldrh r6, [r3] @ XX Boundary size 
ldrh r7, [r3, #2] @ YY Boundary size 



mov r5, #0 @ Y coord 
sub r5, #1 

Number_YLoop:
add r5, #1 
cmp r5, r7 
bge BreakNumberLoop

mov r4, #0 
sub r4, #1 
Number_XLoop:
lsl r0, r5, #2 @ 4 times Y coord 
mov r3, r9 @ movement map 
ldr r1, [r3, r0] @ beginning of Y row 

Number_XLoop_2:
add r4, #1 
cmp r4, r6 
bge Number_YLoop @ Finished the row, so +1 to Y coord 
ldrb r0, [r1, r4] @ Xcoord to check 
cmp r0, #0xFF 
beq Number_XLoop_2

@ We found a valid tile 
mov r0, r4 @ XX 
mov r1, r5 @ YY



ldr 	r2, =UnitMapRows
ldr		r2,[r2]			@Offset of map's table of row pointers
lsl		r1,#0x2			@multiply y coordinate by 4
add		r2,r1			@so that we can get the correct row pointer
ldr		r2,[r2]			@Now we're at the beginning of the row data
add		r2,r0			@add x coordinate
ldrb	r0,[r2]			@deployment byte 
cmp r0, #0 
beq Number_XLoop 
blh GetUnit 
cmp r0, #0 
beq Number_XLoop 
mov r10, r0 @ Target 

@ drawing part 




ldr r0, =CurrentUnit 
ldr r0, [r0] @ actor 
mov r1, r10 @ target 


mov r3, r8 @ table 
ldrb r3, [r3, #ConfigByte]
mov r2, #HealBool
tst r3, r2 
beq DamageNotHeal

mov r2, r8 @ table 
mov r3, #1 @ always return minimum damage 
bl AoE_HealedTargetFinalHp
mov r3, r10 @ target 
ldrb r2, [r3, #0x12] @ max hp 
ldrb r3, [r3, #0x13] 
cmp r2, r3 
beq Number_XLoop @ if full hp, don't draw a number 
sub r3, r0, r3 @ amount healed  
b ContinueDrawNumber 

DamageNotHeal: 
mov r2, r8 @ table 
mov r3, #1 @ always return minimum damage / highest possible hp left 
bl AoE_CalcTargetRemainingHP
@ need the actual damage that we did 
@ r0 as remaining hp of target 
mov r3, r10 @ target 
ldrb r3, [r3, #0x13] 
sub r3, r0 @ damage 

ContinueDrawNumber: 




mov r2, r11 @ parent proc 
ldr r2, [r2, #0x2c] @ start time 



mov r0, r4 @ XX 
mov r1, r5 @ YY
bl Draw_NumberDuringAoE

b Number_XLoop 


BreakNumberLoop: 
pop {r7} 
mov r11, r7 
pop {r6}
mov r10, r6 
pop {r5}
mov r9, r5 
pop {r4} 
mov r8, r4 
pop {r4-r7} 
pop {r0} 
bx r0 
.ltorg 


.type AoE_DrawDamageFunc, %function 
.global AoE_DrawDamageFunc 
AoE_DrawDamageFunc: 
push {r4, lr} 
mov r4, r0 
ldr r3, =MemorySlot 
add r3, #4*0x0B @ sB 
ldr r0, [r3] 
cmp r0, #0 
beq Break 

bl AoE_GetTableEntryPointer
@ r0 = entry 
mov r1, r4 @ parent proc 
bl AoE_DrawNumber 


b Loop_AoE_DrawDamageFunc

Break: 
mov r0, r4 @ parent 
mov r1, #1 
blh ProcGoto
b Exit_AoE_DrawDamageFunc 



Loop_AoE_DrawDamageFunc: 
mov r1, #0 
mov r0, r4 
blh ProcGoto

Exit_AoE_DrawDamageFunc: 

pop {r4} 
pop {r0} 
bx r0 
.ltorg 



.global AoE_StartDrawingProc
.type AoE_StartDrawingProc, %function 
AoE_StartDrawingProc:
push {lr} 
mov r1, #3 @ root proc 3 
ldr r0, =AoE_DrawDamageProc
@ arguments: r0 = pointer to ROM 6C code, r1 = parent; returns: r0 = new 6C pointer (0 if no space available)
blh New6C
push {r0} 
blh GetGameClock 
pop {r1}
str r0, [r1, #0x2c] @ start time 

pop {r0} 
bx r0 
.ltorg 

@ while hovering, this is only called when hovering over a new menu option 
@ while in free select, this is called each frame 
.align 4
.global AoE_DisplayDamageArea
.type AoE_DisplayDamageArea, %function 

AoE_DisplayDamageArea:

push {r4-r7, lr} 

@given r0 = xx, r1 = yy, r2= table entry pointer, display movement squares in a template around it 
mov r4, r0 
mov r5, r1 
mov r6, r2 @ AoE_GetTableEntryPointer
mov r7, r3 @ rotation byte 



ldr r0, =0x202E4E0 @ Movement map	@{U}
@ldr r0, =0x202E4DC @ Movement map 	@{J}

ldr r0, [r0] 
mov r1, #0xFF
blh FillMap

ldr r0, =0x202E4F0 @ Backup Movement map	@{U}
@ldr r0, =0x202E4EC @ Backup Movement map	@{J}
ldr r0, [r0] 
mov r1, #0xFF
blh FillMap



ldrb r2, [r6, #RangeMaskByte]
lsl r2, #2 @ x4 
add r2, r7 @rotation byte 
lsl r2, #2 @ 4 words per entry 
ldr r1, =RangeTemplateIndexList
ldr r2, [r1, r2] @ POIN to the RangeMask we want 



@ Arguments: r0 = center X, r1 = center Y, r2 = pointer to template
mov r0, r4 @ XX 
mov r1, r5  @ YY 
bl CreateMoveMapFromTemplate

ldrb r1, [r6, #ConfigByte] @ Stationary bool 
mov r0, #HealBool
and r0, r1 
cmp r0, #0 
beq DisplayRed
mov r0, #0x44 @ Green / purple
b DisplayColour
DisplayRed:
mov r0, #0x42 @ red / purple
DisplayColour:
@ purple now, thanks to huichelaar & mokha 
blh 0x801da98 @DisplayMoveRangeGraphics	@{U}
@blh 0x801D6FC @DisplayMoveRangeGraphics	@{J}

mov r0, r6 @ aoe table entry 
bl AoE_DrawDamageDealt 

pop {r4-r7}
pop {r0} 
bx r0 




.align 4
.global AoE_ShowBrokenWall_Vertical
.type AoE_ShowBrokenWall_Vertical, %function 
AoE_ShowBrokenWall_Vertical:
push {r4-r7, lr}

@ r0 is the parent proc 
mov r4, r0 

bl AoE_FindHighestMoveMapTile
@ returns r0 X and r1 Y 
mov r5, r0 @ X 
mov r6, r1 @ Y 

cmp r0, #0xFF 
beq ExitRocksAnim

mov r2, #2 @ Down (search direction) 
bl AoE_FindNumberOfTilesForLineOfRocks
@ returns # of rocks in r0 
cmp r0, #1 
ble ExitRocksAnim


sub sp, #0x4

str r0,[sp, #0x0]  @ Count of rocks 
mov r1, r5 @ XX 
mov r2, r6 @ YY 

@ldr r3, =pActionStruct
@ldrb r0, [r4, #0x13] @ XX 
@ldrb r1, [r4, #0x14] @ YY


mov r3, #2 @ Down (Direction) 
@ 0 = left, 1 = right, 2 = down, 3 = up
mov r0, r4 @ Parent proc 

blh 0x0801F780, r7 @FE8U Show_BrokenWall_Effect	@{U}
@blh  0x0801F3D8		@FE8J Show_BrokenWall_Effect	@{J}

add sp, #0x4



ExitRocksAnim:

pop {r4-r7} 
pop {r0}
bx r0


.align 4
.global AoE_ShowBrokenWall_Horizontal
.type AoE_ShowBrokenWall_Horizontal, %function 
AoE_ShowBrokenWall_Horizontal:
push {r4-r7, lr}

@ r0 is the parent proc 
mov r4, r0 

bl AoE_FindLeftMostMoveMapTile
mov r5, r0 @ XX 
mov r6, r1 @ YY 
cmp r0, #0xFF 
beq ExitRocksAnimHorizontal

@ if horizontal line is size of 1 tile, we won't do anything 

mov r2, #1 @ right (search direction) 
bl AoE_FindNumberOfTilesForLineOfRocks
cmp r0, #1 
ble ExitRocksAnimHorizontal

sub sp, #0x4
str r0,[sp, #0x0]  @ Count of rocks 
mov r1, r5 @ XX 
mov r2, r6 @ YY 

mov r3, #1 @ right (Direction) 
@ 0 = left, 1 = right, 2 = down, 3 = up
mov r0, r4 @ Parent proc 

blh 0x0801F780, r7 @FE8U Show_BrokenWall_Effect	@{U}
@blh 0x0801F3D8		@FE8J Show_BrokenWall_Effect	@{J}

ADD SP, #0x4

ExitRocksAnimHorizontal:

pop {r4-r7} 
pop {r0}
bx r0


.align 4
.global  AoE_FindNumberOfTilesForLineOfRocks
.type  AoE_FindNumberOfTilesForLineOfRocks, %function 
AoE_FindNumberOfTilesForLineOfRocks:
push {r4-r7, lr}
@ given r0 = XX, r1 = yy, r2 = direction to search, return the number of tiles in the move map that are not 0xFF 

mov r5, r2 @ direction 
ldr r3, =0x202E4D4 @ Map Size @{U}
@ldr r3, =0x202E4D0 @ Map Size @{J}
ldrh r6, [r3] @ XX 
ldrh r7, [r3, #2] @ YY 

ldr r4, =0x202E4E0 @ Movement Map pointer	@{U}
@ldr r4, =0x202E4DC @ Movement Map pointer 	@{J}
ldr r4, [r4] @ movement map 

cmp r5, #2 
beq SearchDown
cmp r5, #1 
bne RockTilesLength_False

mov r5, #0 @ Counter 

SearchRightLoop:
@ r0 = XX, r1 = YY 
@ r0 = XX, r1 = YY 
add r5, #1
add r0, #1 
cmp r0, r6 
bge RockTilesLength_Exit


lsl		r3, r1,#0x2			@multiply y coordinate by 4
add		r3,r4			@so that we can get the correct row pointer
ldr		r3,[r3]			@Now we're at the beginning of the row data
add		r3,r0			@add x coordinate
ldrb	r2,[r3]			@load datum at those coordinates
cmp r2, #0xFF 
bne SearchRightLoop

b RockTilesLength_Exit


SearchDown:
mov r5, #0 @ Counter 

SearchDownLoop: 
@ r0 = XX, r1 = YY 
add r5, #1
add r1, #1 
cmp r1, r7 
bge RockTilesLength_Exit


lsl		r3, r1,#0x2			@multiply y coordinate by 4
add		r3,r4			@so that we can get the correct row pointer
ldr		r3,[r3]			@Now we're at the beginning of the row data
add		r3,r0			@add x coordinate
ldrb	r2,[r3]			@load datum at those coordinates
cmp r2, #0xFF 
bne SearchDownLoop

b RockTilesLength_Exit

RockTilesLength_False:
mov r5, #0 

RockTilesLength_Exit:
mov r0, r5 

pop {r4-r7} 
pop {r3}
bx r3







.align 
.global AoE_FindHighestMoveMapTile
.type AoE_FindHighestMoveMapTile, %function 
AoE_FindHighestMoveMapTile:

push {r4-r7, lr}

mov r7, r8 
push {r7} 

ldr r3, =0x202E4D4 @ Map Size @{U}
@ldr r3, =0x202E4D0 @ Map Size @{J}
ldrh r6, [r3] @ XX 
ldrh r3, [r3, #2] @ YY 
mov r8, r3 

ldr r3, =MemorySlot 
ldr r5, [r3, #4] @ Slot1 as Nth highest to find 
mov r7, #0 @ 0th found by default 

mov r0, #0 @ Default to false 
ldr r1, =MemorySlot 
add r1, #0x04*0x0C @ Slot C 
str r0, [r1] 


ldr r4, =0x202E4E0 @ Movement Map	@{U}
@ldr r4, =0x202E4DC @ Movement Map 	@{J}
ldr r4, [r4] @ movement map [0,0] 

mov r3, #0 @ Y coord 
sub r3, #1 

YLoop:
add r3, #1 
cmp r3, r8 
bge BreakYLoop
lsl r0, r3, #2 @ 4 times Y coord 
ldr r1, [r4, r0] @ beginning of Y row 
mov r2, #0 
sub r2, #1 
XLoop:
add r2, #1 
cmp r2, r6 
bge YLoop @ Finished the row, so +1 to Y coord 
ldrb r0, [r1, r2] @ Xcoord to check 
cmp r0, #0xFF 
beq XLoop

add r7, #1 @ Nth entry to find 
cmp r7, r5 
blt XLoop

add r0, r2, #1 @ Is the next tile to the right valid too? 
ldrb r0, [r1, r0] 
cmp r0, #0xFF 
beq NoMoreColumns 
mov r0, #1 @ True
b StoreColumnResult
NoMoreColumns:
mov r0, #0 @ False 
StoreColumnResult:
ldr r1, =MemorySlot 
add r1, #0x04*0x0C @ Slot C 
str r0, [r1] 

ValidColumn:
@ We found a valid tile 
mov r0, r2 @ XX 
mov r1, r3 @ YY 

b End_AoE_FindHighestMoveMapTile

BreakYLoop:
mov r0, #0xFF @ -1 / false (no tile found) 
mov r1, #0xFF 


End_AoE_FindHighestMoveMapTile:

pop {r7} 
mov r8, r7 

pop {r4-r7} 
pop {r3}
bx r3







.align 4
.global AoE_FindLeftMostMoveMapTile
.type AoE_FindLeftMostMoveMapTile, %function 
AoE_FindLeftMostMoveMapTile:
push {r4-r7, lr}
mov r7, r8 
push {r7} 

ldr r3, =0x202E4D4 @ Map Size @{U}
@ldr r3, =0x202E4D0 @ Map Size @{J}
ldrh r6, [r3] @ XX 
ldrh r3, [r3, #2] @ YY 
mov r8, r3 

ldr r3, =MemorySlot 
ldr r5, [r3, #4] @ Slot1 as Nth left most to find 
mov r7, #0 @ 0th found by default 

mov r0, #0 @ Default to false 
ldr r1, =MemorySlot 
add r1, #0x04*0x0C @ Slot C 
str r0, [r1] 

ldr r4, =0x202E4E0 @ Movement Map	@{U}
@ldr r4, =0x202E4DC @ Movement Map 	@{J}
ldr r4, [r4] @ movement map [0,0] 

mov r2, #0 @ X coord 
sub r2, #1 
XLoop_2:
add r2, #1 
cmp r2, r6 
bge BreakXLoop_2

mov r3, #0 
sub r3, #1 
YLoop_2:
add r3, #1 
cmp r3, r8
bge XLoop_2 @ Finished the column, so +1 to X coord 
lsl r0, r3, #2 @ 4 times the y coord 
ldr r1, [r4, r0] @ beginning of row 
ldrb r0, [r1, r2] @ coord to check 
cmp r0, #0xFF 
beq YLoop_2

add r7, #1 @ Nth entry to find 
cmp r7, r5 
blt YLoop_2


add r0, r3, #1 @ Is the next tile down valid too? 
lsl r0, #2 @ 4 times y column 
ldr r1, [r4, r0] 
ldrb r0, [r1, r2] 
cmp r0, #0xFF 
beq NoMoreRows
mov r0, #1 @ True
b StoreRowsResult
NoMoreRows:
mov r0, #0 @ False 
StoreRowsResult:
ldr r1, =MemorySlot 
add r1, #0x04*0x0C @ Slot C 
str r0, [r1] 


@ We found a valid tile 
mov r0, r2 @ XX 
mov r1, r3 @ YY 

b End_AoE_FindLeftMostMoveMapTile

BreakXLoop_2:
mov r0, #0xFF 
mov r1, #0xFF 


End_AoE_FindLeftMostMoveMapTile:

pop {r7} 
mov r8, r7 

pop {r4-r7} 
pop {r3}
bx r3

	.equ pr6C_New, 0x08002C7C	@{U}
@	.equ pr6C_New, 0x08002BCC	@{J}
.align 4
.global AoE_Setup 
.type AoE_Setup, %function 

AoE_Setup:

push {r4-r7, lr} 

ldr r4, =CurrentUnit
ldr r4, [r4] 

bl AoE_GetTableEntryPointer
mov r5, r0 
bl AoE_ClearMoveMap 

ldrb r1, [r5, #ConfigByte] 
mov r0, #HealBool
ldr r3, =AoE_FreeSelect @ Proc list 
tst r0, r1 
beq Start_FreeSelect
ldr r3, =AoE_HealFreeSelect @ For green tiles 
Start_FreeSelect:

mov r0, r4 @ CurrentUnit 
ldr r1, =AoE_RangeSetup

@parameters
	@r0 = char pointer
	@r1 = pointer range builder function
	@r2 = nothing now (previously item) 
	@r3 = pointer list for proc
bl AoE_FSTargeting


pop {r4-r7}
pop {r0} 
bx r0 

.align 4
.global AoE_ExternalAnimation
.type AoE_ExternalAnimation, %function 
AoE_ExternalAnimation:
push {r4-r7, lr} 
mov r7, r0 @ Parent Proc 
bl AoE_GetTableEntryPointer

mov r4, r0 
ldrb r0, [r4, #Animation_IDByte] 
@ 12 bytes per entry 
lsl r1, r0, #3 @ 8 bytes
lsl r0, #2 @ 4 bytes  
add r0, r1 @ 12 bytes
mov r5, r0 @ Animation table index byte 
ldr r6, =AoE_Animation_Table 

ldr r0, [r6, r5] @ POIN animation 

cmp r0, #0 
beq NoAnimation 

mov lr, r0 
mov r0, r7 @ Parent proc 
.short 0xF800 @ run the given (animation) routine, whatever that may be 

NoAnimation: 


pop {r4-r7}
pop {r0} 
bx r0 

.global AoEInitNumber
.type AoEInitNumber, %function 
AoEInitNumber: 
push {r4, lr} 
mov r4, r0 
blh GetGameClock 
str r0, [r4, #0x2c] 
pop {r4} 
pop {r0} 
bx r0 
.ltorg 

.equ EnsureCameraOntoPosition,0x08015e0d @ r0 = 0, r1 x, r2 y	@{U}
@.equ EnsureCameraOntoPosition,0x08015E19 @ r0 = 0, r1 x, r2 y	@{J}
.global AoE_Camera
.type AoE_Camera, %function
AoE_Camera:
push {lr}
ldr r3, =MemorySlot
add r3, #4*0x0B
ldrb r1, [r3] @ XX 
ldrb r2, [r3, #2] @ YY 

@r0 as parent 
mov r0, #0 
blh EnsureCameraOntoPosition 
@blh 0x8015D84 @CenterCameraOntoPosition	@{U}
@blh 0x8015D90 @CenterCameraOntoPosition	@{J}
mov r0, #0 

pop {r1} 
bx r1

.global AoE_Camera2
.type AoE_Camera2, %function
AoE_Camera2:
push {lr}
ldr r3, =MemorySlot
add r3, #4*0x0B
ldrb r1, [r3] @ XX 
ldrb r2, [r3, #2] @ YY 

@r0 as parent 
blh 0x08015e0c @EnsureCameraOntoPosition	@{U}
@blh 0x08015E18 @EnsureCameraOntoPosition	@{J}

pop {r1} 
bx r1

@ this starts right away 
.align 4
.global AoE_Animation
.type AoE_Animation, %function 
AoE_Animation:
push {r4-r7, lr} 

ldr r3, =MemorySlot
ldr r1, =0xFFFFFFFF 
str r1, [r3, #8] @ Slot 2 to have the value of "0xFFFFFFFF" 


@mov r0, #0
@ldr r3, =MemorySlot
@add r3, #4*0x0B
@ldrb r1, [r3] @ XX 
@ldrb r2, [r3, #2] @ YY 
@@r0 as parent 
@blh 0x08015e0c @EnsureCameraOntoPosition	@{U}
@@blh 0x08015E18 @EnsureCameraOntoPosition	@{J}


bl AoE_GetTableEntryPointer
mov r4, r0 


ldrb r0, [r4, #Animation_IDByte] 
ldr r3, =MemorySlot 
str r0, [r3, #4*1] 

@ldr r0, =GenericASMC_DrawEvent
@mov r1, #1
@blh EventEngine
@b NoSound

ldr r0, =Call_AoE_ExternalAnimationEvent
mov r1, #1 
blh EventEngine 

ldrb r0, [r4, #Animation_IDByte] 
@ 12 bytes per entry 
lsl r1, r0, #3 @ 8 bytes
lsl r0, #2 @ 4 bytes  
add r0, r1 @ 12 bytes
mov r5, r0 @ Animation table index byte 
ldr r6, =AoE_Animation_Table 
add r5, #4 
ldr r0, [r6, r5] @ POIN event address 
cmp r0, #0 
beq NoEvent
mov r1, #1 
blh EventEngine

NoEvent:
add r5, #4 
ldrh r0, [r6, r5] @ sfx/bgm ID 
cmp r0, #0 
beq NoSound

mov r1, #0 
blh 0x080D01FC   @m4aSongNumStart r0=music id:SOUND // Seems to work fine for SFX 	{U}
@blh 0x080D4EF4   @m4aSongNumStart r0=music id:SOUND // Seems to work fine for SFX	{J}


NoSound: 

ldr r0, =Clear_sBEvent 
@ This needs to be an event so that sB doesn't get cleared until the animation finishes 
mov r1, #1 
blh EventEngine 



pop {r4-r7}
pop {r0} 
bx r0 





@ arguments: r0 = pointer to ROM 6C code, r1 = parent; returns: r0 = new 6C pointer (0 if no space available)
.equ New6CBlocking,                0x08002CE0	@{U}
@.equ New6CBlocking,                0x08002C30	@{J}

.align 4
.global AoE_StartBlockingProc
.type AoE_StartBlockingProc, %function 
AoE_StartBlockingProc:
push {r4-r5, lr} 
mov r4, r0 
mov r1, r4 @ Parent proc 
ldr r0, =AoE_MainProc
@ arguments: r0 = pointer to ROM 6C code, r1 = parent; returns: r0 = new 6C pointer (0 if no space available)
blh New6CBlocking


pop {r4-r5}
pop {r0} 
bx r0 




	.equ BreakProcLoop, 0x08002E94	@{U}
@	.equ BreakProcLoop, 0x08002DE4	@{J}

.align 
.ltorg
.align 4
.global AoE_PauseForAnimation
.type AoE_PauseForAnimation, %function
AoE_PauseForAnimation:
push {r4-r5, lr} 
mov r4, r0 @ Parent? 
mov r0, #0
ldr r3, =MemorySlot
add r3, #4*0x0B 
ldr r0, [r3] 
cmp r0, #0
beq BreakProcLoopNow
b End_AoEPause
BreakProcLoopNow: 
mov r0, r4 @  @ parent to break from 
blh BreakProcLoop
mov r0, #1

End_AoEPause:
pop {r4-r5}
pop {r1}
bx r1 




.align 4
.global AoE_GenericEffect
.type AoE_GenericEffect, %function 
AoE_GenericEffect:
push {r4-r5, lr} 
mov r5, r0 @ Parent Proc? - event engine 

ldr r3, =CurrentUnit
ldr r3, [r3] 
cmp r3, #0 
beq End_AoE



bl AoE_GetTableEntryPointer
mov r4, r0 
ldrb r2, [r4, #RangeMaskByte]
lsl r2, #2 @ x4 
ldr r3, =MemorySlot 
ldrb r3, [r3, #4*0x03] @ Slot 3 as rotation 
lsl r3, #30 
lsr r3, #30 @ Just in case - make only our 4 rotations valid 
add r2, r3 

@ rotation 
lsl r2, #2 @ 4 words per entry 
ldr r1, =RangeTemplateIndexList
ldr r0, [r1, r2] @ POIN to the RangeMask we want 

@ parameters: r0 = RangeMaskPointer 
bl AoE_EffectCreateRangeMap



ldrb r1, [r4, #ConfigByte]
mov r0, #DepleteItemBool
tst r0, r1 
beq DoNotDepleteItem
mov r0, r4 
bl AoE_DepleteItem
DoNotDepleteItem: 

ldrb r0, [r4, #HpCostByte] @ Hp Cost 
cmp r0, #0 
beq SkipHpCost 

ldr r3, =CurrentUnit 
ldr r3, [r3] 
ldrb r1, [r3, #0x13] @ Curr HP
cmp r1, r0 
bgt NoCapHpCost
mov r0, r1 
sub r0, #1 @ deal damage equal to current hp - 1 
NoCapHpCost:
sub r1, r0 
strb r1, [r3, #0x13] @ hp 


SkipHpCost: 

ldrb r1, [r4, #ConfigByte] @ Stationary bool 
mov r0, #HealBool
tst r0, r1 
beq DamageUnits
ldr r0, =AoE_HealUnitsInRange
b Start_ForEachUnitInRange
DamageUnits: 
ldr r0, =AoE_DamageUnitsInRange
Start_ForEachUnitInRange:
blh 0x8024eac @ForEachUnitInRange @ maybe this calls AoE_DamageUnitsInRange for each unit found in the range mask	{U}
@blh 0x8024E5C @ForEachUnitInRange @ maybe this calls AoE_DamageUnitsInRange for each unit found in the range mask	@{J}

ldr r0, =AoE_EventForUnitsInRange @ also does the death fade 
blh 0x8024eac @ForEachUnitInRange

End_AoE:
ldr r1, =CurrentUnitFateData	@these four lines copied from wait routine
mov r0, #0x1
strb r0, [r1,#0x11]



pop {r4-r5}
pop {r0} 
bx r0 
.ltorg 

.global AoE_EventForUnitsInRange 
.type AoE_EventForUnitsInRange, %function 
AoE_EventForUnitsInRange: 
push {r4-r7, lr} 
mov r4, r0 @ Target 
bl AoE_GetTableEntryPointer 
mov r5, r0 @ entry 

mov r0, r4 @ Unit 
ldr r3, =AoE_GetDebuffs 
ldr r3, [r3] 
cmp r3, #0 
beq NoDebuffsPossible 
mov lr, r3 
.short 0xF800 @ blh 
mov r6, r0 @ debuffs pointer 
ldr r1, =AoE_DebuffTable
ldrb r2, [r5, #DebuffID]
@r0 @ debuff entry 
@r1 debuff table to use 
@r2 entry ID of the given table 
mov r3, r0 @ also debuffs pointer 
bl DebuffGivenTableEntry 

NoDebuffsPossible: 


ldr r0, =AoE_EventQueueProc 
blh ProcFind 
cmp r0, #0 
beq NewEventQueueProc
b StoreIntoEventQueueProc

NewEventQueueProc: 
ldr r0, =gProcPlayerPhase 
blh ProcFind 
cmp r0, #0
beq Exit_EventQueueProc
mov r1, r0 @ block player phase proc from continuing 

ldr r0, =AoE_EventQueueProc 
@mov r1, #3 @ root 3 
blh New6CBlocking
mov r1, #0 
mov r2, r0 
add r2, #0x28  @ zero out all the fields 
strb r1, [r2, #1] 
strb r1, [r2, #2] 
strb r1, [r2, #3] 
str r1, [r2, #4] @ 0x2c 
str r1, [r2, #8] @ 30
str r1, [r2, #12] @ 34
str r1, [r2, #16] @ 38
str r1, [r2, #20] @ 3c
str r1, [r2, #24] @ 40
str r1, [r2, #28] @ 44
str r1, [r2, #32] @ 48
str r1, [r2, #36] @ 4c
str r1, [r2, #40] @ 50
str r1, [r2, #44] @ 54
str r1, [r2, #48] @ 58
str r1, [r2, #52] @ 5c
str r1, [r2, #56] @ 60
str r1, [r2, #60] @ 64
str r1, [r2, #64] @ 68

StoreIntoEventQueueProc: 
mov r6, r0 @ EventQueueProc 
add r0, #0x29

ldrb r1, [r0] @ Index of what we've stored 
add r1, #1 @ we've done 1 more 
strb r1, [r0] 
sub r1, #1 @ index we're currently on 

cmp r1, #64
bgt Exit_EventQueueProc @ we can only queue an event for up to 64 bytes / units 

mov r3, r6 
add r3, #0x2c 
ldrb r0, [r4, #0x0B] 
strb r0, [r3, r1] @ deployment ID 


Exit_EventQueueProc: 

pop {r4-r7}
pop {r0} 
bx r0 
.ltorg 

.global AoE_TryEventLoop
.type AoE_TryEventLoop, %function 
AoE_TryEventLoop:
push {r4-r7, lr} 
mov r7, r0 @ Proc 

ldr r0, =gProcEventEngine
blh ProcFind 
cmp r0, #0 
bne ContinueEventLoop @ stall until currently running events are done 

mov r0, r7 
add r0, #0x29 
@ldrb r1, [r0] @ Total 
ldrb r1, [r0, #1] @ Current Index of unit that we're on 
cmp r1, #64 
bgt BreakEventLoop 
add r1, #1 
strb r1, [r0, #1] @ save our next index 
sub r1, #1 @ back to our current index 
mov r0, r7 
add r0, #0x2c 
ldrb r2, [r0, r1] 
cmp r2, #0 
beq BreakEventLoop @ we've gone through every unit in the queue 
mov r0, r2 @ deployment id 
blh GetUnit 
cmp r0, #0 
beq ContinueEventLoop @ skip doing anything
mov r4, r0 @ Unit to act upon 

bl AoE_GetTableEntryPointer 
mov r5, r0 @ entry 
ldrb r0, [r5, #EventIndex]
lsl r0, #2 @ 4 bytes for an event address 
ldr r6, =AoE_EventsTable
add r6, r0 @ address for the specific event we want 



ldr r3, =MemorySlot 
ldr r0, [r4] @ unit pointer 
ldrb r0, [r0, #4] @ unit ID 
str r0, [r3, #4*2] @ s2 as unit ID 
add r3, #0x0B*4 @ sB 
ldrb r0, [r4, #0x10] @ XX 
ldrb r1, [r4, #0x11] @ YY 
strh r0, [r3] 
strh r1, [r3, #2] @ target coordinates in sB 
ldr r0, [r6] @ event to run 
cmp r0, #0 
beq ContinueEventLoop 
mov r1, #1 
blh EventEngine 
@ start our event 



b ContinueEventLoop 

BreakEventLoop: 
@ldr r0, =AoE_EventQueueProc
mov r0, r7 
mov r1, #1 @ label 
blh ProcGoto
b ExitEventLoop 

ContinueEventLoop: 
mov r0, r7 
mov r1, #0 @ label 
blh ProcGoto

ExitEventLoop:
pop {r4-r7}
pop {r0}
bx r0 
.ltorg 


.align 4
.global AoE_GetTableEntryPointer 
.type AoE_GetTableEntryPointer, %function 
AoE_GetTableEntryPointer:
push {lr} 
ldr r0, =AoE_RamAddress @ pointer 
ldr r0, [r0] @ actual address 
ldrb r0, [r0] @ Ram address of previously stored effect index 
ldr r3, =AoE_EntrySize 
ldrb r3, [r3] 
mul r3, r0 
ldr r0, =AoE_Table
add r0, r3 

pop {r1}
bx r1 


.equ ProcFind, 0x08002E9C	@{U}
@.equ ProcFind, 0x08002DEC	@{J}
.equ ClearBG0BG1, 0x0804E884	@{U}
@.equ ClearBG0BG1, 0x0804F610	@{J}
.equ SetFont, 0x8003D38	@{U}
@.equ SetFont, 0x8003C68	@{J}
.equ Font_ResetAllocation, 0x8003D20  	@{U}
@.equ Font_ResetAllocation, 0x8003C50  	@{J}
.equ EndAllMenus, 0x804EF20 	@{U}
@.equ EndAllMenus, 0x804FCAC 	@{J}

.align 4
.global AoE_ClearGraphics
.type AoE_ClearGraphics, %function 
AoE_ClearGraphics:
push {lr} 
bl AoE_ClearRangeMap
blh 0x801dacc @HideMoveRangeGraphics	@{U}
@blh 0x801D730 @HideMoveRangeGraphics	@{J}

bl AoE_ClearBG2 
@ this would probably be better to use if we encounter bugs 
@ 801d6fc PlayerPhase_ReloadGameGfx
@ but it also clears our menu 



blh 0x8019b18 @UpdateGameTileGfx	@{U}
@blh 0x80197F0 @UpdateGameTileGfx	@{J}

@blh ClearBG0BG1
@ copied from vanilla item 'use'
@mov r0, #0 
@blh SetFont 
@blh Font_ResetAllocation 
@blh EndAllMenus
@blh 0x801a1f4 @RefreshEntityMaps	@{U}
@@blh 0x08019ECC @RefreshEntityMaps	@{J}
blh  0x08019c3c   @DrawTileGraphics	@{U}
@blh  0x08019914   @DrawTileGraphics	@{J}

@blh 0x80271a0 @SMS_UpdateFromGameData	@{U}
@@blh 0x8027144 @SMS_UpdateFromGameData	@{J}

@bl AoE_EndTargetSelection 

bl Draw_RoundCleanup

pop {r0}
bx r0 


.align 4
.global AoE_ClearRangeMap
.type AoE_ClearRangeMap, %function 

AoE_ClearRangeMap:
push {lr} 
ldr r0, =0x202E4E4 @ range map pointer @{U}
@ldr r0, =0x202E4E0 @ range map pointer @{J}
ldr r0, [r0]
mov r1, #0
blh 0x80197E4 @MapFill	@{U}
@blh 0x80194BC @MapFill	@{J}
pop {r0}
bx r0 

.align 4
.global AoE_ClearMoveMap
.type AoE_ClearMoveMap, %function 

AoE_ClearMoveMap:
push {lr} 

ldr r0, =0x202E4E0 @ range map pointer	@{U}
@ldr r0, =0x202E4DC @ range map pointer	@{J}
ldr r0, [r0]
mov r1, #0
sub r1, #1
blh 0x80197E4 @MapFill	@{U}
@blh 0x80194BC @MapFill	@{J}
pop {r0}
bx r0 


.type AoE_EffectCreateRangeMap, %function 
.align 4
.global AoE_EffectCreateRangeMap
AoE_EffectCreateRangeMap:

push {r4-r7, lr}
@ r0 = RangeMapPointer 

mov r5, r0 
bl AoE_ClearRangeMap

ldr r0, =CurrentUnit
ldr r4, [r0] 

@ given XX and YY via action struct,
ldr r3, =pActionStruct
ldrb r0, [r3, #0x13]  @@ XX 
ldrb r1, [r3, #0x14] @ YY 
@ Arguments: r0 = center X, r1 = center Y, r2 = pointer to template
mov r2, r5 
bl CreateRangeMapFromTemplate

pop {r4-r7}
pop {r0} 
bx r0 

.type AoE_GetItemUsedOffset, %function 
.global AoE_GetItemUsedOffset 
AoE_GetItemUsedOffset:
push {r4-r7, lr} 

@ r0 = table entry 
mov r4, r0  
ldr r0, =CurrentUnit
ldr r5, [r0] 
mov r6, #0 @ default as none 

@ we want to deplete the lowest weapon rank item 
ldrb r0, [r4, #WeaponType] 
cmp r0, #0xFF @ no weapon type required 
beq ExitWeaponTypeSection
ldrb r1, [r4, #WEXP_Req]
@ no weapon exp required could be prf weapons 


mov r7, #0 @ prev wep to deplete 
mov r6, #0x1c @ almost items 
WeaponTypeLoop_DepleteItem: 
add r6, #2 
cmp r6, #0x26 
bgt MaybeExitWeaponTypeSection 
ldrh r0, [r5, r6] @ weapon ID 
blh GetItemType
ldrb r1, [r4, #WeaponType] 
cmp r0, r1 
bne WeaponTypeLoop_DepleteItem 
@ weapon type is the same, but can we use this weapon? 

mov r0, r5 @ unit 
ldrh r1, [r5, r6] @ weapon ID 
blh CanUnitUseWeapon
cmp r0, #1 
bne WeaponTypeLoop_DepleteItem 
ldrh r0, [r5, r6] @ weapon ID 
blh GetItemRequiredExp
ldrb r1, [r4, #WEXP_Req]
cmp r0, r1 
blt WeaponTypeLoop_DepleteItem @ the weapon is a lower rank than what we require 
cmp r7, #0 @ no item 
beq Skip_CompareForLowestWEXP
push {r0} 
ldrh r0, [r5, r7] @ weapon ID 
blh GetItemRequiredExp
mov r1, r0 
pop {r0} 
@ r1 = prev wep required wexp 
@ r0 = current 
cmp r0, r1 
bgt WeaponTypeLoop_DepleteItem 
Skip_CompareForLowestWEXP: 
mov r7, r6 @ counter 
b WeaponTypeLoop_DepleteItem 

MaybeExitWeaponTypeSection:
cmp r7, #0 
beq ExitWeaponTypeSection 
mov r6, r7 
ldrh r0, [r5, r6] @ weapon ID 
b ReturnItemUsed



ExitWeaponTypeSection: 
ldrb r0, [r4, #ItemByte] @ Req Item 
cmp r0, #0 
beq ReturnItemUsed
mov r1, #0x1C 
InventoryLoop_DepleteItem: 
add r1, #2 
cmp r1, #0x28 
bge ReturnItemUsed
ldrb r2, [r5, r1] 
cmp r2, #0 
beq ReturnItemUsed
cmp r2, r0 
bne InventoryLoop_DepleteItem
ldrh r0, [r5, r1] 
mov r6, r1 

ReturnItemUsed: 
mov r0, r6 
pop {r4-r7} 
pop {r1} 
bx r1 
.ltorg 


.type AoE_DepleteItem, %function 
.align 4
.global AoE_DepleteItem
AoE_DepleteItem:
@ only called if the deplete item bool is set 
push {r4-r7, lr}
@ r0 = table entry 
mov r4, r0  
ldr r0, =CurrentUnit
ldr r5, [r0] 

mov r0, r4 @ table 
bl AoE_GetItemUsedOffset
cmp r0, #0 
beq Done_DepleteItem 

mov r6, r0 @ offset
ldrh r0, [r5, r6] @ item  


@ r0 as item, r6 as counter 
ldrb r1, [r4, #DepleteItemAmount] 
cmp r1, #0 
bne AlreadyDepletingByAtLeastOne
mov r1, #1 
AlreadyDepletingByAtLeastOne: 
lsr r2, r0, #8 @ durability only 
cmp r1, r2 
blt DontSetUsesToZero
mov r0, #0
mov r1, #0
mov r2, #0 
DontSetUsesToZero: 
sub r2, r1 
mov r1, #0xFF 
and r0, r1 
lsl r2, #8 
orr r0, r2 

strh r0, [r5, r6] 
cmp r0, #0 
bne Done_DepleteItem
mov r0, r5 
blh 0x8017984 @RemoveUnitBlankItems	@{U}
@blh 0x801772C @RemoveUnitBlankItems	@{J}

Done_DepleteItem:

pop {r4-r7}
pop {r0} 
bx r0 

.ltorg 
@ hp cost 
@ wexp/item type req ?



.type AoE_CalcTargetRemainingHP, %function 
.global AoE_CalcTargetRemainingHP 
AoE_CalcTargetRemainingHP:
push {r4-r7, lr} 

@ r0 = actor 
@ r1 = target 
@ r2 = AoE table effect address 
@ r3 = do min damage bool 
mov r7, r1 @ target 
mov r6, r0 @ actor 
mov r5, r2 @ table 
mov r4, r3 @ do min damage bool 

ldrb r1, [r5, #ConfigByte] 
mov r0, #FriendlyFireBool
tst r0, r1 
bne AlwaysDamage @ If friendly fire is on, then we heal regardless of allegiance 

mov r2, #0x0B @ Allegiance byte 
ldsb r0, [r6, r2] 
ldsb r1, [r7, r2] 
blh 0x8024d8c @AreAllegiancesAllied	@{U}
@blh 0x8024D3C @AreAllegiancesAllied	@{J}
cmp r0, #1 
beq DoNotDamageTarget

AlwaysDamage: 
ldrb r1, [r5, #ConfigByte]  
mov r0, #FixedDamageBool
tst r0, r1 
bne DoFixedDmg 


mov r0, r5 @ table effect address 
mov r1, r6 @ attacker 
mov r2, r7 @ target 
@r0 = effect index
@r1 = attacker / current unit ram 
@r2 = current target unit ram
mov r3, r4 @ do min damage bool 
bl AoE_RegularDamage @ Returns damage to deal 
b CleanupDamage 

DoFixedDmg: 
mov r0, r5 
mov r1, r6 
mov r2, r7 
mov r3, #0 @ don't return minimum; return a number within the range of dmg 
bl AoE_FixedDamage 


CleanupDamage:

ldrb r1, [r7, #0x13] @ curr hp 
sub r0, r1, r0 

cmp r0, #0 
bgt ReturnRemainingHP 

ldrb r2, [r5, #ConfigByte] 
mov r3, #KeepHP1NotDieBool
tst r3, r2
bne SetHP1

mov r0, #0x0
b ReturnRemainingHP 

SetHP1:
mov r0, #1 
b ReturnRemainingHP 

DoNotDamageTarget: 
ldrb r0, [r7, #0x13] @ curr hp 

NoCapHP:

ReturnRemainingHP: 

pop {r4-r7}
pop {r1} 
bx r1 
.ltorg 






@Let the dead unit speak death Quote to erase it.
@We will take a reliable method even if it is a little inefficient.

@To make it look good, deathQuote is run in bulk at the end.
@The loop starts with DEATHQUOTE_NONE and is set to DEATHQUOTE_RELOOP with delayQuote.
@If there is DEATHQUOTE_RELOOP after the end of the loop, set it to DEATHQUOTE_FIRE to execute deathQuote and loop again.
.equ DEATHQUOTE_NONE, 0x0
.equ DEATHQUOTE_RELOOP, 0x1
.equ DEATHQUOTE_FIRE, 0x2

.align 4
.global AoE_RemoveDeadUnitLoop
.type AoE_RemoveDeadUnitLoop, %function 
AoE_RemoveDeadUnitLoop:
push {r4-r7, lr} 

mov r4, r0	@this procs

@DeathQuote runs on the BattleEventEngine, so wait for it to finish.
blh 0x0800D1B0	@BattleEventEngineExists	{U}
@blh 0x0800D474	@BattleEventEngineExists	{J}
cmp r0, #0x1
beq AoE_RemoveDeadUnitLoop_Exit

mov r7, #DEATHQUOTE_NONE

AoE_RemoveDeadUnitLoop_Setup:
@foeach all units
ldr r5, =0x0202BE4C	@Units {U}
@ldr r5, =0x0202BE48	@Units {J}
ldr r6, =0x0202DDCC+(0x48*0x14)	@Units {U}
@ldr r6, =0x0202DDC8+(0x48*0x14)	@Units {J}

AoE_RemoveDeadUnitLoop_Loop:
ldr r0, [r5]
cmp r0, #0x0
beq AoE_RemoveDeadUnitLoop_Next

ldrb r0, [r5, #0x13] @ curr hp 
cmp  r0, #0x0
bne  AoE_RemoveDeadUnitLoop_Next

ldrb r0, [r5, #0xC] @ curr state 
mov  r1, #0x01 @hide flag
and  r1, r0
bne  AoE_RemoveDeadUnitLoop_Next

ldrb r0, [r5, #0x10] @ curr X 
cmp  r0, #0xff
beq  AoE_RemoveDeadUnitLoop_Next

AoE_RemoveDeadUnitLoop_Match:
@This unit has 0 HP but has not died, so let it die.
ldr  r0, [r5, #0x0] @targetUnit->unit
ldrb r0, [r0, #0x4] @targetUnit->unit->id
blh 0x080835A8	@ShouldDisplayDeathQuoteForChar	@{U}
@blh 0x080858e0	@ShouldDisplayDeathQuoteForChar	@{J}

cmp r0, #0x0
beq AoE_RemoveDeadUnitLoop_KillUnit_Remove

cmp r7, #DEATHQUOTE_FIRE
beq AoE_RemoveDeadUnitLoop_FireDeathQuote

@Death quotes will be executed together later.
mov r7, #DEATHQUOTE_RELOOP
b   AoE_RemoveDeadUnitLoop_Next

AoE_RemoveDeadUnitLoop_FireDeathQuote:
ldr  r0, [r5, #0x0] @targetUnit->unit
ldrb r0, [r0, #0x4] @targetUnit->unit->id
blh 0x080835DC   @DisplayDeathQuoteForChar	@{U}
@blh 0x08085914   @DisplayDeathQuoteForChar	@{J}

AoE_RemoveDeadUnitLoop_KillUnit_Remove:
ldr r3, =CurrentUnit 
ldr r3, [r3] 
ldr r0, [r3, #0x0C] @ state 
mov r1, #1 @ hide 
bic r0, r1 
str r0, [r3, #0x0C] @ so active unit isn't hidden during death fades

mov r0 ,r5
blh 0x08078464   @MakeMOVEUNITForMapUnit	@{U}
@blh 0x0807a888   @MakeMOVEUNITForMapUnit	@{J}
blh 0x0807959C   @StartMoveUnitDeathBlend2	@{U}
@blh 0x0807b9b0   @StartMoveUnitDeathBlend2	@{J}

mov r0, r5
blh 0x08032750   @KillUnitIfNoHealth    {U}
@blh 0x0803269C   @KillUnitIfNoHealth    {J}

blh 0x080321C8   @UpdateMapAndUnit    {U}
@blh 0x08032114   @UpdateMapAndUnit    {J}

b AoE_RemoveDeadUnitLoop_Exit

AoE_RemoveDeadUnitLoop_Next:
add r5, #0x48
cmp r5,r6
blt AoE_RemoveDeadUnitLoop_Loop

@The loop is over.
@If the unit that has DeathQuote is dead and you are putting it off, DEATHQUOTE_RELOOP is defined, so after setting it to DEATHQUOTE_FIRE, turn the loop again.

cmp r7, #DEATHQUOTE_RELOOP
bne AoE_RemoveDeadUnitLoop_BreakProcLoop

mov r7, #DEATHQUOTE_FIRE
b   AoE_RemoveDeadUnitLoop_Setup

AoE_RemoveDeadUnitLoop_BreakProcLoop:

@Now that all the units have been explored, we're done.
mov r0, r4 @  @ parent to break from 
blh BreakProcLoop

AoE_RemoveDeadUnitLoop_Exit:
pop {r4-r7}
pop {r0}
bx r0
.ltorg 

.global AoE_WaitForEvents
.type AoE_WaitForEvents, %function 
AoE_WaitForEvents:
push {r4, lr} 
mov r4, r0 
ldr r0, =AoE_EventQueueProc
blh ProcFind 
cmp r0, #0 
bne WaitForEvents
mov r0, r4 @  @ parent to break from 
blh BreakProcLoop
WaitForEvents: 
pop {r4} 
pop {r0} 
bx r0 
.ltorg 

.equ gProcGotItemPopup, 0x85922D0 
.equ InitBattleUnitFromUnit, 0x802A584 
.equ BATTLE_HandleItemDrop, 0x80328D0 
.equ gProcPlayerPhase, 0x859AAD8 

.type AoE_GotItemDropInit, %function 
.global AoE_GotItemDropInit
AoE_GotItemDropInit:
push {r4-r7, lr} 
mov r4, r8
mov r5, r9 
mov r6, r10 
mov r7, r11 
push {r4-r7} 
mov r8, r0 @ parent proc 
mov r0, #0 
mov r11, r0 @ count of units 

mov r3, r8
add r3, #0x2c @ set as 0 
str r0, [r3] 
str r0, [r3, #4] @ 34 
str r0, [r3, #8] @ 38 
str r0, [r3, #12] @ 3C 
str r0, [r3, #16] @ 40 
str r0, [r3, #20] @ 40 


@ find all affected tiles in range map 
@ldr r4, =RangeMapRows 
ldr r4, =MovementMap
ldr r4, [r4] 
mov r9, r4 

ldr r3, =0x202E4D4 @ Map Size	@{U}
@ldr r3, =0x202E4D0 @ Map Size	@{J}
ldrh r6, [r3] @ XX Boundary size 
ldrh r7, [r3, #2] @ YY Boundary size 



mov r5, #0 @ Y coord 
sub r5, #1 

GotItem_YLoop:
add r5, #1 
cmp r5, r7 
bge BreakGotItemLoop

mov r4, #0 
sub r4, #1 
GotItem_XLoop:
lsl r0, r5, #2 @ 4 times Y coord 
mov r3, r9 @ movement map 
ldr r1, [r3, r0] @ beginning of Y row 

GotItem_XLoop_2:
add r4, #1 
cmp r4, r6 
bge GotItem_YLoop @ Finished the row, so +1 to Y coord 
ldrb r0, [r1, r4] @ Xcoord to check 
cmp r0, #0xFF 
beq GotItem_XLoop_2

@ We found a valid tile 
mov r0, r4 @ XX 
mov r1, r5 @ YY


@ 0x80321c8 


ldr 	r2, =UnitMapRows
ldr		r2,[r2]			@Offset of map's table of row pointers
lsl		r1,#0x2			@multiply y coordinate by 4
add		r2,r1			@so that we can get the correct row pointer
ldr		r2,[r2]			@Now we're at the beginning of the row data
add		r2,r0			@add x coordinate
ldrb	r0,[r2]			@deployment byte 
cmp r0, #0 
beq GotItem_XLoop 
mov r10, r0 @ target deployment byte 
blh GetUnit 
cmp r0, #0 
beq GotItem_XLoop 
ldr r1, [r0, #0xC] 
mov r2, #0x10 
lsl r2, #8 @ 0x1000 is DropItem bitflag 
tst r1, r2 
beq GotItem_XLoop 
ldrb r1, [r0, #0x13] @ current HP 
cmp r1, #0 
bne GotItem_XLoop 

mov r1, r10 @ target deployment byte 



mov r2, r11 @ count of targets 


mov r3, r8 @ proc 
add r3, #0x30 
strb r1, [r3, r2] @ count down for droppable items 

add r2, #1 
mov r11, r2 

mov r10, r0 @ Target 

cmp r2, #16 
bge BreakGotItemLoop @ up to 16 dropped items at once 
b GotItem_XLoop 


BreakGotItemLoop: 

pop {r4-r7} 
mov r8, r4 
mov r9, r5 
mov r10, r6 
mov r11, r7 
pop {r4-r7} 
pop {r0} 
bx r0 
.ltorg 

.type AoE_GotItemDrop, %function 
.global AoE_GotItemDrop
AoE_GotItemDrop:
push {r4-r7, lr} 
mov r4, r0 @ parent proc 

@ loop through affected units and find Nth case 
@ try drop item for each 0 hp unit 

ldr r1, =CurrentUnit 
ldr r1, [r1] @ unit 
ldr r0, =Attacker 
str r1, [r4, #0x54] @ unit used in gProcGotItemPopup 
blh InitBattleUnitFromUnit

ldr r0, [r4, #0x2C] @ index
cmp r0, #1
bge SendRemainingItemsToSupply 

mov r1, r4 
add r1, #0x30 
ldrb r0, [r1, r0] 
cmp r0, #0 
bne Continue_GotItemDrop 
mov r0, #16 
str r0, [r4, #0x2C] 
b Exit_GotItemDropNow
SendRemainingItemsToSupply: 
sub r0, #1 
str r0, [r4, #0x2C] @ index

SendRemainingItemsToSupplyLoop: 
ldr r0, [r4, #0x2C] @ index
add r0, #1 
str r0, [r4, #0x2C] @ index
mov r1, r4 
add r1, #0x30 
ldrb r0, [r1, r0] 
cmp r0, #0 
bne ContinueSendRemainingItemsToSupply 
mov r0, #16 
str r0, [r4, #0x2C] 
b Exit_GotItemDropNow
ContinueSendRemainingItemsToSupply: 
blh GetUnit 

mov r3, #0x1C
DroppableItemLoop:
add r3, #2 @ SHORT 
ldrh r1, [r0, r3] @ item 
cmp r3, #0x28 
bge SendRemainingItemsToSupplyLoop 
cmp r1, #0 
bne DroppableItemLoop 

sub r3, #2 
ldrh r6, [r0, r3] @ item 

@	ldr  r3, =0x8031508 @size of convoy	{J}
	ldr  r3, =0x80315bc @size of convoy	{U}
	ldrb r3, [r3] @normally 0x63

@	ldr  r0, =0x8031500 @pointer to convoy	{J}
	ldr  r0, =0x80315b4 @pointer to convoy	{U}
	ldr  r0, [r0]

	lsl  r3, #0x01            @end = size*2 + convoy
	add  r3, r0

SupplyItemLoop:
	cmp  r0,r3
	bgt  SendRemainingItemsToSupplyLoop
	ldrb r1,[r0]
	cmp  r1,#0x00
	beq  StoreItem
	add  r0,#0x02
	b    SupplyItemLoop

StoreItem:                    @アイテムを書き込む
	strh r6,[r0]
b SendRemainingItemsToSupplyLoop


Continue_GotItemDrop: 
blh GetUnit 
mov r1, r0 
ldr r0, =Defender 


ldrh r3, [r1, #0x1E] @ item 
mov r2, r4 
add r2, #0x58 
strh r3, [r2] @ item to drop 
blh InitBattleUnitFromUnit


ldr r0, =gProcPlayerPhase 
blh ProcFind 
mov r5, r0 @ parent proc 
mov r1, r5 @ player phase proc 
mov r0, r4 
@blh BATTLE_HandleItemDrop

@ldr r0, =gProcGotItemPopup
@mov r1, r4 @ parent proc 

ldr r0, =0x859DB08 @ poin to some proc we want 
ldr r0, [r0] 
blh New6CBlocking
mov r0, r4 @ proc to store deployment bytes of attacker and defender in +0x64 and +0x66 
ldr r0, [r4, #0x2c] @ index  
add r0, #1 
str r0, [r4, #0x2c] 

@mov r0, r5 @ player phase proc 
@mov r1, #7 @ label 
@blh ProcGoto 

Exit_GotItemDropNow:

pop {r4-r7} 
pop {r0} 
bx r0 
.ltorg 

.type CallAoE_DroppedItemsProc, %function 
.global CallAoE_DroppedItemsProc
CallAoE_DroppedItemsProc:
push {lr} 
ldr r0, =AoE_DroppedItemsProc
mov r1, #3 @ root proc 3 
blh New6C 
pop {r0} 
bx r0 
.ltorg 


.type AoE_GotItemDropLoop, %function 
.global AoE_GotItemDropLoop
AoE_GotItemDropLoop:
push {r4-r7, lr} 
mov r4, r0 @ parent proc 

// BATTLE_HandleItemDropwait for 85922D0 gProcGotItemPopup to end 
ldr r0, =0x859DB08 @ poin to some proc we want 
ldr r0, [r0] 
blh ProcFind 
cmp r0, #0 
beq NextUnit 
b Exit_GotItemDrop 

NextUnit: 
ldr r0, [r4, #0x2c] @ index of Nth unit dropping an item 
cmp r0, #16 
bge Break_GotItemDrop 
mov r0, r4 @ parent 
mov r1, #1 
blh ProcGoto 
b Exit_GotItemDrop



Break_GotItemDrop: 
mov r0, r4 @ parent 
mov r1, #2 
blh ProcGoto 

Exit_GotItemDrop: 

pop {r4-r7} 
pop {r0} 
bx r0 
.ltorg 

.global AoE_HealedTargetFinalHp
.type AoE_HealedTargetFinalHp, %function 
AoE_HealedTargetFinalHp:
push {r4-r7, lr} 
mov r6, r0 @ actor 
mov r7, r1 @ target 
mov r5, r2 @ table 
mov r4, r3 @ always return minimum bool 

ldrb r1, [r5, #ConfigByte]  
mov r0, #FriendlyFireBool
tst r0, r1 
bne AlwaysHeal @ If friendly fire is on, then we heal regardless of allegiance 
mov r2, #0x0B 
ldsb r0, [r6, r2] 
ldsb r1, [r7, r2] 
blh 0x8024d8c @AreAllegiancesAllied	@{U}
@blh 0x8024D3C @AreAllegiancesAllied	@{J}
cmp r0, #0 
beq DoNotHealTarget


AlwaysHeal:
mov r0, r5 
mov r1, r6 
mov r2, r7 
mov r3, r4 
@r0 = effect index
@r1 = attacker / current unit ram 
@r2 = current target unit ram
bl AoE_FixedDamage 
mov r4, r0 

ldrb r1, [r5, #ConfigByte]  
mov r0, #FixedDamageBool
tst r0, r1 
bne CleanupHealing @ Fixed Damage means to not use Str/Mag for staves 
mov r0, #MagBasedBool 
tst r0, r1 
beq UseStr 
mov r1, #0x3A		@{U}
@mov r1, #0x1A		@{J}
ldrb r0, [r6, r1] @ Use Mag 
add r4, r0 
b CleanupHealing 


UseStr: @ Seems silly to use str, but non str/mag split users will appreciate 
ldrb r0, [r6, #0x14] @ Str 
add r4, r0 @ 
b CleanupHealing 

DoNotHealTarget:
mov r4, #0 


CleanupHealing:
ldrb r0, [r7, #0x13] 
add r0, r4 @ final hp 


pop {r4-r7} 
pop {r1} 
bx r1 
.ltorg 


.align 4
.global AoE_HealUnitsInRange
.type AoE_HealUnitsInRange, %function 
AoE_HealUnitsInRange:
push {r4-r7, lr} 

@ given r0 unit found in range, heal them 


mov r7, r0 @ target 
ldr r6, =CurrentUnit 
ldr r6, [r6] @ actor 

bl AoE_GetTableEntryPointer
mov r5, r0 @ table effect address 

ldrb r1, [r5, #ConfigByte]  
mov r0, #FriendlyFireBool
tst r0, r1 
bne AlwaysHealInRange @ If friendly fire is on, then we heal regardless of allegiance 
mov r2, #0x0B 
ldsb r0, [r6, r2] 
ldsb r1, [r7, r2] 
blh 0x8024d8c @AreAllegiancesAllied	@{U}
@blh 0x8024D3C @AreAllegiancesAllied	@{J}
cmp r0, #0 
beq DoNotHealTargetInRange
AlwaysHealInRange: 


ldrb r0, [r5, #Status]
cmp r0, #0 
beq DoNotRestoreStatus
mov r1, r7 @ target 
add r1, #0x30 @ status byte 

lsl r2, r0, #28 
lsr r2, #28 @ status type only 
cmp r2, #0xF
beq RestoreAnyStatusTypeButRings

ldrb r2, [r1] 
lsl r2, #28 
lsr r2, #28 @ status only 
lsl r3, r0, #28 
lsr r3, #28 @ status only 
cmp r3, r2 
bne DoNotRestoreStatus 
 
ldrb r2, [r1] 
lsr r0, #4 
lsl r0, #4 @ turns only 
lsr r3, r2, #4 
lsl r3, #4 
cmp r0, r3
bge StoreZeroStatus 
sub r3, r0 
lsl r2, #28 
lsr r2, #28 @ status only 
orr r2, r3 @ new number of turns 
@ restore status by number of turns provided 
strb r2, [r1] @ new status 
b DoNotRestoreStatus 
RestoreAnyStatusTypeButRings: 
ldrb r0, [r1] 
lsl r3, r0, #28 
lsr r3, #28 @ status only 
cmp r3, #5 
beq DoNotRestoreStatus @ don't restore AtkRingStatus 
cmp r3, #6
beq DoNotRestoreStatus @ don't restore AtkRingStatus 
cmp r3, #7 
beq DoNotRestoreStatus @ don't restore AtkRingStatus 
cmp r3, #8 
beq DoNotRestoreStatus @ don't restore AtkRingStatus 
ldrb r0, [r5, #Status]
ldrb r2, [r1] 
lsr r0, #4 
lsl r0, #4 @ turns only 
lsr r3, r2, #4 
lsl r3, #4 
cmp r0, r3
bge StoreZeroStatus 
sub r3, r0 
lsl r2, #28 
lsr r2, #28 @ status only 
orr r2, r3 @ new number of turns 
@ restore status by number of turns provided 
strb r2, [r1] @ new status 
b DoNotRestoreStatus

StoreZeroStatus: 
mov r0, #0 
strb r0, [r1] @ empty out status 
DoNotRestoreStatus: 


mov r1, r7 @ target 
mov r0, r6 @ actor 
mov r2, r5 @ table 
mov r3, #0 @ don't return minimum dmg 
bl AoE_HealedTargetFinalHp

ldrb r1, [r7, #0x12] @ Max HP 
cmp r0, r1
ble NoCapHP_Healing
mov r0, r1 @ Healed to full 
NoCapHP_Healing:
strb r0, [r7, #0x13] 

DoNotHealTargetInRange: 

pop {r4-r7}
pop {r0}
bx r0 



@parameters
	@r0 = char pointer
	@r1 = pointer range builder function
	@r3 = pointer list for proc
.align 4
.global AoE_FSTargeting
.type AoE_FSTargeting, %function 
	
AoE_FSTargeting:
push	{r4,lr}
mov 	r4, r3
mov 	r3, r1
bl		Jump

ldr 	r0, =MoveCostMapRows
ldr 	r0, [r0]
mov 	r1, #0x1
neg 	r1, r1
_blh 	FillMap

mov 	r0, #1
ldr 	r3, =prNewFreeSelect
orr 	r3, r0 
mov 	r0, r4
bl	Jump
pop 	{r4}
pop 	{r3}
Jump:
bx	r3





.ltorg
.align

.align 4
.global AoE_RangeSetup
.type AoE_RangeSetup, %function 

AoE_RangeSetup:
push {lr}
bl AoE_GetTableEntryPointer
bl AoE_RangeSetup_Hover 

pop {r3}
bx r3

.align 4
.global AoE_RangeSetup_Hover
.type AoE_RangeSetup_Hover, %function 

AoE_RangeSetup_Hover:
push {r4-r6, lr}
mov r4, r0 @ AoE_Table Entry 
bl AoE_ClearRangeMap
ldr r5, =CurrentUnit
ldr r5, [r5] 


ldrb r2, [r4, #Config2]
mov r3, #UseWepRange 
tst r2, r3 
beq UseAoERange 
mov r0, r4 @ table 
bl AoE_GetItemUsedOffset
ldrh r6, [r5, r0] @ weapon 
mov r0, r6 @ wep 
blh GetItemMinRange 
push {r0} 
mov r0, r6 @ wep 
blh GetItemMaxRange 
mov r3, r0 
cmp r3, #0
bne ContinueItemMaxRange
mov r3, #5 @ for physic staff lol. 

ContinueItemMaxRange: 
pop {r2} @ min range 
cmp r2, #0 
beq NoSubRangeByte3 
sub r2, #1 
NoSubRangeByte3: 
ldrb r0, [r5, #0x10] @ XX 
ldrb r1, [r5, #0x11] @ YY 
blh CreateRangeMapFromRange, r4
b Exit_RangeSetup_Hover

UseAoERange: 
ldrb r0, [r5, #0x10] @ XX 
ldrb r1, [r5, #0x11] @ YY 
ldrb r2, [r4, #MinRangeByte] @ Min range 
cmp r2, #0 
beq NoSubRangeByte2
sub r2, #1 
NoSubRangeByte2: 
ldrb r3, [r4, #MaxRangeByte] @ Max range  
@ Arguments: r0 = x, r1 = y, r2 = min, r3 = max
blh CreateRangeMapFromRange, r4

Exit_RangeSetup_Hover:

pop {r4-r6} 
pop {r3}
bx r3


.ltorg

.global AoE_DamageUnitsInRange
.type AoE_DamageUnitsInRange, %function 
AoE_DamageUnitsInRange:
push {r4-r7, lr} 

@ given r0 unit found in range, damage them 



mov r7, r0 @ target 

ldr r3, AoE_PokemblemImmuneTargets
cmp r3, #0 
beq NotImmune
mov lr, r3 
.short 0xF800 
cmp r0, #0
beq NotImmune
b DoNotDamageTargetInRange
NotImmune:

ldr r6, =CurrentUnit 
ldr r6, [r6] @ actor

bl AoE_GetTableEntryPointer
mov r5, r0 @ table effect address 

ldrb r1, [r5, #ConfigByte]  
mov r0, #FriendlyFireBool
tst r0, r1 
bne AlwaysDamageInRange @ If friendly fire is on, then we heal regardless of allegiance 
mov r2, #0x0B 
ldsb r0, [r6, r2] 
ldsb r1, [r7, r2] 
blh 0x8024d8c @AreAllegiancesAllied	@{U}
@blh 0x8024D3C @AreAllegiancesAllied	@{J}
cmp r0, #0 
bne DoNotDamageTargetInRange
AlwaysDamageInRange: 

ldrb r0, [r5, #Status]
cmp r0, #0 
beq DoNotInflictStatus
mov r1, r7 @ target 
add r1, #0x30 @ status byte 
strb r0, [r1] @ new status 

DoNotInflictStatus: 

mov r0, r6 @ actor 
mov r1, r7 @ target 
mov r2, r5 @ table 
mov r3, #0 @ return damage range 
bl AoE_CalcTargetRemainingHP
strb r0, [r7, #0x13] @ curr hp 
ldr r3, AoE_PokemblemTrainerPostBattle
cmp r3, #0 
beq DoNotDamageTargetInRange 
mov lr, r3 
mov r0, r6 @ actor 
mov r1, r7 @ target 
.short 0xF800 

DoNotDamageTargetInRange: 

pop {r4-r7}
pop {r0}
bx r0 

.ltorg 

.align
.equ AoE_PokemblemTrainerPostBattle, AoE_PokemblemImmuneTargets+4 
AoE_PokemblemImmuneTargets:
@ POIN address to bl to 

