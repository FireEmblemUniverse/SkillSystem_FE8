.thumb
@draws the stat screen
.include "mss_defs.s"

.global MSS_page1
.type MSS_page1, %function


MSS_page1:

page_start

@load the growth getters onto the stack, if needed
ldr r0,=Growth_Getter_Table
str r0,[sp,#0xC]

ldr r0,=Display_Growth_Options_Link
ldr r0,[r0]
mov r1,#0x10
and r0,r1
mov r1,r8
ldrb r1,[r1,#0xB]
mov r2,#0xC0
tst r1,r2
beq IsPlayerUnit
mov r0,#0
IsPlayerUnit:
str r0,[sp,#0x14]

@draw str or mag
  mov r0, r8
  blh     MagCheck      @r0 = 1 if mag should show
  cmp     r0,#0x0       
  beq     NotMag        
    @draw Mag at 13, 3. colour defaults to yellow.
    draw_textID_at 13, 3, textID=0x4ff, growth_func=2
    b       MagStrDone    
  NotMag:
    @draw Str at 13, 3
    draw_textID_at 13, 3, textID=0x4fe, growth_func=2
  MagStrDone:

draw_textID_at 13, 5, textID=0x4EC, growth_func=3 @skl
draw_textID_at 13, 7, textID=0x4ED, growth_func=4 @spd
draw_textID_at 13, 9, textID=0x4ee, growth_func=5 @luck
draw_textID_at 13, 11, textID=0x4ef, growth_func=6 @def
draw_textID_at 13, 13, textID=0x4f0, growth_func=7 @res

b 	LiteralJump1
.ltorg 
LiteralJump1:

ldr		r0,=StatScreenStruct
sub		r0,#1
mov		r1,r8
ldrb	r1,[r1,#0xB]
mov		r2,#0xC0
tst		r1,r2
beq		Label2
ldrb	r1,[r0]
mov		r2,#0xFE
and		r1,r2
strb	r1,[r0]			@don't display enemy growths
Label2:
ldrb	r0,[r0]
mov		r1,#1
tst		r0,r1
beq		ShowStats
b		ShowGrowths

ShowStats:
b ShowStats2

.ltorg
.align

ShowGrowths: @things in this section are only drawn when in growths mode

ldr		r0,[sp,#0xC]
ldr		r0,[r0,#4]		@str growth getter
draw_growth_at 18, 3
ldr		r0,[sp,#0xC]
ldr		r0,[r0,#8]		@skl growth getter
draw_growth_at 18, 5
ldr		r0,[sp,#0xC]
ldr		r0,[r0,#12]		@spd growth getter
draw_growth_at 18, 7
ldr		r0,[sp,#0xC]
ldr		r0,[r0,#16]		@luk growth getter
draw_growth_at 18, 9
ldr		r0,[sp,#0xC]
ldr		r0,[r0,#20]		@def growth getter
draw_growth_at 18, 11
ldr		r0,[sp,#0xC]
ldr		r0,[r0,#24]		@res growth getter
draw_growth_at 18, 13
ldr		r0,[sp,#0xC]
ldr		r0,[r0]			@hp growth getter (not displaying because there's no room atm)
draw_growth_at 18, 15
draw_textID_at 13, 15, textID=0x4E9, growth_func=1 @hp name

b		literalJump2
.ltorg

ShowStats2: @things in this section are only drawn when not in growths mode


draw_str_bar_at 16, 3
draw_skl_bar_at 16, 5
draw_spd_bar_at 16, 7
draw_luck_bar_at 16, 9
draw_def_bar_at 16, 11
draw_res_bar_at 16, 13

draw_textID_at 13, 15, 0x4f6 @move
draw_move_bar_with_getter_at 16, 15

b literalJump2

.ltorg
.align

literalJump2:



draw_textID_at 13, 17, textID=0x4f7 @con
draw_con_bar_with_getter_at 16, 17

draw_textID_at 21, 3, textID=0x4f8 @aid
draw_number_at 25, 3, 0x80189B8, 2 @aid getter
draw_aid_icon_at 26, 3

draw_trv_text_at 21, 5


draw_textID_at 21, 7, textID=0x042
mov		r0, r8
ldr		r3, =GetLeadershipStarCount
sub		r3, #1 @get rid of unnecessary thumb bit
mov		lr, r3
.short 0xF800
push	{r0}
draw_number_at 25, 7
pop 	{r0}
cmp		r0,#0xFF
beq		DontDrawIcon
draw_icon_at 26, 7, 0xCA @change this to the ID you put the icon in
DontDrawIcon:


draw_status_text_at 21, 9

b exitVanillaStatStuff

.ltorg
.align

exitVanillaStatStuff:

ldr r0,=TalkTextIDLink
ldrh r0,[r0]
draw_talk_text_at 21, 11

b startSkills

.ltorg
.align

startSkills:

.set NoAltIconDraw, 1 @this is the piece that makes them use a separate sheet

ldr r0,=SkillsTextIDLink
ldrh r0, [r0]
draw_textID_at 21, 13, colour=White @skills


mov r0,r8
ldr r1,=Skill_Getter
mov r14,r1
.short 0xF800

mov r6,r0
ldrb r0,[r6]
cmp r0,#0
beq SkillsEnd
draw_skill_icon_at 21, 15

ldrb r0,[r6,#1]
cmp r0,#0
beq SkillsEnd
draw_skill_icon_at 24, 15

ldrb r0,[r6,#2]
cmp r0,#0
beq SkillsEnd
draw_skill_icon_at 27, 15

ldrb r0,[r6,#3]
cmp r0,#0
beq SkillsEnd
draw_skill_icon_at 21, 17

ldrb r0,[r6,#4]
cmp r0,#0
beq SkillsEnd
draw_skill_icon_at 24, 17

ldrb r0,[r6,#5]
cmp r0,#0
beq SkillsEnd
draw_skill_icon_at 27, 17
b SkillsEnd

.ltorg
.align

SkillsEnd:

@ draw_textID_at 13, 15, textID=0x4f6 @move
@ draw_move_bar_at 16, 15

@blh DrawBWLNumbers

ldr		r0,=StatScreenStruct
sub		r0,#0x2
ldrb	r0,[r0]
cmp		r0,#0x0
beq		DoNotUpdate
ldr		r0,=BgBitfield
ldrb	r1,[r0]
mov		r2,#0x5
orr		r1,r2
strb	r1,[r0]
ldr		r0,=CopyToBG
mov		r14,r0
ldr		r0,=Const_2003D2C
ldr		r1,=Const_2022D40
mov		r2,#0x12
mov		r3,#0x12
.short	0xF800
ldr		r0,=CopyToBG
mov		r14,r0
ldr		r0,=Const_200472C
ldr		r1,=Const_2023D40
mov		r2,#0x12
mov		r3,#0x12
.short	0xF800
ldr		r0,=StatScreenStruct
sub		r0,#0x2
mov		r1,#0x0
strb	r1,[r0]

b DoNotUpdate
.ltorg

DoNotUpdate:
page_end

.ltorg

Restore_Palette:
@r0=thing to store back, r1=0 if we can skip this
cmp		r1,#0
beq		RestoreDone
cmp		r0,#0
beq		RestoreDone
ldr		r1,=#0x02028E70
ldr		r1,[r1]
strh	r0,[r1,#0x10]
RestoreDone:
bx		r14

.ltorg

.include "GetTalkee.asm"

