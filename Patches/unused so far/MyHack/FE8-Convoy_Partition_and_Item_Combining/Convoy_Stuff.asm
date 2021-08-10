.thumb

.set Get_Partition_From_Chapter_Data_Table, 1		@ change this to 0 if you want to do a linked list with functions instead (otherwise it uses the byte at +0x3D in the chapter data table as the partition ID

.global GetConvoyPartitionStartOffset
.global GetConvoyItemCount
.global AddItemToConvoy
.global GetConvoyItemSlot
.global ClearConvoyPartition

.global Hook_9D674
.global Hook_9D738
.global Hook_9D764
.global Hook_9E8F4
.global Hook_1DFAC
.global Hook_1E058
.global Hook_1E0E8
.global Hook_9827C
.global Hook_9A550
.global Hook_9A550_No_Combine
.global Hook_9DD08
.global Hook_B4730
.global Hook_9EAD8

.global CombineWhenTaking
.global CombineWhenGivingAll
.global CombineWhenGivingOne

.global CombineConvoyPartitionsASMC

.global StartCombineDisplayProc
.global CombineDisplayLoop
.global Delete_Proc_DisplayCombine


GetConvoyPartitionEntry:
.if Get_Partition_From_Chapter_Data_Table == 1
	push	{r14}
	ldr		r0,=#0x202BCF0		@ gChapterData
	ldrb	r0,[r0,#0xE]
	ldr		r3,=#0x8034618		@ GetChapterDefinition
	mov		r14,r3
	.short	0xF800
	add		r0,#0x3D			@ unused byte between tactics ranking and experience ranking
	ldrb	r0,[r0]
	lsl		r0,#3
	ldr		r1,=ConvoyPartitionTable
	add		r0,r1
	pop		{r1}
	bx		r1
	.ltorg
.else
	push	{r4,r14}
	ldr		r4,=ConvoyPartitionTable
	ConvoyPartitionLoop:
	ldr		r0,[r4]
	cmp		r0,#0				@ terminator
	beq		RetConvoyPartitionEntry
	ldr		r0,[r4,#4]			@ routine
	cmp		r0,#0
	beq		RetConvoyPartitionEntry		@ if routine doesn't exist, this is assumed to be a default case
	bl		bx_r0
	cmp		r0,#0
	bne		RetConvoyPartitionEntry
	add		r4,#8
	b		ConvoyPartitionLoop
	RetConvoyPartitionEntry:
	mov		r0,r4
	pop		{r4}
	pop		{r1}
	bx		r1
	.ltorg

	bx_r0:
	bx		r0
.endif

.align
GetConvoyPartitionSize:
push	{r14}
bl		GetConvoyPartitionEntry
ldrb	r0,[r0,#1]			@ partition length
pop		{r1}
bx		r1



.align
GetConvoyPartitionStartOffset:
push	{r14}
bl		GetConvoyPartitionEntry
ldrb	r0,[r0]				@ partition start
lsl		r0,#1
ldr		r1,=gpConvoyItemArray
ldr		r1,[r1]
add		r0,r1
pop		{r1}
bx		r1
.ltorg



.align
GetConvoyItemCount:
push	{r4,r14}
bl		GetConvoyPartitionStartOffset
mov		r4,r0
bl		GetConvoyPartitionSize
mov		r3,r0
mov		r0,#0
GetConvoyItemCountLoop:
ldrh	r1,[r4]
cmp		r1,#0
beq		EndConvoyItemCountLoop
add		r0,#1
add		r4,#2
sub		r3,#1
cmp		r3,#0
bgt		GetConvoyItemCountLoop
EndConvoyItemCountLoop:
pop		{r4}
pop		{r1}
bx		r1
.ltorg



.align
AddItemToConvoy:
@ r0 = item/uses to store
push	{r4-r7,r14}
mov		r4,r0
ldr		r5,=#0x202BCB0		@ gGameState
mov		r0,#0
strh	r0,[r5,#0x2E]
bl		GetConvoyPartitionStartOffset
mov		r6,r0
bl		GetConvoyPartitionSize
mov		r7,r0
mov		r3,#0
AddItemToConvoyLoop:
ldrh	r0,[r6]
cmp		r0,#0
bne		NextItemInConvoy
strh	r4,[r6]
mov		r0,r3
b		End_AddItemToConvoy
NextItemInConvoy:
add		r3,#1
add		r6,#2
cmp		r3,r7
blt		AddItemToConvoyLoop
strh	r4,[r5,#0x2E]		@ I guess this shouldn't happen, since there's checks to ensure the convoy has room before this, but whatever
mov		r0,#1
neg		r0,r0
End_AddItemToConvoy:
pop		{r4-r7}
pop		{r1}
bx		r1
.ltorg



.align
GetConvoyItemSlot:		@ used to check if member's card is in convoy
@ r0=item id/uses
push	{r4-r5,r14}
ldr		r3,=#0x80174EC	@ GetItemIndex
mov		r14,r3
.short	0xF800
mov		r4,r0
bl		GetConvoyPartitionStartOffset
mov		r5,r0
bl		GetConvoyPartitionSize
mov		r3,#0
mov		r2,#0xFF
GetConvoyItemSlotLoop:
ldrh	r1,[r5]
cmp		r1,#0
beq		ItemNotInConvoy
and		r1,r2
cmp		r1,r4
beq		End_GetConvoyItemSlot
add		r5,#2
add		r3,#1
cmp		r3,r0
blt		GetConvoyItemSlotLoop
ItemNotInConvoy:
mov		r3,#1
neg		r3,r3
End_GetConvoyItemSlot:
mov		r0,r3
pop		{r4-r5}
pop		{r1}
bx		r1
.ltorg



.align
ClearConvoyPartition:
push	{r4,r14}
add		sp,#-4
mov		r1,r13
mov		r0,#0
strh	r0,[r1]
bl		GetConvoyPartitionStartOffset
mov		r4,r0
bl		GetConvoyPartitionSize
mov		r2,#1
lsl		r2,#0x18
orr		r2,r0			@ should make 0x10000XX
mov		r1,r4
mov		r0,r13
ldr		r3,=#0x80D1678	@ CpuSet
mov		r14,r3
.short	0xF800
add		sp,#4
pop		{r4}
pop		{r0}
bx		r0
.ltorg



.align
Hook_9D674:			@ palette of the word 'Give' (grey if full)
@ r5=number of items in convoy
push	{r14}
mov		r4,#0
bl		GetConvoyPartitionSize
cmp		r5,r0
bge		Label1
cmp		r6,#0
bne		Label2
Label1:
mov		r4,#1
Label2:
pop		{r0}
bx		r0



.align
Hook_9D738:			@  palette for the number of items (glowy-green if full)
@ r0=number of items in convoy
push	{r14}
mov		r4,r0
bl		GetConvoyPartitionSize
mov		r3,r4
mov		r4,#2
cmp		r3,r0
blt		Label3
mov		r4,#4
Label3:
pop		{r0}
bx		r0



.align
Hook_9D764:			@ draw the maximum capacity number
push	{r14}
bl		GetConvoyPartitionSize
mov		r2,r0
mov		r0,r6
add		r0,#0x12
mov		r1,#2
ldr		r3,=#0x8004B88	@ DrawUiNumber
mov		r14,r3
.short	0xF800
mov		r0,#1
pop		{r1}
bx		r1
.ltorg



.align
Hook_9E8F4:			@ determine whether to go back to the Give/Take menu after adding an item
@ r1 = gActionData (203A958)
@ return 0 if not going back to menu
push	{r5,r14}
mov		r0,#0x1C
strb	r0,[r1,#0x11]
cmp		r4,#0
beq		RetOne1		@ no inventory space left
ldr		r3,=#0x8097CC8		@ GetConvoyItemCount wrapper
mov		r14,r3
.short	0xF800
mov		r5,r0
bl		GetConvoyPartitionSize
cmp		r5,r0
bge		RetOne1
mov		r0,#0
b		End_Hook_9E8F4
RetOne1:
mov		r0,#1
End_Hook_9E8F4:
pop		{r5}
pop		{r1}
bx		r1
.ltorg



.align
Hook_1DFAC:			@ check if convoy is full when giving an item and the inventory is full
@ [r5] = number of items in convoy
push	{r14}
cmp		r0,#0
beq		ConvoyAccessDenied
bl		GetConvoyPartitionSize
ldrb	r1,[r5]
cmp		r1,r0
bge		ConvoyAccessDenied
ldr		r0,=#0x859D0D0
b		End_Hook_1DFAC
ConvoyAccessDenied:
ldr		r0,=#0x859D0AC
End_Hook_1DFAC:
pop		{r1}
bx		r1
.ltorg



.align
Hook_1E058:			@ what string to display after sending an item or dropping it
@ [r0] = number of items in convoy
@ return 0 if convoy is full
push	{r4,r14}
ldrb	r4,[r0]
bl		GetConvoyPartitionSize
mov		r1,#0
cmp		r4,r0
bge		End_Hook_1E058
mov		r1,#1
End_Hook_1E058:
mov		r0,r1
pop		{r4}
pop		{r1}
bx		r1



.align
Hook_1E0E8:			@ HandleNewItemGet
push	{r4}
ldr		r3,=#0x8031570	@ GetConvoyItemCount
mov		r14,r3
.short	0xF800
mov		r4,r0
bl		GetConvoyPartitionSize
ldr		r1,=#0x801E10D
cmp		r4,r0
bge		End_Hook_1E0E8
ldr		r1,=#0x801E0F1
End_Hook_1E0E8:
pop		{r4}
bx		r1
.ltorg



.align
Hook_9827C:				@ SomethingPrepListRelated
@ r1=ConvoyItemArray, r3=gPrepScreenItemListSize, r4=0, r6=gPrepScreenItemList
@ entry in the prep screen item list is 0, count, item id/uses
push	{r5,r7,r14}
mov		r5,r1
mov		r7,r3
bl		GetConvoyPartitionSize
mov		r1,#0			@ counter
Loop_9827C:
ldrh	r2,[r5]
cmp		r2,#0
beq		End_Loop_9827C
strh	r2,[r6,#2]
strb	r4,[r6]
strb	r1,[r6,#1]
add		r6,#4
add		r5,#2
add		r1,#1
cmp		r1,r0
blt		Loop_9827C
End_Loop_9827C:
ldrb	r2,[r7]
add		r2,r1
strb	r2,[r7]
pop		{r5,r7}
pop		{r0}
bx		r0



.align
Hook_9A550:				@ Give all items
@ r4=counter for number of items, r5=unit data, r6=number of items in convoy, r7=number of items in inventory
push	{r14}
add		sp,#-4
bl		GetConvoyPartitionSize
str		r0,[sp]			@ store on stack since I need the other registers
Loop_9A550:
ldr		r0,[sp]
cmp		r6,r0
bge		End_Loop_9A550	@ convoy is full
ldr		r0,=#0x858791C		@ gKeyStatus
ldr		r0,[r0]
ldrh	r0,[r0,#4]
mov		r1,#2
lsl		r1,#8				@ 0x200, L button
tst		r0,r1
beq		AddItem1
ldrh	r0,[r5,#0x1E]
bl		TryToCombineInConvoy	@ returns updated item/uses short
cmp		r0,#0
beq		RemoveItem1
strh	r0,[r5,#0x1E]
AddItem1:
ldrh	r0,[r5,#0x1E]
ldr		r3,=#0x8031594	@ AddItemToConvoy
mov		r14,r3
.short	0xF800
RemoveItem1:
mov		r0,r5
mov		r1,#0
ldr		r3,=#0x8019484	@ RemoveUnitItem
mov		r14,r3
.short	0xF800
add		r6,#1
add		r4,#1
cmp		r4,r7
blt		Loop_9A550
End_Loop_9A550:
add		sp,#4
pop		{r0}
bx		r0
.ltorg


.align
Hook_9A550_No_Combine:				@ Give all items
@ r4=counter for number of items, r5=unit data, r6=number of items in convoy, r7=number of items in inventory
push	{r14}
add		sp,#-4
bl		GetConvoyPartitionSize
str		r0,[sp]			@ store on stack since I need the other registers
Loop_9A550_2:
ldr		r0,[sp]
cmp		r6,r0
bge		End_Loop_9A550_2	@ convoy is full
ldrh	r0,[r5,#0x1E]
ldr		r3,=#0x8031594	@ AddItemToConvoy
mov		r14,r3
.short	0xF800
mov		r0,r5
mov		r1,#0
ldr		r3,=#0x8019484	@ RemoveUnitItem
mov		r14,r3
.short	0xF800
add		r6,#1
add		r4,#1
cmp		r4,r7
blt		Loop_9A550_2
End_Loop_9A550_2:
add		sp,#4
pop		{r0}
bx		r0
.ltorg


.align
Hook_9DD08:				@ when selecting Give
push	{r4}
ldr		r3,=#0x8097CC8	@ GetConvoyItemCount wrapper
mov		r14,r3
.short	0xF800
mov		r4,r0
bl		GetConvoyPartitionSize
mov		r1,#0
cmp		r4,r0
bge		End_Hook_9DD08
mov		r1,#1
End_Hook_9DD08:
mov		r0,r1
pop		{r4}
ldr		r1,=#0x809DD11
bx		r1
.ltorg



.align
Hook_B4730:				@ probably related to transferring bonus items
push	{r4-r5,r14}
mov		r4,r0
ldr		r3,=#0x8031570	@ GetConvoyItemCount
mov		r14,r3
.short	0xF800
mov		r5,r0
bl		GetConvoyPartitionSize
cmp		r5,r0
bge		End_Hook_B4730
mov		r0,r4
mov		r1,#0xA
ldr		r3,=#0x8002F24	@ GoToProcLable
mov		r14,r3
.short	0xF800
End_Hook_B4730:
pop		{r4-r5}
pop		{r0}
bx		r0
.ltorg



@ courtesy of Hypergammaspaces - properly sets gActiveUnit when calling the convoy from the world map
.align
Hook_9EAD8:            @ Store unit's data in Active Unit even if accessing from prep screen
push     {r4, lr}
mov     r4, r0
ldr     r0, =#0x8A1920C @ convoy proc
ldr    r3, =#0x8002CE0    @ NewBlocking6C
mov    r14, r3
.short    0xF800
ldr    r1, =#0x3004E50 @ gActiveUnit
str     r4, [r1]
str    r4, [r0, #0x2C]
add    r0, #0x30
mov     r1, #0x0
strb    r1, [r0, #0x0]
pop     {r4}
pop     {r0}
bx     r0
.ltorg


.align
CombineWhenTaking:			@ called at 9E320
push	{r4-r7,r14}
add		r0,r6
ldrh	r0,[r0]
lsl		r0,#2
add		r0,r4
ldrh	r4,[r0,#2]			@ item id/uses from PrepScreenList
mov		r5,r1				@ place in char struct to store item
ldr		r0,=#0x858791C		@ gKeyStatus
ldr		r0,[r0]
ldrh	r0,[r0,#4]
mov		r1,#2
lsl		r1,#8				@ 0x200, L button
tst		r0,r1
beq		End_CombineWhenTaking
mov		r0,r4
ldr		r3,=#0x80175B0		@ GetItemMaxUses
mov		r14,r3
.short	0xF800
cmp		r0,#0xFF
beq		End_CombineWhenTaking	@ if infinite uses, can't combine anything
mov		r6,r0
ldr		r7,[r7,#0x2C]		@ unit pointer
add		r7,#0x1E
InventoryLoop1:
ldrb	r0,[r7]
cmp		r0,#0
beq		End_CombineWhenTaking
lsl		r3,r4,#0x18
lsr		r3,#0x18
cmp		r0,r3
bne		NextItem1
ldrb	r1,[r7,#1]
lsr		r2,r4,#8
add		r3,r2,r1
cmp		r3,r6
bgt		DecrementSomeUses1
lsl		r3,#8
add		r3,r0
strh	r3,[r7]
mov		r4,#0
b		End_CombineWhenTaking
DecrementSomeUses1:
sub		r3,r6,r1
sub		r2,r2,r3
lsl		r2,#8
add		r4,r2,r0			@ decrement uses
lsl		r1,r6,#8
add		r1,r0
strh	r1,[r7]
NextItem1:
add		r7,#2
b		InventoryLoop1
End_CombineWhenTaking:
strh	r4,[r5]
pop		{r4-r7}
pop		{r0}
bx		r0
.ltorg



.align
CombineWhenGivingOne:		@ called at 9E894
@ r4=item id/uses
push	{r14}
strb	r0,[r6]
mov		r0,r4
ldr		r2,=#0x858791C		@ gKeyStatus
ldr		r2,[r2]
ldrh	r2,[r2,#4]
mov		r1,#2
lsl		r1,#8				@ 0x200, L button
tst		r2,r1
beq		AddOneItemToConvoy
bl		TryToCombineInConvoy	@ returns updated item/uses short
cmp		r0,#0
beq		ItemWasUsedUp2
AddOneItemToConvoy:
ldr		r3,=#0x8031594		@ AddItemToConvoy
mov		r14,r3
.short	0xF800
ItemWasUsedUp2:
ldr		r0,[r5,#0x2C]
ldrb	r1,[r6]
pop		{r2}
bx		r2
.ltorg


.align
TryToCombineInConvoy:
@ r0=item id/uses; return the updated id/uses (or 0 if item was used up)
push	{r4-r7,r14}
mov		r4,r0
ldr		r3,=#0x80175B0		@ GetItemMaxUses
mov		r14,r3
.short	0xF800
cmp		r0,#0xFF
beq		End_TryToCombineInConvoy
mov		r7,r0
bl		GetConvoyPartitionStartOffset
mov		r5,r0
bl		GetConvoyPartitionSize
lsl		r6,r0,#1
add		r6,r5
TryToCombineInConvoy_Loop:
ldrh	r0,[r5]
cmp		r0,#0
beq		End_TryToCombineInConvoy
lsl		r1,r0,#0x18
lsr		r1,#0x18
lsl		r2,r4,#0x18
lsr		r2,#0x18
cmp		r1,r2
bne		NextItem3
lsl		r1,r0,#0x10
lsr		r1,#0x18
sub		r2,r7,r1			@ how many uses convoy item is missing
lsl		r3,r4,#0x10
lsr		r3,#0x18			@ uses current item has
cmp		r2,r3
blt		RemoveSomeUses
@ if we got here, item is used up
add		r1,r3
lsl		r1,#8
lsl		r0,#0x18
lsr		r0,#0x18
add		r0,r1
strh	r0,[r5]
mov		r4,#0
b		End_TryToCombineInConvoy
RemoveSomeUses:
lsl		r0,#0x18
lsr		r0,#0x18
lsl		r1,r7,#8
add		r1,r0
strh	r1,[r5]
sub		r3,r3,r2
lsl		r3,#8
add		r4,r3,r0
NextItem3:
add		r5,#2
cmp		r5,r6
blt		TryToCombineInConvoy_Loop
End_TryToCombineInConvoy:
mov		r0,r4
pop		{r4-r7}
pop		{r1}
bx		r1
.ltorg




.align
CombineConvoyPartitionsASMC:
@ use SETVAL 1 0x00CCBBAA; AA and BB are the convoy partitions you're combining, and CC is the new partition. AA, BB, and CC are all indices in the ConvoyPartitionTable
@ Example: 0x00040201 would copy the contents of partitions 1 and 2 to partition 4. Make sure there's room for both sets!
push	{r4-r7,r14}
add		sp,#-4
ldr		r4,=#0x30004B8		@ gEventSlot
ldr		r4,[r4,#4]			@ slot 1
ldr		r5,=#0x2020188		@ gGenericBuffer
lsl		r0,r4,#0x18
lsr		r0,#0x18			@ first partition
ldr		r1,=ConvoyPartitionTable
lsl		r0,#3
add		r0,r1
ldrb	r1,[r0]
ldrb	r6,[r0,#1]			@ size of partition
lsl		r1,#1
ldr		r0,=gpConvoyItemArray
ldr		r0,[r0]
add		r7,r0,r1			@ start offset
mov		r3,#0				@ counter
mov		r2,#0				@ to clear items as we go
Loop1:
ldrh	r0,[r7]
cmp		r0,#0
beq		EndLoop1
strh	r0,[r5]
strh	r2,[r7]
add		r3,#1
add		r5,#2
add		r7,#2
sub		r6,#1
cmp		r6,#0
bgt		Loop1
EndLoop1:
lsl		r0,r4,#0x10
lsr		r0,#0x18			@ second partition
ldr		r1,=ConvoyPartitionTable
lsl		r0,#3
add		r0,r1
ldrb	r1,[r0]
ldrb	r6,[r0,#1]			@ size of partition
lsl		r1,#1
ldr		r0,=gpConvoyItemArray
ldr		r0,[r0]
add		r7,r0,r1			@ start offset
Loop2:
ldrh	r0,[r7]
cmp		r0,#0
beq		EndLoop2
strh	r0,[r5]
strh	r2,[r7]
add		r3,#1
add		r5,#2
add		r7,#2
sub		r6,#1
cmp		r6,#0
bgt		Loop2
EndLoop2:
lsl		r0,r4,#0x8
lsr		r0,#0x18			@ third partition
ldr		r1,=ConvoyPartitionTable
lsl		r0,#3
add		r0,r1
ldrb	r1,[r0]
ldrb	r6,[r0,#1]			@ size of partition
lsl		r1,#1
ldr		r0,=gpConvoyItemArray
ldr		r0,[r0]
add		r7,r0,r1			@ start offset
cmp		r3,r6
bge		ClearTargetPartition
mov		r6,r3
ClearTargetPartition:
@ clear the target partition
mov		r0,r13
mov		r1,#0
strh	r1,[r0]
mov		r1,r7
mov		r2,#1
lsl		r2,#0x18
add		r2,r6
ldr		r3,=#0x80D1678		@ CpuSet
mov		r14,r3
.short	0xF800
ldr		r5,=#0x2020188		@ gGenericBuffer
Loop3:
ldrh	r0,[r5]
strh	r0,[r7]
add		r5,#2
add		r7,#2
sub		r6,#1
cmp		r6,#0
bgt		Loop3
EndLoop3:
add		sp,#4
pop		{r4-r7}
pop		{r0}
bx		r0
.ltorg



.align
StartCombineDisplayProc:
@ r0=parent proc, r1=0 for prep screen, 2 for supply screen
push	{r4-r6,r14}
mov		r4,r0
mov		r5,r1
ldr		r0,=Combine_Image_Graphics
ldr		r1,=#0x2020188		@ gGenericBuffer
ldr		r3,=#0x8012F50		@ Decompress
mov		r14,r3
.short	0xF800
ldr		r0,=#0x2020188		@ gGenericBuffer
ldr		r3,=#0x8013020		@ CopyTileGfxForObj
mov		r14,r3
ldr		r1,=#(0x6010000 + (0x38<<5))	@ tile number; if this is changed, change baseOAM data too
mov		r2,#8				@ length
mov		r3,#2				@ height
.short	0xF800
ldr		r0,=gProc_DisplayCombine
ldr		r3,=#0x8002E9C		@ FindProc
mov		r14,r3
.short	0xF800
cmp		r0,#0
bne		Label20
ldr		r0,=gProc_DisplayCombine
mov		r1,r4
ldr		r3,=#0x8002C7C		@ StartProc
mov		r14,r3
.short	0xF800
Label20:
mov		r6,r0
cmp		r5,#0
bne		Label21
@ if 0, we want to check if it should be 1
mov		r0,#0x2E
ldrb	r0,[r4,r0]
cmp		r0,#3				@ Give all
bne		Label21
mov		r5,#1
Label21:
strh	r5,[r6,#0x2C]		@ index
mov		r0,#12
mul		r5,r0
ldr		r0,=CombineGraphicTable
add		r5,r0
ldrb	r1,[r5,#2]
add		r1,#0x10
lsl		r1,#5
ldr		r0,[r5,#8]			@ palette
mov		r2,#0x20
ldr		r3,=#0x8000DB8		@ CopyToPaletteBuffer
mov		r14,r3
.short	0xF800
@ delete the old R: Info graphic
ldr		r0,=#0x8A00B20		@ gProc_8A00B20
ldr		r3,=#0x8002E9C		@ FindProc
mov		r14,r3
.short	0xF800
cmp		r0,#0
beq		End_StartCombineDisplayProc
ldr		r3,=#0x8002D6C		@ EndProc (no idea if this is the right one)
mov		r14,r3
.short	0xF800
End_StartCombineDisplayProc:
pop		{r4-r6}
pop		{r0}
bx		r0
.ltorg



.align
CombineDisplayLoop:
push	{r4-r5,r14}
add		sp,#-4
mov		r4,r0
ldrh	r0,[r4,#0x2C]		@ index
mov		r2,#0				@ flag
cmp		r0,#2
bge		Label22
@ if 0 or 1, then we need to check where the cursor is
@ and also check whether it should be displayed at all (shouldn't show when selecting who to trade with)
ldr		r1,[r4,#0x14]		@ parent proc

@ Cases to not display: +2E=0 and +32=0 (trade partner selection screen), +2E=5 and there's no loop routine (this is pretty hacky, but I can't seem to find another way to tell
mov		r2,#0x32
ldrb	r2,[r1,r2]
cmp		r2,#0
beq		EndCombineDisplay
mov		r2,#0x2E
ldrb	r2,[r1,r2]
cmp		r2,#5
bne		NotArmoury
ldr		r2,[r1,#0xC]
cmp		r2,#0
beq		EndCombineDisplay
NotArmoury:

add		r1,#0x2E
ldrb	r1,[r1]
cmp		r1,#3
beq		HandOnGiveAll
cmp		r0,#0
beq		Label22				@ if 0, all is well
mov		r0,#0
b		Label23
HandOnGiveAll:
cmp		r0,#1
beq		Label22				@ if 1, all is well
mov		r0,#1
Label23:
strh	r0,[r4,#0x2C]		@ update index
mov		r2,#1				@ update flag
Label22:
ldrh	r5,[r4,#0x2C]		@ index
mov		r0,#12
mul		r5,r0
ldr		r0,=CombineGraphicTable
add		r5,r0
cmp		r2,#0
beq		Label24
ldrb	r1,[r5,#2]			@ palette bank id
add		r1,#0x10
lsl		r1,#5
ldr		r0,[r5,#8]			@ palette
mov		r2,#0x20
ldr		r3,=#0x8000DB8		@ CopyToPaletteBuffer
mov		r14,r3
.short	0xF800
Label24:
ldrb	r1,[r5]				@ x
ldrb	r2,[r5,#1]			@ y
ldr		r3,[r5,#4]			@ rom oam data ptr
ldrb	r0,[r5,#2]
lsl		r0,#0xC
str		r0,[sp]				@ base oam2 data
ldr		r0,=#0x80053E8		@ RegisterObjectSafe
mov		r14,r0
mov		r0,#0
.short	0xF800
EndCombineDisplay:
add		sp,#4
pop		{r4-r5}
pop		{r0}
bx		r0
.ltorg


Delete_Proc_DisplayCombine:
@ jumped to from 8952C
mov		r9,r4
mov		r4,r0				@ return value; I don't think it actually needs to be saved, but just in case...
ldr		r0,=gProc_DisplayCombine
ldr		r3,=#0x8002E9C		@ FindProc
mov		r14,r3
.short	0xF800
cmp		r0,#0
beq		Label26
ldr		r3,=#0x8002D6C		@ EndProc (no idea if this is the right one)
mov		r14,r3
.short	0xF800
Label26:
mov		r0,r4
pop		{r4-r7}
pop		{r1}
bx		r1
.ltorg
