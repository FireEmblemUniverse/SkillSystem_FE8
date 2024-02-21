.macro blh to, reg=r3
  ldr \reg, =\to
  mov lr, \reg
  .short 0xf800
.endm
.equ SpinnyPalette, SpinnyBoy+4
.equ SpinnyTSA, SpinnyPalette+4
.thumb

push	{lr}

@set proc body whatever stuff
mov	r2,r0
mov	r1,r2
add	r1,#0x39
mov	r0,#0
strb	r0,[r1]
mov	r1,#0
strh	r0,[r2,#0x2A]
mov	r0,r2
add	r0,#0x35
strb	r1,[r0]
add	r0,#1
strb	r1,[r0]
add	r0,#1
strb	r1,[r0]
add	r0,#1
strb	r1,[r0]
add	r0,#2
strb	r1,[r0]
add	r0,#1
strb	r1,[r0]
add	r0,#2
strb	r1,[r0]
add	r0,#9
strb	r1,[r0]

@set control buffer values
ldr	r1,=#0x03003080
ldrh	r2,[r1]
ldr	r3,=#0x401
orr	r2,r3
	@@this is to hide the layers, for testing
	@ldr	r3,=#0x1B00
	@mvn	r3,r3
	@and	r2,r3
strh	r2,[r1]
@control buffer
ldr	r1,=#0x03003094
ldr	r2,=#0x4F0A
strh	r2,[r1]

@load graphics
ldr	r0,SpinnyBoy
ldr	r1,=#0x06008000
blh	0x08012F50

@load palette
ldr	r0,SpinnyPalette
ldr	r1,=#0x020228A8
mov	r1,#0
mov	r2,#0x60
blh	0x8000DB8

@clear bg 2 and 3
mov	r0,#2
blh	0x08001C4C
mov	r1,#0
blh	0x08001220
mov	r0,#3
blh	0x08001C4C
mov	r1,#0
blh	0x08001220

@draw the circle
mov	r0,#3
blh	0x08001C4C
ldr	r1,=#0x02024CA8
ldr	r2,SpinnyTSA
Loop:
ldr	r3,[r2]
str	r3,[r0]
add	r0,#4
add	r2,#4
cmp	r0,r1
beq	End
b	Loop

End:
pop	{r0}
bx	r0
.align
.ltorg
SpinnyBoy:
@POIN SpinnyBoy
@POIN SpinnyPalette
@POIN SpinnyTSA
