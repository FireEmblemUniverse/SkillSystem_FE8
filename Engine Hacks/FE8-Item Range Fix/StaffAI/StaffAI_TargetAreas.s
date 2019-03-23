.thumb

.include "_ItemAIDefinitions.s"

.equ StaffRangeGetter, OffsetList + 0x0
@.equ MovGetter, OffsetList + 0x0
@.equ AIStaffRangeBuilder, OffsetList + 0x8
@parameters: 	r0= item slot, r1= targeting condition

push	{r4-r7,lr}	
mov 	r5, r8  	
mov 	r6, r9  	
mov 	r7, r10 	
push	{r5-r7} 			@start by pushing everything from r4 to r10
add 	sp, #-0x30			@create stack pocket
str 	r0,[sp,#0x10]		@store item slot number in stack pocket
mov 	r9,r1				@mov pointer to targeting condtion check to r9
mov 	r0, #0x0	
mov 	r10, r0 	
str 	r0, [sp, #0x1C]

ldr 	r0, =#turnList
add 	r0, #0x7B
ldrb	r1, [r0]
mov 	r0, #0x4
and 	r0, r1
cmp 	r0, #0x0
bne 	End

mov 	r1, #0x1
neg 	r1, r1
str 	r1, [sp, #0x14]		@clear out sections in stack pocket
str 	r1, [sp, #0x18]
str 	r1, [sp, #0x20]

ldr 	r7, =ActiveUnit
ldr 	r0, [r7]
_blh 	MovBuild
@mov 	r14, r3
@.short	0xF800 
@ldr 	r0, [sp, #0x18]
_blh 	MagicSealCheck

@get item range
ldr 	r0, [r7]	@get char pointer
ldr 	r1, [sp, #0x10] @get item slot
lsl 	r1, r1, #0x1	
add 	r1, #0x1E	@get item id
ldrh	r1, [r0,r1]
ldr 	r3, StaffRangeGetter
_blr 	r3
str 	r0, [sp, #0x24] 	@hold on to staff range here

ldr 	r4, =#MapSize
mov 	r0, #0x2
ldsh 	r0, [r4, r0]	@grab height of map
sub 	r6, r0, #0x1
cmp 	r6, #0x0
blt 	y_reloop
y_loop:
mov 	r0, #0x0
ldsh 	r0, [r4, r0]	@grab width of map
sub 	r5, r0, #0x1

x_loop:
lsl 	r2, r6, #0x2
ldr 	r0, =MoveCostMapRows
ldr 	r0, [r0]
add 	r0, r2, r0
ldr 	r0, [r0]
add 	r0, r0, r5
ldrb 	r0, [r0]
cmp 	r0, #0x78	@check if unit can move to current tile
bhi x_reloop

ldr 	r0, =UnitMapRows
ldr 	r0, [r0]
add 	r0, r2, r0
ldr 	r0, [r0]
add 	r0, r0, r5
ldrb 	r0, [r0]
cmp 	r0, #0x0 	@check if a unit is on current space
beq EmptySpace
ldr 	r1, =ActiveUnitInfo
ldrb 	r1, [r0]
cmp 	r0, r1 		@check if active unit is the one on the current space
bne x_reloop
EmptySpace:

mov 	r0, sp
ldr 	r1, [r7]
mov 	r2, r5
mov 	r3, r6
_blr r9
@mov 	lr, r9
@.short 0xF800	@check if this space meets the staff's condition

@check bitmap returned by staff's targeting condition
mov 	r1, #0x1
and 	r1, r0
cmp 	r1, #0x0
beq x_reloop
add 	r2, sp, #0x14
strh 	r5, [r2]
strh 	r6, [r2, #0x2]
@mov 	r1, #0x0
@str 	r1, [sp, #0x1C]
mov 	r1, #0x1
mov 	r10, r1

UpdatePriority:
mov 	r1, #0x2
and 	r1, r0
cmp 	r1, #0x0
beq EarlyEndFlag
ldr 	r1, [sp, #0x28]
str 	r1, [sp, #0x20]

EarlyEndFlag:	@end loop early if bit is flagged
mov 	r1, #0x8
and 	r1, r0
cmp 	r1, #0x0
bne loopexit

x_reloop:
sub 	r5, #0x1
cmp 	r5, #0x0
blt y_reloop
b x_loop

y_reloop:
sub 	r6, #0x1
cmp 	r6, #0x0
blt loopexit
b y_loop

loopexit:
mov 	r0, r10
cmp 	r0, #0x0
beq End 		@don't write to AAS if no target was found

@store result in AAS
@ldr 	r2, =#ActionStruct
@ldrh 	r0, [r3]
@strb 	r0, [r2, #0x13]
@ldrh 	r0, [r3, #0x2]
@strb 	r0, [r2, #0x14]
add 	r2, sp, #0x14
ldrh 	r0, [r2]
ldrh 	r1, [r2, #0x2]
ldr 	r3, [sp, #0x1C]
ldr 	r2, [sp, #0x10]
str 	r2, [sp]
mov 	r2, #0x0
str 	r2, [sp, #0x4]
str 	r2, [sp, #0x8]
mov 	r2, #0x5
_blh ActionWrite, r4
@ldr 	r4, =#ActionWrite
@mov 	lr, r4
@.short	0xF800		@write targeting info to AAS

End:
add 	sp, #0x30
pop 	{r3-r5}
mov 	r8, r3
mov 	r9, r4
mov 	r10, r5
pop 	{r4-r7}
pop 	{r3}
Jump:
bx	r3
.ltorg
.align
OffsetList:
