.thumb

.include "_ItemAIDefinitions.h.s"

.equ MovGetter, OffsetList + 0x0
.equ StaffRangeGetter, OffsetList + 0x4
@.equ AIStaffRangeBuilder, OffsetList + 0x8
@arguments: 	r0= item slot, r1= targeting condition

push	{r4-r7,lr}	
mov 	r5, r8  	
mov 	r6, r9  	
@mov 	r7, r10 	
push	{r5-r6} 	
@hold onto pointer to targeting condtion check
mov 	r9,r1
@initialize stack pocket
add 	sp, #-spSize			@create stack pocket
str 	r0,[sp,#spItemSlot]		@store item slot number in stack pocket
mov 	r0, #0x0	
mov 	r8, r0 	
str 	r0, [sp, #0x4]
str 	r0, [sp, #0x8]
str 	r0, [sp, #spTargetUnit]
mov 	r1, #0x1
neg 	r1, r1
str 	r1, [sp, #spDestination]
str 	r1, [sp, #spTargetTile]
str 	r1, [sp, #spPriority]
str 	r1, [sp, #spNewDestination]
str 	r1, [sp, #spNewPriority]
@str 	r1, [sp, #spItemRange]

ldr 	r7, =gActiveUnit
ldr 	r0, [r7]
_blh 	AiFillMovementMapForUnit
ldr 	r0, [sp, #0x18]
_blh 	MapSetInMagicSealedRange

ldr 	r0, =gAIData
add 	r0, #0x7B
ldrb	r1, [r0]
mov 	r0, #0x4
and 	r0, r1
cmp 	r0, #0x0
bne 	End

@get item range
ldr 	r0, [r7]	@get char pointer
ldr 	r1, [sp, #spItemSlot] @get item slot
lsl 	r1, r1, #0x1	
add 	r1, #0x1E	@get item id
ldrh	r1, [r0,r1]
ldr 	r3, StaffRangeGetter
_blr 	r3
str 	r0, [sp, #spItemRange] 	@hold on to staff range here

ldr 	r0, [r7]
ldr 	r3, MovGetter
_blr	r3
@.short 0xF800	@get move of unit
str 	r0, [sp, #spUnitMove]

ldr 	r4, =#gMapSize
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
ldr 	r0, =gMapMovement
ldr 	r0, [r0]
add 	r0, r2, r0
ldr 	r0, [r0]
add 	r0, r0, r5
ldrb 	r0, [r0]
cmp 	r0, #0x78	@check if unit can move to current tile
bhi x_reloop

ldr 	r0, =gMapUnit
ldr 	r0, [r0]
add 	r0, r2, r0
ldr 	r0, [r0]
add 	r0, r0, r5
ldrb 	r0, [r0]
cmp 	r0, #0x0 	@check if a unit is on current space
beq EmptySpace
ldr 	r1, =gActiveUnitID
ldrb 	r1, [r0]
cmp 	r0, r1 		@check if active unit is the one on the current space
bne x_reloop
EmptySpace:

@write to current destination
add 	r0, sp, #spNewDestination
strh 	r5, [r0]
strh 	r6, [r0,#0x2]

@check staff specific condition routine
mov 	r0, sp
ldr 	r1, [r7]
mov 	r2, r5
mov 	r3, r6
_blr r9
mov 	r8, r0

@check bitmap returned by staff's targeting condition
mov 	r1, #0x1
and 	r1, r0
cmp 	r1, #0x0
beq x_reloop
mov 	r0, sp
mov 	r1, #0x0
mov 	r2, #0xFF
mov 	r3, #0xFF
bl ItemAI_PocketWrite

UpdatePriority:
mov 	r0, r8
mov 	r1, #0x2
and 	r1, r0
cmp 	r1, #0x0
beq EarlyEndFlag
ldr 	r1, [sp, #spNewPriority]
str 	r1, [sp, #spPriority]

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
mov 	r0, sp
mov 	r1, #0x5
bl ItemAI_ConfirmAction

End:
add 	sp, #spSize
pop 	{r3-r4}
mov 	r8, r3
mov 	r9, r4
@mov 	r10, r5
pop 	{r4-r7}
pop 	{r3}
Jump:
bx	r3
.ltorg
.align
OffsetList:

