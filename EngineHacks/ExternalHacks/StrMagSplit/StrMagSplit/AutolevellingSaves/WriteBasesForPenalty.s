.thumb

.equ ReturnAddress, 0x80180B4|1

.equ MagClassTable, MagCharTable+4

@r0 = Base res total | Must be 0xB during return
@r2 = Level Count | Preserve
@r3 = Character Data | Preserve (Overwritten by jump)
@r4 = Unit Pointer | Preserve

@Revert r3 to orginal value
ldr   r3, [r4]          @r3 = Character Data pointer

@Vanilla
strb  r0, [r4, #0x18]   @Store base res total
ldrb  r0, [r3, #0x12]   @r0 = Char base luck
strb  r0, [r4, #0x19]   @Store base luck total

@Get char base magic
ldrb  r0, [r3, #0x4]    @r0 = Character index
lsl   r0, #0x1          @Multiply by 2 (size of MagCharTable entry)
ldr   r3, MagCharTable
ldrb  r0, [r3, r0]      @r0 = Char base magic

@Get class base magic
ldr   r1, [r4, #0x4]    @r1 = Class Data pointer
ldrb  r1, [r1, #0x4]    @r1 = Class index
lsl   r1, #0x2          @Multiply by 4 (size of MagClassTable entry)
ldr   r3, MagClassTable
ldrb  r1, [r3, r1]      @r1 = Class base magic

@Add base values and write
add   r0, r1            @r0 = Char base magic + Class base magic
mov   r1, #0x3A         @r1 = Unit magic offset
strb  r0, [r4, r1]      @Store base magic total

@Cleanup
mov   r0, #0xB          @r0 = Unit level offset
ldr   r3, [r4]          @r3 = Character Data pointer

@Return
ldr   r1, =ReturnAddress
bx    r1

.ltorg
MagCharTable:
@POIN MagCharTable
@POIN MagClassTable
