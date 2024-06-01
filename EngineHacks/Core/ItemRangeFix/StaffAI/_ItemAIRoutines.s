.thumb

.include "_ItemAIDefinitions.s"

.global ItemAI_ConfirmAction
.type ItemAI_ConfirmAction, %function
.global ItemAI_PocketWrite
.type ItemAI_PocketWrite, %function
.global ItemAI_RangeBuilder
.type ItemAI_RangeBuilder,%function

ItemAI_ConfirmAction:
@arguments:
	@r0 = stack pocket pointer
	@r1 = action
push 	{r4-r5,lr}
add 	sp, #-0xC
mov 	r4, r0
mov 	r5, r1
@check if destination coordinates are null
mov 	r3, r4
add 	r3, #spDestination
ldr 	r0, [r3]
mov 	r1, #0x1
neg 	r1, r1
@if there is no destination we terminate the routine early
cmp 	r0, r1
beq NoAction	
@store result in AAS
mov 	r3, r4
add 	r3, #spTargetTile
ldr 	r1, [r3]
mov 	r0, #0x1
neg 	r0, r0
cmp 	r1, r0
beq UpdateAction
@store target tile coordinates
@I cheat by storing it directly in the action struct
ldr 	r2, =#gActionData
ldrh 	r0, [r3]
strb 	r0, [r2, #0x13]
ldrh 	r0, [r3, #0x2]
strb 	r0, [r2, #0x14]
UpdateAction:
@get destination coordinates
mov 	r2, r4
add 	r2, #spDestination
ldrh	r0, [r2]
ldrh	r1, [r2,#0x2]
@get target unit id
ldr 	r3, [r4, #spTargetUnit]
ldr 	r2, [r4, #spItemSlot]
str 	r2, [sp]
ldr 	r2, [r4, #0x4]
str 	r2, [sp, #0x4]
ldr 	r2, [r4, #0x8]
str 	r2, [sp, #0x8]
mov 	r2, r5
@ldr 	r4, =#ActionWrite
@mov 	lr, r4
@.short	0xF800		@write targeting info to AAS
_blh AiSetDecision, r4
NoAction:
add 	sp, #0xC
pop 	{r4-r5}
pop 	{r0}
bx 	r0
.align
.ltorg

ItemAI_PocketWrite:
@arguments:
	@r0 = pointer to stack pocket
	@r1 = target unit id
	@r2 = target tile x, r3 = target tile y
push 	{r4}
mov 	r4, r0
@update current target unit to the new target
str 	r1, [r4, #spTargetUnit]
cmp 	r2, #0xFF
beq NoTargetTile
@update current target tile to the new target
mov 	r0, #spTargetTile
add 	r0, r4, r0
strh 	r2, [r0]
strh 	r3, [r0,#0x2]
NoTargetTile:
@store coordinates
mov 	r1, r4
mov 	r2, r4
add 	r1, #spNewDestination
add 	r2, #spDestination
ldrh 	r0, [r1]
strh 	r0, [r2]
ldrh 	r0, [r1,#0x2]
strh 	r0, [r2,#0x2]
@ldr 	r0, [r4,#0xC]
@str 	r0, [r4,#0x14]
pop 	{r4}
bx 	lr
.align

ItemAI_RangeBuilder:
@arguments:
	@r0 = x
	@r1 = y
	@r2 = pointer to item range in stack pocket

push {r4-r6,lr}
mov 	r4, r0
mov 	r5, r1
mov 	r6, r2

@clear out range map
ldr 	r0, =gMapRange
ldr 	r0, [r0]
mov 	r1, #0x0
_blh SetupMapRowPointers

ldrh 	r0, [r6]
cmp 	r0, #0xFF
bne BuildRange
@if total range fill entire range map
ldr 	r0, =gMapRange
ldr 	r0, [r0]
mov 	r1, #0x0
_blh SetupMapRowPointers

BuildRange:
@build max range
mov 	r0, r4
mov 	r1, r5
ldrh 	r2, [r6]
ldr 	r3, =#MapAddInRange
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
ldr 	r3, =#MapAddInRange
mov 	lr, r3
mov 	r3, #0x1
neg 	r3, r3
.short 0xF800
SkipMinRange:
pop 	{r4-r6}
pop {r15}
.align
.ltorg
