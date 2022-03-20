.thumb
.macro blh to, reg=r3
  push {\reg}
  ldr \reg, =\to
  mov lr, \reg
  pop {\reg}
  .short 0xf800
.endm
	.set SpriteData8x8,			0x08590F44
	.set SpriteData16x16,		0x08590F4C
	.set ItemIconPalette,		0x085996F4
	.equ	CopyToPaletteBuffer,		(0x08000DB8+1)

.global ParalysisIconFunc
.type ParalysisIconFunc, %function 

.global BurnIconFunc
.type BurnIconFunc, %function 

BurnIconFunc:
MOV r3, #0x68
push {r3} 
b Start 

.ltorg
.align 
@ dumped 27858 - 278AA 
@ 0x6010600 / tile 0x30 
ParalysisIconFunc:
MOV r3, #0x69
push {r3} 
b Start 

.align 
Start: 
LSL r0 ,r7 ,#0x18
MOV r6 ,r0
CMP r6, #0x0
BNE Skip_1
B Exit_1
Skip_1:
MOV r1, #0x10
LDSB r1, [r4, r1]
LSL r1 ,r1 ,#0x4
ldr r2, =0x202BCB0 @ pointer:08027914 -> 0202BCB0 (BattleMapState@gGameState.boolMainLoopEnded )
MOV r3, #0xC
LDSH r0, [r2, r3] @# pointer:0202BCBC (gCurrentRealCameraPos )
SUB r3 ,r1, R0
MOV r0, #0x11
LDSB r0, [r4, r0]
LSL r0 ,r0 ,#0x4
MOV r5, #0xE
LDSH r1, [r2, r5] @# pointer:0202BCBE
SUB r2 ,r0, R1
MOV r1 ,r3
ADD r1, #0x10
MOV r0, #0x80
LSL r0 ,r0 ,#0x1
CMP r1 ,r0
BHI End
MOV r0 ,r2
ADD r0, #0x10
CMP r0, #0xB0
BHI End
ldr r1, =0x1FF 
ADD r0 ,r3, R1
AND r0 ,r1
MOV r1 ,r2
ADD r1, #0xFB
MOV r2, #0xFF
AND r1 ,r2
@ldr r2, =0x859b968 @# pointer:0802791C -> 0859B968 (Secondary OAM 1 )

pop {r3} @ 0x64 or 0x69 - tile # to use. 
mov r2, #0 @ 0 as icons default palette - 4 item palette # ?
lsl r2, #12 @ bits 12-15 
orr r3, r2 
mov r2, #2 @ above map sprites but below menus etc. 
lsl r2, #0xA @ priority is bits $A-B
orr r3, r2 

ldr r2, =SpriteData8x8

push {lr}
blh 0x08002BB8   @//CallARM_PushToSecondaryOAM
pop {r3}
mov lr, r3 

b End2 
@ldr		r0, =ItemIconPalette
@mov 	r1, #4 @ MMB item icon palette index 
@lsl		r1, r1, #0x05
@mov		r2, #0x20
	
@blh CopyToPaletteBuffer @		(0x08000DB8+1)
@@ palette must be updated 
@ldr	r0,=0x300000E @ this is a byte (bool) that tells the game whether the palette RAM needs to be updated	@{U}
@@ldr	r0,=0x300000D @ this is a byte (bool) that tells the game whether the palette RAM needs to be updated	@{J}
@
@mov	r1,#1
@strb r1,[r0]

End:
pop {r3}
End2:
CMP r6, #0x0
BNE Exit_2

Exit_3:
ldr r3, =0x80279FD 
bx r3 

Exit_1: @ Early exit needs this pop 
pop {r3} 
ldr r3, =0x80279FD
bx r3 

Exit_2:
ldr r3, =0x80278AD
bx r3 

.ltorg 
.align 

