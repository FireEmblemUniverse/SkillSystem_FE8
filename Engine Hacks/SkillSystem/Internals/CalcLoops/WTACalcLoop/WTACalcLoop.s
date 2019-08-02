
.thumb

.macro blh to, reg
    ldr \reg, =\to
    mov lr, \reg
    .short 0xF800
.endm

.equ ApplyReaver, 0x0802C76C

.global WTACalcLoop
.type WTACalcLoop, %function
WTACalcLoop: @ Autohook to 0x0802C830. Loop through all functions under label WTACalcFunctions.
@ r4 = attack struct, r5 = defense struct.
@ Assumed parameters for all functions: r0 = attack struct, r1 = defense struct.
and r0, r6
cmp r0, #0x00
beq VanillaLabel
mov r0, r4
mov r1, r5
blh ApplyReaver, r2
VanillaLabel:

ldr r6, =WTACalcFunctions @ Loop through all functions.
StartLoop:
ldr r2, [ r6 ]
cmp r2, #0x00
beq ExitLoop
	mov r0, r4
	mov r1, r5
	mov lr, r2
	.short 0xF800
	add r6, r6, #0x04
	b StartLoop
ExitLoop:
pop { r4 - r6 }
pop { r0 }
bx r0
