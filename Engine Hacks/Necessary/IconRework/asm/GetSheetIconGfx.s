.thumb
.include "_Definitions.h.s"

.set ppDefaultIconGfx, (0x08003788)
.set lpIconGfx,        (EALiterals+0x00)

@ Arguments: r0 = Icon Id (with or without sheet)
GetSheetIconGfx:
	ldr r1, lpIconGfx
	
	cmp r1, #0
	bne Return @ non zero means not loading defaults
	
	ldr r1, =ppDefaultIconGfx
	ldr r1, [r1]
	
Return:
	lsl r0, #(24)
	lsr r0, #(24 - 7) @ r0 = (IconID & 0xFF) * 0x80
	
	@ Result = pSheet + 0x80*IconID
	add r0, r1
	
	bx lr

.ltorg
.align

EALiterals:
	@ POIN pIconGfx
