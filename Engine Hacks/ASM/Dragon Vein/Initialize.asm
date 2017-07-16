.thumb
    @r5 is pointer to trap in events
    @format is 0x2 XX YY EffectID TextID(2 bytes) [Uses](0xff is unbreakable) 0x0
    mov r0, #0x1
    mov r1, #0x2
    ldsb r0, [r5, r0]
    ldsb r1, [r5, r1]
    ldrb r2, [r5]           @Yay dynamic
    ldr r3, SpawnTrap
    bl goto_r3              @returns pointer to the trap data allocated
    ldrb r1, [r5, #0x3]
    strb r1, [r0, #0x3]

    @Need to copy more than just this
    ldrh r1, [r5, #0x4]
    strh r1, [r0, #0x4]
    @ldrh r1, [r5, #0x6] @damn more than 6 bytes won't work
    @strh r1, [r0, #0x6]

    ldr r3, Return
    goto_r3:
    bx r3
    
SpawnTrap:
    .long 0x0802E2B9
Return:
    .long 0x08037901
