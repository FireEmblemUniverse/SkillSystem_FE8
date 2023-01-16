.thumb

.global HalfHpFunc
.type HalfHpFunc, %function 
HalfHpFunc: @ for hexing rod 
push {r4-r5, lr}
mov r5, r0 @stat
mov r4, r1 @unit
mov r0, r4 @ unit 
bl GetUnitDebuffEntry 
@hp/2 Debuff NOTE TO SELF: off of base only.

ldr r1, =HalfHpBitOffset_Link
ldr r1, [r1] 
bl CheckBit 
cmp r0, #0 
beq ExitHp 

lsr r2, r5, #0x1F
add r5, r2
asr r5, #0x1            @Signed divide by two.
ExitHp:
mov r0, r5
mov r1, r4
pop {r4-r5}
pop {r2} 
bx r2
.ltorg

.global HalfStrFunc
.type HalfStrFunc, %function 
HalfStrFunc: @ for hexing rod 
push {r4-r5, lr}
mov r5, r0 @stat
mov r4, r1 @unit
mov r0, r4 @ unit 
bl GetUnitDebuffEntry 
@str/2 Debuff NOTE TO SELF: off of base only.
ldr r1, =HalfStrBitOffset_Link
ldr r1, [r1] 
bl CheckBit 
cmp r0, #0 
beq ExitStr 
lsr r2, r5, #0x1F
add r5, r2
asr r5, #0x1            @Signed divide by two.
ExitStr:
mov r0, r5
mov r1, r4
pop {r4-r5}
pop {r2} 
bx r2
.ltorg

.global HalfMagFunc
.type HalfMagFunc, %function 
HalfMagFunc: @ for hexing rod 
push {r4-r5, lr}
mov r5, r0 @stat
mov r4, r1 @unit
mov r0, r4 @ unit 
bl GetUnitDebuffEntry 
ldr r1, =HalfStrBitOffset_Link
ldr r1, [r1] 
bl CheckBit 
cmp r0, #0 
beq ExitMag
lsr r2, r5, #0x1F
add r5, r2
asr r5, #0x1            @Signed divide by two.
ExitMag:
mov r0, r5
mov r1, r4
pop {r4-r5}
pop {r2} 
bx r2
.ltorg


