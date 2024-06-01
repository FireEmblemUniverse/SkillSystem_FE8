.thumb

.equ MovDescID, Literals
.equ HPDescID,  Literals+0x4

.equ RTextProc.textID, 0x4C

.equ StatScreenStruct, 0x2003BFC

.global MovHPDescGetter
.type MovHPDescGetter, %function

@ arguments:
@ - r0 = RText proc state
@ returns:
@ - nothing
MovHPDescGetter:
    mov  r3, r0
    @Check if growths are being displayed
    ldr  r0, =StatScreenStruct
    sub  r0, #1
    ldrb r0, [r0]
    mov  r1, #1
    tst	 r0, r1
    beq  GetMovDesc
        @Get HP desc
        ldr  r0, HPDescID
        b    End

    GetMovDesc:
    ldr  r0, MovDescID

    End:
    @Store in RText proc state
    mov  r1, #RTextProc.textID
    strh r0, [r3, r1]

    bx   lr

.align
.ltorg

Literals:
@WORD MovDescID
@WORD HPDescID
