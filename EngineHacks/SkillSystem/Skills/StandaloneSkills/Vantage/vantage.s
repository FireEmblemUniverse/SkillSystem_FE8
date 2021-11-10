@ vantage replace 802af7c
.equ VantageID, SkillTester+4
.equ VantagePlusID, VantageID+4
.thumb
push {r4-r7,r14}
ldr r4, =0x203a4ec @atr
ldr r5, =0x203a56c @dfr
mov r6, r0 @place to store attacker
mov r7, r1 @place to store defender
@check for Vantage, Vantage+ 
ldr r0, SkillTester
mov lr, r0
mov r0, r5 @defender data
ldr r1, VantagePlusID
.short 0xF800
cmp r0, #0
bne VantagePlus

ldr r0, SkillTester
mov lr, r0
mov r0, r5 @defender data
ldr r1, VantageID
.short 0xf800
cmp r0, #0
beq Normal

@if vantage, check hp/2
mov r2, #0x12
ldsb r2, [r5, r2] @defender max hp
lsr r2, #1 @halve it
mov r3, #0x13
ldsb r3, [r5,r3] @currhp
cmp r3, r2
bgt Normal
@swap them
eor r4,r5
eor r5,r4
eor r4,r5
b Normal

@if showing animation
@ ldr     r0,=0x802b444    @pointer to the current round
@ ldr     r0, [r0]          @current round pointer (usually 203a608)
@ ldr     r3, [r0] @203aac0 + (8*round number)

@ ldr     r2,[r3]    
@ lsl     r1,r2,#0xD                @ 0802B42C 0351     
@ lsr     r1,r1,#0xD                @ 0802B42E 0B49     
@ mov     r0, #0x40
@ lsl     r0, #8           @0x4100, attacker skill activated
@ orr     r1, r0
@ ldr     r0,=#0xFFF80000                @ 0802B434 4804     
@ and     r0,r2                @ 0802B436 4010     
@ orr     r0,r1                @ 0802B438 4308     
@ str     r0,[r3]                @ 0802B43A 6018  

@ ldrb  r0, VantageID
@ strb  r0, [r3,#4] 

VantagePlus:
eor r4,r5
eor r5,r4
eor r4,r5
mov r1, #0x66 @crit
mov r0, #0
strh r0, [r4,r1]
@mov r1, #0x68 @crit avoid
@mov r0, #0
@strh r0, [r4,r1]
mov r1, #0x6A @battle crit
mov r0, #0
strh r0, [r4,r1]

Normal:
str r4, [r6]
str r5, [r7]

pop {r4-r7,r15}

.align
.ltorg
SkillTester:
@POIN SkillTester
@WORD VantageID
@WORD VatnagePlusID
