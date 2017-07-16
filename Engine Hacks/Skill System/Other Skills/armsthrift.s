@hook at 802c1f4

.thumb
.macro blh to, reg=r3
  ldr \reg, =\to
  mov lr, \reg
  .short 0xf800
.endm
.equ ArmsthriftID, SkillTester+4
.equ d100Result, 0x802a52c
.equ luckgetter, 0x8019298
@r4 is unit data

@check last action was attack
ldr r0, =0x203a958+0x11 @action taken
ldrb r0, [r0]
cmp r0, #2 @combat
bne Normal

@check for armsthrift skill
ldr r0, SkillTester
mov lr, r0
mov r0, r4 @attacker data
ldr r1, ArmsthriftID
.short 0xf800
cmp r0, #0
beq Normal
@if user has Armsthrift, check for proc rate
mov r0, r4
blh luckgetter
mov r1, r4 @skill user
blh d100Result
cmp r0, #1
bne Normal

@if armsthrift and item is a weapon, do nothing
pop {r4-r6}
pop {r0}
bx r0

Normal:
ldrb r0, [r5, #8]
strb r0, [r4, #8]
ldrb r0, [r5, #9]
strb r0, [r4, #9]
ldrb r0, [r5, #0x13]
strb r0, [r4, #0x13]
ldr r0, =0x802c1ff
bx r0

.ltorg
.align
SkillTester:
@poin SkillTester
@word AstraID
