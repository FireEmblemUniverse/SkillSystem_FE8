.thumb

.equ ReturnAddress, 0x801D0B0|1

.global MenuResetSkillBuffer
.type MenuResetSkillBuffer, %function

@Hooks 801D0A8
MenuResetSkillBuffer:
    push {r0}
    bl   InitSkillBuffers
    pop  {r0}

    @Vanilla
    mov  r1, #0x80
    lsl  r1, #0x11
    eor  r1, r0
    lsr  r5, r1, #0x18

    @Return
    ldr  r3, =ReturnAddress
    bx   r3

.align
