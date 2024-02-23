.thumb
.align

.macro blh to, reg=r3
    ldr \reg, =\to
    mov lr, \reg
    .short 0xF800
.endm
.equ UnitDecreaseItemUse, 0x08018995
.equ GetRescueStaffeePosition, 0x0802ecd1
.equ GoBackLoc, 0x0802FF77
.equ GetUnitByEventParameter, 0x0800BC50
.equ CheckEventId,0x8083da8

.global AumUsability
.type AumUsability, %function

.global AumEffect
.type AumEffect, %function

.global FindDeadUnit
.type FindDeadUnit, %function


FindDeadUnit:
push {r4-r7,r14}

ldr r3, =0x202BCF0 @ gChapterData 
ldrb r2, [r3, #0xE] @ chapterID 
ldr r3, =CannotReviveChapterTable
ldrb r0, [r3, r2] 
cmp r0, #1 
beq RetFalse @ cannot revive during gym battles etc 

ldr r0, =PlayableCutsceneFlag @ Flag that prevents call 
lsl r0, #24 
lsr r0, #24 
blh CheckEventId
cmp r0, #0 
bne RetFalse 

ldr r0, =TrainerBattleActiveFlag @ Flag that prevents call 
lsl r0, #24 
lsr r0, #24 
blh CheckEventId
cmp r0, #0 
bne RetFalse 


ldr r0, =0x106 @ last player unit 
blh GetUnitByEventParameter 
cmp r0, #0 
bne RetFalse 

@search the first 0x40 unit structs for a unit with dead flags set

mov r3,#0 @loop accumulator
ldr r2,=#0x202BE4C @start of structs
ldr r1,=#0x0000008 @bitmask
LoopStart:
ldr r0,[r2,#0xC]
and r0,r1
cmp r0,#0
bne RetDeadGuy
cmp r3,#0x40
bge RetFalse
add r2,#0x48
add r3,#1
b LoopStart

RetDeadGuy:
mov r0,r2
b FindDeadUnit_GoBack

RetFalse:
mov r0,#0

FindDeadUnit_GoBack:

pop {r4-r7}
pop {r1}
bx r1

.ltorg
.align


AumUsability:

@ trainer cannot use revives because it doesn't work 
ldr r3,=#0x03004E50
ldr r3,[r3]
ldr r3,[r3] 
ldrb r3,[r3, #4] 
ldr r1, =ProtagID_Link 
ldr r1, [r1] 
mov r0, #0 @ default false 
cmp r3, r1 
beq Usability_GoBack 

bl FindDeadUnit @see if there are any dead player units
cmp r0,#0 
beq Usability_GoBack @if not, return this return which is false

mov r0,#1 @otherwise, return true

Usability_GoBack:
pop {r4,r5}
pop {r1}
bx r1

.ltorg
.align







.equ Battle_Struct_For_Items,0x0802CB24
.equ AttackStruct,0x0203A4EC
.equ FinishUpItemBattle,0x0802CC54

.equ Get_Char_Data, 0x08019430
.equ Unknown_Func1, 0x0802BA28
.equ Unknown_Func2, 0x0802CC54
.equ Unknown_Func3, 0x0802CA14 



.equ HandleItemExpGain,0x802c5b8
.equ ClearMapWith, 0x080197e4 
.equ RangeMap, 0x202E4E4
.equ SetupTargetBattleUnitForStaff, 0x802cbc8

.equ HideMoveRangeGraphicsWrapper, 0x08022c98 

.equ GetRescueStaffeePosition, 0x0802ecd0
.equ gGenericBuffer,0x2020188

AumEffect: @sort of hybridized from some tequila code
push {r4-r7}

mov r5,r6
@r4 = action struct, r5 = parent proc


@clear range map
ldr r0,=RangeMap
ldr r0,[r0]
mov r1,#0
mov r2,#0
blh ClearMapWith

@clear movement map
ldr r0,=#0x202E4E0 @movement map
ldr r0,[r0]
mov r1,#0xFF
mov r2,#0xFF
blh ClearMapWith

blh HideMoveRangeGraphicsWrapper



@find dead unit

bl FindDeadUnit
@r0 = char struct of dead unit
mov r6,r0


@make them not dead
ldr r1,=#0xFFFFFFF6 @bitmask
ldr r0,[r6,#0xC]
and r0,r1
str r0,[r6,#0xC]

@make them have HP
ldrb r0,[r6,#0x12]
strb r0,[r6,#0x13]
@802ECD0

@make them be in the closest free tile to the active unit
ldr r0,=#0x03004E50 @active unit ptr
ldr r0,[r0] @active unit struct
mov r1,r6
ldr r2,=gGenericBuffer
ldr r3,=GetRescueStaffeePosition
mov r14,r3
add r3,r2,#4
.short 0xF800

@blh GetRescueStaffeePosition @r0 = active unit, r1 = target unit, r2 = place to put X coord, r3 = place to put Y coord

ldr r0,=gGenericBuffer
ldr r1,[r0] @x coord
ldr r2,[r0,#4] @y coord


strb r1,[r6,#0x10]
strb r2,[r6,#0x11]

@ time to do the exp part

ldr r0,=#0x03004E50
ldr r0,[r0]


ldr        r1,=Battle_Struct_For_Items @SetupSubjectBattleUnitForStaff
mov        r14,r1
ldrb    r1,[r4,#0x12]        @item slot
.short    0xF800                @sets up the battle struct for when using items (I think)

mov r0,r6
ldr r1,=SetupTargetBattleUnitForStaff
mov r14,r1
.short 0xF800



@ldr r0,=AttackStruct
@ldrb r1,[r0,#9] @load experience value
@add r1,#50 @add to expierience
@strb r1,[r0,#9] @store experience value
@add r0,#0x6E @r0 = exp gained in this battle
@mov r1,#50 @same amount added to experience
@strb r1,[r0] @store as exp gained


@ldr r0,=AttackStruct @this seems to be forcing a level up every time
@ldr        r1,=Unknown_Func1 @CheckForLevelUp
@mov        r14,r1
@.short    0xF800                

@

@ldr r0,=#0x203AAC0 @somewhere?
@mov r1,#50
@strb r1,[r0]

@ldr r0,=HandleItemExpGain 
@mov r14,r0
@.short 0xF800



ldr        r0,=Unknown_Func2 @FinishUpItemBattle
mov        r14,r0
mov        r0,r5
.short    0xF800                
ldr        r0,=Unknown_Func3 @BeginBattleAnimations
mov        r14,r0
@.short    0xF800


@decrement item uses
ldr r0,=#0x03004E50
ldr r0,[r0]
ldrb r1,[r4,#0x12]
blh UnitDecreaseItemUse

ldr r0, =0x202E4D8 @ Unit map	{U}
ldr r0, [r0] 
mov r1, #0
blh 0x080197E4 @ FillMap 
blh 0x08019FA0   //UpdateUnitMapAndVision
blh 0x0801A1A0   //UpdateTrapHiddenStates
	blh  0x080271a0   @SMS_UpdateFromGameData
	blh  0x08019c3c   @UpdateGameTilesGraphics


pop {r4-r7}

ldr        r0,=GoBackLoc
bx        r0

.ltorg
.align
 


