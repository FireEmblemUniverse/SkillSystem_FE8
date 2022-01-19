
	.thumb

	IID_VULNERARY = 0x6C

	gEventSlot = 0x030004B8
	gAction = 0x0203A958
	.equ MemorySlot,0x30004B8
	SpawnProcLocking = 0x08002CE0+1
	GetUnitFromEventParam = 0x0800BC50+1
	CreateItem = 0x08016540+1
	DoVulneraryEffect = 0x0802F380+1
	GetGameLogicLock = 0x08015380+1

	.global HealLikeAVulnerary
	.type HealLikeAVulnerary, function

HealLikeAVulnerary:
	push {r4-r5, lr}

	mov  r4, r0 @ var r4 = proc

	ldr  r3, =gEventSlot
	ldr  r0, [r3, #4*0x01] @slot 1 as unit 

	ldr  r3, =GetUnitFromEventParam
	bl   bx_r3

	mov  r5, r0 @ var r5 = unit

	ldr  r3, =gAction

	ldrb r1, [r5, #0x0B]
	strb r1, [r3, #0x0C] @ Action::unit_id

	mov  r1, #0
	strb r1, [r3, #0x12] @ Action::item_slot

	mov  r0, #IID_VULNERARY

	ldr  r3, =CreateItem
	bl   bx_r3

	mov  r0, r4  @ arg r0 = proc
	
	ldr r3, =MemorySlot 
	ldr r1, [r3, #4*0x06] @ s6 as healing amount in r1 
	lsl r1, #24 
	lsr r1, #24 @ just in case i guess 
	@ mov  r1, #10 @ arg r1 = healing amount

	ldr  r3, =DoVulneraryEffect
	bl   bx_r3


	pop  {r4-r5}
	pop  {r3}
bx_r3:
	bx   r3
