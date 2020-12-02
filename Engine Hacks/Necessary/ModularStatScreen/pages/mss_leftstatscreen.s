.thumb
@draws the left panel of the stat screen
.include "mss_defs.s"

.global MSS_leftpage
.type MSS_leftpage, %function


MSS_leftpage:

page_start

draw_character_name_at 3,10

draw_affinity_icon_at 1, 10

draw_class_name_at 


@class name
ldr	r0,[r7,#0xC]	@load unit's pointer
ldr	r0,[r0,#4]	@load class pointer
ldrh	r0,[r0]		@load class name
blh	0x800A240	@GetStringFromIndex
mov	r2,r7
add	r2,#0x20
ldr	r1,=#0x342
add	r1,r8
str	r4,[sp]
str	r0,[sp,#4]
mov	r0,r2
mov	r2,#0
mov	r3,#0
blh	0x800443C	@DrawTextInline

@draw "LV" for level
ldr	r0,=#0x3C2
add	r0,r8
mov	r1,#3
mov	r2,#0x24
mov	r3,#0x25
blh	0x8004D5C	@no idea, probably draw something

@draw "E" for exp
ldr	r0,=#0x3CA
add	r0,r8
mov	r1,#3
mov	r2,#0x1D
blh	0x8004B0C	@no idea, probably draw something

@draw "HP" for currhp/maxhp
ldr	r0,=#0x442
add	r0,r8
mov	r1,#3
mov	r2,#0x22
mov	r3,#0x23
blh	0x8004D5C	@no idea, probably draw something

@draw "/" fpr currhp/maxhp
ldr	r0,=#0x44A
add	r0,r8
mov	r1,#3
mov	r2,#0x16
blh	0x8004B0C	@no idea, probably draw something

@draw level number
mov	r0,#0xF2
lsl	r0,#2
add	r0,r8
ldr	r1,[r7,#0xC]	@unit pointer
mov	r2,#8
ldrb	r2,[r1,r2]	@level
mov	r1,#2
blh	0x8004B94	@DrawDecNumber

@draw exp number
ldr	r0,=#0x3CE
add	r0,r8
ldr	r1,[r7,#0xC]	@unit pointer
ldrb	r2,[r1,#9]	@exp
mov	r1,#2
blh	0x8004B94	@DrawDecNumber

@draw hp
ldr	r0,[r7,#0xC]	@unit pointer
blh	0x8019150	@GetUnitCurrentHP
cmp	r0,#100
ble	DrawHP
ldr	r0,=#0x446
add	r0,r8
mov	r1,#2
mov	r2,#0x14
mov	r3,#0x14
blh	0x80045DC	@no idea, probably draw something
b	JumpPool
.align
.ltorg
DrawHP:
mov	r4,#0x89
lsl	r4,#3
add	r4,r8
ldr	r0,[r7,#0xC]	@unit pointer
blh	0x8019150	@GetUnitCurrentHP
mov	r2,r0
mov	r0,r4
mov	r1,#2
blh	0x8004B94	@DrawDecNumber
JumpPool:

@draw max hp
ldr	r5,=#0x2003BFC
ldr	r0,[r5,#0xC]	@unit pointer
blh	0x8019190	@GetUnitMaxHP
cmp	r0,#0x63
ble	DrawMaxHP
ldr	r0,=#0x20230F4
mov	r1,#2
mov	r2,#0x14
mov	r3,#0x14
blh	0x80045DC	@no idea, probably draw something
b	End
DrawMaxHP:
ldr	r4,=#0x20230F6
ldr	r0,[r5,#0xC]	@unit pointer
blh	0x8019190	@GetUnitMaxHP
mov	r2,r0
mov	r0,r4
mov	r1,#2
blh	0x8004B94	@DrawDecNumber

@ HP Name
ldr r0, Hp_Name_Color
mov r14, r0
.short 0xF800

End:
add	sp,#8
pop	{r3}
mov	r8,r3
pop	{r4-r7}
pop	{r0}
bx	r0
.ltorg

Hp_Name_Color:



