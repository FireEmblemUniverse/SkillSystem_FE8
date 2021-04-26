

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
	.equ MemorySlot, 0x30004B8 
	.equ GetUnitByEventParameter, 0x0800BC51
	.equ GetUnit, 0x8019430
	
	.global SetUnitStatusAll
	.type   SetUnitStatusAll, function

SetUnitStatusAll:
	push	{r4-r7,lr}



	ldr		r0, =MemorySlot 
	ldr 	r4, [r0, #4*0x03]	@What status do we set?
	mov 	r1, #0x60
	cmp		r4, r1 
	bgt 	End_LoopThroughUnits 
	
	@lsl 	r4, #8 		@ ----r4--
	ldr 	r5, [r0, #4*0x05]	@What value are we storing? 
								@How much data do we store? 
	ldrb 	r6, [r0, #4*0x04]	@LowerNibble, UpperNibble, Byte, Short, or WORD ? 


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
	mov 	r2,#0xC @ benched/dead
	tst 	r1,r2
	bne 	NextUnit
	@ if you got here, unit exists and is not dead or undeployed, so go ham





check_affiliation:

ldr r3,[r4,#0x04 * 4] @MemorySlot4 (affiliation) 
cmp r3,#0xFF          @FF=ANY
beq affiliation_match

ldrb r2, [r0, #0xb]    @unitram->affiliation

cmp r3,#0x01          @01=Enemy
beq check_affiliation_enemy

cmp r3,#0x02          @02=NPC
beq check_affiliation_npc

check_affiliation_player: @00=Player
                          @Player that did misconfiguration is treated as Player.
cmp r2,#0x40          @if (unit->affiliation >= 0x40){ cotinue; }
bge next_loop
b   affiliation_match

check_affiliation_npc:
cmp r2,#0x40          @if (unit->affiliation < 0x40 || unit->affiliation >= 0x80){ cotinue; }
blt next_loop
cmp r2,#0x80
bge next_loop
b   affiliation_match

check_affiliation_enemy:
cmp r2,#0x80          @if (unit->affiliation < 0x80){ cotinue; }
blt next_loop
@b   affiliation_match


affiliation_match:
found:

	bl Update

b   next_loop
















	
	mov 	r2, r4 
	@lsr 	r2, #8 		@What status? 
	mov 	r1, r6 
	@lsl 	r1, #24
	@lsr 	r1, #24 	@Nibble, Byte, Short, or Word? 
	
	mov 	r0, r5 		@move value into r0 
	
	cmp 	r1, #0x01 
	beq 	LowerNibble
	cmp 	r1, #0x02
	beq 	UpperNibble
	cmp 	r1, #0x03 
	beq 	Byte
	cmp 	r1, #0x04 
	beq 	Short
	cmp 	r1, #0x05 
	beq 	Word
	b Byte 
	b 		End_LoopThroughUnits 
	
	@r0 = value, r1 = free, r2 = what status, r3 = unit, r4 = status&type of byte, r5 = value, r7 = deployment id 
	
	LowerNibble:
	ldrb 	r0, [r3, r2] 
	mov  	r1, #0xF0
	and  	r0, r1
	
	mov 	r1, r5 			@value of lower nibble we are inserting 
	orr 	r0, r1 
	
	strb 	r0, [r3, r2] @r3 is unit 
	b 		NextUnit
	
	UpperNibble:
	
	ldrb 	r0, [r3, r2] 
	mov  	r1, #0xF
	and  	r0, r1
	
	mov 	r1, r5 
	lsl 	r1, #0x4 
	orr 	r0, r1 
	
	strb 	r0, [r3, r2] 
	b 		NextUnit	
	

	Byte:
	strb 	r0, [r3, r2] 
	b 		NextUnit	
	
	Short: 
	strh 	r0, [r3, r2] 
	b 		NextUnit	
	
	Word: 
	str 	r0, [r3, r2] 
	b 		NextUnit


	NextUnit:
	add 	r7,#1
	cmp 	r7,#0xAF
	ble 	LoopThroughUnits




End_LoopThroughUnits:
ldr r2, =MemorySlot 
str r7, [r2, #4*0x0B]


Return:
	blh  0x0801a1f4   @RefreshFogAndUnitMaps
	blh  0x080271a0   @SMS_UpdateFromGameData
	blh  0x08019c3c   @UpdateGameTilesGraphics
Term:
	pop {r4-r7}
	pop	{pc}
