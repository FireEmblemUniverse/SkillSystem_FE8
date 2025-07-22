.thumb
.include 	"../src/_include/_Definitions.h.s"
.include 	"../src/_include/MokhaRAMSpace.s"

SET_FUNC_INLINE		MU_ExecCmd_FixForFreeMU
SET_FUNC_INLINE 	MU_CALL2_FixForFreeMU
SET_FUNC_INLINE 	MU_GetSpeed_FixForFreeMU




MU_ExecCmd_FixForFreeMU:
	push	{r2, r4-r7, lr}
	lsr		r4, r0, #0x10
	bl FMU_HandleContinuedMovement 
	mov r1, #0 
	sub r1, #1 
	cmp r0, r1 
	beq .EndMain 
	mov r7, r0 @ direction 
	b NoRangeEvent 

	
	@ldr		r0, =FreeMovementControlProc
	@blh		ProcFind
	@mov r8, r0 	
	@cmp		r0, #0
	@beq		.EndMain
	@
	@ldr		r0, =gProc_MoveUnit
	@blh		ProcFind
	@mov		r9, r0					
	@cmp		r0, #0
	@beq		.EndMain
	@
	@bl FMU_CheckCurrentCommand 
	@cmp r0, #0 
	@beq .EndMain 
	
	@ldr		r1,[r0, #0x34]			
	@ldrb	r1,[r1, #4]
	@cmp		r1, #1
	@beq		.EndMain				@ 第一次则直接过
	
	@ldr r0, =0x8591AC0 @ gProc_MapEventEngine
	@blh ProcFind 
	@cmp r0, #0 
	@beq Continue @.EndMain 
	@add r0, #0x3e 
	@ldrh r0, [r0] 
	@cmp r0, #0 
	@beq Continue
	@mov r11, r11
	@b .EndMain 
	@Continue: 
@mov r0, r8 
@	blh		FMU_ChkKeyForMUExtra
@	mov		r7, r0					@ r7 = 0L/1R/2D/3U
@	cmp		r0, #0x10
@	beq		.EndMain
@	
@	ldr		r0, =gProc_MuCtr
@	blh		ProcFind
@mov r10, r0 
@	cmp		r0, #0
@	beq		.EndMain
@
@	mov r1, r8 
@	add   r1, #0x34 @ FreeMovementControlProc
@	strb  r7, [r1]          @ store facing direction in FreeMovementControlProc+0x34
	

@mov r1, r7 
@bl FMU_GetCoordX
@mov r5, r0 
@mov r0, r10 @ ctrProc 
@mov r1, r7 
@bl FMU_GetCoordY 
@mov r6, r0 
@add		r0, #0x40
@ldrb	r5,[r0]					@ r5=x
@ldrb	r6,[r0, #1]				@ r6=y
@	
@bl		PositionChange


	
	@mov r0, r8 @ fmu proc 
	@mov r1, r5 @ x 
	@mov r2, r6 @ y 
	@bl FMU_CheckForLedge 
	@cmp r0, #0 
	@beq NoLedge 
	@add r6, #1 @ we move twice 
	@NoLedge: 
	@
	@ldr		r0, =gActiveUnit
	@ldr		r0,[r0]
	@mov		r1, r5
	@mov		r2, r6
	@blh		FMU_CanUnitBeOnPos
	@cmp		r0, #0
	@beq		.EndMain
	@
	@mov r11, r11 
	@@ <!> --------------- Set Here! ---------------------
	
	
@mov r0, r9 @ gProc_MoveUnit
@mov r1, r7 
@bl FMU_SetDirection
	@ldr		r3,[r0, #0x34]			
	@mov		r0, #1
	@strb	r0,[r3, #4]
	@strb	r7,[r3, #5]
	
@mov r0, r10 @ gProc_MuCtr
@mov r1, r5 
@mov r2, r6 
@bl FMU_SetCoords
	@add		r0, #0x40
	@strb	r5,[r0]
	@strb	r6,[r0, #1]
	@strb	r5,[r0, #2]
	@strb	r6,[r0, #3]
	

	
@mov r0, r8 @ FMU 
@mov r1, r5 
@mov r2, r6 
@bl FMU_UpdateFM

	@add r0, #0x2c 
	@strb r5, [r0, #1] @ xx 
	@strb r6, [r0, #3] @ yy 
	@sub r0, #0x2c 
	@blh pFMU_RunLocBasedAsmcAuto
	@cmp r0, #0 
	@bne NoRangeEvent 
	@mov r0, r8 @ FMU 
	@add r0, #0x3a 
	@mov r1, #1 
	@strb r1, [r0] 
	@strb r1, [r0, #1] 
	@add r0, #2 
	@mov r1, #25 @ countdown 
	@strb r1, [r0] 
	@add r0, #0x4
	@mov r1, #1 
	@strb r1, [r0] @ wait for event 
	NoRangeEvent: 

	
	
	lsl		r4, r7, #0x18	@ Vanilla 0x0788AE
	asr		r4, #0x18
.EndMain:
	mov		r0, r4			@ Vanilla 0x0788B0
	lsl		r0, #0x10
	lsr		r3, r0, #0x10
	mov		r1, #1
	lsl		r1, #0x10
	add		r0, r1
	asr		r0, #0x10
	pop		{r2, r4-r7}
	pop		{r1}
	@mov		lr, r1
	cmp r0, #0xF 
	@ldr		r1, =0x80788C1
	bx		r1
	
	
.ltorg	
.align	
MU_CALL2_FixForFreeMU:
	@ORG 0x8078D10    
	ldr		r0, =FreeMovementControlProc
	blh		ProcFind
	cmp		r0, #0
	beq 	.ReturnCall2Normal
    bl      IsFMUPaused
    cmp r0, #0 
    bne .ReturnCall2Normal
	
	ldrh r0, [r4] 
	lsl r0, #0x10 
	asr r0, #0x14 
	bl NewGetCameraCenteredX
	ldr r4, =0x202BCB0 
	strh r0, [r4, #0x0C] @ Camera real X position 
	ldrh r0, [r5] 
	lsl r0, #0x10 
	asr r0, #0x14 
	bl NewGetCameraCenteredY
	strh r0, [r4, #0x0E] @ camera real Y 
	
	
	
	b .ReturnCall2Normal
	.ReturnCall2Camera: 
	ldr		r0, =0x8078D23 // camera 
	bx		r0
		
	.ReturnCall2Normal:
    mov		r0, r6
	add		r0, #0x3E
	ldrb	r0, [r0]
	cmp		r0, #0
	beq		.ReturnCall2SkipCamera
	ldr		r0, =gProc_CameraMovement
	blh		ProcFind
	cmp		r0, #0
	beq		.ReturnCall2Camera
	.ReturnCall2SkipCamera:
	ldr		r1, =0x8078D3D
	bx		r1
	
	
	
.ltorg
.align
MU_GetSpeed_FixForFreeMU:
@ 807947C
	push	{r4, lr}
	mov		r0, r4
	
	ldr		r0, =FreeMovementControlProc
	blh		ProcFind
	cmp		r0, #0
	beq		.MU_GetSpeed_ReturnNormal
	mov r2, r0 
	push {r2} 
	blh 0x8000D28 
	@ get game clock 
	pop {r2} 
	

	mov r1, #0x4C 
	ldr r1, [r2, r1] @ time since started 
	mov r3, #0x35 @moveSpeed
	ldrb r3, [r2, r3] @ speed 
	sub r0, r1 
	cmp r0, #40
	bge NoSlowStart
	cmp r3, #0x20 
	ble NoSlowStart 
	lsr r3, #1 
	NoSlowStart: 
	mov r0, r3 

	
	pop		{r4, pc}
	
	.MU_GetSpeed_ReturnNormal:
	mov		r0, #0x4A
	add		r0, r4
	mov		r2, #0
	ldsh	r1,[r0, r2]
	mov		r0, #0x80
	and		r0, r1
	ldr		r2, =0x807948B
	bx		r2
	
	
	
	
.ltorg	
.align	
PositionChange:
	push	{lr}
	@ R7 = 0L/1R/2D/3U
	@ r5 = x
	@ r6 = y
.Left:
	cmp		r7, #0
	bne		.Right
	add		r5, #-1
	b		.EndPositionChange
.Right:
	cmp		r7, #1
	bne		.Down
	add		r5, #1
	b		.EndPositionChange
.Down:	
	cmp		r7, #2
	bne		.Up
	add		r6, #1
	b		.EndPositionChange
.Up:	
	cmp		r7, #3
	bne		.EndPositionChange
	add		r6, #-1
.EndPositionChange:
	pop		{pc}
	