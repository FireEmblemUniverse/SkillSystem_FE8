.align 4
.macro blh to, reg=r3
  ldr \reg, =\to
  mov lr, \reg
  .short 0xf800
.endm
	.thumb

	.equ MemorySlot, 0x30004B8 
	.equ GetUnit, 0x8019430
	.equ GetUnitByEventParameter, 0x0800BC50

	.equ ExecSomeSelfHeal, 0x802F380
	.equ ExecuteGraphics, 0x802CA14

	.global SetMaxMove_ASMC
	.type   SetMaxMove_ASMC, function

SetMaxMove_ASMC:
	push {r4-r7, lr}	

mov r4,#1 @ current deployment id
ldr r0, =MemorySlot
ldr r5, [r0, #4*0x01] @s1 as affiliation: 00=Player, 01=Enemy, 02=NPC, FF=Any 
ldr r7, =MaxMovementValue
lsl r7, #24 
lsr r7, #24 

LoopThroughUnits:
mov r0,r4
blh GetUnit @ 19430
cmp r0,#0
beq NextUnit
ldr r3,[r0] @if no unit, exit 
cmp r3,#0
beq NextUnit


	check_affiliation:
	cmp     r5,#0xFF          @FF=ANY
	beq     affiliation_match
	
	ldrb    r2, [r0, #0xb]    @unitram->affiliation
	
	cmp     r5, #0x00
	beq     check_affiliation_player
	
	cmp     r5, #0x01          @01=Enemy
	beq     check_affiliation_enemy
	
	cmp     r5, #0x02          @02=NPC
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
	mov r6, r0 
	

ldr r3, [r6, #4] @ Class 
ldrb r3, [r3, #0x12] @ Move 
cmp r3, r7
bge NextUnit 

mov r2, r7
sub r2, r3 @ mov bonus to give 
mov r1, #0x1D @move bonus  
strb r2, [r6, r1]

NextUnit:
add r4,#1
cmp r4,#0xAF
ble LoopThroughUnits
mov r0, #0

Exit:
pop {r4-r7}
pop {r0}
bx r0

.ltorg

