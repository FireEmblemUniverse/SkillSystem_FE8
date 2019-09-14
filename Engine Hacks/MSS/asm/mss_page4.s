.thumb
.include "mss_defs.s"
.set HolyBloodNameGetter, SS_BloodText+4

page_start

draw_textID_at 17, 9, textID=0xd4b, width=16, colour=Green



ldr r0, SS_BloodText
draw_textID_at 17, 11 @Blood label text

@pass in textid in r0
blh HolyBloodNameGetter,r0
draw_textID_at 17, 13, colour=White,

page_end

.align
.ltorg
.align
SS_BloodText:
@WORD SS_BloodText
@POIN HolyBloodNameGetter
