.thumb

StartLoop:
    push {r4-r6, lr}
    mov  r4, r0
    mov  r5, r1

    mov  r6, #0x0 @initialize for loop
    Loop:
        ldr  r2, PreBattlePointers
        ldr  r2, [r2, r6]
        cmp  r2, #0x0
        beq  EndLoop
            mov  r0, #0x1
            orr  r2, r0 @Make sure we're in thumb mode
            mov  r0, r4
            mov  r1, r5
            mov  lr, r2
            .short 0xF800
            add  r6, #0x4
            b    Loop

    EndLoop:
    pop  {r4-r6}
    pop  {r0}
    bx   r0

.align
.ltorg
PreBattlePointers:
@POIN PreBattleFunctions
@it should contain a list of pointers to functions terminated by a four bytes of 0
