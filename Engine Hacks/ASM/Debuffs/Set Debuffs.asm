.thumb
push {r0, lr}
@r5 = attacker
@r4 = defender
mov r0, r5
mov r1, r4
bl ApplyDebuffs
mov r0, r4
mov r1, r5
bl ApplyDebuffs
pop {r0}
@From original routine
lsl     r0,r0,#0x1
mov     r1,r4
add     r1,#0x1E
add     r0,r0,r1
add     r1,#0x2A
ldrh    r1,[r1]

pop {r2}
bx r2

.align
ApplyDebuffs:
@First apply own debuffs
push {r4-r7}
mov r4, r0          @r4 = one to update
mov r5, r1          @r5 = other

ldr r6, ExtraDataLocation
ldrb r0, [r4, #0xB]
lsl r0, #0x3        @8 bytes per unit
add r6, r0          @r6 = &extra data

mov r0, #0x48       @Equipped item after battle
ldrh r0, [r4, r0]   
mov r1, #0xFF
and r0, r1
ldr r2, ItemTableLocation
mov r1, #0x24
mul r0, r1
add r2, r0          @r2 = &Item Data
mov r0, #0x21       @Offset of debuff data
ldrb r0, [r2, r0]
@r0 = debuff data.

ldrb r1, [r6, #0x4]
mov r2, #0x40       @str/2 for status data
and r2, r1
cmp r2, #0x0
beq checkHalveStrength
@Str was already  halved so unhalve it.
mov r2, #0xCF
and r1, r2
strb r1, [r6, #0x4]
b magicHalvingDebuff
checkHalveStrength:
mov r1, #0x80       @str/2 for weapon debuff data.
and r1, r0
cmp r1, #0x0        @No str/2 debuff
beq magicHalvingDebuff
ldrb r1, [r6, #0x4] @reload the debuff
mov r2, #0x40       @set the str/2 bit
orr r1, r2
strb r1, [r6, #0x4]

magicHalvingDebuff:
@TODO: Implement mag/2 debuffs

silverDebuff:
mov r1, #0x20
and r1, r0
cmp r1, #0x0
beq noSilverDebuff
ldrb r1, [r6, #0x4]
mov r2, #0x1F       @silver debuff only
and r2, r1
mov r3, #0xE0       @H.o. bits only
and r1, r3
add r2, #0x2
cmp r2, #0x1F
ble storeSilverDebuff
mov r2, #0x1F
storeSilverDebuff:
orr r1, r2
strb r1, [r6, #0x4]
noSilverDebuff:

@Now the enemy weapon's debuffs.
mov r0, #0x7C       @damage/hit data
ldrb r0, [r5, r0]
mov r1, #0x2
and r0, r1
cmp r0, #0x0
beq noHit
mov r0, #0x48       @Equipped item after battle
ldrh r0, [r5, r0]   
mov r1, #0xFF
and r0, r1
ldr r2, ItemTableLocation
mov r1, #0x24
mul r0, r1
add r2, r0          @r2 = &Item Data
mov r0, #0x21       @Offset of debuff data
ldrb r0, [r2, r0]
@r0 = debuff data.
mov r1, #0x1F
and r0, r1
lsl r1, r0, #0x1
add r1, r0          @Each entry is 0x3 bytes
ldr r0, DebuffTableLocation
add r0, r1          @r0 = offset in debuff table
@construct the data
ldrb r2, [r0, #0x2]
lsl r2, #0x10
ldrb r1, [r0, #0x1]
lsl r1, #0x8
ldrb r0, [r0]
orr r0, r1
orr r0, r2

ldr r1, [r6]
mov r2, #0x0        @loop counter

push {r6}
mov r6, #0x0        @accumulator
@TODO: maybe implement negative chain?
debuffLoop:
mov r3, #0xF
lsl r4, r2, #0x2    @bits in a nibble
lsl r3, r4          @this many to the left
mov r5, r3          @existing debuffs
mov r7, r3          @maybe new debuffs
and r5, r1
and r7, r0
cmp r7, r5
bge takeNew         @should work since shifted by same amount
mov r7, r5          @keep old debuffs
takeNew:
orr r6, r7          @Set the chosen debuff

add r2, #0x1
cmp r2, #0x6
blt debuffLoop
mov r0, r6
pop {r6}
ldr r1, [r6]        @we only want to store 3 bytes, so...
mov r2, #0xFF
lsl r2, #0x18       @push into 4th byte
and r2, r1
orr r0, r2
str r0, [r6]        @store new debuffs
noHit:
pop {r4-r7}
bx lr

.align
ExtraDataLocation:
.long 0x0203F100
ItemTableLocation:
.long 0x08809B10
DebuffTableLocation:
@.long 0xDEADBEEF

