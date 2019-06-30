
@r4 has attacker pointer in ram (actual character pointer, not attacker pointer)
@r5 has defender pointer in ram (actual character pointer, not defender pointer)
@r6 has action struct

.thumb

.macro blh to, reg
  ldr \reg, =\to
  mov lr, \reg
  .short 0xf800
.endm

.global PoisonStrike
.type PoisonStrike, %function @ r4 = attacker's character struct, r5 = defender's character struct
PoisonStrike: @ Deals damage equal to 20% of the enemy's HP after combat if this unit initiates battle.
push { r6, r7, lr }
ldr r0, =#0x0203A958
ldrb r0, [ r0, #0x11 ]
cmp r0, #0x02
bne End @ End if this isn't combat.
mov r0, r4
ldr r1, =PoisonStrikeIDLink
ldrb r1, [ r1 ]
blh SkillTester, r3
cmp r0, #0x00
beq End
ldr r6, =#0x0203A4EC @ Attack struct
ldr r7, =#0x0203A56C @ Defense struct
bl PSGWInjureDefender
b End

.global GrislyWound
.type GrislyWound, %function
GrislyWound: @ Same as Poison Strike, except unit doesn't have to initiate.
push { r6, r7, lr }
ldr r0, =#0x0203A958
ldrb r0, [ r0, #0x11 ]
cmp r0, #0x02
bne End @ End if this isn't combat.
mov r0, r4
ldr r1, =GrislyWoundIDLink
ldrb r1, [ r1 ]
blh SkillTester, r3
cmp r0, #0x00
beq CheckGrislyWoundDefender
ldr r6, =#0x0203A4EC @ Attack struct
ldr r7, =#0x0203A56C @ Defense struct
bl PSGWInjureDefender

CheckGrislyWoundDefender:
mov r0, r5
ldr r1, =GrislyWoundIDLink
ldrb r1, [ r1 ]
blh SkillTester, r3
cmp r0, #0x00
beq End
ldr r6, =#0x0203A4EC @ Attack struct
ldr r7, =#0x0203A56C @ Defense struct
bl PSGWInjureAttacker

End:
pop { r6, r7 }
pop { r0 }
bx r0

