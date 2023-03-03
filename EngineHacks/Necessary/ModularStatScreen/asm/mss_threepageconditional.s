.thumb
.equ EnableBgSyncByIndex, 0x08001FBD
.equ Text_InitFont, 0x08003C94
.equ _ResetIconGraphics, 0x08003578
.equ Decompress, 0x08012F50
.equ BgMap_ApplyTsa, 0x080D74A0
.equ BgMapCopyRect, 0x080D74B9
.equ gpStatScreenPageBg1Map, 0x0200422C
.equ gGenericBuffer, 0x02020188
.equ gBg1MapBuffer, 0x20234A8

.macro blh to, reg=r3
	push	{\reg}
	ldr \reg, =\to
	mov lr, \reg
	pop	{\reg}
	.short 0xF800
.endm

@ Autohook to 0x08088690. r0 should equal the number of stat screen pages to have upon hitting the strb r0, [ r5, #0x01 ].
@ r5 = StatScreenStruct. Preserve no scratch registers!
ldr  r0,[r5,#0x0C] @ r0 = character struct.
ldr  r1,[r0]       @load character pointer
ldrb r1,[r1,#0x4]  @load character number
mov  r0,#12
mul  r1,r0
adr  r0,PersonalInfoTable  @load first like
ldr  r0,[r0]
ldrh r0,[r0,r1]
mov  r1, #0x04 @ 4 pages if there are supports to show.
cmp  r0, #0x00
bne NoSupportsStatScreen
    mov r1, #0x03 @ 3 pages if there no are supports to show.
    @ We also need to ensure that the stat screen does not try to load page 4 (because the user left from page 4 on the last stat screen).
    ldrb r0, [ r5 ] @ Current stat screen page.
    cmp r0, #0x03
    bne NoSupportsStatScreen
        mov r0, #0x00
        strb r0, [r5] @ Move to page 1 instead of 4.
        str  r0, [r5, #0x14]
        ldr r2, =SSS_PageTSATable
        ldr r2, [r2]
        cmp r2, #0x00 @ If no Scrolling StatScreen, no TSA unpackaging.
        beq NoSupportsStatScreen
            lsl r0, #0x02 @ Page has changed so update PageTSA.
            ldr r1, =SSS_PageTSATable
            ldr r0, [r0, r1] @ pointer to TSA for right page.
            ldr r1, =gGenericBuffer
            blh Decompress, r1 @ Decompress TSA into gGenericBuffer
            ldr r0, =gpStatScreenPageBg1Map
            ldr r1, =gGenericBuffer
            mov r2, #0x00
            blh BgMap_ApplyTsa, r1 @ Apply right page tsa.
            ldr r0, =gpStatScreenPageBg1Map
            ldr r1, =gBg1MapBuffer+0x98
            mov r2, #0x12
            ldr r3, =gGenericBuffer
            ldrb  r3, [r3, #0x1] @ Height differs, so we snag it from decompressed TSA.
            add r3, #0x01 @ TSA width and height are decremented by 1.
            blh BgMapCopyRect, r1 @ Apply TSA to BG1 screen entries.
            mov r0, #0x01
            blh EnableBgSyncByIndex, r1
            mov r1, #0x03 @ 3 pages if there no are supports to show.
        
        
NoSupportsStatScreen:
strb r1, [ r5, #0x01 ]
blh Text_InitFont, r1
blh _ResetIconGraphics, r1
blh #0x08086DF0, r1
ldr r0, =#0x080886A1
bx r0

.align
.ltorg

PersonalInfoTable:
