@hook at 802c088 with jumptohack
.thumb
.equ SealSkillList, SkillTester+4
.equ ExtraDataLocation, SealSkillList+4
.equ DebuffAmount, 6

mov r1,r5
ldr r3, =0x802c1ec
mov lr, r3
.short 0xf800
cmp r6, #0
beq loc_2c0a4

mov r0, r6
mov r1, r4
ldr r3, =0x802c1ec
mov lr, r3
.short 0xf800
b ApplySeals

loc_2c0a4:
ldr r0, =0x802c984
mov lr, r0
mov r0, r4
.short 0xf800

ApplySeals:
@ @just gonna... zero out the attack command flag here...
@ @as a safety measure
@ ldr r0, =0x203f101
@ mov r1, #0
@ strb r1, [r0]

ldr r4, SealSkillList
mov r5, #0
SealLoop:
  ldrb r1, [r4,r5] @nth skill
  mov r0, r6 @defender
  ldr r2, SkillTester
  mov lr, r2
  .short 0xf800
  cmp r0, #0
  beq OtherSide
    @if defender has a seal skill, apply to the attacker.
    mov r0, r7
    mov r1, #DebuffAmount
    mov r2, r5 @nth seal
    bl ApplyDebuff
  OtherSide:
  ldrb r1, [r4,r5] @nth skill
  mov r0, r7 @attacker
  ldr r2, SkillTester
  mov lr, r2
  .short 0xf800
  cmp r0, #0
  beq NextLoop
    @if attacker has a seal skill, apply to the defender
    mov r0, r6
    mov r1, #DebuffAmount
    mov r2, r5
    bl ApplyDebuff
  NextLoop:
  add r5, #1
  cmp r5, #5
  ble SealLoop

End:
pop {r4-r7}
pop {r0}
bx r0
.ltorg

ApplyDebuff:
@r0 is unit data, r1 is amount, r2 is nth stat
push {r4-r7, lr}
mov r4, r0
mov r5, r1
mov r6, r2
ldr r7, ExtraDataLocation
ldrb r0, [r4, #0xB]
lsl r0, #0x3        @8 bytes per unit
add r7, r0          @r7 = &extra data

@now r7 has the location of the extra data, load up the appropriate debuff
ldr r0, [r7]
lsl r0, #8
lsr r0, #8 @strip the top byte
lsl r1, r6, #2 @r1 = n*4 (4 bits per stat)
lsr r0, r1
mov r2, #0xf
and r0, r2 @isolate the current debuff
@ add r0, r5 @add the debuff amount
mov r0, r5 @otherwise it will stack with itself
cmp r0, #0xF
ble NotCapped
  mov r0, #0xF @max it out at 0xf
NotCapped:
@now i need to zero out the debuff for that particular stat
@r2 is 0xf
ldr r3, [r7]
lsl r2, r1
mvn r2, r2 @0xffff0f or whatever
and r3, r2 @stripped the thing
lsl r0, r1
orr r3, r0
str r3, [r7]
pop {r4-r7,pc}

.align
.ltorg
SkillTester:
@POIN SkillTester
@POIN SealSkillList (str/skl/spd/def/res/luk)
@WORD ExtraDataLocation
