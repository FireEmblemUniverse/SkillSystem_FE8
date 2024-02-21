.macro blh to, reg=r3
  push {\reg}
  ldr \reg, =\to
  mov lr, \reg
  pop {\reg}
  .short 0xf800
.endm
.thumb

push	{r4,lr}
mov	r4,r0

sub	sp,#8
ldrh	r1,[r4,#0x2A]
add	r1,#1		@no idea
strh	r1,[r4,#0x2A]

@rotation
ldrh	r1,[r4,#0x2C]
sub	r1,#4		@rotation
strh	r1,[r4,#0x2C]
lsl	r1,#0x10
asr	r1,#0x10
mov	r0,#0xC0
lsl	r0,#1
str	r0,[sp]
str	r0,[sp,#4]
mov	r0,#2		@background layer
mov	r2,#0
mov	r3,#0
blh	0x80ADDFC	@update background 2 rotation

@scaling
mov	r0,#2		@background
mov	r1,#0x80
lsl	r1,#2		@vertical size
mov	r2,#0x80
lsl	r2,#1		@horizontal size
blh	0x80ADE90	@update background 2 scaling

@position
mov	r0,#0x4C	@anchor y
str	r0,[sp]
mov	r0,#2		@background
mov	r1,#0x78	@x position
mov	r2,#0xA0	@y position
mov	r3,#0x4C	@anchor x
blh	0x80ADEE0	@update background 2 position/anchor
mov	r0,#2
blh	0x8001FBC	@set background 2 to update
mov	r0,#3
blh	0x8001FBC	@set background 3 to update

End:
add	sp,#8
pop	{r4}
pop	{r0}
bx	r0
