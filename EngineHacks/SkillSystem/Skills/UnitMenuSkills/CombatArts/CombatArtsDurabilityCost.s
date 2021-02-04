.thumb
.align

.global Proc_CombatArtCost
.type Proc_CombatArtCost, %function


Proc_CombatArtCost:
push {r4-r7,r14}
mov r4, r0 @attacker
mov r5, r1 @defender
mov r6, r2 @battle buffer
mov r7, r3 @battle data

@is our equipped weapon unbreakable?
mov r0,r4
add r0,#0x4C
ldr r0,[r0]
mov r1,#0x8
and r0,r1
cmp r0,#0
bne GoBack @if so, don't do durability loss

@table indexed by attack type containing extra durability cost
ldr r0,=CombatArtCostTable
ldr r1,=#0x0203F101 @location of attack type byte 
ldrb r1,[r1]
add r0,r1
ldrb r0,[r0] @r0 = amount to subtract
lsl r0,r0,#8

@subtract from post-battle durability
add r4,#0x48
ldrh r1,[r4]
@can't just blindly subtract in case it'll go below 0
@let's split the short in half

mov r2,#0xFF
lsl r2,r2,#8
and r2,r1
mov r3,#0xFF
and r1,r3

@now we can subtract from the durability and floor at 0
sub r2,r0
cmp r2,#0
bgt NotNegative 
mov r2,#0
mov r1,#0

NotNegative:
@recombine them

orr r1,r2
strh r1,[r4]

GoBack:
pop {r4-r7}
pop {r0}
bx r0


.ltorg
.align
