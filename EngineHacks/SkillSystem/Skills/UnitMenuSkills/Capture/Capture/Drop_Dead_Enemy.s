.thumb
.org 0x0
.macro blh to, reg=r3
  ldr \reg, =\to
  mov lr, \reg
  .short 0xf800
.endm


@set bit 0x1 of byte 1 if unit has 0 hp when being dropped
@jumped to from 183B0
@r2=char data of droppee

@r5 = dropper
@r6 = x coord (or 0 if giving/taking)
@r7 = y coord (or 0 if giving/taking)

strb	r0,[r5,#0x1B]
strb	r0,[r4,#0x1B]
strb	r6,[r4,#0x10]
strb	r7,[r4,#0x11]

@drop check
@The Drop can only be compared with the r14.
ldr		r0, =0x0803223C+1 @FE8U
cmp		r0, r14
bne		End

ldrb	r0,[r4,#0x13]
cmp		r0,#0x1		@HP 1 <=
bgt		End

ldrb	r0,[r5,#0xB]	@myself
ldrb	r1,[r4,#0xB]	@target
blh 0x08024D8C   @AreUnitsAllied
cmp		r0, #0x1
beq		End


ldr r0, [r4]
ldrb r0, [r0, #0x4] @EnemyUnitID
blh 0x080835dc   @DisplayDeathQuoteForChar

ldr		r0,[r4,#0xC]
mov		r1,#0xD @make them dead
orr		r0,r1
str		r0,[r4,#0xC]

mov     r0, #0x0
str		r0, [r4]			@Clear EnemyStruct
strb	r0, [r4, #0x13]		@HP=0

End:
pop		{r4-r7}
pop		{r0}
bx		r0
