.thumb
.equ DrawIcon, 				0x80036BC
.equ DrawNumberOrDashes,	0x8004b94
.equ ReturnPoint,			0x808E4E3
.equ LoadIconPalette,		0x80035D4
.macro blh to, reg=r3
  ldr \reg, =\to
  mov lr, \reg
  .short 0xf800
.endm

@hook from 808E4D4

push	{r4}
mov		r0, #0x1
mov		r1, #0x5
blh		LoadIconPalette

@first get leadership count
mov		r0, #0x0 	@ player faction
ldr		r1, GetFactionLeadershipCount
mov		lr, r1
.short	0xF800		@ bl to lr

cmp		r0, #0x0
bne		DrawNumber
mov		r0, #0xFF	@ need to do this so it shows dashes if zero

DrawNumber:
@draw the number
mov		r1, #2
mov		r2, r0
mov		r4, r0
ldr		r0, =#0x20235F0 @coordinates to draw at
blh		DrawNumberOrDashes

cmp		r4,#0xFF
beq		DontDrawIcon

@draw the icon
ldr		r4, =#0x20235F2 @coordinates
mov		r1, #0xCA
mov		r2, #0xA0
lsl		r2, r2,#0x7
mov		r0, r4
blh     DrawIcon 

DontDrawIcon:
pop		{r4}
ldr		r0, =ReturnPoint
bx		r0

.ltorg
.align
GetFactionLeadershipCount:
@POIN GetFactionLeadershipCount
