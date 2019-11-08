@ aura skill tester
@ r0 is unit
@ r1 is skill to check (0 is always true, ff is always false)
@ r2 is allegiance setting: 0 = same team, 1 = are allies, 2 = different team, 3 - are enemies, 4 - all units
@ 2033f3c contains 'active' unit

.thumb
.macro blh to, reg=r3
  ldr \reg, =\to
  mov lr, \reg
  .short 0xf800
.endm

push {r4-r7,lr}
mov r4, r0
mov r5, r1
mov r6, r2
@load correct allegiance routine
cmp r2, #4
beq AllCheck
cmp r2, #3
bgt ret_false
mov r0, #1
tst r2, r0
beq TradeCheck @1 bit not set = can/cannot_trade
ldr r3, =0x8024d8c @return 1 if allies/npcs
b GotAllegRoutine
TradeCheck:
ldr r3, =0x8024da4 @return 1 if same team
b GotAllegRoutine

AllCheck:
ldr r3, =0x802c0b0 @always return 1

GotAllegRoutine:
mov lr, r3
ldr r0, =0x2033f3c
ldr r0, [r0]
ldrb r0, [r0, #0xb] @deployment number of main unit
lsl r0, #0x18
asr r0, #0x18
mov r1, #0xb
ldsb r1, [r4, r1] @deployment number of unit being checked
mov r7, r1
.short 0xf800 @check allegiance
@r0 is 0 or 1
mov r1, #2
tst r6, r1
beq NoInvert @if bit 2 not set, invert
neg r0, r0 @0 becomes 0, 1 becomes -1
add r0, #1 @0 becomes 0, 1 becomes 0
NoInvert:
@if r0 = 1 then the allegiance is correct, now check for the skill.
cmp r0, #0
beq ret_false

mov r0, r4 @unit
mov r1, r5 @skill
ldr r3, SkillTester
mov lr, r3
.short 0xf800
@now r0 is 0 or 1
cmp r0, #1
bne ret_false
@if true, we need to add it to the list.
mov r0, r7 @otherwise return the deployment number
b End

ret_false:
mov r0, #0

End:
pop {r4-r7}
pop {r1}
bx r1

.ltorg
SkillTester:
@POIN SkillTester
