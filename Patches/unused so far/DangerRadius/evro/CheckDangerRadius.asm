@ Intended to be called as ASMC. Arguments: UnitID.
@ Returns 1 if true - currently displaying
@ the Danger Radius for unitID in mem slot 0x2
@ or unit of coords xxyy in mem slot 0xB.

.thumb

.equ S2,									0x030004C0
.equ SC,									0x030004E8
.equ GetUnitStructFromEventParameter,		0x0800BC51

push {r14}

mov		r0, #0x0
ldr		r2, =SC
str		r0, [r2]	@ Assume Danger Radius is not set.

ldr		r2, =S2
ldr		r0, [r2]
ldr		r2, =GetUnitStructFromEventParameter
bl		GOTO_R2

@ Check if enemy unit
ldrb	r1, [r0, #0xB]
mov		r2, #0x80
tst		r1, r2
beq		Return

@ Check if DR is set
mov		r1, #0x32
ldrb 	r1, [r0, r1]	@ Replace with a different bit...
mov		r2,	#0x40		@ ...in unit struct, if in use.
tst		r1, r2
beq		Return

mov		r0, #0x1
ldr		r2, =SC
str		r0, [r2]		@ Danger Radius is set.

Return:
pop		{r0}
bx		r0
GOTO_R2:
bx		r2
