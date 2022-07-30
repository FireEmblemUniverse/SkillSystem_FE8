.thumb
.global MovementArrowInitialization
.type MovementArrowInitialization, %function

.macro blh to, reg=r3
  ldr \reg, =\to
  mov lr, \reg
  .short 0xf800
.endm


.ltorg
.align
.equ MemorySlot,0x30004B8
.equ GetTrapAt,0x802e1f0

.equ RemoveUnitBlankItems,0x8017984
.equ CheckEventId,0x8083da8
.equ GetItemAfterUse, 0x08016AEC
.equ SetFlag, 0x8083D80

.equ SpawnTrap,0x802E2B8 @r0 = x coord, r1 = y coord, r2 = trap ID
.equ Init_ReturnPoint,0x8037901


MovementArrowInitialization:

@r5 = pointer to trap data in events
ldrb r0,[r5,#1] @x coord
ldrb r1,[r5,#2] @y coord
ldrb r2,[r5] @trap ID
blh SpawnTrap @returns pointer to trap data in RAM

@give it our data
ldrb r1,[r5,#3] @save byte 0x3
strb r1,[r0,#3] 
ldrb r1,[r5,#4] @save byte 0x4
strb r1,[r0,#4]
ldrb r1,[r5,#5] @save byte 0x5
strb r1,[r0,#5]

ReturnPoint:
ldr r3,=Init_ReturnPoint
bx r3


.ltorg
.align 
.equ gTerrainMap, 0x202E4DC
.equ MapSize, 0x202E4D4
.equ gMapHidden, 0x202E4EC 
.global UpdateTrapHiddenHook 
.type UpdateTrapHiddenHook, %function 
UpdateTrapHiddenHook:
ldr r6, =0x202E4D8 @ gMapUnit 
ldr r5, =0x202E4EC @ gMapHidden 

ldrb r0, [r3, #2] @ jumps to this hack with r1, not r3 
ldr r2, =HiddenTrapList 
sub r2, #1 
Loop: 
add r2, #1 
ldrb r1, [r2] 
cmp r1, #0 
beq False 
cmp r0, r1
beq True 
b Loop 

False: 
mov r1, #1 
b Exit 

True: 
mov r1, #0 
b Exit 

Exit: 
cmp r1, #0 
ldr r1, =0x801A1B9 
bx r1 


ExecuteEvent:
	.long 0x800D07D @AF5D
CurrentUnitFateData:
	.long 0x203A958
CurrentUnitPointer:
	.long 0x3004E50
.equ GetTrap, 0x802E1F0
RemoveTrap:
    .long 0x802EA91

.type UpdateHiddenGlaciers, %function 
.global UpdateHiddenGlaciers 
UpdateHiddenGlaciers: 
push {r4-r7, lr} 
ldr r6, =gTerrainMap 
ldr r6, [r6] 
ldr r4, =MapSize 
ldrh r5, [r4, #2] @ YY 
sub r5, #1 
ldrh r4, [r4] @ XX 

mov r3, #0 @ YY 
sub r3, #1 
YLoop: 
add r3, #1 
cmp r3, r5 
bgt Break 
mov r2, #0 
sub r2, #1 
XLoop: 
add r2, #1 
cmp r2, r4 
bgt YLoop
lsl r1, r3, #2 @ y * 4 
add r1, r6 @ location of X row 
ldr r1, [r1] 
add r1, r2 @ address of terrain 
ldrb r1, [r1] 
cmp r1, #0x2F @ is this ice? 
bne XLoop 
ldr r0, =gMapHidden 
ldr r0, [r0] 
lsl r1, r3, #2 @ y * 4 
add r1, r0 
ldr r7, [r1] 
add r7, r2 @ coordinate 
ldrb r0, [r7] 
mov r1, #2 
orr r0, r1 
strb r0, [r7] 
b XLoop 

Break: 
mov r0, #0 
blh GetTrap 
add r3, r0 
ldrb r0, [r3, #2] 

pop {r4-r7} 
pop {r1} 
ldr r1, =0x801A1B1 
bx r1
.ltorg 

.equ AddTrap, 0x802E2B8 
.type SpawnIceIfIce, %function 
.global SpawnIceIfIce 
SpawnIceIfIce:
push {r4, lr} 
mov r4, r0 

ldrb r0, [r4, #0x10] @ XX 
ldrb r1, [r4, #0x11] @ Y 
ldr		r2,=0x202E4DC	@Load the location in the table of tables of the map you want
ldr		r2,[r2]			@Offset of map's table of row pointers
lsl		r1,#0x2			@multiply y coordinate by 4
add		r2,r1			@so that we can get the correct row pointer
ldr		r2,[r2]			@Now we're at the beginning of the row data
add		r2,r0			@add x coordinate
ldrb	r0,[r2]			@load datum at those coordinates
cmp r0, #0x2f @ ice 
bne End 
ldrb r0, [r4, #0x10] @ XX 
ldrb r1, [r4, #0x11] @ Y 
ldr r2, =IceTrapID 
lsl r2, #24 
lsr r2, #24 
mov r3, #0 
blh AddTrap, r4  


End:

pop {r4} 
pop {r0} 
bx r0 
.ltorg 

.equ RunPostMoveEvents, 0x8084508 
.type MovementCalcLoop, %function 
.global MovementCalcLoop 
MovementCalcLoop: 
push {r4-r7, lr} 

blh RunPostMoveEvents 
lsl r0, #24 
asr r0, #24 




pop {r4-r7} 
pop {r1} 
cmp r0, #1 
bx r1 
.ltorg 




