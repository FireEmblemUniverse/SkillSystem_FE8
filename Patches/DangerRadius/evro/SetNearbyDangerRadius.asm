@ Intended to be called as ASMC. Arguments: none.
@ Sets every enemy's Danger Radius.

.thumb

.equ DRCounter,								0x03000006 @ Free space used to count how many DR's are active.
.equ GetUnitStruct,							0x08019431
.equ RefreshFogAndUnitMaps,					0x0801A1F5


push {r4-r7, r14}

@ Iterate over all enemy units and set DR-bit.
mov		r4, #0x0		@ r4 as DRCounter 
mov		r7, #0x40		@ ...in unit struct, if in use.
mov		r6,	#0x80		@r6 as deployment # counter 
mov 	r5, #0x0 		@r5 as non-enemy unit deployment ID counter 
Loop:
mov		r0, r6
ldr		r2, =GetUnitStruct
bl		GOTO_R2	
mov		r7, r0			@r7 as unit struct pointer 
cmp		r7, #0x0
beq		NextIteration

ldr		r3, [r7]
cmp		r3, #0x0
beq		NextIteration

ldrb 	r0, [r3, #4] @Unit ID 
cmp 	r0, #0xF0 
bge 	NextIteration 	@do not set DR for units 0xF0 or higher  


mov 	r3, r7 

@ my stuff in here 
@ r0, r1, r2, and r3 as free 
@r3 as enemy unit 

CheckNearbyPlayerLoop: 
add 	r5, #1 
cmp 	r5, #0x7F 
bgt 	NextIteration 
mov 	r0, r5 
ldr 	r2, =GetUnitStruct 
bl 		GOTO_R2 
cmp 	r0, #0 
beq 	CheckNearbyPlayerLoop
mov 	r2, r0 @player 
@ldr 	r3, [r7] @enemy 

ldrb 	r0, [ r2, #0x10 ] @ X coords.
ldrb 	r1, [ r3, #0x10 ]
sub 	r0, r0, r1 @ Take the difference between the X coords.
cmp 	r0, #0x00
bge 	NotNegative1
		neg r0, r0
NotNegative1:
ldrb 	r1, [ r2, #0x11 ] @ Y coords.
ldrb 	r2, [ r3, #0x11 ]
sub 	r1, r1, r2
cmp 	r1, #0x00
bge 	NotNegative2
		neg r1, r1
NotNegative2:
add 	r0, r0, r1 @ Add the X and Y differences.
	
cmp 	r0, #0x0F 		@distance from enemy. If 15+ tiles, don't set DR. 
bge 	CheckNearbyPlayerLoop 

@ enemy is within 5 tiles, so 

@ Set DR-bit and increment DRCounter
add		r4, #0x1

mov 	r2, #0x32 @ Replace with a different bit in unit struct, if in use.
ldrb	r0, [r7, r2]
mov 	r1, #0x40 
orr 	r0, r1			@ Set DR-bit.
strb	r0, [r7, r2]
b 		CheckNearbyPlayerLoop

NextIteration:

mov 	r5, #0x0 		@reset non-enemy loop deployment ID counter 

add		r6, #0x1
cmp		r6, #0xBF		@ Max enemy unit count.
ble		Loop

Exit:
ldr  	r1, =DRCounter 
strb	r4, [r1] 		@ Store final DRCounter

ldr		r2,=RefreshFogAndUnitMaps
bl		GOTO_R2

@ Return
pop		{r4-r7}
pop		{r0}
bx		r0
GOTO_R2:
bx		r2
