.thumb
.equ Text_InitFont, 0x08003C94
.equ _ResetIconGraphics, 0x08003578

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
