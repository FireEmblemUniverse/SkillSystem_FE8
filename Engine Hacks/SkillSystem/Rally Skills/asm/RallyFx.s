
	.thumb

	@ build using lyn
	@ requires MapAuraFx functions to be visible

	LockGame   = 0x08015360|1
	UnlockGame = 0x08015370|1

	StartProc = 0x08002C7C|1
	BreakProcLoop = 0x08002E94|1

	m4aSongNumStart = 0x080D01FC|1

	gChapterData = 0x0202BCF0
	gActiveUnit = 0x03004E50

	.type   StartRallyFx, function
	.global StartRallyFx

	.type RallyFx_OnInit, function
	.type RallyFx_OnLoop, function
	.type RallyFx_OnEnd,  function

RallyFxProc:
	.word 1, RallyFxProc.name

	.word 2, LockGame

	.word 14, 0

	.word 2, RallyFx_OnInit
	.word 4, RallyFx_OnEnd

	.word 3, RallyFx_OnLoop

	.word 2, UnlockGame

	.word 0, 0 @ end

RallyFxProc.name:
	.asciz "Rally Fx"

	.align

RallyFx_OnInit:
	push {lr}

	@ Set [proc+2C] to 0
	@ It will be our clock
	mov r1, #0
	str r1, [r0, #0x2C]

	@ start map aura fx

	ldr r3, =StartMapAuraFx
	bl  BXR3

	@ add units to aura fx

	ldr r3, =ForEachRalliedUnit

	ldr r0, =AddMapAuraFxUnit @ arg r0 = function
	@ unused                  @ arg r1 = user argument

	bl BXR3

	@ set aura fx thing speed

	ldr r3, =SetMapAuraFxSpeed

	mov r0, #32 @ arg r0 = speed

	bl BXR3

	ldr  r0, =gChapterData+0x41
	ldrb r0, [r0]

	lsl r0, r0, #0x1E
	blt 0f @ Skip sound

	ldr r3, =m4aSongNumStart

	mov r0, #136 @ arg r0 = sound ID (some kind of staff sound?)

	bl BXR3

0:
	@ TODO: use another palette for aura effect

	ldr r0, =gActiveUnit
	ldr r0, [r0]

	bl GetUnitRallyBits

	mov r1, #0

0:
	mov r2, #1
	tst r0, r2
	beq 1f

	lsr r2, r0
	bne 2f

	@ load palette corresponding to rally type

	ldr r0, =RallyFxPaletteLookup
	lsl r1, #2

	ldr r0, [r0, r1]

	b 3f

1:
	add r1, #1
	lsr r0, #1

	b 0b

2:
	@ if 2 or more different rallies, use generic palette
	ldr r0, =gRallyGenericPalette

3:
	ldr r3, =SetMapAuraFxPalette

	@ implied @ arg r0 = palette

	bl BXR3

	pop {r1}
	bx r1

	.pool
	.align

RallyFx_OnEnd:
	push {lr}

	@ end map aura fx

	ldr r3, =EndMapAuraFx
	bl  BXR3

	pop {r1}
	bx r1

	.pool
	.align

RallyFx_OnLoop:
	ldr r1, [r0, #0x2C]
	add r1, #1
	str r1, [r0, #0x2C]

	cmp r1, #0x20
	beq RallyFx_OnLoop.break

	cmp r1, #0x10
	bge 1f

2:
	cmp r1, #0x08
	blt 3f

	mov r0, #0x10
	b 0f

3:
	lsl r0, r1, #1
	b 0f

1:
	@ r1 = 0x20 - r1
	mov r0, #0x20
	sub r1, r0, r1

	b 2b

0:
	ldr r3, =SetMapAuraFxBlend

	@ implied @ arg r0 = blend

	bx r3 @ jump

RallyFx_OnLoop.break:
	ldr r3, =BreakProcLoop

	@ implied @ r0 = proc

	bx r3 @ jump

	.pool
	.align

StartRallyFx:
	ldr r3, =StartProc

	ldr r0, =RallyFxProc @ arg r0 = proc scr
	mov r1, #3           @ arg r1 = parent

BXR3:
	bx r3

