.thumb
.include "mss_defs.s"

.set NoAltIconDraw, 1 

page_start
.set SkillGetter, IconGraphic+4
.set SkillTester, SkillGetter+4
.set SaviorID, SkillTester+4
.set CelerityID, SaviorID+4
.set SS_SkillsText, CelerityID+4
.set SS_TalkText, SS_SkillsText+4
.set SkillDescTable, SS_TalkText+4

setup_menu

@Skills

draw_textID_at 16, 18, textID=0xd4d, width=16, colour=Green

Nexty:
b skipliterals
.ltorg
skipliterals:

ldr r5, SkillDescTable

mov r0, r8
ldr r1, SkillGetter
mov lr, r1
.short 0xf800 @skills now stored in the skills buffer

mov r6, r0
ldrb r0, [r6] 
cmp r0, #0
bne ContSkill1
b SkillEnd
ContSkill1:
draw_skill_icon_at 13, 4
ldrb r0, [r6] 
lsl r0, r0, #1
ldrh r0, [r5, r0]
draw_skillname_at 16, 4

ldrb r0, [r6,#1]
cmp r0, #0
bne ContSkill2
b SkillEnd
ContSkill2:
draw_skill_icon_at 13, 6
ldrb r0, [r6, #1] 
lsl r0, r0, #1
ldrh r0, [r5, r0]
draw_skillname_at 16, 6

ldrb r0, [r6, #2]
cmp r0, #0
bne ContSkill3
b SkillEnd
ContSkill3:
draw_skill_icon_at 13, 8
ldrb r0, [r6, #2] 
lsl r0, r0, #1
ldrh r0, [r5, r0]
draw_skillname_at 16, 8

ldrb r0, [r6, #3]
cmp r0, #0
bne ContSkill4
b SkillEnd
ContSkill4:
draw_skill_icon_at 13, 10
ldrb r0, [r6, #3] 
lsl r0, r0, #1
ldrh r0, [r5, r0]
draw_skillname_at 16, 10

ldrb r0, [r6, #4]
cmp r0, #0
bne ContSkill5
b SkillEnd
ContSkill5:
draw_skill_icon_at 13, 12
ldrb r0, [r6, #4] 
lsl r0, r0, #1
ldrh r0, [r5, r0]
draw_skillname_at 16, 12

ldrb r0, [r6, #5]
cmp r0, #0
bne ContSkill6
b SkillEnd
ContSkill6:
draw_skill_icon_at 13, 14
ldrb r0, [r6, #5] 
lsl r0, r0, #1
ldrh r0, [r5, r0]
draw_skillname_at 16, 14

SkillEnd:

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

GetSkillNameFromSkillDesc:
	push {r4, lr}
	mov r4, r0
	
	sub r0, #1
	
Continue:
	add r0, #1
	ldrb r1, [r0]
	
	cmp r1, #0
	beq End
	
	cmp r1, #0x3A @ ':'
	bne Continue
	
	mov  r1, #0
	strb r1, [r0]
	
End:
	mov r0, r4
	pop {r4, pc}

.ltorg

Restore_Palette:
@r0=thing to store back, r1=0 if we can skip this
cmp		r1,#0
beq		RestoreDone
cmp		r0,#0
beq		RestoreDone
ldr		r1,Const2_2028E70
ldr		r1,[r1]
strh	r0,[r1,#0x10]
RestoreDone:
bx		r14

.align
Const2_2028E70:
.long 0x02028E70
.ltorg
IconGraphic:
