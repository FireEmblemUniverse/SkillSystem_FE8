@hook at 0801d308
.macro blh to, reg=r3
  ldr \reg, =\to
  mov lr, \reg
  .short 0xf800
.endm
.equ GetCharPtr, 0x8019430
.equ ActionStruct, 0x203A958
.equ Attacker, 0x203A4EC
.equ Defender, 0x203A56C
.equ CurrentUnit, 0x3004E50
.thumb
@r4 has attacker pointer in ram (actual character pointer, not attacker pointer)
@r5 has defender pointer in ram (actual character pointer, not defender pointer)
@r6 has action struct
@r7 loop table pointer
push	{r0-r7}

@reload current unit data to avoid weird staff on reload
ldr	r5, =CurrentUnit
ldr	r6, [r5]
ldr	r0, [r5]
ldr	r1, =#0x801a3cc
mov	lr, r1
.short 0xf800

@giving the registers useful values
PrepareLoop:
ldr	r4, =CurrentUnit
ldrb	r0, [r4,#0x1A]	@allegiance byte
blh	GetCharPtr	@given allegiance byte, gives pointer to character data in ram
mov	r4, r0		@move current unit (potential attacker) to r4
ldr	r5, =Defender
ldrb	r0, [r5,#0x0B]
blh	GetCharPtr
mov	r5, r0
ldr	r6, =ActionStruct
ldr	r7, #PostCombatSkills

@set the "action taken" flag
ldr	r0, [r4,#0x0C]	@status bitfield
mov	r1, #0x02
orr	r0, r1		@set bit 0x2
str	r0, [r4,#0x0C]

@changes attacker and defender around for every routine call
@(currently commented out because no skill makes use of it, but has been tested)
Loop:
ldr	r0, [r7]	@load pointer to routine
cmp	r0, #0x00	@if terminator, end
beq	End
mov	lr, r0
.short	0xf800
	@mov	r0, r4		@swap pointers around
	@mov	r1, r5
	@mov	r4, r1
	@mov	r5, r0
	@ldr	r0, [r7]	@load pointer to routine
	@mov	lr, r0
	@.short	0xf800
	@mov	r0, r4		@swap pointers around
	@mov	r1, r5
	@mov	r4, r1
	@mov	r5, r0
add	r7, #0x04	@prepare next pointer
b	Loop

End:
ldr	r0,=#0x203A4D4
mov	r1,#0
strb	r1,[r0]
pop	{r0-r7}
push	{r4}
cmp	r0, #0x00
bne	Skipmov
mov	r0, #0x01
ldr	r4,=#0x801d316
b	Skipmore
Skipmov:
ldr	r4,=#0x801d310
Skipmore:
mov	lr, r4
pop	{r4}
.short	0xf800

.ltorg
.align
PostCombatSkills:	@list of post combat skills
@POIN PostCombatSkills
