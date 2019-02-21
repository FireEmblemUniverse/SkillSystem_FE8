.thumb
.include "_TargetSelectionDefinitions.s"
@parameters:
	@r0 = x
	@r1 = y
	@r2 = min max range word
	
push	{r4-r7,lr}
mov 	r5, r0
mov 	r6, r1
mov 	r7, r2
@build max range
ldr 	r4, DrawRange
mov 	r2, #0xFF
and 	r2, r7
mov 	r3, #0x1
bl	Jumpr4
@clear out everything below min range
lsr 	r2, r7, #0x10
mov 	r1, #0xFF
and 	r2, r1
cmp 	r2, #0x0
ble SkipMinRange
sub 	r2, #0x1
mov 	r0, r5
mov 	r1, r6
mov 	r3, #0x1
neg 	r3, r3
bl	Jumpr4
SkipMinRange:
pop 	{r4-r7}
pop 	{r3}
bx	r3
Jumpr4:
bx	r4

.ltorg
.align
DrawRange:
