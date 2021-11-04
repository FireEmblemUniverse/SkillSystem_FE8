.thumb 
.macro blh to, reg=r3
  ldr \reg, =\to
  mov lr, \reg
  .short 0xf800
.endm

	.equ pr6C_NewBlocking,           0x08002CE0 
	.equ pr6C_New,                   0x08002C7C
	.equ Proc_CreateBlockingChild, 0x80031c4 
	.equ BreakProcLoop, 0x08002E94
	.equ ProcFind, 0x08002E9C
	.equ EnsureCameraOntoPosition, 0x08015e0d
	.equ CheckEventId, 0x8083da8
	.equ MemorySlot, 0x30004B8
	.equ CurrentUnit, 0x3004E50
	.equ EventEngine, 0x800D07C
	

.global ASMC_Draw
.type ASMC_Draw, %function 

ASMC_Draw:
push {r4-r7, lr}


bl Draw_StartBlockingProc


pop {r4-r7}
pop {r1}
bx r1 

.align 4
.global Draw_StartBlockingProc
.type Draw_StartBlockingProc, %function 
Draw_StartBlockingProc:
push {r4-r5, lr} 
mov r4, r0 
mov r1, r4 @ Parent proc 
ldr r0, =DrawSpriteProc
@ arguments: r0 = pointer to ROM 6C code, r1 = parent; returns: r0 = new 6C pointer (0 if no space available)
@blh pr6C_NewBlocking
mov r1, #3 
blh pr6C_New


pop {r4-r5}
pop {r0} 
bx r0 

	.equ BreakProcLoop, 0x08002E94

.align 
.ltorg
.align 4
.global Draw_PauseForAnimation
.type Draw_PauseForAnimation, %function
@ this loops our animation until the event engine does sval rB 0 
Draw_PauseForAnimation:
push {r4-r5, lr} 
mov r4, r0 @ Parent? 
ldr r3, =MemorySlot
add r3, #4*0x0B 
ldr r0, [r3] 
mov r1, #0 
sub r1, #1
cmp r0, r1
beq BreakProcLoopNow
mov r0, #0 
b End_DrawPause
BreakProcLoopNow: 
mov r0, r4 @  @ parent to break from 
blh BreakProcLoop
mov r0, #1

End_DrawPause:
pop {r4-r5}
pop {r1}
bx r1 


.equ RegisterTileGraphics, 0x8002014 
.equ RegisterObjectTileGraphics, 0x8012FF4 

.global Draw_StoreToBuffer
.type Draw_StoreToBuffer, %function 
Draw_StoreToBuffer:
push {r4-r7, lr}
ldr r4, =0x6010000 @ tile one 
ldr r5, =0x6010FFF @ end of first two rows 


blh 0x8001FE0 @| ClearTileRigistry


ldr r3, =MemorySlot 
ldr r3, [r3, #4] @ Slot 1 
lsl r3, #2 @ x4 
add r0, r3, r3 @ x8 
add r0, r3 @ x12 
add r0, #4 @ palette offset in table 
ldr r2, =AnimTable 

ldr r0, [r2, r0] @ Palette 

mov r1, #26 @ palette # 
lsl r1, #5 @ multiply by #0x20



mov	r2,#0x20
blh CopyToPaletteBuffer @Arguments: r0 = source pointer, r1 = destination offset, r2 = size (0x20 per full palette)

@ palette must be updated 
ldr	r0,=#0x300000E @ 0300000E is a byte (bool) that tells the game whether the palette RAM needs to be updated
mov	r1,#1
strb r1,[r0]


mov r0, #0 
ldr r3, =MemorySlot 
add r3, #4*0x0B 
ldrh r1, [r3] @ XX 
ldrh r2, [r3, #2] @ YY 
blh EnsureCameraOntoPosition


blh GetGameClock 
ldr r3, =MemorySlot
str r0, [r3, #4*3] @ slot 3



pop {r4-r7}
pop {r1}
bx r1 

.align 4 
.ltorg 

.equ CopyToPaletteBuffer, 0x8000DB8
.equ PushToSecondaryOAM, 0x08002BB8
.equ GetGameClock, 0x08000D28


.global Draw_PushToOam
.type Draw_PushToOam, %function 
Draw_PushToOam:
push {r4-r7, lr}

mov r5, r0 

push {r5} 

blh GetGameClock 



ldr r3, =MemorySlot
ldr r2, [r3, #12] @ initial game clock time in s3
sub r0, r2 @ frame we're on

 
ldr r3, =MemorySlot 
ldr r3, [r3, #4] @ Slot 1 
lsl r3, #2 @ x4 
add r2, r3, r3 @ x8 
add r2, r3 @ x12 
ldr r3, =AnimTable 
ldr r3, [r3, r2] @ Specific animation table 

sub r3, #8 
mov r1, #0 @ frames offset 
b TryNextFrameLoop 
ExitAnimation: 
ldr r0, =SetSlotBTo0xFFFFFFFF
mov r1, #1 
blh EventEngine
b Skip

TryNextFrameLoop:
add r3, #8 
ldrh r2, [r3] 
cmp r2, #0 
add r1, r2 
beq ExitAnimation  
cmp r0, r1 
bge TryNextFrameLoop 



ldr r0, [r3, #4] 

ldr r1, =0x6013000 @vram
ldr r2, =#4096 @ number of bytes 
mov r2, #8
mov r3, #8
@ Arguments: r0 = Source gfx (uncompressed), r1 = Target pointer, r2 = Tile Width, r3 = Tile Height
blh RegisterObjectTileGraphics, r4






sub sp, #8 


@ Prepare OAM data
mov   r2, #0x1
mov   r1, sp
str   r2, [r1]
mov   r2, #0x0
str   r2, [r1, #0x4]


@	bit 0-9   | Tile Number     (0-1023)
@			bit 10    | Horizontal Flip (0=Normal, 1=Mirrored)
@			bit 11    | Vertical Flip   (0=Normal, 1=Mirrored)
@			bit 12-15 | Palette Number  (0-15)




mov r5, #40 @ XX 
mov r6, #40 @ YY 

ldr r3, =MemorySlot 
add r3, #4*0x0B 
ldrh r5, [r3]
ldrh r6, [r3, #2]
sub r5, #1
sub r6, #1 


ldr r3, =0x202BCBC @(gCurrentRealCameraPos )
ldrh r0, [r3]
ldrh r1, [r3, #2] 

lsr r0, #4
lsr r1, #4 
sub r5, r0 
sub r6, r1 

ldr r7, =0x180 @ offset where we put the tiles 

@ Push to secondary OAM
@To compute the offset for one tile in the map buffer given its (x, y) pos: offset = 2*x + 0x40*y
mov r0, r5 


@	00 | short | base OAM0 data (y coord, various flags, shape)
@			02 | short | base OAM1 data (x coord, flips, size)
@			04 | short | base OAM2 data (tile index, priority, palette index)

lsl r0, #4 @ 16*XX 
mov   r2, #0xc0 @ #0xC0 64x64  FF 
lsl   r2, #0x8 @ shifted by this amount 
orr   r0, r2                    @ Sprite size, 32x32


lsl r1, r6, #4 @ 16*YY 
sub r1, #8 
sub r0, #8 



mov r3, r7
mov r2, #26 @ palette # 26 - or 27 is the light rune palette i think 
lsl r2, #12 @ bits 12-15 
add r3, r2 @ palette | flips | tile 

mov r2, sp 

@ r0 = base x coord, r1 = base y coord, r2 = pointer to OAM Data, r3 = base OAM2 (tile/palette index)
blh PushToSecondaryOAM, r4 

add sp, #8 

Skip:
pop {r5} 

mov r0, r5 
bl Draw_PauseForAnimation

pop {r4-r7}
pop {r1}
bx r1 

.global Draw_Cleanup
.type Draw_Cleanup, %function 

Draw_Cleanup:
push {r4-r7, lr}
blh 0x8021668 @ Redraw map at end of event effect 


@ palette must be updated 
ldr	r0,=#0x300000E @ 0300000E is a byte (bool) that tells the game whether the palette RAM needs to be updated
mov	r1,#0
strb r1,[r0]


mov r0, #0 
ldr r1, =0x6013000 
ldr r2, =#4096 @ 64x64 image bytes size 
@=#4096 @64x64 image bytes 
@Arguments: r0 = *word* to fill with, r1 = Destination pointer, r2 = size (bytes)
blh 0x08002054 @ RegisterFillTile

blh 0x8001FE0 @| ClearTileRigistry


pop {r4-r7}
pop {r1}
bx r1 









