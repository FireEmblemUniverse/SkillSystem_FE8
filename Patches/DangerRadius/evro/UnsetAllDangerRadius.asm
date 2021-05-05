@ Intended to be called as ASMC. Arguments: none.
@ Unsets every enemy's Danger Radius.

.thumb

.equ DRCounter,								0x03000006 @ Free space used to count how many DR's are active.
.equ GetUnitStruct,							0x08019431
.equ RefreshFogAndUnitMaps,					0x0801A1F5


push {r4-r7, r14}

@ Iterate over all enemy units and unset DR-bit.

mov		r4, #0x0
mov		r5, #0x32		@ Replace with a different bit in unit struct, if in use.
ldr		r6, =DRCounter
mov		r7, #0x40		@ ...in unit struct, if in use.
mvn		r7, r7
mov		r3,	#0x81
Loop:
mov		r0, r3
ldr		r2, =GetUnitStruct
bl		GOTO_R2
mov		r1, r0
cmp		r1, #0x0
beq		NextIteration

ldr		r0, [r1]
cmp		r0, #0x0
beq		NextIteration

@ Unset DR-bit
ldrb	r0, [r1, r5]
and 	r0, r7			@ Unset DR-bit.
strb	r0, [r1, r5]

NextIteration:
add		r3, #0x1
cmp		r3, #0xBF		@ Max enemy unit count.
ble		Loop

strb	r4, [r6] 		@ Reset DRCounter

ldr		r2,=RefreshFogAndUnitMaps
bl		GOTO_R2

@ Return
pop		{r4-r7}
pop		{r0}
bx		r0
GOTO_R2:
bx		r2
