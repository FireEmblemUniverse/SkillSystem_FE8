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
GetTrap:
    .long 0x802E1F1
RemoveTrap:
    .long 0x802EA91
