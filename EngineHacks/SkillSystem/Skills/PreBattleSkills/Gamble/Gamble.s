.thumb
.equ GambleFlag, 0x203f101
push {r4-r7, lr}
mov r4, r0 @atkr
mov r5, r1 @dfdr

ldr r0, =GambleFlag
ldrb r0, [r0]
cmp r0, #5 @was gamble selected
bne End

ldr r0, =0x203a4ec @is attacker?
cmp r4, r0
bne End

@double crit, halve hit
mov r1, #0x60
ldrh r0, [r4, r1] @hit
lsr r0, #1
strh r0, [r4,r1]

mov r1, #0x66
ldrh r0, [r4, r1] @crit
lsl r0, #1
strh r0, [r4,r1]

End:
pop {r4-r7, r15}
.align
.ltorg
