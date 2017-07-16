.thumb
.macro blh to, reg=r3
  ldr \reg, =\to
  mov lr, \reg
  .short 0xf800
.endm
.equ MercyFlag, 0x203f101
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
add r1, #2 @miss
tst r0, r1
bne End

@ @check defender's hp >50%
@ ldrb r0, [r5,#0x12] @max hp
@ ldrb r1, [r5,#0x13] @current hp
@ lsr r0, #1 @max/2
@ cmp r1, r0
@ blt End

@check damage >= currhp
ldrb r1, [r5,#0x13] @current hp
mov r0, #4
ldrsh r0, [r7, r0]
cmp r0, r1
blt End @not gonna die

@check for Mercy
ldr r0, =MercyFlag
ldrb r0, [r0]
cmp r0, #4
bne End

@and set damage to currhp-1
ldrb r0, [r5, #0x13] @currhp
sub r0, #1
strh r0, [r7, #4] @final damage

End:
pop {r4-r7}
pop {r15}

.align
.ltorg

