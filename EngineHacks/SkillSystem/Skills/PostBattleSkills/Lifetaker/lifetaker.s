.macro blh to, reg=r3
  ldr \reg, =\to
  mov lr, \reg
  .short 0xf800
.endm
.equ LifetakerID, SkillTester+4
.equ LifetakerEvent, LifetakerID+4
.thumb
push	{lr}
@check if dead
ldrb	r0, [r4,#0x13]
cmp	r0, #0x00
beq	End

@check if attacked this turn
ldrb 	r0, [r6,#0x11]	@action taken this turn
cmp	r0, #0x2 @attack
bne	End
ldrb 	r0, [r6,#0x0C]	@allegiance byte of the current character taking action
ldrb	r1, [r4,#0x0B]	@allegiance byte of the character we are checking
cmp	r0, r1		@check if same character
bne	End

@check if killed enemy
ldrb	r0, [r5, #0x13]	@currhp
cmp	r0, #0
bne	End

@check for skill
mov	r0, r4
ldr	r1, LifetakerID
ldr	r3, SkillTester
mov	lr, r3
.short	0xf800
cmp	r0,#0x00
beq	End

@killed enemy, then heal 25%hp
mov	r0,r4
ldr	r3,=#0x8019190	@max hp getter
mov	lr,r3
.short	0xF800
mov	r1,r0
push	{r1}
mov	r0,r4
ldr	r3,=#0x8019150	@current hp getter
mov	lr,r3
.short	0xF800
mov	r2,r0
pop	{r1}
cmp	r1, r2		@check if hp is already max
beq	End
add	r2, r0		@total healing
cmp	r2, r1		@is the new hp higher than max?
ble	StoreHP
mov	r2, r1		@if so, set to max
StoreHP:
strb	r2, [r4,#0x13]

Event:
mov	r3, #0x00
ldrb	r0, [r4,#0x11]		@load y coordinate of character
lsl	r0, #0x10
add	r3, r0
ldrb	r0, [r4,#0x10]		@load x coordinate of character
add	r3, r0
ldr	r1,=#0x30004E4		@and store them for the event engine
str	r3, [r1]

ldr	r0,=#0x800D07C		@event engine thingy
mov	lr, r0
ldr	r0, LifetakerEvent	@this event is just "teleport animation on current character"
mov	r1, #0x01		@0x01 = wait for events
.short	0xF800

End:
pop	{r0}
bx	r0
.ltorg
.align
SkillTester:
@POIN SkillTester
@WORD LifetakerID
@POIN LifetakerEvent
