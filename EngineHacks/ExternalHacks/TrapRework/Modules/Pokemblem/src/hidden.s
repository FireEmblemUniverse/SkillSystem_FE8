.thumb

.set Continue, (. + 0x0801A1DE - 0x0801A1B6)

@cmp r0, #0x0B
beq Yes

cmp r0, #0x20
bne Continue

Yes:

ldr  r0, [r6]     @ r0 = Unit Raws
ldrb r1, [r3, #1] @ r1 = trap y
lsl  r1, #2       @ r1 = trap y * sizeof(void*)
ldrb r4, [r3, #0] @ r4 = trap x
ldr  r0, [r0, r1] @ r0 = Row
ldrb r0, [r0, r4] @ r0 = Tile

