.thumb
.align

.global TrapRework_NewAddBreakables
.type TrapRework_NewAddBreakables, %function

.global TrapRework_NewTryAddTrapsToTargetList
.type TrapRework_NewTryAddTrapsToTargetList, %function

.global TrapRework_MakeSnagTargetAdder
.type TrapRework_MakeSnagTargetAdder, %function

.global TrapRework_DoNewBreakAnim
.type TrapRework_DoNewBreakAnim, %function

.global TrapRework_DoNewHideMapSprite
.type TrapRework_DoNewHideMapSprite, %function

.global TrapRework_NewForceMapAnimsForTrap
.type TrapRework_NewForceMapAnimsForTrap, %function

.global TrapRework_NewTerrainHPDisplay
.type TrapRework_NewTerrainHPDisplay, %function










.macro blh to, reg=r3
  ldr \reg, =\to
  mov lr, \reg
  .short 0xf800
.endm

.equ AddTrap,0x802E2B8
.equ GetChapterDefinition,0x8034618
.equ gChapterData,0x202BCF0
.equ gMapSize,0x202E4D4
.equ gMapTerrain,0x202E4DC
.equ GetTrap,0x802EB8C
.equ AddTarget,0x804F8BC
.equ gMapRange,0x202E4E4
.equ GetCharacterData,0x8019464
.equ ReturnPoint_BreakAnim1,0x8081793
.equ ReturnPoint_BreakAnim2,0x80817CB
.equ ReturnPoint_HideMapSprite1,0x807B37F @do hide
.equ ReturnPoint_HideMapSprite2,0x807B385 @do not hide
.equ ReturnPoint_ForceAnims1,0x8057C73
.equ ReturnPoint_ForceAnims2,0x8057C29
.equ ReturnPoint_TerrainWeirdCheck,0x808CAD9
.equ ReturnPoint_TerrainDisplayHP,0x808CA75
.equ ReturnPoint_TerrainNormalCase,0x808CB07








TrapRework_NewAddBreakables: @r3 hook at 2E3A8
push {r4-r6,r14}

ldr r0,=gMapSize
mov r1,#2
ldsh r0,[r0,r1]
sub r5,r0,#1
cmp r5,#0
blt AddBreakables_GoBack

AddBreakables_ResetXLoop:
ldr r0,=gMapSize
mov r1,#0
ldsh r0,[r0,r1]
sub r4,r0,#1
sub r6,r5,#1
cmp r4,#0
blt AddBreakables_GoBack

AddBreakables_LoopStart:
ldr r0,=gMapTerrain
ldr r1,[r0]
lsl r0,r5,#2
add r1,r0
ldr r0,[r1]
add r0,r4
ldrb r0,[r0]

ldr r2,=TrapBreakableTerrainList

AddBreakables_TypeLoopStart:
ldrb r1,[r2]
cmp r1,#0
beq AddBreakables_LoopRestart
cmp r0,r1
beq AddBreakables_MakeBreakable

add r2,#4
b AddBreakables_TypeLoopStart


AddBreakables_MakeBreakable:
ldrb r0,[r2,#2]
cmp r0,#0xFF
beq AddBreakables_ChapterHPAmount


AddBreakables_SetHPAmount:
mov r0,r4  @x coord
mov r1,r5  @y coord
ldr r3,=AddTrap
mov r14,r3
ldrb r3,[r2,#2] @trap HP
mov r2,#2  @trap ID
.short 0xF800

b AddBreakables_LoopRestart


AddBreakables_ChapterHPAmount:
ldr r0,=gChapterData
ldrb r0,[r0,#0xE] @chapter ID
blh GetChapterDefinition @returns pointer to chapter data

add r0,#0x2C 
ldrb r3,[r0] @wall HP for current chapter
mov r0,r4 @x coord
mov r1,r5 @y coord
ldr r2,=AddTrap
mov r14,r2
mov r2,#2 @trap ID
.short 0xF800


AddBreakables_LoopRestart:
sub r4,#1
cmp r4,#0
bge AddBreakables_LoopStart

mov r5,r6
cmp r5,#0
bge AddBreakables_ResetXLoop


AddBreakables_GoBack:
pop {r4-r6}
pop {r0}
bx r0

.ltorg
.align




TrapRework_NewTryAddTrapsToTargetList: @r3 hook at 250BC
push {r4-r7,r14}

@this is a way it just gets the start of traps but only sometimes?
@other times it just loads the trap array location directly
mov r0,#0
blh GetTrap 

mov r4,r0
ldrb r0,[r4,#2]
cmp r0,#0
beq TargetTraps_GoBack

ldr r6,=gMapTerrain
ldr r5,=gMapRange


TargetTraps_StartLoop:
ldr r7,=TrapBreakableTerrainList
cmp r0,#2
bne TargetTraps_RestartLoop



ldrb r1,[r4,#1]
ldr r0,[r6]
lsl r3,r1,#2
add r0,r3,r0
ldrb r2,[r4]
ldr r0,[r0]
add r0,r2
ldrb r0,[r0]
TargetTraps_StartListLoop:
ldrb r1,[r7]
cmp r0,r1
bne TargetTraps_AdvanceListLoop

ldr r0,[r5]
add r0,r3,r0
ldr r0,[r0]
add r0,r2
ldrb r0,[r0]
lsl r0,r0,#24
asr r0,r0,#24
cmp r0,#0
beq TargetTraps_RestartLoop

ldrb r3,[r4,#3] @HP
mov r0,r2
ldrb r1,[r4,#1]
ldr r2,=AddTarget
mov r14,r2
mov r2,#0
.short 0xF800


TargetTraps_AdvanceListLoop:
add r7,#4
ldr r1,[r7]
cmp r1,#0
bne TargetTraps_StartListLoop

TargetTraps_RestartLoop:
add r4,#8
ldrb r0,[r4,#2]
cmp r0,#0
bne TargetTraps_StartLoop

TargetTraps_GoBack:
pop {r4-r7}
pop {r0}		
bx r0

.ltorg
.align








TrapRework_MakeSnagTargetAdder: @hooks at 2C910
@r0 = terrain ID


ldr r2,=TrapBreakableTerrainList

MakeTarget_TerrainLoopStart:
ldrb r1,[r2]
cmp r1,#0
beq MakeTarget_GoBack
cmp r0,r1
beq MakeTarget_GetChar

add r2,#4
b MakeTarget_TerrainLoopStart


MakeTarget_GetChar:
ldrb r0,[r2,#1]
push {r2}
blh GetCharacterData
pop {r2}
str r0,[r4]
ldrb r0,[r2,#2]
cmp r0,#0xFF @if 0xFF get from chapter table
bne MakeTarget_StoreMHP
ldr r1,=ChapterDataTable
add r1,#0x2C
ldrb r0,[r1]
MakeTarget_StoreMHP:
strb r0,[r4,#0x12]
b MakeTarget_GoBack

MakeTarget_GoBack:
pop {r4}
pop {r0}
bx r0

.ltorg
.align






TrapRework_DoNewBreakAnim: @r3 hook at 81784
@r0 = terrain ID
ldr r2,=TrapBreakableTerrainList

BreakAnim_LoopStart:
ldrb r1,[r2]
cmp r1,#0
beq DoNewBreakAnim_RetFalse
cmp r0,r1
beq DoNewBreakAnim_RetTrue

add r2,#4
b BreakAnim_LoopStart


DoNewBreakAnim_RetTrue:
ldr r3,=ReturnPoint_BreakAnim1
b DoNewBreakAnim_GoBack


DoNewBreakAnim_RetFalse:
ldr r3,=ReturnPoint_BreakAnim2

DoNewBreakAnim_GoBack:
bx r3


.ltorg
.align









TrapRework_DoNewHideMapSprite: @r3 hook at 7B374
ldrb r0,[r0]
@r0 = terrain ID

ldr r2,=TrapBreakableTerrainList

HideMapSprite_LoopStart:
ldrb r1,[r2]
cmp r1,#0
beq DoNewHideMapSprite_IsFalse
cmp r0,r1
beq DoNewHideMapSprite_IsTrue

add r2,#4
b HideMapSprite_LoopStart


DoNewHideMapSprite_IsTrue:
ldr r0,=ReturnPoint_HideMapSprite1
b DoNewHideMapSprite_GoBack

DoNewHideMapSprite_IsFalse:
ldr r0,=ReturnPoint_HideMapSprite2

DoNewHideMapSprite_GoBack:
bx r0

.ltorg
.align






TrapRework_NewForceMapAnimsForTrap: @r3 hook at 57C20
@r0 = terrain ID

ldr r2,=TrapBreakableTerrainList

ForceMapAnims_LoopStart:

ldrb r1,[r2]
cmp r1,#0
beq ForceAnims_RetFalse
cmp r0,r1
beq ForceAnims_RetTrue

add r2,#4
b ForceMapAnims_LoopStart


ForceAnims_RetTrue:
ldr r0,=ReturnPoint_ForceAnims1
b ForceAnims_GoBack

ForceAnims_RetFalse:
ldr r3,=0x0203E104
ldr r0,=ReturnPoint_ForceAnims2

ForceAnims_GoBack:
bx r0

.ltorg
.align






TrapRework_NewTerrainHPDisplay: @r3 hook at 8CA3C
@r7 = terrain ID


ldr r1,=TrapBreakableTerrainList

TerrainDisplay_LoopStart:
ldrb r0,[r1]
cmp r0,#0
beq TerrainDisplay_RetNormal
cmp r0,r7
beq TerrainDisplay_RetHP

add r1,#4
b TerrainDisplay_LoopStart


TerrainDisplay_RetHP:
ldr r1,=ReturnPoint_TerrainDisplayHP
b TerrainDisplay_GoBack

TerrainDisplay_RetNormal:
ldr r1,=ReturnPoint_TerrainNormalCase

TerrainDisplay_GoBack:
bx r1


.ltorg
.align









