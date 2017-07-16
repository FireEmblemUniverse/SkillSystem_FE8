.thumb
.macro blh to, reg=r3
  ldr \reg, =\to
  mov lr, \reg
  .short 0xf800
.endm
.equ AdeptID, SkillTester+4
.equ d100Result, 0x802a52c
.equ recurse_round, 0x802b83c

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

@check for Adept proc
ldr r0, SkillTester
mov lr, r0
mov r0, r4 @attacker data
ldr r1, AdeptID
.short 0xf800
cmp r0, #0
beq End
@if user has Adept, check for proc rate

ldrb r0, [r4, #0x15] @speed stat as activation rate
mov r1, r4 @skill user
blh d100Result
cmp r0, #1
bne End 

@if we proc, set the brave effect flag for the NEXT hit
ldrb r1, AdeptID @first mark Adept active
strb r1, [r6,#4]

add     r6, #8 @double width battle buffer   
mov     r0, #0x40
lsl     r0, #8  
str     r0,[r6]                @ 0802B43A 6018  
ldrb r0, AdeptID
strb r0, [r6,#4] @save the skill ID at byte #4

@now add the number of rounds - 
mov r1, #0x38
mov r2, sp
ldr r0, [r2,r1] @location of number of rounds on the stack... hopefully
add r0, #1
str r0, [r2,r1]

End:
pop {r4-r7}
pop {r15}

.align
.ltorg
SkillTester:
@POIN SkillTester
@WORD AdeptID
