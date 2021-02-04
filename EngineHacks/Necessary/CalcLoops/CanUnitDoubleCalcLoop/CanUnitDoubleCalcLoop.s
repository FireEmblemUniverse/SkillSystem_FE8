.thumb
.align

.global CanUnitDoubleCalcLoopFunc
.type CanUnitDoubleCalcLoopFunc, %function


.equ Get_Weapon_Effect, 0x8017724


CanUnitDoubleCalcLoopFunc:

@we need a good way to do this
@functions in the loop can either 
@A. set to always true
@B. set to always false
@C. keep the same as before

@they need passed attacker & defender
@the teq func for this liked to load the attacker & defender structs manually
@but they get passed in via the stack
@(pointers to via stack or them loaded into the stack?)

@seems to be pointers to via stack
@useful thing

@ldr r4,[r0] @r4 = attacker
@ldr r5,[r1] @r5 = defender
ldr r4,=#0x203A4EC @attacker struct
ldr r5,=#0x203A56C @defender struct
@keep the current true/false bool in r6

mov r6,r0
mov r7,r1
push {r6-r7}

@do standard "can you double" check
mov r3,#0x5E
ldsh r2,[r5,r3] @r2 = defender's AS
ldsh r3,[r4,r3] @r3 = attacker's AS
sub r1,r3,r2 @r1 = attacker's AS - defender's AS
cmp r1,#0
ble DoInverseCheck
@instead of returning from here, we will store whether it's true or false in r6

@cmp r1,#3
push {r2}
ldr r2,=DoublingThresholdLink
ldrb r2,[r2]
cmp r1,r2
pop {r2}
ble SetASFalse
b SetASTrue

DoInverseCheck:
sub r1,r2,r3
push {r2}
ldr r2,=DoublingThresholdLink
ldrb r2,[r2]
cmp r1,r2
pop {r2}
ble SetASFalse

SetASTrue: 
ldr r4,=#0x203A4EC @attacker struct
ldr r5,=#0x203A56C @defender struct
mov r0,r4
add r0,#0x5E
ldrh r0,[r0]
mov r1,r5
add r1,#0x5E
ldrh r1,[r1]
cmp r0,r1
blt SetASTrue_TargetDoubles
str r4,[r6]
str r5,[r7]
b SetASTrue_End
SetASTrue_TargetDoubles:
str r4,[r7]
str r5,[r6]
SetASTrue_End:
mov r6,#1
b PrepLoop

SetASFalse:
ldr r4,=#0x203A4EC @attacker struct
ldr r5,=#0x203A56C @defender struct
str r4,[r6]
str r5,[r7]
mov r6,#0

PrepLoop:
ldr r7,=CanUnitDoubleCalcLoop

LoopStart:
ldr r3,[r7]
cmp r3,#0
beq LoopExit

mov r14,r3
mov r0,r4
mov r1,r5
mov r2,r6
.short 0xF800

cmp r0,#0
beq UnitCannotDouble
cmp r0,#1
beq UnitCanDouble

add r7,#4
b LoopStart

LoopExit:
mov r0,r6
pop {r6-r7}
b GoBack

UnitCanDouble:
pop {r6-r7}
ldr r4,=#0x203A4EC @attacker struct
ldr r5,=#0x203A56C @defender struct
mov r0,r4
add r0,#0x5E
ldrh r0,[r0]
mov r1,r5
add r1,#0x5E
ldrh r1,[r1]
cmp r0,r1
blt UnitCanDouble_TargetDoubles
str r4,[r6]
str r5,[r7]
b UnitCanDouble_End
UnitCanDouble_TargetDoubles:
str r4,[r7]
str r5,[r6]
UnitCanDouble_End:
mov r0,#1
b GoBack

UnitCannotDouble:
pop {r6-r7}
mov r0,#0

GoBack:
pop {r4-r7}
pop {r1}
bx r1

.ltorg
.align








.global IsDefenderSnag
.type IsDefenderSnag, %function

IsDefenderSnag:
push {r4-r5}
mov r4,r0
mov r5,r1

mov r0,#0x5E
ldsh r0,[r5,r0] @r0 = defender's AS
cmp r2,#0xFA
bgt IsDefenderSnag_RetFalse

mov r0,#2 @2 = keep current result untouched
b IsDefenderSnag_GoBack

IsDefenderSnag_RetFalse:
mov r0,#0 @0 = force result to false

IsDefenderSnag_GoBack:
pop {r4-r5}
bx r14

.ltorg
.align





.global IsAttackerEclipsing
.type IsAttackerEclipsing, %function

IsAttackerEclipsing:
push {r4-r5,r14}
mov r4,r0 @r4 = attacker
mov r5,r1 @r5 = defender

mov r0,r4
add r0,#0x4A
ldrh r0,[r0]
ldr r1,=Get_Weapon_Effect
mov r14,r1
.short 0xF800
cmp r0,#3
beq IsAttackerEclipsing_RetFalse

mov r0,#2
b IsAttackerEclipsing_GoBack

IsAttackerEclipsing_RetFalse:
mov r0,#0

IsAttackerEclipsing_GoBack:
pop {r4-r5}
pop {r1}
bx r1

.ltorg
.align







.global IsAttackerUsingStone
.type IsAttackerUsingStone, %function

IsAttackerUsingStone:
push {r4-r5}
mov r4,r0 @r4 = attacker
mov r5,r1 @r5 = defender

mov r0,r4
add r0,#0x48
ldrb r0,[r0]
cmp r0,#0xB5 @Stone item ID
beq IsAttackerUsingStone_RetFalse

mov r0,#2
b IsAttackerUsingStone_GoBack

IsAttackerUsingStone_RetFalse:
mov r0,#0

IsAttackerUsingStone_GoBack:
pop {r4-r5}
bx r14

.ltorg
.align





.global IsAttackerWeaponUnableToDouble
.type IsAttackerWeaponUnableToDouble, %function

IsAttackerWeaponUnableToDouble:
push {r4-r5,r14}
mov r4,r0 @r4 = attacker
mov r5,r1 @r5 = defender

mov r0,r4
add r0,#0x4A
ldrh r0,[r0]
ldr r1,=Get_Weapon_Effect
mov r14,r1
.short 0xF800
cmp r0,#0xC
beq IsAttackerWeaponUnableToDouble_RetFalse

mov r0,#2
b IsAttackerWeaponUnableToDouble_GoBack

IsAttackerWeaponUnableToDouble_RetFalse:
mov r0,#0

IsAttackerWeaponUnableToDouble_GoBack:
pop {r4-r5}
pop {r1}
bx r1

.ltorg
.align
