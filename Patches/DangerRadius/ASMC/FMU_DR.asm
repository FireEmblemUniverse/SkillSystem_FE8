
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

.global FMU_Mu_Ctr_DontRefreshFog
.type FMU_Mu_Ctr_DontRefreshFog, %function 
FMU_Mu_Ctr_DontRefreshFog:
push {lr} 
ldsb r1, [r4, r1] 
ldr r0, [r0] 
add r0, r1 
ldrb r1, [r4, #0xB] 
strb r1, [r0] 

@ if free mu is on, set DR for all enemies 
ldr r3, =FreeMoveRam
ldr r3, [r3] 
ldrb r0, [r3] 
ldr r1, =FreeMove_Running
ldrb r1, [r1] 
ldr r2, =FreeMove_Silent
ldrb r2, [r2] 
orr r1, r2 
tst r0, r1 
bne DontUpdateFog
blh 0x801A1F4 // RefreshEntityMaps 
DontUpdateFog:
pop {r0} 
bx r0 
.ltorg 



