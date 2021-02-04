.thumb
@draws the left panel of the stat screen
.include "mss_defs.s"

.global MSS_leftpage
.type MSS_leftpage, %function


MSS_leftpage:

leftpage_start

draw_character_name_at 3,10
draw_class_name_at 1,13


draw_left_affinity_icon_at 10,10


draw_lv_icon_at 1, 15
draw_level_at 4, 15

draw_exp_icon_at 5, 15
draw_exp_at 7, 15

draw_hp_icon_at 1, 17
draw_ui_slash_at 5, 17
draw_hp_at 4, 17
draw_max_hp @for contrived reasons this doesn't take coordinates

ldr r0,=#0x442
bl HP_Name_Color


page_end

