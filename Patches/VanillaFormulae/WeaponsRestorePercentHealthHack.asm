.thumb 

.macro blh to, reg=r3
  ldr \reg, =\to
  mov lr, \reg
  .short 0xf800
.endm



.global WeaponsRestorePercentHealthHack
.type WeaponsRestorePercentHealthHack, %function 

WeaponsRestorePercentHealthHack:
push {r4-r7,lr}
mov r4, r0 @attacker
mov r5, r1 @defender
mov r6, r2 @battle buffer
mov r7, r3 @battle data



@ldr     r0,[r2]           @r0 = battle buffer                @ 0802B40A 6800     
@lsl     r0,r0,#0xD                @ 0802B40C 0340     
@lsr     r0,r0,#0xD        @Without damage data                @ 0802B40E 0B40     
@mov r1, #0xC0 @skill flag
@lsl r1, #8 @0xC000
@add r1, #0x82 @miss OR devil
@tst r0, r1
@bne End
@if another skill already activated, don't do anything


@check liquid ooze
mov	r0,r5
ldr	r1,=LiquidOozeID
lsl r1, #24 
lsr r1, #24 
blh SkillTester 
cmp	r0,#0
beq	noOoze

@take damage from healing
mov r0, #4
ldrsh r0, [r7, r0]
cmp r0, #0
ble End @don't do anything
mov r1, #5
ldsb r1, [r6, r1] @existing hp change
sub	r0,r1,r0
cmp	r0,#0x7F
blo	checkCap
neg	r1,r0
mov r2, #0x13
ldrsb r2, [r4,r2] @curr hp
cmp	r1,r2
blo	NoCap
mov	r0,r2
sub	r0,#1
neg	r0,r0
b	NoCap

noOoze:
@and recalculate damage with healing
mov r0, #4
ldrsh r0, [r7, r0]
cmp r0, #0
ble End @don't do anything
mov r1, #5
ldsb r1, [r6, r1] @existing hp change
add r0, r1

checkCap:
@now r0 is total HP change - is this higher than the max HP?
mov r2, #0x13
ldrsb r2, [r4,r2] @curr hp
mov r1, #0x12
ldrsb r1, [r4,r1] @max hp
sub r1, r2 @damage taken
cmp r1, r0
bge NoCap
  @if hp will cap, set r0 to damage taken
  mov r0, r1
NoCap:
strb r0, [r6, #5] @write hp change
mov r2, #0x13
ldrsb r2, [r4,r2] @curr hp
add r0, r2 @new hp
strb r0, [r4, #0x13]

End:
pop {r4-r7}
pop {r15}

.align
.ltorg
@SkillTester:




