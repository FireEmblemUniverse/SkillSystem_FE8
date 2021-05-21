.thumb
.include "mss_defs.s"

.global MSS_page3
.type MSS_page3, %function


MSS_page3:

page_start

@draw_textID_at 13, 3, 0xd4b, 16, Green
draw_gaiden_spells_at 13, 3, GaidenStatScreen @ GaidenStatScreen is a pointer to the routine, GaidenStatScreen.

page_end
