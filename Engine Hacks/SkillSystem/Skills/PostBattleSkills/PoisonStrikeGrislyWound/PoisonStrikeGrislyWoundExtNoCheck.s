
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
ldrb r0, [ r4, #0x12 ] @ Max HP
lsl r0, r0, #1 @ Multiply by 2
mov r1, #10
blh #0x080D18FC, r3 @ r0 has 20% of the max HP
ldrb r1, [ r4, #0x13 ]
cmp r0, r1
bge SetAttacker1HP
sub r1, r0
strb r1, [ r4, #0x13 ]
b PlayAttackerSound
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
ldrb r0, [ r5, #0x12 ] @ Max HP
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
