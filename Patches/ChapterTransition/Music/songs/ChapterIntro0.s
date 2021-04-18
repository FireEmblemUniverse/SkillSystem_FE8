        .include "MPlayDef.s"

        .equ    ChapterIntro0_grp, voicegroup000
        .equ    ChapterIntro0_pri, 0
        .equ    ChapterIntro0_rev, 0
        .equ    ChapterIntro0_key, 0

        .section .rodata
        .global ChapterIntro0
        .align  2

@****************** Track 0 (Midi-Chn.0) ******************@

ChapterIntro0_0:
        .byte   KEYSH , ChapterIntro0_key+0
@ 000   ----------------------------------------
        .byte   TEMPO , 120/2
        .byte           VOICE , 81
        .byte           VOL   , 60
        .byte           N12   , Gn2 , v100
        .byte   W12
        .byte                   Gn2
        .byte   W24
        .byte                   Fn2
        .byte   W12
        .byte                   Gn2
        .byte   W12
        .byte                   Gn2
        .byte   W24
        .byte                   Fn2
        .byte   W12
@ 001   ----------------------------------------
ChapterIntro0_0_1:
        .byte           N12   , Gn2 , v100
        .byte   W12
        .byte                   Gn2
        .byte   W24
        .byte                   Fn2
        .byte   W12
        .byte                   Gn2
        .byte   W12
        .byte                   Gn2
        .byte   W24
        .byte                   As2
        .byte   W12
        .byte   PEND
@ 002   ----------------------------------------
ChapterIntro0_0_LOOP:
        .byte           N12   , Ds2 , v100
        .byte   W12
        .byte                   Ds2
        .byte   W24
        .byte                   Dn2
        .byte   W12
        .byte                   Ds2
        .byte   W12
        .byte                   Ds2
        .byte   W24
        .byte                   Dn2
        .byte   W12
@ 003   ----------------------------------------
        .byte                   Ds2
        .byte   W12
        .byte                   Ds2
        .byte   W24
        .byte                   Dn2
        .byte   W12
        .byte                   Ds2
        .byte   W12
        .byte                   Ds2
        .byte   W24
        .byte                   Bn2
        .byte   W12
@ 004   ----------------------------------------
ChapterIntro0_0_4:
        .byte           N12   , Cn3 , v100
        .byte   W12
        .byte                   Cn3
        .byte   W24
        .byte                   Bn2
        .byte   W12
        .byte                   Cn3
        .byte   W12
        .byte                   Cn3
        .byte   W24
        .byte                   Bn2
        .byte   W12
        .byte   PEND
@ 005   ----------------------------------------
ChapterIntro0_0_5:
        .byte           N12   , Cn3 , v100
        .byte   W12
        .byte                   Cn3
        .byte   W24
        .byte                   Bn2
        .byte   W12
        .byte                   Cn3
        .byte   W12
        .byte                   Cn3
        .byte   W24
        .byte                   Cs3
        .byte   W12
        .byte   PEND
@ 006   ----------------------------------------
ChapterIntro0_0_6:
        .byte           N12   , Dn3 , v100
        .byte   W12
        .byte                   Dn3
        .byte   W24
        .byte                   Cs3
        .byte   W12
        .byte                   Dn3
        .byte   W12
        .byte                   Dn3
        .byte   W24
        .byte                   Cs3
        .byte   W12
        .byte   PEND
@ 007   ----------------------------------------
ChapterIntro0_0_7:
        .byte           N12   , Dn3 , v100
        .byte   W12
        .byte                   Dn3
        .byte   W24
        .byte                   Cs3
        .byte   W12
        .byte                   Fn3
        .byte   W12
        .byte           N24   , Fs3
        .byte   W24
        .byte           N12   , An2
        .byte   W12
        .byte   PEND
@ 008   ----------------------------------------
ChapterIntro0_0_8:
        .byte           N12   , Gn2 , v100
        .byte   W12
        .byte                   Gn2
        .byte   W24
        .byte                   Fn2
        .byte   W12
        .byte                   Gn2
        .byte   W12
        .byte                   Gn2
        .byte   W24
        .byte                   Fn2
        .byte   W12
        .byte   PEND
@ 009   ----------------------------------------
        .byte   PATT
         .word  ChapterIntro0_0_1
@ 010   ----------------------------------------
        .byte           N12   , Ds2 , v100
        .byte   W12
        .byte                   Ds2
        .byte   W24
        .byte                   Dn2
        .byte   W12
        .byte                   Ds2
        .byte   W12
        .byte                   Ds2
        .byte   W24
        .byte                   Dn2
        .byte   W12
@ 011   ----------------------------------------
        .byte                   Ds2
        .byte   W12
        .byte                   Ds2
        .byte   W24
        .byte                   Dn2
        .byte   W12
        .byte                   Ds2
        .byte   W12
        .byte                   Ds2
        .byte   W24
        .byte                   Fn2
        .byte   W12
@ 012   ----------------------------------------
        .byte   PATT
         .word  ChapterIntro0_0_4
@ 013   ----------------------------------------
        .byte   PATT
         .word  ChapterIntro0_0_5
@ 014   ----------------------------------------
        .byte   PATT
         .word  ChapterIntro0_0_6
@ 015   ----------------------------------------
        .byte   PATT
         .word  ChapterIntro0_0_7
@ 016   ----------------------------------------
        .byte   PATT
         .word  ChapterIntro0_0_8
@ 017   ----------------------------------------
        .byte   PATT
         .word  ChapterIntro0_0_1
@ 018   ----------------------------------------
        .byte   GOTO
         .word  ChapterIntro0_0_LOOP
        .byte   FINE

@****************** Track 1 (Midi-Chn.1) ******************@

ChapterIntro0_1:
        .byte   KEYSH , ChapterIntro0_key+0
@ 000   ----------------------------------------
        .byte           VOICE , 127
        .byte           VOL   , 100
        .byte   W24
        .byte           N12   , Cn3 , v100
        .byte   W48
        .byte                   Cn3
        .byte   W24
@ 001   ----------------------------------------
ChapterIntro0_1_1:
        .byte   W24
        .byte           N12   , Cn3 , v100
        .byte   W48
        .byte                   Cn3
        .byte   W24
        .byte   PEND
@ 002   ----------------------------------------
ChapterIntro0_1_LOOP:
        .byte   W24
        .byte           N12   , Cn3 , v100
        .byte   W48
        .byte                   Cn3
        .byte   W24
@ 003   ----------------------------------------
        .byte   PATT
         .word  ChapterIntro0_1_1
@ 004   ----------------------------------------
        .byte   PATT
         .word  ChapterIntro0_1_1
@ 005   ----------------------------------------
        .byte   PATT
         .word  ChapterIntro0_1_1
@ 006   ----------------------------------------
        .byte   PATT
         .word  ChapterIntro0_1_1
@ 007   ----------------------------------------
        .byte   PATT
         .word  ChapterIntro0_1_1
@ 008   ----------------------------------------
        .byte   PATT
         .word  ChapterIntro0_1_1
@ 009   ----------------------------------------
        .byte   PATT
         .word  ChapterIntro0_1_1
@ 010   ----------------------------------------
        .byte   PATT
         .word  ChapterIntro0_1_1
@ 011   ----------------------------------------
        .byte   PATT
         .word  ChapterIntro0_1_1
@ 012   ----------------------------------------
        .byte   PATT
         .word  ChapterIntro0_1_1
@ 013   ----------------------------------------
        .byte   PATT
         .word  ChapterIntro0_1_1
@ 014   ----------------------------------------
        .byte   PATT
         .word  ChapterIntro0_1_1
@ 015   ----------------------------------------
        .byte   PATT
         .word  ChapterIntro0_1_1
@ 016   ----------------------------------------
        .byte   PATT
         .word  ChapterIntro0_1_1
@ 017   ----------------------------------------
        .byte   PATT
         .word  ChapterIntro0_1_1
@ 018   ----------------------------------------
        .byte   GOTO
         .word  ChapterIntro0_1_LOOP
        .byte   FINE

@****************** Track 2 (Midi-Chn.2) ******************@

ChapterIntro0_2:
        .byte   KEYSH , ChapterIntro0_key+0
@ 000   ----------------------------------------
        .byte           VOICE , 127
        .byte           VOL   , 60
        .byte   W72
        .byte           N12   , Ds4 , v100
        .byte   W24
@ 001   ----------------------------------------
ChapterIntro0_2_1:
        .byte           N12   , Ds4 , v100
        .byte   W24
        .byte                   Ds4
        .byte   W12
        .byte                   Ds4
        .byte   W12
        .byte                   Ds4
        .byte   W24
        .byte                   Ds4
        .byte   W24
        .byte   PEND
@ 002   ----------------------------------------
ChapterIntro0_2_LOOP:
        .byte   W72
        .byte           N12   , Ds4 , v100
        .byte   W24
@ 003   ----------------------------------------
        .byte   PATT
         .word  ChapterIntro0_2_1
@ 004   ----------------------------------------
ChapterIntro0_2_4:
        .byte   W72
        .byte           N12   , Ds4 , v100
        .byte   W24
        .byte   PEND
@ 005   ----------------------------------------
        .byte   PATT
         .word  ChapterIntro0_2_1
@ 006   ----------------------------------------
        .byte   PATT
         .word  ChapterIntro0_2_4
@ 007   ----------------------------------------
        .byte   PATT
         .word  ChapterIntro0_2_1
@ 008   ----------------------------------------
        .byte   PATT
         .word  ChapterIntro0_2_4
@ 009   ----------------------------------------
        .byte   PATT
         .word  ChapterIntro0_2_1
@ 010   ----------------------------------------
        .byte   PATT
         .word  ChapterIntro0_2_4
@ 011   ----------------------------------------
        .byte   PATT
         .word  ChapterIntro0_2_1
@ 012   ----------------------------------------
        .byte   PATT
         .word  ChapterIntro0_2_4
@ 013   ----------------------------------------
        .byte   PATT
         .word  ChapterIntro0_2_1
@ 014   ----------------------------------------
        .byte   PATT
         .word  ChapterIntro0_2_4
@ 015   ----------------------------------------
        .byte   PATT
         .word  ChapterIntro0_2_1
@ 016   ----------------------------------------
        .byte   PATT
         .word  ChapterIntro0_2_4
@ 017   ----------------------------------------
        .byte   PATT
         .word  ChapterIntro0_2_1
@ 018   ----------------------------------------
        .byte   GOTO
         .word  ChapterIntro0_2_LOOP
        .byte   FINE

@****************** Track 3 (Midi-Chn.3) ******************@

ChapterIntro0_3:
        .byte   KEYSH , ChapterIntro0_key+0
@ 000   ----------------------------------------
        .byte           VOICE , 105
        .byte           VOL   , 0
        .byte           TIE   , Gn1 , v100
        .byte   W24
        .byte           VOL   , 10
        .byte   W19
        .byte                   20
        .byte   W19
        .byte                   30
        .byte   W19
        .byte                   40
        .byte   W15
@ 001   ----------------------------------------
        .byte   W04
        .byte                   50
        .byte   W20
        .byte                   60
        .byte   W60
        .byte           EOT
        .byte           N12   , As1
        .byte   W12
@ 002   ----------------------------------------
ChapterIntro0_3_LOOP:
        .byte           TIE   , Ds1 , v100
        .byte   W96
@ 003   ----------------------------------------
ChapterIntro0_3_3:
        .byte   W84
        .byte           EOT   , Ds1
        .byte           N12   , Gn1 , v100
        .byte   W12
        .byte   PEND
@ 004   ----------------------------------------
        .byte           TIE   , Cn2
        .byte   W96
@ 005   ----------------------------------------
ChapterIntro0_3_5:
        .byte   W84
        .byte           EOT   , Cn2
        .byte           N12   , Cs2 , v100
        .byte   W12
        .byte   PEND
@ 006   ----------------------------------------
        .byte           TIE   , Dn2
        .byte   W96
@ 007   ----------------------------------------
ChapterIntro0_3_7:
        .byte   W84
        .byte           EOT   , Dn2
        .byte           N12   , An1 , v100
        .byte   W12
        .byte   PEND
@ 008   ----------------------------------------
        .byte           TIE   , Gn1
        .byte   W96
@ 009   ----------------------------------------
ChapterIntro0_3_9:
        .byte   W84
        .byte           EOT   , Gn1
        .byte           N12   , As1 , v100
        .byte   W12
        .byte   PEND
@ 010   ----------------------------------------
        .byte           TIE   , Ds1
        .byte   W96
@ 011   ----------------------------------------
        .byte   PATT
         .word  ChapterIntro0_3_3
@ 012   ----------------------------------------
        .byte           TIE   , Cn2 , v100
        .byte   W96
@ 013   ----------------------------------------
        .byte   PATT
         .word  ChapterIntro0_3_5
@ 014   ----------------------------------------
        .byte           TIE   , Dn2 , v100
        .byte   W96
@ 015   ----------------------------------------
        .byte   PATT
         .word  ChapterIntro0_3_7
@ 016   ----------------------------------------
        .byte           TIE   , Gn1 , v100
        .byte   W96
@ 017   ----------------------------------------
        .byte   PATT
         .word  ChapterIntro0_3_9
@ 018   ----------------------------------------
        .byte   GOTO
         .word  ChapterIntro0_3_LOOP
        .byte   FINE

@****************** Track 4 (Midi-Chn.4) ******************@

ChapterIntro0_4:
        .byte   KEYSH , ChapterIntro0_key+0
@ 000   ----------------------------------------
        .byte   W28
        .byte           VOICE , 74
        .byte   W04
        .byte           VOL   , 60
        .byte   W64
@ 001   ----------------------------------------
        .byte   W96
@ 002   ----------------------------------------
ChapterIntro0_4_LOOP:
        .byte   W96
@ 003   ----------------------------------------
        .byte   W96
@ 004   ----------------------------------------
        .byte   W96
@ 005   ----------------------------------------
        .byte   W96
@ 006   ----------------------------------------
        .byte   W96
@ 007   ----------------------------------------
        .byte   W96
@ 008   ----------------------------------------
        .byte           N24   , Gn4 , v100
        .byte   W24
        .byte           N12
        .byte   W12
        .byte                   Fs4
        .byte   W12
        .byte           N24   , Gn4
        .byte   W24
        .byte           N12
        .byte   W12
        .byte                   Fs4
        .byte   W12
@ 009   ----------------------------------------
        .byte           N24   , Gn4
        .byte   W24
        .byte           N12
        .byte   W12
        .byte                   Fs4
        .byte   W12
        .byte                   Gn4
        .byte   W12
        .byte                   As4
        .byte   W12
        .byte                   Gn4
        .byte   W12
        .byte                   Fs4
        .byte   W12
@ 010   ----------------------------------------
        .byte           N24   , Ds4
        .byte   W24
        .byte           N12
        .byte   W12
        .byte                   Dn4
        .byte   W12
        .byte           N24   , Ds4
        .byte   W24
        .byte           N12
        .byte   W12
        .byte                   Dn4
        .byte   W12
@ 011   ----------------------------------------
        .byte           N24   , Ds4
        .byte   W24
        .byte           N12
        .byte   W12
        .byte                   Dn4
        .byte   W12
        .byte                   Ds4
        .byte   W12
        .byte                   Fs4
        .byte   W12
        .byte                   Ds4
        .byte   W12
        .byte                   Dn4
        .byte   W12
@ 012   ----------------------------------------
        .byte           N24   , Cn4
        .byte   W24
        .byte           N12
        .byte   W12
        .byte                   Bn3
        .byte   W12
        .byte           N24   , Cn4
        .byte   W24
        .byte           N12
        .byte   W12
        .byte                   Bn3
        .byte   W12
@ 013   ----------------------------------------
        .byte           N24   , Cn4
        .byte   W24
        .byte           N12
        .byte   W12
        .byte                   Bn3
        .byte   W12
        .byte                   Cn4
        .byte   W12
        .byte                   Ds4
        .byte   W12
        .byte                   Cn4
        .byte   W12
        .byte                   Cs4
        .byte   W12
@ 014   ----------------------------------------
        .byte           N24   , Dn4
        .byte   W24
        .byte           N12
        .byte   W12
        .byte                   Cs4
        .byte   W12
        .byte           N24   , Dn4
        .byte   W24
        .byte           N12
        .byte   W12
        .byte                   Cs4
        .byte   W12
@ 015   ----------------------------------------
        .byte           N24   , Dn4
        .byte   W24
        .byte           N12
        .byte   W12
        .byte                   Cs4
        .byte   W12
        .byte                   Dn4
        .byte   W12
        .byte           N36   , Fs4
        .byte   W36
@ 016   ----------------------------------------
        .byte   W96
@ 017   ----------------------------------------
        .byte   W96
@ 018   ----------------------------------------
        .byte   GOTO
         .word  ChapterIntro0_4_LOOP
        .byte   FINE


@********************** End of Song ***********************@

        .align  2
ChapterIntro0:
        .byte   5                       @ Num Tracks
        .byte   0                       @ Unknown
        .byte   ChapterIntro0_pri       @ Priority
        .byte   ChapterIntro0_rev       @ Reverb

        .word   ChapterIntro0_grp      

        .word   ChapterIntro0_0
        .word   ChapterIntro0_1
        .word   ChapterIntro0_2
        .word   ChapterIntro0_3
        .word   ChapterIntro0_4

        .end
