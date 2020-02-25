.thumb
.align


.global ReverseWeaponTriangle
.type ReverseWeaponTriangle, %function
ReverseWeaponTriangle:

push {r4-r5,r14}
mov r4,r0 @attacker
mov r5,r1 @defender

@load equipped item's weapon ability word
ldr r0,[r4,#0x4C]
mov r1,#0x80
lsl r1,#1
and r0,r1
cmp r0,#0
beq ReaverEffectBitSet
ldr r0,[r5,#0x4C]
and r0,r1
cmp r0,#0
bne GoBack @do nothing if we both have it set

ReaverEffectBitSet: @if reaver weapon, we invert our WTA stats (but don't double them!)
mov r0,r4
add r0,#0x53
ldrb r1,[r0]
neg r1,r1
strb r1,[r0]
add r0,#1
ldrb r1,[r0]
neg r1,r1
strb r1,[r0]

@also do it for defender
mov r0,r5
add r0,#0x53
ldrb r1,[r0]
neg r1,r1
strb r1,[r0]
add r0,#1
ldrb r1,[r0]
neg r1,r1
strb r1,[r0]

GoBack:
pop {r4-r5}
pop {r0}
pop {r0}
bx r0

.ltorg
.align



.global DoubleWeaponTriangle
.type DoubleWeaponTriangle, %function
DoubleWeaponTriangle:
@r0=attacker
@r1=defender

push {r4-r5,r14}
mov r4,r0 @attacker
mov r5,r1 @defender

@load equipped item's weapon ability word
ldr r0,[r4,#0x4C]
ldr r1,=0x00400000
and r0,r1
cmp r0,#0
bne DoubleWTAEffectBitSet
@check if defender has double WTA weapon too
ldr r0,[r5,#0x4C]
ldr r1,=0x00400000
and r0,r1
cmp r0,#0
beq Return @if they do, don't double WTA effect

@otherwise, we double just our effect (function is run twice)
DoubleWTAEffectBitSet: 
mov r0,r4
add r0,#0x53
ldrb r1,[r0]
lsl r1,#1
strb r1,[r0]
add r0,#1
ldrb r1,[r0]
lsl r1,#1
strb r1,[r0]

mov r0,r5
add r0,#0x53
ldrb r1,[r0]
lsl r1,#1
strb r1,[r0]
add r0,#1
ldrb r1,[r0]
lsl r1,#1
strb r1,[r0]



Return:
pop {r4-r5}
pop {r0}
bx r0


.ltorg
.align
