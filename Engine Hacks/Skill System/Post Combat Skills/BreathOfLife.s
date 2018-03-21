.macro blh to, reg=r3
  ldr \reg, =\to
  mov lr, \reg
  .short 0xf800
.endm
.equ BreathOfLifeID, SkillTester+4
.equ BreathOfLifeEvent, BreathOfLifeID+4
.equ AuraSkillCheck, BreathOfLifeEvent+4
.thumb
push	{r4-r7,lr}
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

@check for skill
mov	r0, r4
ldr	r1, BreathOfLifeID
ldr	r3, SkillTester
mov	lr, r3
.short	0xf800
cmp	r0,#0x00
beq	End

@Check if there are allies in 2 spaces
ldr	r0, AuraSkillCheck
mov	lr, r0
mov	r0, r4		@attacker
mov	r1, #0x00
mov	r2, #0x00	@can_trade
mov	r3, #0x02	@range
.short	0xf800

BreathOfLifeDamage:
mov	r4, r0		@number of units
ldr	r1,=#0x202B256
mov	r5, r1		@start of buffer
mov	r6, #0x00	@counter
cmp	r0, #0x00
beq	End
@if not 0 go through the buffer in r1

CheckEventLoop:		@check if all units in range are at full hp and if so do not play sound
ldrb	r0, [r5,r6]
add	r6,#1
ldr	r2,=#0x8019430
mov	lr, r2
.short	0xf800
ldrb	r2,[r0,#0x13]	@current hp
ldrb  r0,[r0,#0x12] @max hp
cmp r2, r0
blt	Event
cmp	r6,r4
beq	End
b	CheckEventLoop

Event:
mov	r6, #0x00		@reset counter
ldr	r0,=#0x800D07C		@event engine thingy
mov	lr, r0
ldr	r0, BreathOfLifeEvent	@this event is just "play some sound effects"
mov	r1, #0x01		@0x01 = wait for events
.short	0xF800

BOL_loop:
ldrb	r0, [r5,r6]
ldr	r2,=#0x8019430
mov	lr, r2
.short	0xf800
@r0 is ram data
mov	r7, r0
ldrb	r0, [r7,#0x12]	@max hp
mov	r1, #0x05
swi	#0x06		@r0 max hp/5
ldrb	r1, [r7,#0x13]	@r1 = current hp
cmp	r1, #0x00	@checking if the unit is already dead, probably not needed but w/e
beq	NextLoop
add	r1, r0
ldrb r0, [r7, #0x12]
cmp	r1, r0 @is hp>max?
ble	NextLoop
mov	r1, r0	@cap hp at max
NextLoop:
strb	r1, [r7,#0x13]
add	r6, #0x01
cmp	r6, r4
blt	BOL_loop

End:
pop	{r4-r7}
pop	{r0}
bx	r0
.ltorg
.align
SkillTester:
@POIN SkillTester
@WORD BreathOfLifeID
@POIN BreathOfLifeEvent
@POIN AuraSkillCheck
