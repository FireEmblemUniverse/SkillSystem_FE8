
	.thumb

	@ build using lyn
	@ requires MapAuraFx functions to be visible

	RALLY_EFFECT_RANGE = 2

	GetUnit = 0x08019430|1
	StartProc = 0x08002C7C|1
	FindProc = 0x08002E9C|1
	EndProc = 0x08002D6C|1

	gActiveUnit = 0x03004E50
	gActionData = 0x0203A958

	gAuraUnitListOut = 0x0202B256

	.type   RallyCommandUsability, function
	.global RallyCommandUsability

	.type   RallyCommandSwitchIn, function
	.global RallyCommandSwitchIn

	.type   RallyCommandEffect, function
	.global RallyCommandEffect

	.type   RallyCommandSwitchOut, function
	.global RallyCommandSwitchOut

	.type   GetUnitRallyBits, function
	.global GetUnitRallyBits

	.type   ForEachRalliedUnit, function
	.global ForEachRalliedUnit

	.type RallyAuraCheck, function

RallyCommandUsability:
	push {lr}

	ldr r0, =gActiveUnit
	ldr r0, [r0] @ r0 = active unit

	@ Check if unit is canto-ing

	ldr r1, [r0, #0x0C]
	mov r2, #0x40

	tst r1, r2
	bne RallyCommandUsability.no

	@ Check if unit can perform any rallies

	@ implied @ arg r0 = unit

	bl GetUnitRallyBits

	cmp r0, #0
	beq RallyCommandUsability.no

	@ Check if anybody would be rallied

	bl RallyAuraCheck

	@ implied @ ret r0 = unit count

	cmp r0, #0
	beq RallyCommandUsability.no

	mov r0, #1 @ return 1 (command usable)

	b RallyCommandUsability.end

RallyCommandUsability.no:
	mov r0, #3 @ return 3 (command hidden)

RallyCommandUsability.end:
	pop {r1}
	bx r1

	.pool
	.align

RallyCommandEffect:
	push {lr}

	ldr r0, =gActiveUnit
	ldr r0, [r0] @ arg r0 = active unit

	bl GetUnitRallyBits

	mov r1, r0 @ arg r1 = user argument

	adr r0, RallyCommandEffect.apply
	add r0, #1 @ arg r0 = function

	bl ForEachRalliedUnit

	ldr r3, =StartRallyFx
	bl  BXR3

	ldr  r0, =gActionData
	mov  r1, #1
	strb r1, [r0, #0x11]

	mov r0, #0x17

	pop {r1}
	bx r1

	.align

RallyCommandEffect.apply:
	@ args: r0 = unit, r1 = rally bits

	push {r4,lr}
	mov r4,r1

	@ ldr  r3, =gpRallyDebuffsAddr
	@ ldr  r3, [r3]

	@ ldrb r0, [r0, #0x0B] @ r0 = unit index
	@ lsl  r0, #3          @ r0 = unit index * 8

	@ add  r3, r0

	ldr  r3, =GetDebuffs
	mov lr, r3
	.short 0xF800
	mov r3, r0

	ldrb r0, [r3, #3] @ Magic rally occupies the 9th bit which shouldn't affect regular behavior. (Really no #ifdef necessary)
	orr  r0, r4
	strb r0, [r3, #3]
	
	@ Special instructions for rally mag.
	lsl r2, r4, #23 @ Remove all higher bits than the ninth.
	lsr r2, r2, #31 @ Remove all lower bits than the ninth.
	lsl r2, r2, #4 @ Align to match the magic byte in the extra data struct ((RallyMag<<4)||MagDebuff)
	ldrb r0, [ r3, #5 ] @ Magic byte
	orr r0, r2
	strb r0, [ r3, #5 ]
	
	pop {r4}
	pop {r0}
	bx r0

	.pool
	.align

RallyCommandSwitchIn:
	push {lr}

	@ start map aura fx

	ldr r3, =StartProc

	ldr r0, =RallyPreviewFxProc
	mov r1, #3

	bl  BXR3

	mov r0, #0 @ no menu effect

	pop {r1}
	bx r1

	.pool
	.align

RallyCommandSwitchOut:
	push {lr}

	@ end map aura fx

	ldr r0, =RallyPreviewFxProc

	ldr r3, =FindProc
	bl  BXR3

	ldr r3, =EndProc
	bl BXR3

	mov r0, #0 @ no menu effect

	pop {r1}
	bx r1

	.pool
	.align

GetUnitRallyBits:
	@ Arguments: r0 = unit
	@ Returns:   r0 = bitfield of what rallies this unit can perform

	push {r4-r7, lr}

	mov r4, r0 @ var r4 = unit

	ldr r7, =RallySkillList @ var r7 = rally skill list it

	mov r5, #0 @ var r5 = rally bits
	mov r6, #0 @ var r6 = shift

GetUnitRallyBits.lop:
	ldrb r1, [r7]

	cmp r1, #0
	beq GetUnitRallyBits.end

	mov r0, r4 @ arg r0 = unit
	@ implied  @ arg r1 = skill id

	@ doing this because SkillTester may not have the thumb bit encoded into its address
	ldr r3, =SkillTester
	mov lr, r3
	.short 0xF800

	cmp r0, #0
	beq GetUnitRallyBits.continue

	@ Set corresponding bit
	mov r0, #1
	lsl r0, r6
	orr r5, r0

GetUnitRallyBits.continue:
	add r7, #1
	add r6, #1

	b GetUnitRallyBits.lop

GetUnitRallyBits.end:
	mov r0, r5

	pop {r4-r7}

	pop {r1}
	bx r1

	.align
	.pool

RallyAuraCheck:
	ldr r0, =AuraSkillCheck
	mov ip, r0

	ldr r0, =gActiveUnit
	ldr r0, [r0]                @ arg r0 = unit
	mov r1, #0                  @ arg r1 = skill
	mov r2, #0                  @ arg r2 = check type
	mov r3, #RALLY_EFFECT_RANGE @ arg r3 = range

	bx  ip @ jump (it will return to wherever this was called)

	.pool
	.align

ForEachRalliedUnit:
	@ Arguments: r0 = function (void(*)(struct Unit*, void*)), r1 = second argument to give to function
	@ Returns:   nothing

	push {r0-r1, r4, lr} @ note: [sp] = function, [sp+4] = second argument

	bl RallyAuraCheck

	ldr r4, =gAuraUnitListOut

ForEachRalliedUnit.lop:
	ldrb r0, [r4]

	cmp r0, #0
	beq ForEachRalliedUnit.end

	@ implied @ arg r0 = unit id

	ldr r3, =GetUnit
	bl  BXR3

	@ implied @ ret r0 = unit

	ldr r3, [sp]

	@ implied        @ arg r0 = unit
	ldr r1, [sp, #4] @ arg r1 = extra data

	bl BXR3

	add r4, #1

	b ForEachRalliedUnit.lop

ForEachRalliedUnit.end:
	pop {r1-r2, r4}

	pop {r1}
	bx r1

	.pool
	.align

	.type RallyPreviewFx_OnInit, function
	.type RallyPreviewFx_OnLoop, function
	.type RallyPreviewFx_OnEnd,  function

RallyPreviewFxProc:
	.word 1, RallyPreviewFxProc.name

	.word 2, RallyPreviewFx_OnInit
	.word 4, RallyPreviewFx_OnEnd
	.word 3, RallyPreviewFx_OnLoop

	.word 0, 0

RallyPreviewFxProc.name:
	.asciz "Rally Preview Fx"

	.align

RallyPreviewFx_OnInit:
	push {lr}

	mov r1, #0 @ timer (unneeded?)
	str r1, [r0, #0x2C]

	@ start map aura fx

	ldr r3, =StartMapAuraFx
	bl  BXR3

	ldr r0, =AddMapAuraFxUnit @ arg r0 = function
	@ unused                  @ arg r1 = user argument

	bl ForEachRalliedUnit

	@ set map aura fx palette

	ldr r3, =SetMapAuraFxPalette

	ldr r0, =gRallyPreviewPalette @ arg r0 = palette pointer

	bl BXR3

	bl RallyPreviewFx_OnLoop

	pop {r1}
	bx r1

	.pool
	.align

RallyPreviewFx_OnLoop:
	ldr r1, [r0, #0x2C]
	add r1, #1
	str r1, [r0, #0x2C]

	mov r0, #31
	and r0, r1 @ r0 = timer % 32

	lsr r0, #1 @ r0 = (timer % 32) / 2

	cmp r0, #8
	ble 1f

	mov r1, #0x10
	sub r0, r1, r0

1:
	cmp r0, #6
	bge 1f

	cmp r0, #2
	blt 2f

	sub r0, #2
	b 0f

2:
	mov r0, #0
	b 0f

1:
	mov r0, #4

0:
	ldr r3, =SetMapAuraFxBlend

	@ implied @ arg r0 = blend

	bx r3

	.pool
	.align

RallyPreviewFx_OnEnd:
	ldr r3, =EndMapAuraFx

BXR3:
	bx r3
