	.include "MPlayDef.s"

	.equ	song04_grp, voicegroup000
	.equ	song04_pri, 10
	.equ	song04_rev, 128
	.equ	song04_mvl, 127
	.equ	song04_key, 0
	.equ	song04_tbs, 1
	.equ	song04_exg, 0
	.equ	song04_cmp, 1

	.section .rodata
	.global	song04
	.align	2


@**************** Track 1 (Midi-Chn.0) ****************@

song04_001:
@ 000   ----------------------------------------
 .byte   KEYSH , song04_key+0
 .byte   W12
 .byte   TEMPO , 144*song04_tbs/2
 .byte   VOICE , 1
 .byte   CD
 .byte   GsM2 ,v010
 .byte   AnM2 ,v008
 .byte   VOL , 90*song04_mvl/mxv
 .byte   PAN , c_v+47
 .byte   N09 ,Fn4 ,v060
 .byte   W18
 .byte   N03 ,Dn4
 .byte   W06
 .byte   N24
 .byte   W09
 .byte   MOD 0
 .byte   FsM2
 .byte   W15
 .byte   VOICE , 2
 .byte   MOD 0
 .byte   CnM2
 .byte   PAN , c_v+0
 .byte   N06 ,Fn3 ,v072
 .byte   W06
 .byte   As2 ,v060
 .byte   W06
 .byte   Dn3
 .byte   W06
 .byte   Fn3
 .byte   W06
 .byte   Dn3 ,v072
 .byte   W06
 .byte   Fn3 ,v060
 .byte   W06
@ 001   ----------------------------------------
 .byte   As3
 .byte   W06
 .byte   Dn4
 .byte   W06
 .byte   VOICE , 1
 .byte   PAN , c_v+47
 .byte   N09 ,Gn4 ,v056
 .byte   W18
 .byte   N03 ,En4 ,v060
 .byte   W06
 .byte   N24
 .byte   W12
 .byte   MOD 0
 .byte   FsM2
 .byte   W12
 .byte   VOICE , 2
 .byte   MOD 0
 .byte   CnM2
 .byte   PAN , c_v+0
 .byte   N06 ,Gn3 ,v072
 .byte   W06
 .byte   Cn3 ,v060
 .byte   W06
 .byte   En3
 .byte   W06
 .byte   Gn3
 .byte   W06
 .byte   En3 ,v072
 .byte   W06
 .byte   Gn3 ,v060
 .byte   W06
@ 002   ----------------------------------------
 .byte   Cn4
 .byte   W06
 .byte   En4
 .byte   W06
 .byte   VOICE , 1
 .byte   PAN , c_v-47
 .byte   N48 ,An4
 .byte   W05
 .byte   VOL , 76*song04_mvl/mxv
 .byte   W04
 .byte   Fn3
 .byte   W05
 .byte   Gs3
 .byte   W01
 .byte   MOD 0
 .byte   FsM2
 .byte   W04
 .byte   VOL , 71*song04_mvl/mxv
 .byte   W05
 .byte   Ds4
 .byte   W05
 .byte   Fn4
 .byte   W04
 .byte   MOD 0
 .byte   GsM2
 .byte   W01
 .byte   VOL , 80*song04_mvl/mxv
 .byte   W05
 .byte   Cn5
 .byte   W05
 .byte   Ds5
 .byte   W04
 .byte   Fs5
 .byte   MOD 0
 .byte   CnM2
 .byte   N09
 .byte   W48
 .byte   FINE

@**************** Track 2 (Midi-Chn.1) ****************@

song04_002:
@ 000   ----------------------------------------
 .byte   KEYSH , song04_key+0
 .byte   W12
 .byte   VOICE , 6
 .byte   VOL , 90*song04_mvl/mxv
 .byte   PAN , c_v+11
 .byte   N09 ,As4 ,v116
 .byte   W18
 .byte   N03 ,Fn4
 .byte   W06
 .byte   N44
 .byte   W09
 .byte   MOD 0
 .byte   FsM2
 .byte   W15
 .byte   VOL , 78*song04_mvl/mxv
 .byte   W05
 .byte   Ds3
 .byte   W05
 .byte   Dn1
 .byte   W05
 .byte   DnM1
 .byte   W03
 .byte   CnM2
 .byte   W03
 .byte   Fs5
 .byte   MOD 0
 .byte   CnM2
 .byte   N03 ,An4 ,v100
 .byte   W03
 .byte   N06 ,As4 ,v116
 .byte   W12
@ 001   ----------------------------------------
 .byte   Bn4
 .byte   W12
 .byte   N09 ,Cn5
 .byte   W18
 .byte   N03 ,Gn4
 .byte   W06
 .byte   N44
 .byte   W12
 .byte   MOD 0
 .byte   FsM2
 .byte   W12
 .byte   VOL , 78*song04_mvl/mxv
 .byte   W05
 .byte   Ds3
 .byte   W05
 .byte   Dn1
 .byte   W05
 .byte   DnM1
 .byte   W03
 .byte   CnM2
 .byte   W03
 .byte   Fs5
 .byte   MOD 0
 .byte   CnM2
 .byte   N03 ,Bn4 ,v100
 .byte   W03
 .byte   N24 ,Cn5 ,v116
 .byte   W15
@ 002   ----------------------------------------
 .byte   MOD 0
 .byte   FsM2
 .byte   W09
 .byte   CnM2
 .byte   N48 ,Dn5
 .byte   W05
 .byte   VOL , 76*song04_mvl/mxv
 .byte   W04
 .byte   Fn3
 .byte   W05
 .byte   Gs3
 .byte   W01
 .byte   MOD 0
 .byte   FsM2
 .byte   W04
 .byte   VOL , 71*song04_mvl/mxv
 .byte   W05
 .byte   Ds4
 .byte   W05
 .byte   Fn4
 .byte   W04
 .byte   MOD 0
 .byte   GsM2
 .byte   W01
 .byte   VOL , 80*song04_mvl/mxv
 .byte   W05
 .byte   Cn5
 .byte   W05
 .byte   Ds5
 .byte   W04
 .byte   Fs5
 .byte   MOD 0
 .byte   CnM2
 .byte   N09
 .byte   W48
 .byte   FINE

@**************** Track 3 (Midi-Chn.2) ****************@

song04_003:
@ 000   ----------------------------------------
 .byte   KEYSH , song04_key+0
 .byte   W12
 .byte   VOICE , 7
 .byte   VOL , 90*song04_mvl/mxv
 .byte   N09 ,As1 ,v080
 .byte   W18
 .byte   N03
 .byte   W06
 .byte   N24
 .byte   W24
 .byte   N18 ,Dn2
 .byte   W18
 .byte   Cn2
 .byte   W18
@ 001   ----------------------------------------
 .byte   N12 ,As1
 .byte   W12
 .byte   N09 ,Cn2
 .byte   W18
 .byte   N03
 .byte   W06
 .byte   N24
 .byte   W24
 .byte   N18 ,En2
 .byte   W18
 .byte   Dn2
 .byte   W18
@ 002   ----------------------------------------
 .byte   N12 ,Cn2
 .byte   W12
 .byte   N06 ,Dn2
 .byte   W12
 .byte   An1
 .byte   W12
 .byte   Dn2
 .byte   W12
 .byte   An1
 .byte   W12
 .byte   N09 ,Dn2
 .byte   W48
 .byte   FINE

@**************** Track 4 (Midi-Chn.3) ****************@

song04_004:
@ 000   ----------------------------------------
 .byte   KEYSH , song04_key+0
 .byte   W12
 .byte   VOICE , 8
 .byte   VOL , 90*song04_mvl/mxv
 .byte   PAN , c_v-13
 .byte   N06 ,As1 ,v127
 .byte   W36
 .byte   As1 ,v100
 .byte   W06
 .byte   Fn1
 .byte   W06
 .byte   As1 ,v127
 .byte   W12
 .byte   Fn1
 .byte   W12
 .byte   As1
 .byte   W12
@ 001   ----------------------------------------
 .byte   Fn1
 .byte   W12
 .byte   Cn2
 .byte   W36
 .byte   Cn2 ,v100
 .byte   W06
 .byte   Gn1
 .byte   W06
 .byte   Cn2 ,v127
 .byte   W12
 .byte   Gn1
 .byte   W12
 .byte   Cn2
 .byte   W12
@ 002   ----------------------------------------
 .byte   Gn1
 .byte   W06
 .byte   Cn2
 .byte   W06
 .byte   Dn2
 .byte   W12
 .byte   An1
 .byte   W12
 .byte   Dn2
 .byte   W12
 .byte   An1
 .byte   W12
 .byte   Dn2
 .byte   W48
 .byte   FINE

@**************** Track 5 (Midi-Chn.4) ****************@

song04_005:
@ 000   ----------------------------------------
 .byte   KEYSH , song04_key+0
 .byte   W12
 .byte   VOICE , 9
 .byte   CD
 .byte   GsM2 ,v010
 .byte   AnM2 ,v008
 .byte   VOL , 90*song04_mvl/mxv
 .byte   PAN , c_v-48
 .byte   BEND , c_v+0
 .byte   N09 ,Dn4 ,v060
 .byte   W18
 .byte   N03 ,As3
 .byte   W06
 .byte   N24
 .byte   W09
 .byte   MOD 0
 .byte   FsM2
 .byte   W15
 .byte   CnM2
 .byte   W06
 .byte   VOICE , 10
 .byte   PAN , c_v+48
 .byte   BEND , c_v-2
 .byte   N06 ,Fn3 ,v052
 .byte   W06
 .byte   PAN , c_v-48
 .byte   N06 ,As2
 .byte   W06
 .byte   PAN , c_v+48
 .byte   N06 ,Dn3
 .byte   W06
 .byte   PAN , c_v-48
 .byte   N06 ,Fn3
 .byte   W06
 .byte   PAN , c_v+48
 .byte   N06 ,Dn3
 .byte   W06
@ 001   ----------------------------------------
 .byte   PAN , c_v-48
 .byte   N06 ,Fn3
 .byte   W06
 .byte   PAN , c_v+48
 .byte   N06 ,As3
 .byte   W06
 .byte   VOICE , 9
 .byte   PAN , c_v-48
 .byte   BEND , c_v+0
 .byte   N09 ,En4 ,v060
 .byte   W18
 .byte   N03 ,Cn4
 .byte   W06
 .byte   N24
 .byte   W12
 .byte   MOD 0
 .byte   FsM2
 .byte   W12
 .byte   CnM2
 .byte   W06
 .byte   VOICE , 10
 .byte   PAN , c_v+48
 .byte   BEND , c_v-2
 .byte   N06 ,Gn3 ,v052
 .byte   W06
 .byte   PAN , c_v-48
 .byte   N06 ,Cn3
 .byte   W06
 .byte   PAN , c_v+48
 .byte   N06 ,En3
 .byte   W06
 .byte   PAN , c_v-48
 .byte   N06 ,Gn3
 .byte   W06
 .byte   PAN , c_v+48
 .byte   N06 ,En3
 .byte   W06
@ 002   ----------------------------------------
 .byte   PAN , c_v-48
 .byte   N06 ,Gn3
 .byte   W06
 .byte   PAN , c_v+48
 .byte   N06 ,Cn4
 .byte   W06
 .byte   VOICE , 9
 .byte   BEND , c_v+0
 .byte   N48 ,Fs4 ,v060
 .byte   W05
 .byte   VOL , 76*song04_mvl/mxv
 .byte   W04
 .byte   Fn3
 .byte   W05
 .byte   Gs3
 .byte   W01
 .byte   MOD 0
 .byte   FsM2
 .byte   W04
 .byte   VOL , 71*song04_mvl/mxv
 .byte   W05
 .byte   Ds4
 .byte   W05
 .byte   Fn4
 .byte   W04
 .byte   MOD 0
 .byte   GsM2
 .byte   W01
 .byte   VOL , 80*song04_mvl/mxv
 .byte   W05
 .byte   Cn5
 .byte   W05
 .byte   Ds5
 .byte   W04
 .byte   Fs5
 .byte   MOD 0
 .byte   CnM2
 .byte   N09
 .byte   W48
 .byte   FINE

@**************** Track 6 (Midi-Chn.5) ****************@

song04_006:
@ 000   ----------------------------------------
 .byte   KEYSH , song04_key+0
 .byte   W12
 .byte   VOICE , 6
 .byte   VOL , 90*song04_mvl/mxv
 .byte   PAN , c_v+0
 .byte   W68
 .byte   W01
 .byte   N03 ,En4 ,v080
 .byte   W03
 .byte   N06 ,Fn4 ,v100
 .byte   W12
@ 001   ----------------------------------------
 .byte   Gn4
 .byte   W12
 .byte   W68
 .byte   W01
 .byte   N03 ,Fs4 ,v080
 .byte   W03
 .byte   N24 ,Gn4 ,v100
 .byte   W24
@ 002   ----------------------------------------
 .byte   W96
 .byte   FINE

@**************** Track 7 (Midi-Chn.6) ****************@

song04_007:
@ 000   ----------------------------------------
 .byte   KEYSH , song04_key+0
 .byte   W12
 .byte   VOICE , 0
 .byte   VOL , 90*song04_mvl/mxv
 .byte   N06 ,En1 ,v096
 .byte   N24 ,Bn2 ,v100
 .byte   W18
 .byte   N06 ,En1 ,v096
 .byte   W06
 .byte   En1 ,v120
 .byte   W12
 .byte   N03 ,En1 ,v100
 .byte   W03
 .byte   N03
 .byte   W03
 .byte   N06
 .byte   W06
 .byte   N12
 .byte   W12
 .byte   N12
 .byte   W12
 .byte   N03 ,En1 ,v084
 .byte   W03
 .byte   En1 ,v080
 .byte   W03
 .byte   N03
 .byte   W03
 .byte   N03
 .byte   W03
@ 001   ----------------------------------------
 .byte   N03
 .byte   W03
 .byte   N03
 .byte   W03
 .byte   N03
 .byte   W03
 .byte   N03
 .byte   W03
 .byte   N06 ,En1 ,v096
 .byte   N24 ,Bn2 ,v100
 .byte   W18
 .byte   N06 ,En1 ,v096
 .byte   W06
 .byte   En1 ,v120
 .byte   W12
 .byte   N03 ,En1 ,v100
 .byte   W03
 .byte   N03
 .byte   W03
 .byte   N06
 .byte   W06
 .byte   N12
 .byte   W12
 .byte   N12
 .byte   W12
 .byte   N03 ,En1 ,v084
 .byte   W03
 .byte   En1 ,v080
 .byte   W03
 .byte   N03
 .byte   W03
 .byte   N03
 .byte   W03
@ 002   ----------------------------------------
 .byte   N03
 .byte   W03
 .byte   N03
 .byte   W03
 .byte   N03
 .byte   W03
 .byte   N03
 .byte   W03
 .byte   N06 ,En1 ,v096
 .byte   N24 ,Bn2 ,v100
 .byte   W18
 .byte   N06 ,En1 ,v096
 .byte   W06
 .byte   N06
 .byte   W12
 .byte   N06
 .byte   W06
 .byte   N06
 .byte   W06
 .byte   En1 ,v120
 .byte   N24 ,Bn2 ,v100
 .byte   W48
 .byte   FINE

@******************************************************@
	.align	2

song04:
	.byte	7	@ NumTrks
	.byte	0	@ NumBlks
	.byte	song04_pri	@ Priority
	.byte	song04_rev	@ Reverb.
    
	.word	song04_grp
    
	.word	song04_001
	.word	song04_002
	.word	song04_003
	.word	song04_004
	.word	song04_005
	.word	song04_006
	.word	song04_007

	.end
