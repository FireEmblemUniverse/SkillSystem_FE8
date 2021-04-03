.macro blh to, reg=r3
  ldr \reg, =\to
  mov lr, \reg
  .short 0xf800
.endm
.equ CulturedID, SkillTester+4
.equ CulturedEvent, CulturedID+4
.equ NiceThighsTester, CulturedEvent+4
.thumb

push	{r14}

@check if dead
ldrb	r0, [r4,#0x13]
cmp	r0, #0x00
beq	End

@check for skill
mov	r0, r4
ldr	r1, CulturedID
ldr	r3, SkillTester
mov	lr, r3
.short	0xf800
cmp		r0,#0
beq		End

@check if already Cultured; if so can't trigger again
ldr	r0, [r4,#0x0C]	@status bitfield
mov	r1, #0x04
lsl	r1, #0x08
and	r0, r1
cmp	r0, #0x00
bne	End


@check for adjacent units that have Nice Thighs
ldr r0,NiceThighsTester
mov r14,r0
mov r0,r4
.short 0xF800
cmp r0,#0
beq End

@unset 0x2 and 0x40, set 0x400, write to status
ldr	r0, [r4,#0x0C]	@status bitfield
mov	r1, #0x42
mvn	r1, r1
and	r0, r1		@unset bits 0x42
mov	r1, #0x04
lsl	r1, #0x08
orr	r0, r1
str	r0, [r4,#0x0C]

@add unit to the AI list so enemies act twice
ldr	r0,=#0x203AA03
ldrb	r1, [r4,#0x0B]	@allegiance byte of the character we are checking
AddAILoop:
add	r0, #0x01
ldrb	r2, [r0]
cmp	r2, #0x00
bne	AddAILoop
strb	r1, [r0]
add	r0, #0x01
strb	r2, [r0]

Event:
ldr	r0,=#0x800D07C		@event engine thingy
mov	lr, r0
ldr	r0, CulturedEvent		@this event is just "play some sound effects"
mov	r1, #0x01			@0x01 = wait for events
.short	0xF800

End:
pop	{r0}
bx	r0
.ltorg
.align
SkillTester:
@POIN SkillTester
@WORD ReMoveID
@#include "ReMoveEvent.event"
