.thumb
.align

.global TrapRework_MapSpriteDisplay
.type TrapRework_MapSpriteDisplay, %function

.global AddTrapASMC
.type AddTrapASMC, %function

.global AnimLightRuneASMC
.type AnimLightRuneASMC, %function

.global RemoveTrapAtCoordsASMC
.type RemoveTrapAtCoordsASMC, %function

.global GetTrapIDAtASMC
.type GetTrapIDAtASMC, %function

.global GetTrapExt1AtASMC
.type GetTrapExt1AtASMC, %function

.global TrapRework_GenericInitializer
.type TrapRework_GenericInitializer, %function

.global TrapRework_NewRefreshTrapFogVision
.type TrapRework_NewRefreshTrapFogVision, %function


.global TrapRework_NewUpdateAllLightRunes
.type TrapRework_NewUpdateAllLightRunes, %function



.macro blh to, reg=r3
    ldr \reg, =\to
    mov lr, \reg
    .short 0xF800
.endm

.equ CheckEventId,0x8083da8
.equ gTrapArray,0x203a614 	@location of traps in memory
.equ GetTrapAt,0x802e1f0 	@r0 = x coord, r1 = y coord
.equ AddTrap,0x802e2b8 		@r0 = x coord, r1 = y coord, r2 = trap ID
.equ RemoveTrap,0x802e2fc 	@r0 = pointer to trap data
.equ RemoveTrapUpdateTerrain, 0x802EA90 	@r0 = pointer to trap data

.equ MemorySlot1,0x30004BC	@contains trap ID paramters
.equ MemorySlotB,0x30004E4	@contains coordinate parameters, formatted 0xYYYYXXXX
.equ MemorySlotC,0x30004E8	@contains returned values
.equ SpawnTrap,0x802E2B8 @r0 = x coord, r1 = y coord, r2 = trap ID
.equ Init_ReturnPoint,0x8037901
.equ GetTrap,0x802EB8C
.equ MapAddInRange,0x801AABC
.equ gTrapArray,0x203A614
.equ gMapTerrain,0x202E4DC



TrapRework_MapSpriteDisplay:
mov r2,r0 @r2 = trap ID


@add special cases here for your traps, if needed
@check to display as normal, hide on completion, or display sprite from 0x04 byte of trap 
mov r1, #0x20		@custom traps 0x10 - 0x1F to use 0x3 as completion flag / hidden sprite on compl.
@ 2022 update: nevermind 
cmp r2, r1
blt HealTiles
mov r1, #0x50 
cmp r2, r1 
bge HealTiles 
ldr r1, =BoulderReceptacleID 
lsl r1, #24 
lsr r1, #24 
cmp r2, r1 
beq End @ nothing for receptacle 

mov r1, #0x33 @ trainer trap ID 
cmp r2, r1 
beq TrainerSpriteToDisplay

mov r1, #0x20 		@custom traps 0x20 and greater to use 0x3 as req'd flag and 0x4 as sprite 
cmp r2, r1
bge SpriteToDisplay

HiddenSprite:		@completion flag
ldrb r0,[r4,#0x3]	@XX 0x01 YY 0x02 completion flag 0x03 to not display, etc. 
push {r2}
blh CheckEventId,r1
pop {r2}
cmp r0,#0
bne End
b GeneralTrapMapSpriteCase

TrainerSpriteToDisplay: 
ldrb r0,[r4,#0x3]	@0x3 Sprite to display 
cmp r0, #0
beq End			@if no sprite to display, then display nothing 
b TrapMapSpriteCheck 

SpriteToDisplay:
ldrb r0,[r4,#0x4]	@0x04 Sprite to display 
cmp r0, #0
beq End			@if no sprite to display, then display nothing 
b TrapMapSpriteCheck 	@XX 0x01 YY 0x02 usability flag 0x03 sprite to display 0x04 event 0x05

HealTiles:
@ex. heal tiles
ldr r1,=HealTileTrapIDLink
ldrb r1,[r1]
cmp r2,r1
bne TorchOnOffCheck
ldrb r0,[r4,#0x7]
push {r2}
blh CheckEventId,r1
pop {r2}
cmp r0,#0
bne End

TorchOnOffCheck:
ldr r1,=TelliusTorchTrapIDLink
ldrb r1,[r1]
cmp r0,r1
bne GeneralTrapMapSpriteCase

ldrb r1,[r4,#3]
cmp r1,#0
bne GeneralTrapMapSpriteCase

ldr r0,=TelliusTorchOffMapSpriteIDLink
ldrb r0,[r0]
b TrapMapSpriteCheck

@general cases
GeneralTrapMapSpriteCase:
ldr r1,=TrapMapSpriteTable
add r0,r1,r2
sub r0,#1
ldrb r0,[r0]
cmp r0,#0
beq End

TrapMapSpriteCheck:
@what palette stuff do we use? (load into r1)
ldr r1,=TrapMapSpritePaletteTable
mov r3,r2
sub r3,#1
lsl r3,r3,#2 @*4
add r1,r3
ldr r1,[r1]


@prepare to return
push {r1} @gets resolved later
push {r0} @gets resolved later
ldr r1,=#0x8027321
ldrb r0,[r4,#1]
lsl r0,r0,#4
b End2

End:
ldr r1,=#0x8027345
End2:
bx r1


.ltorg
.align





TrapRework_GenericInitializer:
ldrb r0,[r5,#1] @x coord
ldrb r1,[r5,#2] @y coord
ldrb r2,[r5] @trap ID
blh SpawnTrap @returns pointer to trap data in RAM

ldr r3,=Init_ReturnPoint
bx r3

.ltorg
.align





AddTrapASMC: @memory slot 1 = trap ID, memory slot B = coords
push {r4, r14}
ldr r0,=MemorySlot1
ldr r2,[r0] @r2 = trap ID
ldr r1,=MemorySlotB
ldr r0,[r1]
ldr r1,[r1]
lsr r1,r1,#16 @r1 = y coord
lsl r0,r0,#16
lsr r0,r0,#16 @r0 = x coord
mov r3, #0 
blh AddTrap, r4
pop {r4} 
pop {r0}
bx r0

.ltorg
.align
.global AddTrapExtASMC
.type AddTrapExtASMC, %function 
AddTrapExtASMC: @memory slot 1 = trap ID, memory slot B = coords
push {r4, r14}
ldr r0,=MemorySlot1
ldr r2,[r0] @r2 = trap ID
ldr r1,=MemorySlotB
ldr r0,[r1]
ldr r1,[r1]
lsr r1,r1,#16 @r1 = y coord
lsl r0,r0,#16
lsr r0,r0,#16 @r0 = x coord
blh AddTrap, r4
ldr r3, =MemorySlot 
ldr r1, [r3, #4*2] @ ext1 
strb r1, [r0, #3] 
ldr r1, [r3, #4*3] @ ext2
strb r1, [r0, #4] 
ldr r1, [r3, #4*4] @ ext3
strb r1, [r0, #5] 
ldr r1, [r3, #4*5] @ ext4
strb r1, [r0, #6] 
ldr r1, [r3, #4*6] @ ext5
strb r1, [r0, #7] 

pop {r4} 
pop {r0}
bx r0

.ltorg
.align



AnimLightRuneASMC: @memory slot 1 = trap ID, memory slot B = coords
push {r14}

ldr r0,=MemorySlot1
ldr r2,[r0] @r2 = trap ID
ldr r1,=MemorySlotB
ldr r0,[r1]
ldr r1,[r1]
lsr r1,r1,#16 @r1 = y coord
lsl r0,r0,#16
lsr r0,r0,#16 @r0 = x coord
blh AddTrap 


ldr r3,=MemorySlot1
ldr r3,[r3] @r2 = trap ID
ldr r2,=MemorySlotB
ldr r1,[r2]
ldr r2,[r2]
lsr r2,r2,#16 @r1 = y coord
lsl r1,r1,#16
lsr r1,r1,#16 @r0 = x coord

mov r0, #0x1
blh	0x08021684+1             @FE8U BeginLightRuneMapAnim


pop {r0}
bx r0

.ltorg
.align



RemoveTrapAtCoordsASMC: @memory slot B = coords
push {r14}
ldr r0,=MemorySlotB
ldrh r1,[r0, #2] @ YY 
ldrh r0,[r0] @ XX 
blh GetTrapAt @r0 = pointer to trap data
blh RemoveTrapUpdateTerrain
pop {r0}
bx r0

.ltorg
.align

.equ MemorySlot,0x30004B8	@contains trap ID paramters
.global RemoveLightRuneASMC
.type RemoveLightRuneASMC, %function 
RemoveLightRuneASMC: @memory slot B = coords
push {r14}
ldr r3,=MemorySlot
ldrh r1,[r3, #4*0xB+2] @ YY 
ldrh r0,[r3, #4*0xB] @ XX 
mov r2, #0x0D @ Light Rune trap ID type 
blh 0x802e24c @GetSpecificTrapAt @ XX, YY, TrapType 
cmp r0, #0 
beq DoNothing 
blh 0x802ea90 @RemoveLightRune given trap pointer, remove 
DoNothing: 
pop {r0}
bx r0 
.align 




GetTrapIDAtASMC: @memory slot B = coords
push {r14}
ldr r0,=MemorySlotB
ldr r1,[r0]
ldr r0,[r0]
lsl r0,r0,#16
lsr r0,r0,#16 @r0 = x coord
lsr r1,r1,#16 @r1 = y coord
blh GetTrapAt @r0 = pointer to trap data
ldrb r0,[r0,#2] @r0 = trap ID
ldr r1,=MemorySlotC
str r0,[r1]
pop {r0}
bx r0

.ltorg
.align


GetTrapExt1AtASMC: @memory slot B = coords
push {r14}
ldr r0,=MemorySlotB
ldr r1,[r0]
ldr r0,[r0]
lsl r0,r0,#16
lsr r0,r0,#16 @r0 = x coord
lsr r1,r1,#16 @r1 = y coord
blh GetTrapAt @r0 = pointer to trap data
ldrb r0,[r0,#3] @r0 = ext1
ldr r1,=MemorySlotC
str r0,[r1]
pop {r0}
bx r0

.ltorg
.align

.type ASMC_IsTrapAtCoordMatchingType, %function 
.global ASMC_IsTrapAtCoordMatchingType 
ASMC_IsTrapAtCoordMatchingType: @memory slot B = coords
push {r14}
mov r0, #0 
blh GetTrap @ start of trap data 
ldr r3, =MemorySlot 
mov r1, #0 
str r1, [r3, #4*0x0C] @ sC 
ldrh r1, [r3, #4*0x0B] 
ldrh r2, [r3, #4*0x0B+2]
lsl r2, #8 
orr r1, r2 @ YYXX  
ldr r2, [r3, #4] @ s1 as trap ID 
mov r3, r1 @ YYXX 

sub r0, #8 
Loop: 
add r0, #8 
ldr r1, [r0] 
cmp r1, #0 
beq Exit 
ldrb r1, [r0, #2] @ trap ID 
cmp r1, r2 
bne Loop 
ldrh r1, [r0] @ YYXX 
cmp r1, r3 
bne Loop 
mov r0, #1
ldr r3, =MemorySlotC  
str r0, [r3] 

Exit: 

pop {r0}
bx r0

.ltorg
.align


.type ASMC_RemoveMatchingTrapTypeAtCoord, %function 
.global ASMC_RemoveMatchingTrapTypeAtCoord
ASMC_RemoveMatchingTrapTypeAtCoord: @memory slot B = coords
push {r14}
mov r0, #0 
blh GetTrap @ start of trap data 
ldr r3, =MemorySlot 
ldrh r1, [r3, #4*0x0B] 
ldrh r2, [r3, #4*0x0B+2]
lsl r2, #8 
orr r1, r2 @ YYXX  
ldr r2, [r3, #4] @ s1 as trap ID 
mov r3, r1 @ YYXX 

sub r0, #8 
Loop2: 
add r0, #8 
ldr r1, [r0] 
cmp r1, #0 
beq Exit2
ldrb r1, [r0, #2] @ trap ID 
cmp r1, r2 
bne Loop2
ldrh r1, [r0] @ YYXX 
cmp r1, r3 
bne Loop2
blh RemoveTrap 

Exit2: 

pop {r0}
bx r0

.ltorg
.align



TrapRework_NewRefreshTrapFogVision:
push {r4,r14}
mov r0,#0
blh GetTrap
mov r4,r0


NewRefreshTrapFogVision_LoopStart:

ldrb r0,[r4,#2]
ldr r1,=TrapFogLightSourceTable
add r1,r0
ldrb r0,[r1]
cmp r0,#1
bne NewRefreshTrapFogVision_LoopRestart

NewRefreshTrapFogVision_ValidTrap:
ldrb r0,[r4]
ldrb r1,[r4,#1]
ldrb r2,[r4,#3]
cmp r2,#0
beq NewRefreshTrapFogVision_LoopRestart
ldr r3,=MapAddInRange
mov r14,r3
mov r3,#1
.short 0xF800

NewRefreshTrapFogVision_LoopRestart:
add r4,#8 @size of trap data entry

NewRefreshTrapFogVision_LoopInit:
ldrb r0,[r4,#2]
cmp r0,#0
bne NewRefreshTrapFogVision_LoopStart

pop {r4}
pop {r0}
bx r0

.ltorg
.align




.global TrapRework_NewUpdateAllLightRunes
.type TrapRework_NewUpdateAllLightRunes, %function

@based on NullAllLightRunesTerrain at address 2EB50

TrapRework_NewUpdateAllLightRunes:
push {r4,r14}

ldr r2,=gTrapArray
ldrb r0,[r2,#2]
cmp r0,#0
beq LightRunes_GoBack

ldr r4,=gMapTerrain

LightRunes_LoopStart:
ldrb r0,[r2,#2]
ldr r1,=TrapLightRuneImpassableTable
add r1,r0
ldrb r3,[r1]
cmp r3,#0
beq LightRunes_LoopRestart

LightRunes_LoopCont:
ldrb r0,[r2,#1]
ldr r1,[r4]
lsl r0,r0,#2
add r0,r1
ldrb r1,[r2]
ldr r0,[r0]
add r0,r1
strb r3,[r0]

LightRunes_LoopRestart:
add r2,#8
ldrb r0,[r2,#2]
cmp r0,#0
bne LightRunes_LoopStart

LightRunes_GoBack:
pop {r4}
pop {r0}
bx r0

.ltorg
.align


