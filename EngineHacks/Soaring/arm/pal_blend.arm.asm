/*
void pal_blend_asm(COLOR *pa, COLOR *pb, COLOR *pc, 
    int nclrs, u32 alpha) CODE_IN_IWRAM;
//! Blends palettes pa and pb into pc. 
//! \param pa, pb. Source palettes
//! \param pc. Destination palette
//! \param nclrs Number of colors
//! \param alpha Blend weight 0-32
//! \note u32 version, 2 clrs/loop. Loop: 16i/30c, Barrel shifter FTW.
*/
    .section .iwram,"ax", %progbits
    .align 2
    .arm
    .global clr_blend_asm
clr_blend_asm:
    @ movs    r3, r3, lsr #1          @ adjust nclrs for u32 run
    @ bxeq    lr                      @ quit on nclrs=0
    @r0 = clr1, r1 = clr2, r2 = alpha
    lsl     r2, #2               @alpha x 4
    stmfd   sp!, {r4-r10}
    ldr     r7, =0x03E07C1F         @ MASKLO: -g-|b-r
    mov     r6, r7, lsl #5          @ MASKHI: g-|b-r-
@ .Lpbld_loop:
        @mov     r8, r0            @ a= *pa  
        @mov     r9, r1            @ b= *pb  
        @ --- -g-|b-r
        and     r4, r6, r0, lsl #5      @ x/32: (-g-|b-r)
        and     r5, r7, r1              @ y: -g-|b-r
        sub     r5, r5, r4, lsr #5      @ z: y-x
        mla     r4, r5, r2, r4         @ z: (y-x)*w   x*32
        and     r10, r7, r4, lsr #5     @ blend(-g-|b-r)            
        @ --- b-r|-g- (rotated by 16 for cheapskatiness)
        and     r4, r6, r0, ror #11     @ x/32: -g-|b-r (ror16)
        and     r5, r7, r1, ror #16     @ y: -g-|b-r (ror16)
        sub     r5, r5, r4, lsr #5      @ z: y-x
        mla     r4, r5, r2, r4         @ z: (y-x)*w   x*32
        and     r4, r7, r4, lsr #5      @ blend(-g-|b-r (ror16))
        @ --- mix -g-|b-r and b-r|-g-
        @ orr     r10, r10, r4, ror #16
        orr     r0, r10, r4, ror #16
        lsl r0, #16
        lsr r0, #16 @@wipe top 2 bytes???
        @ --- write blended, loop
        @ str     r10, [r2], #4           @ *pc  = c
        @ subs    r3, r3, #1
        @ bgt     .Lpbld_loop        
    ldmfd   sp!, {r4-r10}
    bx      lr
