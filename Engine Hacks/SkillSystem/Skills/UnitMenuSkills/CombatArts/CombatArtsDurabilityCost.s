.thumb
.align

.global CombatArtsDurabilityCost
.type CombatArtsDurabilityCost, %function



CombatArtsDurabilityCost:
push {r14}

@table indexed by attack type containing extra durability cost
ldr r0,=CombatArtCostTable
ldr r1,=#0x0203F101 @location of attack type byte 
ldrb r1,[r1]
add r0,r1
ldrb r0,[r0] @r0 = amount to subtract
lsl r0,r0,#8

@subtract from post-battle durability
mov r2,r4
add r2,#0x48
ldrh r1,[r2]
mov r3,#0xFF
and r1,r3
and r1,r0
strh r1,[r2]

pop {r0}
bx r0

.ltorg
.align
