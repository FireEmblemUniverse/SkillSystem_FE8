.thumb
.macro blh to, reg=r3
  ldr \reg, =\to
  mov lr, \reg
  .short 0xf800
.endm


.align 
.equ MemorySlot,                 0x030004B8	@{U}
@.equ MemorySlot,                 0x030004B0	@{J}
.equ CurrentUnit,                0x03004E50	@{U}
@.equ CurrentUnit,                0x03004DF0	@{J}
.equ EventEngine,                0x0800D07C	@{U}
@.equ EventEngine,                0x0800D340	@{J}
.equ GetUnit, 0x8019430 


.type AoE_GrantExp, %function 
.global AoE_GrantExp 
AoE_GrantExp:
push {r4-r7, lr}
mov r7, r8 
push {r7}
mov r6, r9 
push {r6}
mov r5, r10 
push {r5} 
mov r5, #0 @ units found counter ? 
mov r8, r5 
mov r10, r5 @ exp 


ldr r3, =CurrentUnit
ldr r1, [r3]
ldr r0, =0x203A4EC
blh 0x802A584 @CopyUnitToBattleStruct


ldr r4, =0x202E4E0 @ Movement Map	@{U}
@ldr r4, =0x202E4DC @ Movement Map	@{J}
ldr r4, [r4] @ movement map [0,0] 
mov r9, r4 @ movement map 

ldr r3, =0x202E4D4 @ Map Size	@{U}
@ldr r3, =0x202E4D0 @ Map Size	@{J}
ldrh r6, [r3] @ XX Boundary size 
ldrh r7, [r3, #2] @ YY Boundary size 



mov r5, #0 @ Y coord 
sub r5, #1 

YLoop:
add r5, #1 
cmp r5, r7 
bge BreakYLoop

mov r4, #0 
sub r4, #1 
XLoop:
lsl r0, r5, #2 @ 4 times Y coord 
mov r3, r9 @ movement map 
ldr r1, [r3, r0] @ beginning of Y row 

XLoop_2:
add r4, #1 
cmp r4, r6 
bge YLoop @ Finished the row, so +1 to Y coord 
ldrb r0, [r1, r4] @ Xcoord to check 
cmp r0, #0xFF 
beq XLoop_2

mov r1, r8 
add r1, #1 
mov r8, r1 
cmp r1, #8 
blt NoBreak 
b BreakYLoop @ 8+ as max exp 
NoBreak:
@ ValidCoord:
@ We found a valid tile 
mov r0, r4 @ XX 
mov r1, r5 @ YY



ldr		r2,=0x202E4D8 @ Unit Map	@Load the location in the table of tables of the map you want
ldr		r2,[r2]			@Offset of map's table of row pointers
lsl		r1,#0x2			@multiply y coordinate by 4
add		r2,r1			@so that we can get the correct row pointer
ldr		r2,[r2]			@Now we're at the beginning of the row data
add		r2,r0			@add x coordinate
ldrb	r0,[r2]			@deployment byte 

blh GetUnit 
cmp r0, #0 
beq XLoop

ldr r3, =CurrentUnit
ldr r3, [r3]

@ are units allied 24D8C
mov r2, #0x80 
ldrb r1, [r0, #0x0B] @ deployment byte 
ldrb r3, [r3, #0x0B] @ deployment byte 
and r1, r2 
and r2, r3 
mov r3, #0 
cmp r1, r2 
bne NotAllied
mov r3, #1 @ Allied 
b XLoop 
NotAllied: 


mov r1, r0
ldr r0, =0x203A56C
blh 0x802A584 @CopyUnitToBattleStruct


ldr r0, =0x203A4EC
mov r2, #0x7c
add r2, r0
mov r3, #1
strb r3, [r2]

ldr r1, =0x203A56C

blh 0x802c534 @ComputeExpFromBattle



add r0, #1 @ round up 
lsr r0, #1 @ half exp  
mov r1, r10 
add r0, r1 
cmp r0, #100 
ble NoCap
mov r0, #100
mov r10, r0 
b BreakYLoop
NoCap: 
mov r10, r0 


b XLoop

BreakYLoop:
mov r0, r10 
cmp r0, #0 
ble NoExp 

ldr r3, =MemorySlot
str r0, [r3, #12]

ldr r0, AoE_GrantExpEvent
mov r1, #1 
blh EventEngine

NoExp:


@ count tiles/units effected in move map 
@ grant exp to active unit 
pop {r5} 
mov r10, r5 
pop {r6} 
mov r9, r6 
pop {r7}
mov r8, r7

pop {r4-r7}
pop {r0}
bx r0 


.align
.ltorg 

AoE_GrantExpEvent:

