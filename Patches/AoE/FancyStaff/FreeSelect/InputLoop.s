.thumb
.include "_FE8Definitions.h.s"

.set EAL_prHandleCode, (OffsetList+0x00)

FreeSelect6C_Loop:
	push {r4-r5, lr}
	
	mov r4, r0 @ var r4 = 6C
	
	ldr r0, =pGameDataStruct
	ldr r5, [r0, #0x14] @ r5 = Cursor Position Pair
	
	_blh HandlePPCursorMovement
	
	@ (r1, r2) = Cursor Map Pos
	ldr r0, =pGameDataStruct
	ldrh r1, [r0, #0x14]
	ldrh r2, [r0, #0x16]
	
	@ r0 = New Key Presses
	ldr  r0, =pKeyStatusBuffer
	ldrh r0, [r0, #8] @ New Presses
	
	mov r3, #0x01 @ A
	tst r0, r3
	beq NoAPress
	
	ldr r3, [r4, #0x2C] @ routine array pointer
	ldr r3, [r3, #0x08] @ OnAPress
	
	cmp r3, #0
	beq NoAPress
	
	mov r0, r4
	bl BXR3
	
	b HandleCode
	
NoAPress:
	mov r3, #0x02 @ B
	tst r0, r3
	beq NoBPress

	ldr r3, [r4, #0x2C] @ routine array pointer
	ldr r3, [r3, #0x0C] @ OnBPress
	
	cmp r3, #0
	beq NoBPress
	
	mov r0, r4
	bl BXR3
	
	b HandleCode
	
NoBPress:
	mov r3, #1
	lsl r3, #8 @ R
	tst r0, r3
	beq NoRPress
	
	ldr r3, [r4, #0x2C] @ routine array pointer
	ldr r3, [r3, #0x10] @ OnRPress
	
	cmp r3, #0
	beq NoRPress
	
	mov r0, r4
	bl BXR3
	
	b HandleCode
	
NoRPress:
	ldr r0, =pGameDataStruct
	ldr r0, [r0, #0x14] @ r0 = Cursor Position Pair
	
	cmp r0, r5
	beq NoPositionChange
	
	ldr r3, [r4, #0x2C] @ routine array pointer
	ldr r3, [r3, #0x10] @ OnPositionChange
	
	cmp r3, #0
	beq NoPositionChange
	
	mov r0, r4
	bl BXR3

HandleCode:
	mov r1, r0
	mov r0, r4
	
	ldr r3, EAL_prHandleCode
	bl BXR3
	
	cmp r0, #0
	bne End
	
NoPositionChange:
Finish:
	@ Update Cursor Graphics
	
	ldr r3, =pGameDataStruct
	
	@ Cursor Gfx X
	mov  r0, #0x20
	ldsh r1, [r3, r0]
	
	@ Camera X
	mov  r0, #0x0C
	ldsh r2, [r3, r0]
	
	@ Draw X
	sub r1, r2
	
	@ Cursor Gfx Y
	mov  r0, #0x22
	ldsh r2, [r3, r0]
	
	@ Camera Y
	mov  r0, #0x0E
	ldsh r3, [r3, r0]
	
	@ Draw Y
	sub r2, r3
	
	ldr r0, [r4, #0x30]
	_blh TCS_Update
	
End:
	pop {r4-r5}
	
	pop {r3}
BXR3:
	bx r3

.ltorg
.align

OffsetList:
	@ POIN prHandleCode+1
	