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
	movs	r6, #0
	ldr	r4, .L10
	movs	r2, r6
	movs	r1, r6
	strh	r6, [r0, #42]
	movs	r0, #1
	bl	.L12
	movs	r2, r6
	movs	r1, r6
	movs	r0, #3
	bl	.L12
	ldr	r1, .L10+4
	ldr	r0, .L10+8
	ldr	r4, .L10+12
	bl	.L12
	movs	r1, #192
	movs	r2, #32
	ldr	r0, .L10+16
	ldr	r3, .L10+20
	lsls	r1, r1, #1
	bl	.L4
	movs	r2, r6
	ldr	r5, .L10+24
	ldr	r6, .L10+28
.L6:
	lsls	r1, r2, #16
	lsrs	r1, r1, #16
	movs	r3, r1
	movs	r0, r5
	adds	r3, r3, #129
	adds	r1, r1, #161
	adds	r3, r3, #255
	adds	r1, r1, #255
	lsls	r3, r3, #16
	lsls	r1, r1, #16
	lsrs	r3, r3, #16
	lsrs	r1, r1, #16
.L7:
	movs	r7, r6
	orrs	r7, r3
	adds	r3, r3, #1
	lsls	r3, r3, #16
	strh	r7, [r0]
	lsrs	r3, r3, #16
	adds	r0, r0, #2
	cmp	r3, r1
	bne	.L7
	movs	r3, #160
	adds	r2, r2, #32
	adds	r5, r5, #64
	lsls	r3, r3, #2
	cmp	r2, r3
	bne	.L6
	movs	r1, #192
	@ sp needed
	movs	r5, #0
	ldr	r0, .L10+32
	lsls	r1, r1, #19
	bl	.L12
	mov	r0, sp
	ldr	r6, .L10+36
	ldr	r2, .L10+40
	ldr	r1, .L10+44
	str	r5, [sp]
	bl	.L13
	str	r5, [sp, #4]
	ldr	r5, .L10+48
	add	r0, sp, #4
	movs	r1, r5
	ldr	r2, .L10+52
	bl	.L13
	ldr	r3, .L10+56
	ldrb	r3, [r3]
	ldr	r6, .L10+60
	ldr	r2, .L10+64
	lsls	r3, r3, #2
	movs	r1, r6
	ldr	r0, [r3, r2]
	bl	.L12
	movs	r2, #128
	movs	r1, r6
	movs	r0, r5
	ldr	r3, .L10+68
	lsls	r2, r2, #5
	bl	.L4
	ldrb	r3, [r6, #1]
	movs	r0, r5
	movs	r2, #18
	ldr	r1, .L10+72
	ldr	r4, .L10+76
	adds	r3, r3, #1
	bl	.L12
	movs	r0, #7
	ldr	r3, .L10+80
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
	.word	SSS_PageAndPortraitGfx
	.word	CpuFastSet
	.word	16777728
	.word	gBg1MapBuffer
	.word	gpStatScreenPageBg1Map
	.word	16777376
	.word	33569788
	.word	gGenericBuffer
	.word	SSS_PageTSATable
	.word	BgMap_ApplyTsa
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
	ldr	r4, .L15
	movs	r3, #0
	ldr	r0, .L15+4
	bl	.L12
	movs	r2, #18
	movs	r3, #0
	movs	r1, r2
	ldr	r0, .L15+8
	bl	.L12
	pop	{r4}
	pop	{r0}
	bx	r0
.L16:
	.align	2
.L15:
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
	.size	SSS_UpdateBG1Tiles, .-SSS_UpdateBG1Tiles
	.global	SSS_mainProc
	.section	.rodata.str1.1,"aMS",%progbits,1
.LC25:
	.ascii	"SSS_Main\000"
	.section	.rodata
	.align	2
	.type	SSS_mainProc, %object
	.size	SSS_mainProc, 32
SSS_mainProc:
	.short	1
	.short	0
	.word	.LC25
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
.L12:
	bx	r4
.L13:
	bx	r6
.L20:
	bx	r7
