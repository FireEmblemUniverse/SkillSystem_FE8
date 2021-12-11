.thumb 
.macro blh to, reg=r3
  ldr \reg, =\to
  mov lr, \reg
  .short 0xf800
.endm




.global Reinforce_HpRestore
.type Reinforce_HpRestore, %function 

Reinforce_HpRestore:
push {r4-r5, lr} 

mov r4,r0 @r4 = unit
mov r5,r1 @r5 = heal % (0) 
ldr r2, [r4] @ Char pointer 
ldrb r2, [r2, #4] @Char ID 
cmp r2, #0xF0 
blt NoHeal
cmp r2, #0xFA 
bge NoHeal 
ldr r0, =0x202BCF0 @ ChapterData 
ldrb r0, [r0, #0xF] 
cmp r0, #0 
bne NoHeal @ Only heal bushes on Player Phase 

ldr r0, [r4] 
ldrb r0, [r0, #4] @ Unit ID 
bl Reinforce_GetTableEntry
ldr r1, =0xFFFFFFFF 
cmp r0, r1 
beq NoHeal  

mov r3, r0 

ldr r2, =0x202BCF0 
add r2, #0x10 
ldrh r1, [r2] @ Turn # 
ldrb r0, [r3, #2] @ Grace period 

cmp r0, r1 
bgt NoHeal 
sub r1, r0 
ldrb r1, [r3, #3] @ Frequency 
mov r0, #100 
blh #0x080D18FC @ div by 100 
add r5, r0


NoHeal: 
mov r0, r5 @ heal % 

pop {r4-r5}
pop {r1} 
bx r1


.ltorg 
.align 

.type Reinforce_GetTableEntry, %function 
Reinforce_GetTableEntry:
push {lr} 
mov r1, #0xF0 
sub r0, r1
lsl r1, r0, #3 @ 8 bytes per entry 
ldr r0, =ReinforcementTableOfPointers
ldr r3, =0x202BCFE @ Chapter ID 
ldrb r3, [r3] @ Ch ID 
lsl r3, #2 @ 4 bytes per entry 
add r0, r3 
ldr r0, [r0] @ Individual table 
add r0, r1 @ table to use 

ldr r1, [r0] 
cmp r1, #0 
bne Passed
ldr r0, =0xFFFFFFFF 
Passed:

pop {r1} 
bx r1 

	.equ CurrentUnit, 0x3004E50	@{U}
	.equ MemorySlot,0x30004B8	@{U}
	.equ EventEngine, 0x800D07C	@{U}
	.equ CheckEventId,0x8083da8	@{U}
	.equ NextRN_100, 0x8000c64 @NextRN_100	@{U}
	.equ pActionStruct, 0x203A958	@{U}
	.equ CurrentUnitFateData, 0x203A958	@{U}
	.equ GetUnitStructFromEventParameter, 0x800bc50
	.equ LoadUnit, 0x8017ac4 
	.equ FillMap,                      0x080197E4	@{U}

.global Reinforce_SpawnIfFull
.type Reinforce_SpawnIfFull, %function 

Reinforce_SpawnIfFull:
push {r4-r7, lr}
@ given unit struct in s9 and target array in sA, check if full HP and spawn reinforcements if so 
@ r0, and unit group in r1, check if full HP. 
mov r7, r8 
push {r7} 

ldr r3, =MemorySlot 
add r3, #4*0x9 
ldr r4, [r3] @ Unit 
ldr r6, [r3, #4] @ Target array 

@mov r4, r0 @ unit 
@mov r6, r1 @ target array 

ldr r0, [r4] 
ldrb r0, [r0, #4] @ Unit ID 
bl Reinforce_GetTableEntry
ldr r1, =0xFFFFFFFF 
cmp r0, r1 
beq False 

mov r7, r0 
mov r1, #0 
mov r8, r1 

ldr r3, =MemorySlot 
add r3, #4*0x0B @ sB 
ldrb r2, [r4, #0x10] @ XX // used for camera 
strh r2, [r3] @ XX 
add r3, #2 
ldrb r2, [r4, #0x11] @ YY // used for camera in ASMC_Draw 
strh r2, [r3] 


ldr r0, =0x202E4F0 @ Backup Movement map	@{U}
ldr r0, [r0] 
mov r1, #0xFF
blh FillMap


LoadUnitsLoop:

ldr r0, =0x202E4E0 @ Movement map	@{U}
ldr r0, [r0] 
mov r1, #0xFF


ldr r1, [r7, #4] @ Unit group to load 


ldr r0, =0x8000000 
orr r0, r1 @ just in case we didn't do |IsPointer already 

blh LoadUnit 
mov r5, r0 @ Newly loaded unit 

ldrh r1, [r4, #0x10] @ XX / YY 
strh r1, [r5, #0x10] 
@mov r0, r5 @ New unit in r0 
ldr r1, =MemorySlot 
add r1, #4*0x09 @ XX in s9
add r2, r1, #4 @ YY in sA 
ldr r3, =0xFFFFFFFF @ (-1) as failed value 
str r3, [r1]
str r3, [r2] 


bl FindFreeTile @FindFreeTile(struct Unit *unit, int* xOut, int* yOut)

ldr r3, =MemorySlot 
add r3, #4*0x09 @ s9
mov r2, #0 
ldsh r0, [r3, r2] @ XX 
add r3, #4 @ sA 
ldsh r1, [r3, r2] @ YY






@ Store new coord into new  unit 
@strb r0, [r5, #0x10] @ XX 
@strb r1, [r5, #0x11] @ YY 

@@ r0 / r1 is still our coords 
ldr r3, =0x203A958 @ ActionStruct 
strb r0, [r3, #0x13] @ X 
strb r1, [r3, #0x14] @ Y 


ldr r3, =0xFFFFFFFF @ coords are (-1) if failed 
cmp r1, r3 
bne OnlyDeleteIfFailedAndNotPlayer 
ldrb r2, [r5, #0x0B] @ deployment byte 
cmp r2, #0x3F 
ble OnlyDeleteIfFailedAndNotPlayer 
mov r0, r5 
blh 0x80177F4 @ClearUnit @ 0x080177f4
b FinishUp

OnlyDeleteIfFailedAndNotPlayer:

ldr r3, =0x203A958 @ ActionStruct  @ Temp move new unit to diff tile for AutoLevelUnits 
mov r1, #0x13 
ldrh r0, [r3, r1] @ Coords 
strh r0, [r5, #0x10] @ Coords 

@ AutoLevelUnits(15, True, 0x50FF)
ldr r3, =MemorySlot 
add r3, #4 @ s1 
ldrb r0, [r4, #8] 
str r0, [r3] @ # of levels equal to the bush 

mov r0, #1 @ True IncreaseDisplayedLevelBoolean s3 
add r3, #8 @ s3 
str r0, [r3] 
ldr r0, [r5]
ldrb r0, [r0, #4] @ Unit ID 
str r0, [r3, #4] @ s4 UnitIDRange
mov r0, #0 
ldrb r0, [r5, #0x10] @ XX 
strh r0, [r3, #8] 
ldrb r1, [r5, #0x11] @ YY 
strh r1, [r3, #10] @ YY 
@SVAL 3 ; SVAL 4 ; SVAL 5 0; ASMC AutoLevelUnits" 
bl AutoLevelUnits

ldrh r0, [r4, #0x10] @ Coords 
strh r0, [r5, #0x10] @ Coords 




ldr r3, =0x203A958 @ ActionStruct 
ldrb r0, [r3, #0x13] @ X 
ldrb r1, [r3, #0x14] @ Y 

bl AddToMaps @ r0 XX, r1 YY 


ldr r3, =0x203A958 @ ActionStruct 
mov r0, r5 @ Unit 
ldrb r1, [r3, #0x13] @ X 
ldrb r2, [r3, #0x14] @ Y 
bl CreateREDA @ @r0 = char struct, target x coord, target y coord, 0





@blh  0x0801a1f8   @RefreshUnitMaps messing stuff up? 
GotoNextLoop:
mov r1, r8 
add r1, #1 
mov r8, r1 
ldrb r0, [r7, #1] @ Number of enemies 
cmp r1, r0 
blt LoadUnitsLoop 

FinishUp:

bl CopyMapOver

blh 0x8026688 @SMS_Init

ldr r0, =ENUNEvent
mov r1, #1
blh EventEngine





mov r0, #1
strb r0, [r4, #0x13] @ current hp [0202D0A7]?
mov r0, #0
strb r0, [r6, #3] @ hp to restore 



mov r0, #1 @ true 
b ExitReinforce_SpawnIfFull 



False:
mov r0, #0 
ExitReinforce_SpawnIfFull:

pop {r7} 
mov r8, r7 
pop {r4-r7}
pop {r1} 
bx r1 

.align 
.ltorg 

@.equ MuCtr_CreateWithReda, 0x800FEF5 @r0 = char struct, target x coord, target y coord
.equ MuCtr_CreateWithReda, 0x8079DDC @ Doesn't return? 
@.equ MoveUnit, 0x807A014


.type CreateREDA, %function 
CreateREDA: 
push {r4, lr} 

sub sp,#0x1C
mov r3,#0
str r3,[sp]
str r3,[sp,#0x4]
str r3,[sp,#0x8]
str r3,[sp,#0xC]
str r3,[sp,#0x10]
str r3,[sp,#0x14]
str r3,[sp,#0x18]
@str r3,[sp,#0x1C] @ this was a mistake Sme made, as it overwrites something we haven't allocated 

mov r3,#2 @ Speed 
@r0 = char struct, target x coord, target y coord, speed 
blh MuCtr_CreateWithReda, r4 @ 0x8079DDC
add sp,#0x1C 



pop {r4} 

pop {r0} 
bx r0 

.align 
.ltorg 










.type AddToMaps, %function 
AddToMaps:
push {lr} 
ldr		r2,=0x202E4F0 @ Backup Movemap 	@Load the location in the table of tables of the map you want
ldr		r2,[r2]			@Offset of map's table of row pointers
lsl		r3, r1, #0x2			@multiply y coordinate by 4
add		r2,r3			@so that we can get the correct row pointer
ldr		r2,[r2]			@Now we're at the beginning of the row data
add		r2,r0			@add x coordinate

@ldrb	r0,[r2]			@load datum at those coordinates
mov r3, #1 
strb r3, [r2] 

ldr		r2,=0x202E4D8 @ unit map	@Load the location in the table of tables of the map you want
ldr		r2,[r2]			@Offset of map's table of row pointers
lsl		r3, r1, #0x2			@multiply y coordinate by 4
add		r2,r3			@so that we can get the correct row pointer
ldr		r2,[r2]			@Now we're at the beginning of the row data
add		r2,r0			@add x coordinate

@ldrb	r0,[r2]			@load datum at those coordinates
mov r3, #0xFF  
strb r3, [r2] 


pop {r2} 
bx r2 

.ltorg 
.align 

.type CopyMapOver, %function 
CopyMapOver:
push {r4-r7, lr} 

ldr r4, =0x202E4F0 
ldr r5, =0x202E4E0 
ldr r4, [r4] 
ldr r5, [r5] 

ldr r7, =0x202E4D4 
ldrh r6, [r7] 
add r7, #2 
ldrh r7, [r7] 
sub r6, #1 @ Map size X 
sub r7, #1 @ Map size Y 

lsl r1, r7, #2 
add r2, r4, r1 
ldr r4, [r4] 
ldr r5, [r5] 

ldr r2, [r2] 
add r6, r2 @ end ram address A 
mov r0, r6
sub r0, r4 
add r7, r5, r0 @ end ram address B 

mov r0, #0
LoopCopyMap: 
cmp r4, r6 
bge ExitLoopCopyMap 
ldr r0, [r4] 
str r0, [r5]
add r4, #4 
add r5, #4  
b LoopCopyMap 


ExitLoopCopyMap: 







pop {r4-r7}
pop {r0}
bx r0 

.ltorg 
.align 




.global Reinforce_AddBushToPlayerHpRestorationTargetList
.type Reinforce_AddBushToPlayerHpRestorationTargetList, %function 
Reinforce_AddBushToPlayerHpRestorationTargetList:
push {r4-r7, lr} 


mov r6, #0xEF @ Counter 
Loop: 
add r6, #1 
cmp r6, #0xFA 
bge ExitLoop 
mov r0, r6 
blh GetUnitStructFromEventParameter 
cmp r0, #0 
beq Loop 
mov r5, r0 

@r5 as unit 
ldrb r0, [r5, #0x12] @ Max hp 
ldrb r1, [r5, #0x13] @ Current Hp 
cmp r1, r0 
bge Loop @ If full hp already, do not add to list 

mov r0, r5 
mov r1, #0 @ Start with 0 healing 
bl Reinforce_HpRestore
cmp r0, #0 
beq Loop

@ r0 as Amount to heal in percentage 
ldrb r1, [r5, #0x12] @ Max hp 
mul r0, r1
mov r1, #100 
blh 0x080D18FC   @//__divsi3 
mov r3, r0 @ Amount to heal as a number 



mov r0, #0x10 
ldsb r0, [r5, r0] 
mov r1, #0x11 
ldsb r1, [r5, r1] 
mov r2, #0xB 
ldsb r2, [r5, r2]

@r3 is specific amount to heal 
@ r3 as (-1) restores status instead? 
blh 0x804F8BC, r4 @ AddTarget 

b Loop 

ExitLoop: 
ExitReinforce_AddToPlayerHpRestorationTargetList: 


pop {r4-r7}
pop {r1} 
bx r1 
.ltorg 
.align 

.global HookAddBushes 
.type HookAddBushes, %function 
HookAddBushes: 
push {lr} 
ldr r0, =0x202BCF0 
ldrb r0, [r0, #0xF] 
blh 0x8025904 @ MakeTerrainHealTargetList 
ldr r0, =0x202BCF0 
ldrb r0, [r0, #0xF] 
cmp r0, #0 
bne SkipReinforce @ Occur only on player phase 
bl Reinforce_AddBushToPlayerHpRestorationTargetList 
SkipReinforce: 
blh 0x804FD28 @ GetTargetListSize 

pop {r1} 
bx r1 
.ltorg 
.align 


.global HookSpawnUnits
.type HookSpawnUnits, %function 
HookSpawnUnits: 
push {r4-r5, lr} 
mov r4, r0 
mov r0, #2 
ldsb r0, [r4, r0] 
blh 0x8019430 @ GetUnitStruct 
mov r5, r0 


ldr r0, [r5] @ Unit Table 
ldrb r0, [r0, #4] @ Unit ID 
cmp r0, #0xF0 
blt ExitSpawnUnits 
cmp r0, #0xFA 
bge ExitSpawnUnits 

ldrb r0, [r5, #0x12] @ max Hp 
ldrb r1, [r5, #0x13] @ current hp 
ldrb r2, [r4, #3]
cmp r2, #0xFF 
beq Error 
add r1, r2 

cmp r0, r1 
bgt Error 


ldr r3, =MemorySlot 
add r3, #4*0x9 
str r5, [r3] @ Unit 
str r4, [r3, #4] @ Some struct 

ldr r0, =CallReinforce_SpawnIfFullEvent
mov r1, #1 
blh EventEngine 
@mov r0, r5 
@mov r1, r4 
@bl Reinforce_SpawnIfFull



Error:
ExitSpawnUnits:
mov r1, r5 
mov r0, #3 

pop {r4-r5} 
pop {r3} 
bx r3

.ltorg 
.align 














