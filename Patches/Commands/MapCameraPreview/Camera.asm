.macro blh to, reg=r3
  ldr \reg, =\to
  mov lr, \reg
  .short 0xf800
.endm

.thumb
	.equ MemorySlot, 0x30004B8 
	.equ GetUnitByEventParameter, 0x0800BC50
	.equ CenterCameraOntoPosition, 0x8015D84
	.equ gMapSize, 0x202E4D4
	@blh 0x8015D90 @CenterCameraOntoPosition	@{J}
	

.global ASMC_CameraNW
.type ASMC_CameraNW, %function 
ASMC_CameraNW:
push {lr}
mov r1, #0 
mov r2, #0 
@r0 as parent proc 
blh CenterCameraOntoPosition	@{U}
pop {r0}
bx r0

.global ASMC_CameraSW
.type ASMC_CameraSW, %function 
ASMC_CameraSW:
push {lr}
ldr r3, =gMapSize
ldrh r2, [r3, #2] 
mov r1, #0
sub r2, #1 @ Map height - 1 as YY coord 
@r0 parent proc 
blh CenterCameraOntoPosition	
pop {r0}
bx r0

.global ASMC_CameraSE
.type ASMC_CameraSE, %function 
ASMC_CameraSE:
push {lr}
ldr r3, =gMapSize
ldrh r1, [r3] 
ldrh r2, [r3, #2] 
sub r1, #1 @ Map width - 1 as XX coord 
sub r2, #1 @ Map height - 1 as YY coord 
@r0 parent proc 
blh CenterCameraOntoPosition	
pop {r0}
bx r0

.global ASMC_CameraNE
.type ASMC_CameraNE, %function 
ASMC_CameraNE:
push {lr}
ldr r3, =gMapSize
ldrh r1, [r3] 
sub r1, #1 @ Map width - 1 as XX coord 
mov r2, #0 @ Y coord 
@r0 parent proc 
blh CenterCameraOntoPosition	
pop {r0}
bx r0




.global ASMC_CameraLord
.type ASMC_CameraLord, %function
ASMC_CameraLord:
push {r4, lr}

mov r4, r0 @ parent proc (event engine)
mov r0, #0 @ Party leader 
blh GetUnitByEventParameter
cmp r0, #0
beq Exit
ldrb r1, [r0, #0x10] @ XX 
ldrb r2, [r0, #0x11] 
mov r0, r4 @ parent proc 
blh CenterCameraOntoPosition	
Exit: 

pop {r4}
pop {r0} 
bx r0 


@ldrb r1, [r3] @ XX 
@ldrb r2, [r3, #2] @ YY 
@@r0 as parent 
@blh 0x08015e0c @EnsureCameraOntoPosition	@{U}
@@blh 0x08015E18 @EnsureCameraOntoPosition	@{J}
@.equ MoveCameraByStepMaybe,0x8015838 @ Updates map to be where cursor is? 


.align
.ltorg
@blh 0x08015e0c @EnsureCameraOntoPosition	@{U}
@blh 0x08015E18 @EnsureCameraOntoPosition	@{J}




@ldr r0, =0x859A548 @ gProc_CameraMovement
@blh ProcFind 
@ +0x34 short XX coord 
@ +0x36 short YY coord 
@ +0x3C byte countdown until finished? 
@ 15c86 - store some table in ram that goes 1, 1, 2, 2, 3, 3, 4, 4, ... 8,8, 8,8, 8,8, etc. 
@ldr r0, =0x859D908
@ 15cD6 - load this table 
@[202BD44..202BDFF]?!

