.thumb
.macro blh to, reg=r3
  ldr \reg, =\to
  mov lr, \reg
  .short 0xf800
.endm
.equ EclipseID, SkillTester+4
.equ d100Result, 0x802a52c

@ r0 is attacker, r1 is defender, r2 is current buffer, r3 is battle data
push {r4-r7,lr}
mov r4, r0 @attacker
mov r5, r1 @defender
mov r6, r2 @battle buffer
mov r7, r3 @battle data
ldr     r0,[r2]           @r0 = battle buffer                @ 0802B40A 6800     
lsl     r0,r0,#0xD                @ 0802B40C 0340     
lsr     r0,r0,#0xD        @Without damage data                @ 0802B40E 0B40     
mov r1, #0xC0 @skill flag
lsl r1, #8 @0xC000
add r1, #2 @miss @@@@OR BRAVE??????
tst r0, r1
bne End
@if another skill already activated, don't do anything

@check if we're already in astra
ldrb r0, [r2, #4] @active skill
@make sure no other skill is active
cmp r0, #0
bne End

@get enemy HP after battle and current damage dealt and see if we'll kill anyhow
mov r0,r5
add r0,#0x72
ldrb r0,[r0]
ldrb r1,[r7,#4]
cmp r0,r1
ble End


@check for Eclipse proc
ldr r0, SkillTester
mov lr, r0
mov r0, r4 @attacker data
ldr r1, EclipseID
.short 0xf800
cmp r0, #0
beq End
@if user has Eclipse, check for proc rate

ldrb r0, [r4, #0x16] @speed stat as activation rate
mov r1, r4 @skill user
blh d100Result
cmp r0, #1
bne End 

ldrb r1, EclipseID @first mark Eclipse active
strb r1, [r6,#4]

@if we proc, get enemy HP, subtract 1, and set as damage dealt 
mov r0,r5
add r0,#0x72
ldrb r0,[r0]
sub r0,#1
strb r0,[r7,#4]


End:
pop {r4-r7}
pop {r15}

.align
.ltorg
SkillTester:
@POIN SkillTester
@WORD EclipseID
