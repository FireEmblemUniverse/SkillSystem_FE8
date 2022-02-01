.thumb
.macro blh to, reg=r3
  ldr \reg, =\to
  mov lr, \reg
  .short 0xf800
.endm
.equ AetherID, SkillTester+4
.equ LiquidOozeID, AetherID+4
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
@mov r1, #0xC0 @skill flag
@lsl r1, #8 @0xC000
mov r1, #2 @miss
tst r0, r1
bne End
@if another skill already activated, don't do anything

@check if we're already in aether
ldrb r0, [r2, #4] @active skill
@make sure no other skill is active
ldr r1, AetherID
cmp r0, r1
bne End

@check if first attack (skill activated and hp draining)
ldr     r2,[r6]    
lsl     r1,r2,#0xD                @ 0802B42C 0351     
lsr     r1,r1,#0xD                @ 0802B42E 0B49     
mov     r0, #0x41
lsl     r0, #8           @0x4100, attacker skill activated and hp draining
and     r1, r0
cmp	r1, r0
bne	End

@check liquid ooze
mov	r0,r5
ldr	r1,LiquidOozeID
ldr	r3,SkillTester
mov	lr,r3
.short	0xF800
mov	  r1, #4
ldsh	r1, [r7, r1]    @ damage
ldrb  r2, [r5, #0x13] @ defender's curr hp
cmp   r1, r2
ble   defLives        @ Damage taken / HP healed by attacker.
  mov   r1, r2        @ can't exceed damage dealt to defender.
defLives:
cmp	r0,#0
beq	noOoze
  neg   r1, r1
noOoze:
mov   r2, #0x5
ldsb	r2,[r6,r2]	@hp change
add   r2, r1
strb	r2,[r6,#5]	@hp change


End:
pop {r4-r7}
pop {r15}

.align
.ltorg
SkillTester:
@POIN SkillTester
@WORD AetherID
@WORD LiquidOozeID
