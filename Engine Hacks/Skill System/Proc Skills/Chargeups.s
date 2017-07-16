.thumb
.macro blh to, reg=r3
  ldr \reg, =\to
  mov lr, \reg
  .short 0xf800
.endm
.equ d100Result, 0x802a52c
@ r0 is attacker, r1 is defender, r2 is current buffer, r3 is battle data
push {r4-r7,lr}


ldrb r4,[r3]
cmp r4,#0x1
bne End

mov r4,#0x47
ldrb r5,[r0,r4]
cmp r5,#0x10
ble DefCheck
sub r5,#0x1
strb r5,[r0,r4]

DefCheck:
ldrb r5,[r1,r4]
cmp r5,#0x10
ble End
sub r5,#0x1
strb r5,[r1,r4]

End:
pop {r4-r7}
pop {r15}

.align
.ltorg
SkillTester:
@POIN SkillTester
@WORD LunaID
