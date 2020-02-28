@Staff AI Range Building
.thumb

.include "_ItemAIDefinitions.s"

@parameters
	@r0 = x
	@r1 = y
	@r2 = stack pocket pointer

RangeBuilder:
push {r4-r6,lr}
mov 	r4, r0
mov 	r5, r1
@get the part of stack pocket that's holding the range
add 	r2, #0x24	
mov 	r6, r2
@clear out range map
ldr 	r0, =RangeMap
ldr 	r0, [r0]
mov 	r1, #0x0
_blh FillMap
@mov 	lr, r3
@.short 0xF800

@build max range
mov 	r0, r4
mov 	r1, r5
ldrh 	r2, [r6]
ldr 	r3, =#AddRange
mov 	lr, r3
mov 	r3, #0x1
.short 0xF800

@clear out everything below min range
ldrh 	r2, [r6, #0x2]
cmp 	r2, #0x0
ble SkipMinRange
sub 	r2, #0x1
mov 	r0, r4
mov 	r1, r5
ldr 	r3, =#AddRange
mov 	lr, r3
mov 	r3, #0x1
neg 	r3, r3
.short 0xF800
SkipMinRange:
pop 	{r4-r6}
pop 	{r0}
bx r0

.ltorg
.align
