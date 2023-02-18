
	.thumb
.macro blh to, reg=r3
  ldr \reg, =\to
  mov lr, \reg
  .short 0xf800
.endm
	@ build using lyn
	@ requires MapAuraFx functions to be visible

	RALLY_EFFECT_RANGE = 2

.global BuffAnim_ASMC
.type BuffAnim_ASMC, %function 
BuffAnim_ASMC:
push {r4-r5, lr} 
ldr r4, =MemorySlot 
ldr r0, [r4, #4*1] @ s1 as unit 
blh GetUnitByEventParameter 
mov r5, r0 
bl IsUnitOnField 
cmp r0, #0 
beq Break_ASMC
mov r0, r5 @ unit 
mov r1, #1 
ldr r3, [r4, #4*3] @ s3 as rally bit 
lsl r2, r1, #9 @ 0x200 
lsl r1, r3 @ 0x01 - 0x100 
cmp r1, r2 
bge Break_ASMC 
ldr r2, [r4, #4*4] @ s4 as range (0 = self) 
bl StartBuffFx

Break_ASMC: 
pop {r4-r5} 
pop {r0} 
bx r0 
.ltorg 

.equ MemorySlot, 0x30004B8
.equ GetUnitByEventParameter, 0x0800BC50
	GetUnit = 0x08019430|1
	StartProc = 0x08002C7C|1
	FindProc = 0x08002E9C|1
	EndProc = 0x08002D6C|1

	gActiveUnit = 0x03004E50
	gActionData = 0x0203A958

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

.global BuffFx_ASMC
.type BuffFx_ASMC, %function 
BuffFx_ASMC: 
push {r4, lr} 
ldr r0, =MemorySlot 
ldr r0, [r0, #4] @ slot 1 as unit 
blh GetUnitByEventParameter 
mov r4, r0 
bl IsUnitOnField 
cmp r0, #0 
beq Exit_StrBuffFx 
ldr r3, =MemorySlot 
ldr r1, [r3, #4*3] @ s3 as bitfield to use for the anim (see StrAnim, SklAnim, etc.) 
ldr r2, [r3, #4*4] @ s4 as range (0 for self) 
mov r3, #2 
lsl r3, #8 @ 0x200 
cmp r1, r3 
bge Exit_StrBuffFx @ ensure slot3 was valid 
mov r0, r4 
bl StartBuffFx 

Exit_StrBuffFx: 
pop {r4} 
pop {r0} 
bx r0 
.ltorg 


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

	adr r0, RallyCommandEffect_apply
	add r0, #1 @ arg r0 = function
	ldr r2, =gActiveUnit
	ldr r2, [r2] @ arg r2 = active unit
	bl ForEachRalliedUnit

	ldr r3, =StartRallyFx
	bl  BXR3

	ldr  r0, =gActionData
	mov  r1, #1
	strb r1, [r0, #0x11]

	mov r0, #0x17

	pop {r1}
	bx r1
	
.equ ProcFind, 0x8002E9C
.ltorg 
.global RallyCommandEffect_NoneActive
.type RallyCommandEffect_NoneActive, %function 
RallyCommandEffect_NoneActive:
	push {r4-r5, lr}
	mov r4, r0 @ unit 
	mov r5, r1 @ r1 = rally bits 


	adr r0, RallyCommandEffect_apply
	add r0, #1 @ arg r0 = function
	mov r2, r4 @ unit 
	mov r1, #RALLY_EFFECT_RANGE
	bl ForEachRalliedUnit_NoneActive

	ldr r0, =BuffFxProc
	blh ProcFind 
	cmp r0, #0 
	beq NewProc 
	
	str r4, [r0, #0x30] 
	str r5, [r0, #0x34] 
	bl BuffFx_OnInit 
	
	b ExitRallyCommandEffect_NoneActive
	
	NewProc: 
	mov r0, r4 @ unit 
	mov r1, r5 @ bits 
	mov r2, #RALLY_EFFECT_RANGE 
	ldr r3, =StartBuffFx
	bl  BXR3

	ExitRallyCommandEffect_NoneActive: 
	mov r0, #0x17
	pop {r4-r5} 
	pop {r1}
	bx r1

	.align
.global RallyCommandEffect_apply
.type RallyCommandEffect_apply, %function 
RallyCommandEffect_apply:
	@ args: r0 = unit, r1 = rally bits

	push {r4-r5,lr}
	mov r4,r1
	@ r0 = unit struct 
	bl GetUnitDebuffEntry
	mov r5, r0 @ debuff entry 
	ldr r1, =RalliesOffset_Link
	ldr r1, [r1] 
	ldr r2, =RalliesNumberOfBits_Link
	ldr r2, [r2] 
	bl UnpackData 
	mov r3, r0 @ data 
	mov r0, r5 @ debuff entry 
	ldr r1, =RalliesOffset_Link
	ldr r1, [r1] 
	ldr r2, =RalliesNumberOfBits_Link
	ldr r2, [r2] 
	orr r3, r4 @ data to store 
	bl PackData 
	pop {r4-r5}
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
	ldr r0, =GetUnitsInRange
	mov ip, r0

	ldr r0, =gActiveUnit
	ldr r0, [r0]                @ arg r0 = unit
	mov r1, #0                  @ arg r1= check type
	mov r2, #RALLY_EFFECT_RANGE @ arg r2 = range

	bx  ip @ jump (it will return to wherever this was called)

	.pool
	.align
	
RallyAuraCheck_NoneActive:
	ldr r0, =GetUnitsInRange
	mov ip, r0

	mov r0, r2 					@ arg r0 = unit 
	mov r2, r1 					@ arg r2 = range
	mov r1, #0                  @ arg r1= check type


	bx  ip @ jump (it will return to wherever this was called)

	.pool
	.align

.global ForEachRalliedUnit_NoneActive
.type ForEachRalliedUnit_NoneActive, %function 
ForEachRalliedUnit_NoneActive:
	@ Arguments: r0 = function (void(*)(struct Unit*, void*)), r1 = second argument to give to function
	@ r2 = unit, r1 = rally effect range 
	@ Returns:   nothing

	push {r0-r1, r4-r5, lr} @ note: [sp] = function, [sp+4] = second argument
	mov r5, r2 @ unit 
	bl RallyAuraCheck_NoneActive
	cmp r0, #0 
	beq ForEachRalliedUnit.end
	b NextPart

ForEachRalliedUnit:
	@ Arguments: r0 = function (void(*)(struct Unit*, void*)), r1 = second argument to give to function
	@ Returns:   nothing

	push {r0-r1, r4-r5, lr} @ note: [sp] = function, [sp+4] = second argument
	mov r5, r2 @ unit 
	bl RallyAuraCheck

	NextPart: 
	mov r4, r0

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
	@mov r0, r5 @ unit 
	ldr r1, [sp, #4] @ arg r1 = extra data
	bl BXR3

	add r4, #1

	b ForEachRalliedUnit.lop

ForEachRalliedUnit.end:
	pop {r1-r2, r4-r5}

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
	ldr r2, =gActiveUnit
	ldr r2, [r2] @ arg r2 = active unit
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
