.thumb

.macro blh to, reg=r3
  ldr \reg, =\to
  mov lr, \reg
  .short 0xf800
.endm

.equ PickupID, SkillTester+4
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
@ mov r1, #0xC0 @skill flag @it's a passive, regardless of skills
@ lsl r1, #8 @0xC000
mov r1, #2 @miss
tst r0, r1
bne End

@make sure this is the actual attacker kthx
ldr r0, =0x203A4EC
cmp r0, r4
bne End

mov		r0,r4
ldr		r1,PickupID
ldr		r3,SkillTester
mov		r14,r3
.short	0xF800
cmp		r0,#0
beq		End
ldrb	r0,[r4,#0x19]	@luck% proc rate
@ mov		r0,#100			@for testing
mov		r1,r4
blh		d100Result
cmp		r0,#1
bne		End				@didn't proc

@check damage >= currhp
ldrb r1, [r5,#0x13] @current hp
mov r0, #4
ldrsh r0, [r7, r0]
cmp r0, r1
blt End @not gonna die

@and set the 'drop last item' byte
mov  r0, #0x10      @drop last item
strb r0, [r5, #0xD] @last item byte

End:
pop {r4-r7}
pop {r15}

.align
.ltorg
SkillTester:
@POIN SkillTester
@WORD PickupID
