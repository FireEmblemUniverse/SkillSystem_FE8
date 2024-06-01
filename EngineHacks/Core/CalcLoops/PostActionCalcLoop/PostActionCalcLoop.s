
.thumb

.macro blh to, reg
    ldr \reg, =\to
    mov lr, \reg
    .short 0xF800
.endm

.global PostActionCalcLoop
.type PostActionCalcLoop, %function
PostActionCalcLoop: @ Autohook to 0x0801879C. r0 = character struct.
cmp r0, #0x00
beq End
	ldr r0, [ r6 ]
	ldr r1, [ r0, #0x0C ] @ Turn status bitfield.
	mov r2, #0x02
	neg r2, r2
	and r1, r1, r2
	str r1, [ r0, #0x0C ] @ Set "Turn ended". Here and up from vanilla.
	
	@ Now to loop through the functions at PostActionCalcFunctions.
	push { r4 }
	ldr r4, =PostActionCalcFunctions
	CalcLoop:
	ldr r1, [ r4 ]
	cmp r1, #0x00
	beq EndLoop
		ldr r0, [ r6 ] @ r0 = character struct.
		mov lr, r1
		.short 0xF800 @ Call function.
		add r4, r4, #0x04
		b CalcLoop
EndLoop:
pop { r4 }
End:
ldr r0, [ r6 ]
blh #0x0801849C, r1
pop { r4 - r6 }
pop { r0 }
bx r0
