.macro blh to, reg=r3
  ldr \reg, =\to
  mov lr, \reg
  .short 0xf800
.endm
.equ CantoID, SkillTester+4
.equ Option, CantoID+4
.thumb
push	{lr}
@check if dead
ldrb	r0, [r4,#0x13]
cmp	r0, #0x00
beq	End

@check if moved all the squares
ldr	r0,=#0x8019224	@mov getter
mov	lr, r0
mov	r0, r4		@attacker
.short	0xF800
ldrb 	r1, [r6,#0x10]	@squares moved this turn
cmp	r0, r1
beq	End

@check if flag 0x3 set; if so, cannot canto
ldr r0,=#0x8083da8 @CheckEventId
mov r14,r0
mov r0,#3
.short 0xF800
cmp r0,#1
beq End

blh 0x801A1F5 @first refresh the entity map
ldr	r1,=#0x8018BD8	@check if can move again
mov	lr, r1
.short	0xF800
lsl	r0, #0x18
cmp	r0, #0x00
beq	End


@check if attacked this turn
ldrb  r0, [r6,#0x11]  @action taken this turn
cmp r0, #0x04 @check if staff or attack was used
blo End
cmp r0, #0x1E @check if found enemy in the fog
beq End
ldrb  r0, [r6,#0x0C]  @allegiance byte of the current character taking action
ldrb  r1, [r4,#0x0B]  @allegiance byte of the character we are checking
cmp r0, r1    @check if same character
bne End

@check if already cantoing, and is not in a ballista
ldr	r0, [r4,#0x0C]	@status bitfield
mov	r1, #0x21
lsl	r1, #0x06	@has moved already and is in a ballista
and	r0, r1
cmp	r0, #0x00
bne	End

@check for option and ability
ldr	r0,Option
cmp	r0,#0
beq	HasSkill
ldr	r0,[r4]		@load character data
cmp	r0,#0x00	@just in case there's no pointer (was doing weird things with generics without this)
beq	JumpLoad1
ldr	r0,[r0,#0x28]	@load character abilities
JumpLoad1:
ldr	r1,[r4,#0x04]	@load class data
cmp	r1,#0x00	@just in case there's no pointer
beq	JumpLoad2
ldr	r1,[r1,#0x28]	@load class abilities
JumpLoad2:
orr	r0,r1
mov	r1,#2		@canto bit
and	r0,r1
cmp	r0,#2
beq	CanCanto	@if the option is set and has the ability, skip skill check


@check for skill
HasSkill:
mov	r0, r4
ldr	r1, CantoID
ldr	r3, SkillTester
mov	lr, r3
.short	0xf800
cmp	r0,#0x00
beq	End

CanCanto:
@if canto, unset 0x2 and set 0x40
ldr	r0, [r4,#0x0C]	@status bitfield
mov	r1, #0x02
mvn	r1, r1
and	r0, r1		@unset bit 0x2
mov	r1, #0x40	@set canto bit
orr	r0, r1
str	r0, [r4,#0x0C]

@ @add unit to the AI list so enemies act twice
@ ldr	r0,=#0x203AA03
@ ldrb	r1, [r4,#0x0B]	@allegiance byte of the character we are checking
@ AddAILoop:
@ add	r0, #0x01
@ ldrb	r2, [r0]
@ cmp	r2, #0x00
@ bne	AddAILoop
@ strb	r1, [r0]
@ add	r0, #0x01
@ strb	r2, [r0]

End:
pop	{r0}
bx	r0
.ltorg
.align
SkillTester:
@POIN SkillTester
@WORD CantoID
@WORD Option
