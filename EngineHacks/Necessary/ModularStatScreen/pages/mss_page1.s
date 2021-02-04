.thumb
@draws the stat screen
.include "mss_defs.s"

.global MSS_page1
.type MSS_page1, %function


MSS_page1:

page_start

@draw str or mag
  mov r0, r8
  blh     MagCheck			@r0 = 1 if mag should show
  cmp     r0,#0x0				
  beq     NotMag				
    @draw Mag at 13, 3. colour defaults to yellow.
    draw_textID_at 13, 3, 0x4ff
    b       MagStrDone    
  NotMag:
    @draw Str at 13, 3
    draw_textID_at 13, 3, 0x4fe
  MagStrDone:
	draw_str_bar_at 16, 3

@Draw skl
draw_textID_at 13, 5, 0x4EC
@draw spd
draw_textID_at 13, 7, 0x4ED

b NoRescue
.ltorg
NoRescue:
  draw_skl_bar_at 16, 5
  draw_spd_bar_at 16, 7
RescueCheckEnd:

draw_textID_at 13, 9, 0x4ee @luck
draw_luck_bar_at 16, 9

draw_textID_at 13, 11, 0x4ef @def
draw_def_bar_at 16, 11

draw_textID_at 13, 13, 0x4f0 @res
draw_res_bar_at 16, 13

draw_textID_at 13, 15, 0x4f6 @move
draw_move_bar_with_getter_at 16, 15

draw_textID_at 13, 17, 0x4f7 @con
draw_con_bar_at 16, 17

@ draw_textID_at 21, 7, 0x4f8 @aid
@ draw_number_at 25, 7, 0x80189B8, 1 @aid getter
@ draw_aid_icon_at 26, 7

draw_textID_at 21, 3, 0x4f1 @affin
draw_affinity_icon_at 24, 3

draw_status_text_at 21, 5

ldr r0,=TalkTextIDLink
ldrh r0,[r0]
draw_talk_text_at 21, 7

b literalpoolskip
.ltorg
literalpoolskip:

draw_trv_text_at 21, 9

draw_textID_at 21, 11, 0x4f3 @atk
get_attack
draw_number_at 26, 11

draw_textID_at 21, 13, 0x504 @AS
get_attack_speed
draw_number_at 26, 13

draw_textID_at 21, 15, 0x4f4 @hit
get_hit
draw_number_at 26, 15

draw_textID_at 21, 17, 0x4f5 @avoid
get_avoid
draw_number_at 26, 17
  
@blh DrawBWLNumbers

page_end

.ltorg

.include "GetTalkee.asm"
