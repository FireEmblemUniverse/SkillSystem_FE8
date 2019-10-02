.thumb
.syntax unified
.org 0x00
sub_80057C0: @ 0x080057C0
	push {r4, lr}
	add r3, r0, #0 @Move E_Face's Proc Pointer into r3
	ldr r1, [r3, #0x30] @Load Word 0x30 of E_Face
	ldr r0, =0x807
	and r1, r0 @ r1 = E_Face->FaceControl & 0b100000000111
	cmp r1, #3
	beq BossFacingLeft @ if r1 = 3
	cmp r1, #3
	bls NormalPortrait @ if r1 < 3
	cmp r1, #5
	beq _0800581C @ if r1 = 5
	cmp r1, #5
	bcc _08005814 @ if r1 < 5
	sub r0, #7
	cmp r1, r0
	beq _08005824 @if only bit 11 is triggered
	adds r0, #1
	cmp r1, r0 
	beq _0800582C @if bit 11 and 0 are triggered
	b _08005830
	.pool
	
NormalPortrait: @ if r1 < 3
	cmp r1, #1
	beq NormalFacingLeft @ If r1 = 1
	cmp r1, #1
	bhi NormalFacingRight @ If r1 > 1
	ldr r0, CutInBoxFacingLeft @if r1 = 0
	b _0800582E

NormalFacingLeft: @ if r1 = 1
	ldr r0, PortraitOAMNormalFacingLeft  @ gUnknown_08591026
	b _0800582E

NormalFacingRight:
	ldr r0, PortraitOAMNormalFacingRight  @ gUnknown_08591040
	b _0800582E

BossFacingLeft:
	ldr r0, _08005810  @ gUnknown_08591066
	b _0800582E
	.align 2, 0
_08005810: .4byte gUnknown_08591066

_08005814:
	ldr r0, _08005818  @ gUnknown_0859108C
	b _0800582E
	.align 2, 0
_08005818: .4byte gUnknown_0859108C

_0800581C:
	ldr r0, _08005820  @ gUnknown_085910BE
	b _0800582E
	.align 2, 0
_08005820: .4byte gUnknown_085910BE

_08005824:
	ldr r0, _08005828  @ gUnknown_085910F0
	b _0800582E
	.align 2, 0
_08005828: .4byte gUnknown_085910F0

_0800582C:
	ldr r0, _08005848  @ gUnknown_08591122
_0800582E:
	str r0, [r3, #0x38]
_08005830:
	ldr r1, [r3, #0x30]
	movs r0, #0xf0
	lsls r0, r0, #2
	ands r1, r0
	cmp r1, #0x80
	beq _0800585A
	cmp r1, #0x80
	bhi _0800584C
	cmp r1, #0x40
	beq _08005856
	b _08005866
	.align 2, 0
_08005848: .4byte gUnknown_08591122

_0800584C:
	movs r0, #0x80
	lsls r0, r0, #2
	cmp r1, r0
	beq _08005860
	b _08005866
_08005856:
	movs r4, #0
	b _0800586A
_0800585A:
	movs r4, #0x80
	lsls r4, r4, #3
	b _0800586A
_08005860:
	movs r4, #0xc0
	lsls r4, r4, #4
	b _0800586A
_08005866:
	movs r4, #0x80
	lsls r4, r4, #4
_0800586A:
	ldr r1, _08005890  @ gUnknown_0202A68C
	adds r0, r3, #0
	adds r0, #0x40
	ldrb r0, [r0]
	lsls r0, r0, #3
	adds r0, r0, r1
	ldr r1, [r0]
	lsrs r1, r1, #5
	ldrh r2, [r0, #4]
	movs r0, #0xf
	ands r0, r2
	lsls r0, r0, #0xc
	adds r1, r1, r0
	adds r1, r1, r4
	strh r1, [r3, #0x3c]
	pop {r4}
	pop {r0}
	bx r0
	.align 2, 0
_08005890: .4byte gUnknown_0202A68C

EArgs:
.equ CutInBoxFacingLeft, EArgs @ 0x59100C, cut in portrait box
.equ PortraitOAMNormalFacingLeft, CutInBoxFacingLeft+4
.equ PortraitOAMNormalFacingRight, PortraitOAMNormalFacingLeft+4
