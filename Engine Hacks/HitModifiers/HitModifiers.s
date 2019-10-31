@requisition 3 global flags
@flag 0xEC: 1RN mode
@flag 0xED: Fates RN mode
@flag 0xEE: Nice mode (braise stan)
@make the flags EA literals too pls

@hook into the hit 2RN function; Roll2RNIfBattleStarted 0x802A558


.thumb
.equ gBattleStats,0x203A4D4
.equ Roll2RN,0x8000CB8
.equ Roll1RN,0x8000CA0
.equ CheckGlobalEventId,0x8083d6c
.equ FatesRNFlag,RNFlag+4
.equ NiceFlag,FatesRNFlag+4
.equ NextRN_100,0x8000C64
.equ Thumb_Division_Func,0x80D18FC
.macro blh to, reg=r3
  ldr \reg, =\to
  mov lr, \reg
  .short 0xf800
.endm


push {r4-r7,r14}

mov r3,r0
mov r2,r1
mov r7,r3
ldr r0,=gBattleStats
ldrh r1,[r0]
mov r0,#2
and r0,r1
cmp r0,#0
bne SkipCheck

@here's where we do our part
ldr r0,RNFlag
blh CheckGlobalEventId,r1
cmp r0,#1
bne FlagCheck2
mov r0,r7
blh Roll1RN,r1
b CheckEnd

FlagCheck2:
@and the other check
ldr r0,FatesRNFlag
blh CheckGlobalEventId,r1
cmp r0,#1
bne NoFlagsSet
@now do fates rn stuff here
cmp r7,#50 @if hitrate (r7) is 50 or less, roll 1RN
bgt Over50
@roll 1RN and return that
mov r0,r7
blh Roll1RN,r1
b CheckEnd

Over50:
@first, roll 1RN twice and save the numbers to r4 and r5
blh NextRN_100,r0
mov r5,r0
blh NextRN_100,r0
mov r4,r0
@now, plug it into the function (3A+B)/4
mov r0,#3
mul r0,r4
add r0,r5 
mov r1,#4
blh Thumb_Division_Func,r2 @divide r0 by 4
cmp r0,r7
bgt RetFalse
mov r0,#1
b CheckEnd
RetFalse:
mov r0,#0
b CheckEnd


NoFlagsSet: @if no flags, do 2RN as normal
mov r0,r3
blh Roll2RN,r1
b CheckEnd

SkipCheck:
mov r0,r2
CheckEnd: @at this point, r0=whether or not we hit
@here we check for nice mode
mov r6,r0
ldr r0,NiceFlag
blh CheckGlobalEventId,r1
cmp r0,#1
bne NotNice
@do nice mode here 
mov r0,r6
cmp r7,#69
bne GoBack
mov r0,#100
b GoBack

NotNice:
mov r0,r6
GoBack:
pop {r4-r7}
pop {r1}
bx r1

.ltorg
.align
RNFlag:
@WORD 0xEC
@WORD 0xED
@WORD 0xEE
