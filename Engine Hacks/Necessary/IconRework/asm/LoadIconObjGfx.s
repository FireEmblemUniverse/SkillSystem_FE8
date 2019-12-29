.thumb
.include "_Definitions.h.s"

.set prRegisterTileFill,    (0x08002054+1)
.set prRegisterTileGfx,     (0x08002014+1)

.set lpaIconGfxGetterArray, (EALiterals+0x00)

@ Arguments: r0 = Icon ID (Short), r1 = Tile Index
LoadIconObjGfx:
	push {r4-r5, lr}
	
	@ r4 = Output VRAM root
	ldr r4, =#0x6010000 @ Start of obj tile region of VRAM
	lsl r1, #5
	add r4, r1
	
	cmp r0, #0
	bge Register
	
	@ Invalid Icon Index: Clearing the output
	
	mov r0, #0    @ arg r0 = fill value
	mov r1, r4    @ arg r1 = destination
	mov r2, #0x40 @ arg r2 = size
	
	_blh prRegisterTileFill
	
	mov r1, #0x04
	lsl r1, #8
	add r1, r4    @ arg r1 = destination
	
	mov r0, #0    @ arg r0 = fill value
	mov r2, #0x40 @ arg r2 = size
	
	_blh prRegisterTileFill
	
	b End
	
Register:
	@ r0 = Item Icon Short
	
	lsr r2, r0, #8 @ r2 = Sheet Index
	lsl r2, #2     @ r2 = Sheet Index * sizeof(pointer)
	
	@ r1 = Icon Getter for relevant Sheet
	ldr r1, lpaIconGfxGetterArray
	add r1, r2
	ldr r1, [r1]
	
	@ arg r0 = IconID Short
	
	_blr r1
	
	@ r5 = Item Icon Gfx Pointer
	mov r5, r0
	
	              @ arg r0 = Sorc
	mov r1, r4    @ arg r1 = Dest
	mov r2, #0x40 @ arg r2 = Size
	
	_blh prRegisterTileGfx
	
	mov r1, #0x04
	lsl r1, #8
	add r1, r4    @ arg r1 = Dest
	
	mov r0, r5
	add r0, #0x40 @ arg r0 = Sorc
	
	mov r2, #0x40 @ arg r2 = Size
	
	_blh prRegisterTileGfx
	
End:
	pop {r4-r5}
	
	pop {r0}
	bx r0

.ltorg
.align

EALiterals:
	@ POIN IconGfxGetterArray
