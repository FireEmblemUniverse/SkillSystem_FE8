
.thumb

.macro blh to, reg
  ldr \reg, =\to
  mov lr, \reg
  .short 0xf800
.endm

.global PSGWInjureAttacker
.type PSGWInjureAttacker, %function
PSGWInjureAttacker: @ r4 = attacker's characterr struct, @ r5 = defender's character struct, 6 = attack struct, r7 = defense struct
push { lr }
ldrb r1, [ r4, #0x13 ]
cmp r1, #0x00
beq EndInjureAttacker @ Leave if the attacker is already dead.
@ I also need to check if the defender did no damage.
mov r2, #0x5A
ldrh r1, [ r7, r2 ] @ Get attack
cmp r1, #0xFF
beq EndInjureAttacker @ If attack is 0xFF, the defender cannot attack.
mov r2, #0x5C
ldrh r0, [ r6, r2 ] @ Get defense
cmp r0, r1
bge EndInjureAttacker @ Leave if the defender isn't doing damage. The defense is greater than the attack
ldrb r0, [ r4, #0x12 ] @ Max HP
lsl r0, r0, #1 @ Multiply by 2
mov r1, #10
blh #0x080D18FC, r3 @ r0 has 20% of the max HP
ldrb r1, [ r4, #0x13 ]
cmp r0, r1
bge SetAttacker1HP
sub r1, r0
strb r1, [ r4, #0x13 ]
b PlayDefenderSound
SetAttacker1HP:
mov r1, #0x01
strb r1, [ r4, #0x13 ]
PlayAttackerSound:
ldr r0, =PSGWEvent
mov r1, #0x01
blh 0x0800D07C, r2 @ Call event engine.
EndInjureAttacker:
pop { r0 }
bx r0

.global PSGWInjureDefender
.type PSGWInjureDefender, %function
PSGWInjureDefender: @ r4 = attacker's characterr struct, @ r5 = defender's character struct, 6 = attack struct, r7 = defense struct
push { lr }
ldrb r1, [ r5, #0x13 ]
cmp r1, #0x00
beq EndInjureDefender @ Leave if the defender is already dead.
@ I also need to check if the attacker did no damage.
mov r2, #0x5A
ldrh r1, [ r6, r2 ] @ Get attack
cmp r1, #0xFF
beq EndInjureDefender @ If the attacker cannot attack... wait what? Whatever. I'll check this for consistency's sake.
mov r2, #0x5C
ldrh r0, [ r7, r2 ] @ Get defense
cmp r0, r1
bge EndInjureDefender @ Leave if the attacker isn't doing damage.
ldrb r0, [ r5, #0x12 ] @ Max HP of defender
lsl r0, r0, #1 @ Multiply by 2
mov r1, #10
blh #0x080D18FC, r3 @ r0 has 20% of the max HP
ldrb r1, [ r5, #0x13 ]
cmp r0, r1
bge SetDefender1HP
sub r1, r0
strb r1, [ r5, #0x13 ]
b PlayDefenderSound
SetDefender1HP:
mov r1, #0x01
strb r1, [ r5, #0x13 ]
PlayDefenderSound:
ldr r0, =PSGWEvent
mov r1, #0x01
blh 0x0800D07C, r2 @ Call event engine.
EndInjureDefender:
pop { r0 }
bx r0
