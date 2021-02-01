.macro blh to, reg
    ldr \reg, =\to
    mov lr, \reg
    .short 0xF800
.endm

.thumb
push	{r4-r7, lr}


mov r5, r0			@save to r5 for now
@ldr r1, =#0x0203A4EC 		@attacker
@ldr r2, =#0x0203A56C		@defender

ldr r4, =#0x03004E50		@active char address 
ldr r4, [ r4 ]			@active char struct


		@makes it function only if attacked 
@ldr r6, =#0x203A958	@action struct
@ldrb r0, [r6, #0x11]		@action struct of active unit
@cmp	r0, #0x2 @attack
@bne	End

		@check if dead
ldrb	r2, [r4,#0x0C]
cmp	r2, #0x00
beq	End	@active unit must not have state "0x00" - they have (Hide) state

		@CheckIfActiveIsPlayer:
ldr r6, =#0x203A958	@action struct
@ldr r6, [ r6 ]
ldrb	r2, [r6,#0x0C]	@allegiance byte of the current character taking action
			@0xXY, 0x00 = Player, 0x40 = NPC, 0x80 = Enemy. Uses top 2 bits. 
lsr 	r2, #4		@0xXY must become  0x0X
cmp r2, #0
bne End
b PlayerIsActive


PlayerIsActive:
@ldr r4, =#0x03004E50		@active char struct 
@ldr r4, [ r4 ]			@active char pointer
ldrb r0, [r4, #8]		@byte: current level of active unit in r0

@ldr r4, =#0x03004E50		@active char struct 
@ldr r4, [ r4]			@active char pointer
ldr r2, [ r4, #0x04 ] 		@Class data pointer.
ldrb r1, [r2, #0x04]  		@Class->ClassID  GetClassID

ldr r5, =PromoteLevelList	@List indexed by class.
ldrb r1, [r5, r1]    		@=PromoteLevelList[ClassID]
cmp r0, r1			@If unit lvl is lower than promotion lvl, End
blt End

Event:
ldr	r0,=#0x800D07C		@event engine thingy
mov	lr, r0
ldr	r0, =PromotionEvent	@promote active if they leveled up
mov	r1, #0x01		@0x01 = wait for events
.short	0xF800

ldr r4, =#0x03004E50		@active char struct 
ldr r4, [ r4]			@active char pointer
@ldr r0, [ r6 ]

	ldr r1, [ r4, #0x0C ] @ Turn status bitfield.
	mov r2, #0x42
	neg r2, r2
	and r1, r1, r2
	str r1, [ r4, #0x0C ] @ Set "Turn ended". Here and up from vanilla.


End:
pop 	{r4-r7}
pop	{r0}
bx	r0
.ltorg
.align
SkillTester:
@POIN SkillTester
@WORD DespoilID
@POIN DespoilEvent
