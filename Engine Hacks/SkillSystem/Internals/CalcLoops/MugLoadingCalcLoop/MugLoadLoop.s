
.thumb

.macro blh to, reg
    ldr \reg, =\to
    mov lr, \reg
    .short 0xF800
.endm

.global MugLoadCalcLoop
.type MugLoadCalcLoop, %function
MugLoadCalcLoop: @ Autohook to 0x08007898. This loops through each function under MugLoadingFunctions.
@ Their parameters will be r0 = this control code. Each function should return either a mug or 0. If a mug is returned, all following functions will be ignored.
push { r5, r6 }
ldrb r4, [ r0 ]
ldrb r0, [ r0, #0x01 ]
lsl r0, r0, #0x08
add r4, r0, r4
	@ r4 = this control code.
	ldr r5, =MugLoadingFunctions
	BeginLoop:
	ldr r1, [ r5 ]
	cmp r1, #0x00
	beq EndNormal @ End of the list with no special mug. Proceed normally.
	mov r0, r4
	mov lr, r1
	.short 0xF800
	add r5, r5, #0x04
	cmp r0, #0x00
	beq BeginLoop @ The function returned 0, indicating there is no mug for this control code.
End:
ldr r2, =#0x100
add r4, r0, r2
EndNormal:
ldr r0, =#0xFFFF
cmp r4, r0
beq CurrentChar @ Keep 0xFFFF hardcoded to the current character.
pop { r5, r6 }
ldr	r0, =#0x80078C1
bx r0

CurrentChar:
ldr	r0, =#0x3004E50
ldr	r0, [ r0 ]
blh #0x080192B8, r2
pop { r5, r6 }
ldr r2, =#0x080078AF
bx r2
