
.thumb
.macro blh to, reg=r3
  ldr \reg, =\to
  mov lr, \reg
  .short 0xf800
.endm
.global FMU_EnableDR
.type FMU_EnableDR, %function 
FMU_EnableDR: 
push {lr} 
@ if free mu is on, set DR for all enemies 
ldr r3, =FreeMoveRam
ldr r3, [r3] 
ldrb r0, [r3] 
ldr r1, =FreeMove_Running
ldrb r1, [r1] 
tst r0, r1 
beq No_FMU
@bl SetAllDR
bl SetNearbyDR
blh 0x08019FA0   //UpdateUnitMapAndVision
blh 0x0801A1A0   //UpdateTrapHiddenStates
	blh  0x080271a0   @SMS_UpdateFromGameData
	blh  0x08019c3c   @UpdateGameTilesGraphics

b Exit 

No_FMU: 
bl SetNearbyDR
b Exit 

Exit: 
pop {r0} 
bx r0 
.ltorg 


