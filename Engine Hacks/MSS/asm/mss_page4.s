.thumb
.include "mss_defs.s"
.set HolyBloodNameGetter, SS_BloodText+4

page_start

draw_textID_at 17, 9, textID=0xd4b, width=16, colour=Green



ldr r0, SS_BloodText
draw_textID_at 17, 11 @Blood label text

@pass in textid in r0
ldr r0, HolyBloodNameGetter
mov r14,r0
.short 0xF800
draw_textID_at 23, 11, colour=White, width=16

page_end

.align
.ltorg
.align
SS_BloodText:
@WORD SS_BloodText
@POIN HolyBloodNameGetter
