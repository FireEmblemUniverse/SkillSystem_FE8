.macro blh to, reg=r3
  ldr \reg, =\to
  mov lr, \reg
  .short 0xf800
.endm
.thumb
.equ LadyBladeID, SkillTester+4

push {r4-r7, lr}
mov r4, r0 @atkr
mov r5, r1 @dfdr

@has LadyBlade
ldr r0, SkillTester
mov lr, r0
mov r0, r4 @attacker data
ldr r1, LadyBladeID
.short 0xf800
cmp r0, #0
beq End

@check that the attacker is female, if not, jump to end
ldr r0, [r4] @char
ldr r0, [r0, #0x28] @char abilities
ldr r1, [r4,#4] @class
ldr r1, [r1,#0x28] @class abilities
orr r0, r1
mov r1, #0x40
lsl r1, #8 @0x4000 IsFemale
tst r0, r1
beq End @skip if male

@grab the might of the equipped weapon into r0 and save it in r3
mov r0, #0x4a 
ldrh r0, [r4, r0] @ item 
blh 0x80175dc
mov r3, r0

@add damage equal to weapon might
mov r1, #0x5a
ldrh r0, [r4, r1] @atk
add r0, r3
strh r0, [r4,r1]

End:
pop {r4-r7, r15}
.align
.ltorg
SkillTester:
@Poin SkillTester
@WORD LadyBladeID

