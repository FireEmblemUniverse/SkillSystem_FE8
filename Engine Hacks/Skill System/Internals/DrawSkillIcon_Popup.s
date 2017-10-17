.thumb
@ based on 10fa8, see also 10fc8
mov r0, r6
add r0, #0x44
strb r4, [r0]
ldr r0, =0x30005f4
ldrh r0, [r0]
@ blh 0x8017700 @grabs the weapon icon??
mov r1, #0x001
lsl r1, #0x8 @ STAN EDIT: 0x0100 for sheet #1 (aka Skill Icon Sheet)
orr r0, r1 @set top bit
strh r0, [r6, #0x3e]
mov r0, r6
add r0, #0x42
ldrb r1, [r0]
mov r0, #0 @palette
ldr r2, =0x8010fdf @jump to thing
bx r2
@drawn by 8011342... need to make it handle different icon set

@edit 8003732 to check top bit and use different thing
