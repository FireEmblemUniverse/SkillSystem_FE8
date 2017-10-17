.thumb
.include "_Definitions.h.s"

.set prGetIconGfxTileIndex, (0x08003610+1)
.set prRegisterTileGfx,     (0x08002014+1)

.set paIconInfoArray,       (0x02026A90)

.set lpaIconGfxGetterArray, (EALiterals+0x00)

GetIconTileIndex:
	push {r4-r5, lr}
	
	mov r4, r0
	
	bl GetIconGfxIndex @ Arguments: r0 = Icon Id; Returns: r0 = Gfx Index (0 if none)
	
	cmp r0, #0
	beq Register
	
	_blh prGetIconGfxTileIndex
	b End
	
Register:
	mov r0, r4
	bl AddIconGfxIndex @ Arguments: r0 = Icon Id; Returns: r0 = Gfx Index (0 if no space available)
	
	_blh prGetIconGfxTileIndex
	mov r5, r0
	
	lsr r0, r4, #8 @ r0 = Sheet Index
	lsl r0, #2     @ r0 = Sheet Index * sizeof(pointer)
	
	@ r1 = Icon Getter for relevant Sheet
	ldr r1, lpaIconGfxGetterArray
	add r1, r0
	ldr r1, [r1]
	
	@ arg r0 = IconID Short
	mov r0, r4
	
	_blr r1
	
	@ arg r0 = Pointer to icon gfx
	
	lsl r3, r5, #5 @ r0 = r5*32
	
	@ r2 = 0x06000000 = VRAM root
	mov r2, #0x06
	lsl r2, #24
	
	add r1, r3, r2 @ arg r1 = Target VRAM
	mov r2, #0x80  @ arg r2 = sizeof(gfx)
	
	_blh prRegisterTileGfx
	
	mov r0, r5

End:
	pop {r4-r5}
	
	pop {r1}
	bx r1

.ltorg
.align

AddIconGfxIndex:
	ldr r3, =(paIconInfoArray-2)
	mov r2, #0
	
AddIconGfxIndex_BeginLoop:
	@ Icrement iterator and index
	add r3, #2
	add r2, #1
	
	@ r1 = *it
	mov r1, #0
	ldsh r1, [r3, r1]
	
	cmp r1, #0
	bge AddIconGfxIndex_ContinueLoop @ icon >= 0 means Not Free
	
	@ STORE because that's freeeee
	strh r0, [r3]
	b AddIconGfxIndex_End
	
AddIconGfxIndex_ContinueLoop:
	cmp r2, #0x20
	bne AddIconGfxIndex_BeginLoop
	
	mov r2, #0
	
AddIconGfxIndex_End:
	mov r0, r2
	bx lr

.ltorg
.align

GetIconGfxIndex:
	ldr r3, =(paIconInfoArray-2)
	mov r2, #0

GetIconGfxIndex_BeginLoop:
	add r3, #2
	add r2, #1
	
	ldrh r1, [r3]
	
	cmp r1, r0
	beq GetIconGfxIndex_End
	
	cmp r2, #0x20
	bne GetIconGfxIndex_BeginLoop
	
	mov r2, #0

GetIconGfxIndex_End:
	mov r0, r2
	bx lr

.ltorg
.align

EALiterals:
	@ POIN IconGfxGetterArray
