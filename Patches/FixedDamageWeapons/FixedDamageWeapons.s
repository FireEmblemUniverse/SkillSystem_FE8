.thumb
.align

.global FixedDamageWeapons
.type FixedDamageWeapons, %function
FixedDamageWeapons:

push {r4-r7,r14}

mov r4,r0 @attacker
mov r5,r1 @defender

@check attacker weapon's item ID
mov r0,r4
add r0,#0x4A
ldrh r0,[r0]
mov r1,#0xFF
and r0,r1 @r0 = item ID

@load list of fixed damage weapon item IDs
ldr r3,=FixedDamageWeaponList

LoopStart:
ldrb r1,[r3]
cmp r1,#0
beq GoBack
cmp r1,r0
beq LoopEnd
add r3,#1
b LoopStart

LoopEnd: @now we find the might of the weapon whose ID is in r0
mov r1,#0x24
mul r0,r1
ldr r1,=ItemTable
add r1,r0
ldrb r0,[r1,#0x15] @r0 = item might

@now we set the might as our attack value
mov r1,r4
add r1,#0x5A
strh r0,[r1]

@put this at the end of the pre battle calc loop

GoBack:
pop {r4-r7}
pop {r0}
bx r0

.ltorg
.align

