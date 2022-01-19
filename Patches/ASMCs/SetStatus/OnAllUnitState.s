

@Author 7743, Vesly 
@
.align 4
.thumb
.macro blh to, reg=r3
  ldr \reg, =\to
  mov lr, \reg
  .short 0xf800
.endm
@
@
					@ldr 	r1, =MemorySlot 
					@str 	r0, [r1, #4*0x02] @Store to s2 as break point: [0x30004C0]!!
	
	
	
	.equ MemorySlot, 0x30004B8 
	.equ GetUnitByEventParameter, 0x0800BC51
	.equ GetUnit, 0x8019430
	
	.global OnAllUnitState
	.type   OnAllUnitState, function

OnAllUnitState:
	push	{r4-r7,lr}


                    @MemorySlot1 (UnitID lower bound -> UnitID upper bound, or UnitID exact)  00=ANY
                    @MemorySlot3 (Status)  00=ANY
					

                    @MemorySlot5 (Value to store) 
					@MemorySlot6 (State to affect eg. 0x0C is "Dead" and "Undeployed" units to affect) 
					
                    @MemorySlot7 (affiliation)  FF=ANY 00=Player 01=Enemy 02=NPC
					@MemorySlot8 (ClassID lower bound -> ClassID upper bound)  00=ANY 
                    @MemorySlot9 XXYYZZWW Start range -> end range
                    @MemorySlotA (HeldItem) 00=ANY, otherwise unit must have this item in their inventory


	ldr		r0, =MemorySlot 
	mov 	r4, #0x0C @condition State 
	
	@lsl 	r4, #8 		@ ----r4--
	ldr 	r5, [r0, #4*0x05]	@What value are we storing? 
								@How much data do we store? 



	mov 	r7, #1 
	
	LoopThroughUnits:
	
	mov 	r0,r7
	blh 	GetUnit @ 19430
	cmp 	r0,#0
	beq 	NextUnit
	ldr 	r3,[r0]
	cmp 	r3,#0
	beq 	NextUnit
	mov 	r3, r0 		@ 
	

	ldr 	r1,[r3,#0xC] @ condition word
	
    ldr		r0, =MemorySlot 
	ldr 	r2, [r0, #4*0x06]	@if unit state does not match, ignore them
	cmp 	r2, #0xFF 
	beq 	check_affiliation
	
	@mov 	r2,#0xC @ 
	and 	r1, r2 
	cmp 	r1, #0 
	beq 	NextUnit
	@ if you got here, unit exists and is not dead or undeployed, so go ham


	check_affiliation:
	ldr     r0, =MemorySlot
	ldrb    r1,[r0,#0x07 * 4] @MemorySlot7 (affiliation) 
	cmp     r1,#0xFF          @FF=ANY
	beq     affiliation_match
	
	ldrb    r2, [r3, #0xb]    @unitram->affiliation
	
	cmp     r1, #0x00
	beq     check_affiliation_player
	
	cmp     r1, #0x01          @01=Enemy
	beq     check_affiliation_enemy
	
	cmp     r1, #0x02          @02=NPC
	beq     check_affiliation_npc
	
	check_affiliation_player: @00=Player
	
	cmp 	r2,#0x40          @if (unit->affiliation >= 0x40){ cotinue; }
	bge 	NextUnit
	b   	affiliation_match
	
	check_affiliation_npc:
	cmp 	r2,#0x40          @if (unit->affiliation < 0x40 || unit->affiliation >= 0x80){ cotinue; }
	blt 	NextUnit
	cmp 	r2,#0x80
	bge 	NextUnit
	b   	affiliation_match
	
	check_affiliation_enemy:
	cmp 	r2,#0x80          @if (unit->affiliation < 0x80){ cotinue; }
	blt 	NextUnit
	@b   affiliation_match
	
	
	affiliation_match:

	check_unit_id:

	ldr		r2, =MemorySlot 
	ldr 	r1, [r2, #4*0x01]	@valid unit ID 

	cmp 	r1, #0
	beq 	CheckClass 	@00=ANY 
	cmp 	r1, #0xFF
	beq 	CheckClass @0xFF=ANY 

	ldr 	r0, [ r3 ] @ r0 now has your ROM character data pointer.
	ldrb 	r2, [ r0, #0x04 ] @ r2 now has your character ID.
	
	lsr 	r0, r1, #0x8 
	cmp 	r0, #0 
	beq 	Check_exact_unit_match 
	
	cmp 	r2, r0 @ current unit ID, unit id lower bound 
	blt 	NextUnit 
	lsl 	r0, r1, #24 
	lsr 	r0, #24 
	cmp 	r2, r0 
	bgt 	NextUnit 
	b 		CheckClass
	
	Check_exact_unit_match: 
	cmp 	r1, r2 
	bne 	NextUnit 
	
	CheckClass:
	@b CheckRange
	ldr		r2, =MemorySlot 
	ldr 	r1, [r2, #4*0x08]	@valid class ID 

	ldr 	r0, [ r3, #0x04 ] @ r0 now has your ROM class data pointer.
	ldrb 	r2, [ r0, #0x04 ] @ r2 now has your class ID.
	cmp 	r1, #0
	beq 	CheckRange 	@00=ANY 
	cmp 	r1, #0xFF
	beq 	CheckRange @0xFF=ANY 
	
	lsr 	r0, r1, #8 
	cmp 	r0, #0 
	beq 	Check_exact_class_match 
	
	cmp 	r2, r0 @ current unit ID, unit id lower bound 
	blt 	NextUnit 
	
	lsl 	r0, r1, #24 
	lsr 	r0, #24 
	cmp 	r2, r0 
	bgt 	NextUnit 
	b 		CheckRange
	
	Check_exact_class_match: 
	cmp 	r1, r2 
	bne 	NextUnit 
	b 		CheckRange
	
NextUnit:
	add 	r7,#1
	cmp 	r7,#0xAF
	ble 	LoopThroughUnits
	b 		Return 

Return:
	blh  0x0801a1f4   @RefreshFogAndUnitMaps
	blh  0x080271a0   @SMS_UpdateFromGameData
	blh  0x08019c3c   @UpdateGameTilesGraphics
Term:
	pop {r4-r7}
	pop	{pc}

	CheckRange:
	ldr		r2, =MemorySlot 
	ldr 	r0,[r2,#0x04*9] @MemorySlot9 (end range) 
	cmp 	r0,#0x0           @00=ANY
	beq 	CheckItem
	cmp		r0, #0xFF
	beq		CheckItem 
		
	ldrb 	r1, [r3, #0x10]    @unitram->x
	mov 	r0, #0x04*9+3
	ldrb 	r0,[r2, r0] @MemorySlot9 (start->x) 
	cmp  	r1,r0
	blt  	NextUnit
		
	ldrb 	r1, [r3, #0x11]    @unitram->y
	mov 	r0, #0x04*9+2
	ldrb 	r0,[r2,r0] @MemorySlot9 (start->y) 
	cmp  	r1,r0
	blt  	NextUnit
		
	ldrb 	r1, [r3, #0x10]    @unitram->x
	mov 	r0, #0x04*9+1
	ldrb 	r0,[r2, r0] @MemorySlot9 (end->x) 
	cmp  	r1,r0
	bgt  	NextUnit
		
	ldrb 	r1, [r3, #0x11]    @unitram->y
	mov 	r0, #0x04*9
	ldrb 	r0,[r2, r0] @MemorySlot9 (end->y) 
	cmp  	r1,r0
	bgt  	NextUnit


	


	CheckItem:
	ldr 	r0, =MemorySlot
	mov 	r1, #0x04*10 
	ldr 	r2,[r0, r1]  @MemorySlotA (ItemID)
	cmp 	r2,#0x00
	beq 	item_match 
	cmp 	r2, #0xFF 
	beq 	item_match 
	
	ldrb 	r1, [r3, #0x1e]    @unitram->item1
	cmp  	r1, r2
	beq  	item_match
		
	mov  	r1, #0x20
	ldrb 	r1, [r3, r1]    @unitram->item2
	cmp  	r1, r2
	beq  	item_match
		
	mov  	r1, #0x22
	ldrb 	r1, [r3, r1]    @unitram->item3
	cmp  	r1, r2
	beq  	item_match
		
	mov  	r1, #0x24
	ldrb 	r1, [r3, r1]    @unitram->item4
	cmp  	r1, r2
	beq  	item_match
		
	mov  	r1, #0x26
	ldrb 	r1, [r3, r1]    @unitram->item5
	cmp  	r1, r2
	bne  	NextUnit
		
	item_match:
		
	mov 	r0, r5 		@move value into r0 
	
	ldr 	r1, [r3, r4] 
	orr 	r0, r1 @bic 
	str 	r0, [r3, r4] 
	b 		NextUnit


	

