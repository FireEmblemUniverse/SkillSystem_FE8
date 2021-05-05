@ Intended to be called as ASMC. Arguments: UnitID.
@ Unsets the Danger Radius for unitID in mem slot 0x2
@ or unit of coord xxyy in mem slot 0xB.

.thumb

.equ S2,									0x030004C0
.equ SC,									0x030004E8
.equ DRCounter,								0x03000006 @ Free space used to count how many DR's are active.
.equ GetUnitStructFromEventParameter,		0x0800BC51
.equ RefreshFogAndUnitMaps,					0x0801A1F5


push {r14}

ldr		r2, =S2
ldr		r0, [r2]
ldr		r2, =GetUnitStructFromEventParameter
bl		GOTO_R2

@ Check if enemy unit
ldrb	r1, [r0, #0xB]
mov		r2, #0x80
tst		r1, r2
beq		Return

@ Check DR
mov		r1, #0x32
ldrb 	r3, [r0, r1]	@ Replace with a different bit...
mov		r2,	#0x40		@ ...in unit struct, if in use.
tst		r2, r3
beq		Return			@ DRbit is already unset

@ Unset DR
ldr		r1, =DRCounter
ldrb	r2, [r1]
sub		r2, #0x1
strb	r2, [r1]

mov		r2,	#0x40
eor		r3, r2
mov		r1, #0x32
strb	r3, [r0, r1]

ldr		r2,=RefreshFogAndUnitMaps
bl		GOTO_R2

Return:
pop		{r0}
bx		r0
GOTO_R2:
bx		r2
