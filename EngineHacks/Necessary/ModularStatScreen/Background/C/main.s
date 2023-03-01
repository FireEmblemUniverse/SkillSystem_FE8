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
	movs	r5, #0
	@ sp needed
	ldr	r4, .L10+32
	ldr	r7, .L10+12
	movs	r1, r4
	ldr	r0, .L10+36
	bl	.L13
	ldr	r6, .L10+40
	mov	r0, sp
	movs	r1, r6
	ldr	r2, .L10+44
	ldr	r3, .L10+48
	str	r5, [sp]
	bl	.L4
	movs	r2, r5
	movs	r1, r4
	movs	r0, r6
	ldr	r3, .L10+52
	bl	.L4
	movs	r1, #192
	ldr	r0, .L10+56
	lsls	r1, r1, #19
	bl	.L13
	movs	r2, #32
	ldr	r0, .L10+60
	movs	r1, r2
	ldr	r3, .L10+20
	bl	.L4
	ldr	r6, .L10+64
	add	r0, sp, #4
	movs	r1, r6
	ldr	r2, .L10+68
	ldr	r3, .L10+48
	str	r5, [sp, #4]
	bl	.L4
	ldr	r3, .L10+72
	ldrb	r3, [r3]
	ldr	r2, .L10+76
	lsls	r3, r3, #2
	ldr	r0, [r3, r2]
	movs	r1, r4
	bl	.L13
	movs	r2, r5
	movs	r0, r6
	movs	r1, r4
	ldr	r3, .L10+52
	bl	.L4
	ldrb	r3, [r4, #1]
	movs	r0, r6
	movs	r2, #18
	ldr	r1, .L10+80
	ldr	r4, .L10+84
	adds	r3, r3, #1
	bl	.L14
	movs	r0, #7
	ldr	r3, .L10+88
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
	.word	gGenericBuffer
	.word	SSS_PortraitBoxTSA
	.word	gBg1MapBuffer
	.word	16777728
	.word	CpuFastSet
	.word	BgMap_ApplyTsa
	.word	SSS_PageAndPortraitGfx
	.word	SSS_PageAndPortraitPal
	.word	gpStatScreenPageBg1Map
	.word	16777376
	.word	StatScreenStruct
	.word	SSS_PageTSATable
	.word	gBg1MapBuffer+152
	.word	BgMapCopyRect
	.word	EnableBgSyncByMask
	.size	SSS_init, .-SSS_init
	.align	1
	.global	SSS_ClearBG1Tiles
	.syntax unified
	.code	16
	.thumb_func
	.fpu softvfp
	.type	SSS_ClearBG1Tiles, %function
SSS_ClearBG1Tiles:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	movs	r2, #18
	push	{r4, lr}
	movs	r1, r2
	@ sp needed
	ldr	r4, .L16
	movs	r3, #0
	ldr	r0, .L16+4
	bl	.L14
	movs	r2, #18
	movs	r3, #0
	movs	r1, r2
	ldr	r0, .L16+8
	bl	.L14
	pop	{r4}
	pop	{r0}
	bx	r0
.L17:
	.align	2
.L16:
	.word	BgMapFillRect
	.word	gBg1MapBuffer+152
	.word	gBg2MapBuffer+152
	.size	SSS_ClearBG1Tiles, .-SSS_ClearBG1Tiles
	.align	1
	.global	SSS_UpdateBG1Tiles
	.syntax unified
	.code	16
	.thumb_func
	.fpu softvfp
	.type	SSS_UpdateBG1Tiles, %function
SSS_UpdateBG1Tiles:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r3, r4, r5, r6, r7, lr}
	movs	r6, r2
	@ sp needed
	asrs	r0, r0, #1
	asrs	r4, r1, #1
	lsls	r5, r0, #1
	ldr	r1, .L19
	ldr	r0, .L19+4
	adds	r4, r4, #76
	lsls	r4, r4, #1
	ldr	r7, .L19+8
	adds	r0, r5, r0
	adds	r1, r4, r1
	movs	r3, #18
	bl	.L13
	ldr	r1, .L19+12
	ldr	r0, .L19+16
	movs	r2, r6
	adds	r0, r5, r0
	movs	r3, #18
	adds	r1, r4, r1
	bl	.L13
	pop	{r3, r4, r5, r6, r7}
	pop	{r0}
	bx	r0
.L20:
	.align	2
.L19:
	.word	gBg1MapBuffer
	.word	gpStatScreenPageBg1Map
	.word	BgMapCopyRect
	.word	gBg2MapBuffer
	.word	gpStatScreenPageBg2Map
	.size	SSS_UpdateBG1Tiles, .-SSS_UpdateBG1Tiles
	.align	1
	.global	SSS_ScrollBG1
	.syntax unified
	.code	16
	.thumb_func
	.fpu softvfp
	.type	SSS_ScrollBG1, %function
SSS_ScrollBG1:
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
	.size	SSS_ScrollBG1, .-SSS_ScrollBG1
	.align	1
	.global	SSS_BlendMMSBox
	.syntax unified
	.code	16
	.thumb_func
	.fpu softvfp
	.type	SSS_BlendMMSBox, %function
SSS_BlendMMSBox:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	movs	r3, #3
	ldr	r2, .L25
	ldrb	r1, [r2, #24]
	orrs	r3, r1
	push	{r4, lr}
	strb	r3, [r2, #24]
	@ sp needed
	ldr	r3, .L25+4
	bl	.L4
	movs	r2, #0
	ldr	r3, .L25+8
	strb	r2, [r3, #8]
	pop	{r4}
	pop	{r0}
	bx	r0
.L26:
	.align	2
.L25:
	.word	gLCDIOBuffer
	.word	SetDefaultColorEffects
	.word	StatScreenStruct
	.size	SSS_BlendMMSBox, .-SSS_BlendMMSBox
	.global	SSS_mainProc
	.section	.rodata.str1.1,"aMS",%progbits,1
.LC32:
	.ascii	"SSS_Main\000"
	.section	.rodata
	.align	2
	.type	SSS_mainProc, %object
	.size	SSS_mainProc, 32
SSS_mainProc:
	.short	1
	.short	0
	.word	.LC32
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
.L14:
	bx	r4
.L12:
	bx	r5
.L13:
	bx	r7
