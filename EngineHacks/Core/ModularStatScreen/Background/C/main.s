	.cpu arm7tdmi
	.eabi_attribute 20, 1
	.eabi_attribute 21, 1
	.eabi_attribute 23, 3
	.eabi_attribute 24, 1
	.eabi_attribute 25, 1
	.eabi_attribute 26, 1
	.eabi_attribute 30, 4
	.eabi_attribute 34, 0
	.eabi_attribute 18, 4
	.file	"main.c"
	.text
	.align	1
	.global	SSS_loop
	.arch armv4t
	.syntax unified
	.code	16
	.thumb_func
	.fpu softvfp
	.type	SSS_loop, %function
SSS_loop:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, lr}
	ldrh	r1, [r0, #42]
	@ sp needed
	adds	r1, r1, #1
	strh	r1, [r0, #42]
	lsls	r1, r1, #22
	movs	r2, #0
	movs	r0, #3
	ldr	r3, .L2
	lsrs	r1, r1, #24
	bl	.L4
	pop	{r4}
	pop	{r0}
	bx	r0
.L3:
	.align	2
.L2:
	.word	SetBgPosition
	.size	SSS_loop, .-SSS_loop
	.align	1
	.global	SSS_init
	.syntax unified
	.code	16
	.thumb_func
	.fpu softvfp
	.type	SSS_init, %function
SSS_init:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r0, r1, r2, r4, r5, r6, r7, lr}
	movs	r4, #0
	ldr	r5, .L10
	movs	r2, r4
	movs	r1, r4
	strh	r4, [r0, #42]
	movs	r0, #1
	bl	.L12
	movs	r2, r4
	movs	r1, r4
	movs	r0, #3
	bl	.L12
	ldr	r1, .L10+4
	ldr	r0, .L10+8
	ldr	r3, .L10+12
	bl	.L4
	movs	r1, #192
	movs	r5, #160
	movs	r2, #32
	lsls	r1, r1, #1
	ldr	r0, .L10+16
	ldr	r3, .L10+20
	bl	.L4
	ldr	r2, .L10+24
	ldr	r1, .L10+28
	lsls	r5, r5, #2
.L6:
	lsls	r0, r4, #16
	lsrs	r0, r0, #16
	movs	r3, r0
	movs	r6, r2
	adds	r3, r3, #129
	adds	r0, r0, #161
	adds	r3, r3, #255
	adds	r0, r0, #255
	lsls	r3, r3, #16
	lsls	r0, r0, #16
	lsrs	r3, r3, #16
	lsrs	r0, r0, #16
.L7:
	movs	r7, r1
	orrs	r7, r3
	adds	r3, r3, #1
	lsls	r3, r3, #16
	strh	r7, [r6]
	lsrs	r3, r3, #16
	adds	r6, r6, #2
	cmp	r3, r0
	bne	.L7
	adds	r4, r4, #32
	adds	r2, r2, #64
	cmp	r4, r5
	bne	.L6
	movs	r2, #12
	@ sp needed
	movs	r1, #192
	ldr	r4, .L10+32
	adds	r4, r4, #65
	ldrb	r3, [r4]
	ands	r3, r2
	ldr	r2, .L10+36
	lsls	r1, r1, #19
	ldr	r0, [r3, r2]
	ldr	r3, .L10+12
	bl	.L4
	movs	r2, #12
	movs	r6, #0
	ldrb	r3, [r4]
	ldr	r0, .L10+40
	ands	r3, r2
	adds	r2, r2, #20
	movs	r1, r2
	ldr	r0, [r3, r0]
	ldr	r3, .L10+20
	bl	.L4
	ldr	r5, .L10+44
	ldr	r0, .L10+48
	movs	r1, r5
	ldr	r3, .L10+12
	bl	.L4
	ldr	r7, .L10+52
	mov	r0, sp
	movs	r1, r7
	ldr	r2, .L10+56
	ldr	r3, .L10+60
	str	r6, [sp]
	bl	.L4
	movs	r2, r6
	movs	r1, r5
	movs	r0, r7
	ldr	r3, .L10+64
	bl	.L4
	ldr	r7, .L10+68
	add	r0, sp, #4
	movs	r1, r7
	ldr	r2, .L10+72
	ldr	r3, .L10+60
	str	r6, [sp, #4]
	bl	.L4
	ldr	r3, .L10+76
	ldrb	r3, [r3]
	ldr	r2, .L10+80
	lsls	r3, r3, #2
	ldr	r0, [r3, r2]
	movs	r1, r5
	ldr	r3, .L10+12
	bl	.L4
	movs	r2, r6
	movs	r0, r7
	movs	r1, r5
	ldr	r3, .L10+64
	bl	.L4
	ldrb	r3, [r5, #1]
	movs	r0, r7
	ldr	r5, .L10+84
	movs	r2, #18
	ldr	r1, .L10+88
	adds	r3, r3, #1
	bl	.L12
	movs	r2, #12
	movs	r1, #144
	ldrb	r3, [r4]
	ldr	r0, .L10+40
	ands	r3, r2
	ldr	r0, [r3, r0]
	adds	r2, r2, #20
	ldr	r3, .L10+20
	lsls	r1, r1, #2
	bl	.L4
	movs	r2, #12
	ldrb	r3, [r4]
	ldr	r0, .L10+92
	ands	r3, r2
	movs	r1, #96
	ldr	r0, [r3, r0]
	adds	r2, r2, #20
	ldr	r3, .L10+20
	bl	.L4
	movs	r0, #7
	ldr	r3, .L10+96
	bl	.L4
	pop	{r0, r1, r2, r4, r5, r6, r7}
	pop	{r0}
	bx	r0
.L11:
	.align	2
.L10:
	.word	SetBgPosition
	.word	100708352
	.word	SSS_MuralGfx
	.word	Decompress
	.word	SSS_MuralPal
	.word	CopyToPaletteBuffer
	.word	gBg3MapBuffer
	.word	-16384
	.word	gChapterData
	.word	SSS_PageAndPortraitGfxTable
	.word	SSS_PageAndPortraitPalTable
	.word	gGenericBuffer
	.word	SSS_PortraitBoxTSA
	.word	gBg1MapBuffer
	.word	16777728
	.word	CpuFastSet
	.word	BgMap_ApplyTsa
	.word	gpStatScreenPageBg1Map
	.word	16777376
	.word	StatScreenStruct
	.word	SSS_PageTSATable
	.word	BgMapCopyRect
	.word	gBg1MapBuffer+152
	.word	SSS_StatsBoxPalTable
	.word	EnableBgSyncByMask
	.size	SSS_init, .-SSS_init
	.align	1
	.global	SSS_clearBG1Tiles
	.syntax unified
	.code	16
	.thumb_func
	.fpu softvfp
	.type	SSS_clearBG1Tiles, %function
SSS_clearBG1Tiles:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	movs	r2, #18
	push	{r4, lr}
	movs	r1, r2
	@ sp needed
	ldr	r4, .L14
	movs	r3, #0
	ldr	r0, .L14+4
	bl	.L16
	movs	r2, #18
	movs	r3, #0
	movs	r1, r2
	ldr	r0, .L14+8
	bl	.L16
	pop	{r4}
	pop	{r0}
	bx	r0
.L15:
	.align	2
.L14:
	.word	BgMapFillRect
	.word	gBg1MapBuffer+152
	.word	gBg2MapBuffer+152
	.size	SSS_clearBG1Tiles, .-SSS_clearBG1Tiles
	.align	1
	.global	SSS_updateBG1Tiles
	.syntax unified
	.code	16
	.thumb_func
	.fpu softvfp
	.type	SSS_updateBG1Tiles, %function
SSS_updateBG1Tiles:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r3, r4, r5, r6, r7, lr}
	movs	r6, r2
	@ sp needed
	asrs	r0, r0, #1
	asrs	r4, r1, #1
	lsls	r5, r0, #1
	ldr	r1, .L18
	ldr	r0, .L18+4
	adds	r4, r4, #76
	lsls	r4, r4, #1
	ldr	r7, .L18+8
	adds	r0, r5, r0
	adds	r1, r4, r1
	movs	r3, #18
	bl	.L20
	ldr	r1, .L18+12
	ldr	r0, .L18+16
	movs	r2, r6
	adds	r0, r5, r0
	movs	r3, #18
	adds	r1, r4, r1
	bl	.L20
	pop	{r3, r4, r5, r6, r7}
	pop	{r0}
	bx	r0
.L19:
	.align	2
.L18:
	.word	gBg1MapBuffer
	.word	gpStatScreenPageBg1Map
	.word	BgMapCopyRect
	.word	gBg2MapBuffer
	.word	gpStatScreenPageBg2Map
	.size	SSS_updateBG1Tiles, .-SSS_updateBG1Tiles
	.align	1
	.global	SSS_scrollBG1
	.syntax unified
	.code	16
	.thumb_func
	.fpu softvfp
	.type	SSS_scrollBG1, %function
SSS_scrollBG1:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	movs	r1, #0
	push	{r4, r5, r6, lr}
	lsls	r4, r0, #16
	lsrs	r4, r4, #16
	ldr	r5, .L22
	@ sp needed
	movs	r2, r4
	movs	r0, r1
	bl	.L12
	movs	r2, r4
	movs	r1, #0
	movs	r0, #1
	bl	.L12
	movs	r2, r4
	movs	r1, #0
	movs	r0, #2
	bl	.L12
	pop	{r4, r5, r6}
	pop	{r0}
	bx	r0
.L23:
	.align	2
.L22:
	.word	SetBgPosition
	.size	SSS_scrollBG1, .-SSS_scrollBG1
	.align	1
	.global	SSS_blendMMSBox
	.syntax unified
	.code	16
	.thumb_func
	.fpu softvfp
	.type	SSS_blendMMSBox, %function
SSS_blendMMSBox:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	movs	r3, #3
	push	{r0, r1, r4, r5, r6, lr}
	movs	r4, #0
	@ sp needed
	ldr	r5, .L25
	ldrb	r2, [r5, #24]
	orrs	r3, r2
	strb	r3, [r5, #24]
	ldr	r3, .L25+4
	bl	.L4
	ldr	r3, .L25+8
	movs	r0, r4
	strb	r4, [r3, #8]
	movs	r2, #8
	movs	r3, r4
	movs	r1, #6
	ldr	r6, .L25+12
	bl	.L27
	movs	r1, r4
	movs	r3, r4
	movs	r2, #1
	movs	r0, r4
	str	r4, [sp]
	ldr	r6, .L25+16
	bl	.L27
	movs	r0, #1
	ldr	r3, .L25+20
	bl	.L4
	movs	r2, r4
	movs	r1, r4
	movs	r0, r4
	ldr	r6, .L25+24
	movs	r3, #1
	str	r4, [sp]
	bl	.L27
	movs	r0, r4
	ldr	r3, .L25+28
	bl	.L4
	movs	r2, #63
	adds	r5, r5, #60
	ldrb	r3, [r5]
	ands	r2, r3
	movs	r3, #64
	orrs	r3, r2
	strb	r3, [r5]
	pop	{r0, r1, r4, r5, r6}
	pop	{r0}
	bx	r0
.L26:
	.align	2
.L25:
	.word	gLCDIOBuffer
	.word	SetDefaultColorEffects
	.word	StatScreenStruct
	.word	SetColorEffectsParameters
	.word	SetColorEffectsFirstTarget
	.word	SetColorEffectBackdropFirstTarget
	.word	SetColorEffectsSecondTarget
	.word	SetColorEffectBackdropSecondTarget
	.size	SSS_blendMMSBox, .-SSS_blendMMSBox
	.global	SSS_mainProc
	.section	.rodata.str1.1,"aMS",%progbits,1
.LC41:
	.ascii	"SSS_Main\000"
	.section	.rodata
	.align	2
	.type	SSS_mainProc, %object
	.size	SSS_mainProc, 32
SSS_mainProc:
	.short	1
	.short	0
	.word	.LC41
	.short	2
	.short	0
	.word	SSS_init
	.short	3
	.short	0
	.word	SSS_loop
	.short	0
	.short	0
	.word	0
	.ident	"GCC: (devkitARM release 55) 10.2.0"
	.text
	.code 16
	.align	1
.L4:
	bx	r3
.L16:
	bx	r4
.L12:
	bx	r5
.L27:
	bx	r6
.L20:
	bx	r7
