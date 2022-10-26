.thumb
.align

.global WeaponsThatAlwaysDouble
.type WeaponsThatAlwaysDouble, %function

WeaponsThatAlwaysDouble:
push {r4-r5, lr}
mov r4,r0 @battle struct 
mov r5, r1 @ battle struct #2 

mov r0, #0x48 
add r0, r4 
ldrb r0, [r0] @ item id in battle 
ldr r3, =WeaponsThatAlwaysDoubleList
sub r3, #1 
Loop: 
add r3, #1 
ldrb r1, [r3] 
cmp r1, #0 
beq GoBack
cmp r0, r1 
beq RetTrue 
b Loop 
RetTrue:
@get attacker's AS
mov r5, r2 
add r2,#0x5E
ldrh r2,[r2]
@add 5
ldr r3, =DoublingThresholdLink
ldrb r3, [r3] 
add r2,r3 
@store as defender's AS
mov r3, r4 
add r3,#0x5E
strh r2,[r3] 

GoBack:
pop {r4-r5}
pop {r0}
bx r0
.ltorg

