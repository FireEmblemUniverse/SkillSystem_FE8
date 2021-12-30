
.thumb

.macro blh to, reg
    ldr \reg, =\to
    mov lr, \reg
    .short 0xF800
.endm

.global CreatorClassSetup
.type CreatorClassSetup, %function
CreatorClassSetup:
                        push    {r4-r7,r14}
    /* 080CCD4A (T) */  mov     r7,r10
    /* 080CCD4C (T) */  mov     r6,r9
    /* 080CCD4E (T) */  mov     r5,r8
    /* 080CCD50 (T) */  push    {r5-r7}
    /* 080CCD52 (T) */  sub     sp,#0x20
    /* 080CCD54 (T) */  mov     r5,r0
    /* 080CCD56 (T) */  ldr     r0,[r5,#0x14]
    /* 080CCD58 (T) */  str     r0,[sp,#0x4]
    /* 080CCD5A (T) */  mov     r1,r0
    /* 080CCD5C (T) */  add     r1,#0x29
    /* 080CCD5E (T) */  mov     r4,#0x0
    @/* 080CCD60 (T) */  mov     r0,#0x2
    @/* 080CCD62 (T) */  strb    r0,[r1]
    /* 080CCD64 (T) */  ldr     r0,[sp,#0x4]
    /* 080CCD66 (T) */  add     r0,#0x38
    /* 080CCD68 (T) */  ldrb    r0,[r0]
    /* 080CCD6A (T) */  mov     r1,r5
    /* 080CCD6C (T) */  add     r1,#0x42
    /* 080CCD6E (T) */  strh    r0,[r1]
    /* 080CCD70 (T) */  mov     r0,#0x9
    /* 080CCD72 (T) */  str     r0,[r5,#0x50]
    
    /* 080CCD94 (T) */  mov     r1,#0x1
    /* 080CCD96 (T) */  neg     r1,r1
    /* 080CCD98 (T) */  mov     r2,#0xFB
    /* 080CCD9A (T) */  lsl     r2,r2,#0x1
    /* 080CCD9C (T) */  mov     r0,#0x6
    /* 080CCD9E (T) */  str     r0,[sp]
    /* 080CCDA0 (T) */  mov     r0,#0x0
    @/* 080CCDA2 (T) */  mov     r3,#0x58
    /* 080CCDA4 (T) */  ldr     r3, =#0x80CD47C
                        mov     lr, r3
			        	mov r3, #0x58
				        .short 0xF800
    
    /* 080CCDAC (T) */  ldr     r0,[r5,#0x50]
    /* 080CCDAE (T) */  mov     r1,#0x8C
    /* 080CCDB0 (T) */  lsl     r1,r1,#0x1
    /* 080CCDB2 (T) */  ldr		r2, =gCreatorPlatformHeight
						ldrb	r2, [ r2 ]
    /* 080CCDB4 (T) */  blh     #0x80CD408, r3
    /* 080CCDB8 (T) */  strh    r4,[r5,#0x32]
    /* 080CCDBA (T) */  strh    r4,[r5,#0x34]
    /* 080CCDBC (T) */  strh    r4,[r5,#0x36]
    /* 080CCDBE (T) */  mov     r4,#0x1
	_0x80CCDC0:
    /* 080CCDC0 (T) */  mov     r0,r4
    /* 080CCDC2 (T) */  blh     GetUnit, r1
    /* 080CCDC6 (T) */  mov     r10,r0
    /* 080CCDC8 (T) */  cmp     r0,#0x0
    /* 080CCDCA (T) */  bne     _0x80CCDCE
    /* 080CCDCC (T) */  b       _0x80CCEEE
	_0x80CCDCE:
    /* 080CCDCE (T) */  ldr     r0,[r0]
    /* 080CCDD0 (T) */  cmp     r0,#0x0
    /* 080CCDD2 (T) */  bne     _0x80CCDD6
    /* 080CCDD4 (T) */  b       _0x80CCEEE
	_0x80CCDD6:
    /* 080CCDD6 (T) */  mov     r1,r5
    /* 080CCDD8 (T) */  add     r1,#0x42
    /* 080CCDDA (T) */  ldrb    r0,[r0,#0x4]
    /* 080CCDDC (T) */  ldrh    r1,[r1]
    /* 080CCDDE (T) */  cmp     r0,r1
    /* 080CCDE0 (T) */  beq     _0x80CCDE4
    /* 080CCDE2 (T) */  b       _0x80CCEEE
	_0x80CCDE4:
    /* 080CCDE4 (T) */  mov     r1,r10
    /* 080CCDE6 (T) */  ldr     r0,[r1,#0x4]
    /* 080CCDE8 (T) */  ldrb    r0,[r0,#0x4]
    /* 080CCDEA (T) */  str     r0,[sp,#0x8]
    /* 080CCDEC (T) */  mov     r0,r10
    /* 080CCDEE (T) */  blh     GetUnitEquippedItem, r1
    /* 080CCDF2 (T) */  lsl     r0,r0,#0x10
    /* 080CCDF4 (T) */  lsr     r0,r0,#0x10
    /* 080CCDF6 (T) */  mov     r9,r0
    /* 080CCDF8 (T) */  mov     r2,#0x0
    /* 080CCDFA (T) */  mov     r8,r2
    /* 080CCDFC (T) */  mov     r0,r5
    /* 080CCDFE (T) */  add     r0,#0x4A
    /* 080CCE00 (T) */  str     r0,[sp,#0x18]
    /* 080CCE02 (T) */  mov     r1,r5
    /* 080CCE04 (T) */  add     r1,#0x48
    /* 080CCE06 (T) */  str     r1,[sp,#0x14]
    /* 080CCE08 (T) */  mov     r2,r5
    /* 080CCE0A (T) */  add     r2,#0x40
    /* 080CCE0C (T) */  str     r2,[sp,#0xC]
    /* 080CCE0E (T) */  sub     r0,#0x9
    /* 080CCE10 (T) */  str     r0,[sp,#0x10]
    /* 080CCE12 (T) */  mov     r3,r5
    /* 080CCE14 (T) */  add     r3,#0x38
    /* 080CCE16 (T) */  mov     r7,r5
    /* 080CCE18 (T) */  add     r7,#0x32
    /* 080CCE1A (T) */  mov     r6,r5
    /* 080CCE1C (T) */  add     r6,#0x2C
	_0x80CCE1E:
    /* 080CCE1E (T) */  ldr     r1,[sp,#0x8]
    /* 080CCE20 (T) */  lsl     r4,r1,#0x1
    /* 080CCE22 (T) */  add     r4,r8
    @/* 080CCE24 (T) */  ldr     r2,=#0x92E543E
    @/* 080CCE26 (T) */  add     r4,r4,r2
    @/* 080CCE28 (T) */  ldrb    r0,[r4]
    @/* 080CCE2A (T) */  strh    r0,[r6]
    @/* 080CCE2C (T) */  ldrb    r1,[r4]
						ldrb	r1,[r6]
    /* 080CCE2E (T) */  mov     r0,r7
    /* 080CCE30 (T) */  mov     r2,r9
    /* 080CCE32 (T) */  str     r3,[sp,#0x1C]
    @/* 080CCE34 (T) */  blh     GetClassAnimationIdForWeapon, r3
    /* 080CCE38 (T) */  ldr     r1,[sp,#0x18]
    /* 080CCE3A (T) */  add     r1,r8
    @/* 080CCE3C (T) */  strb    r0,[r1]
    /* 080CCE3E (T) */  ldrb    r0,[r4]
    /* 080CCE40 (T) */  blh     GetClassData, r1
    /* 080CCE44 (T) */  ldrh    r0,[r0,#0x2]
    /* 080CCE46 (T) */  ldr     r3,[sp,#0x1C]
    /* 080CCE48 (T) */  strh    r0,[r3]
    /* 080CCE4A (T) */  add     r3,#0x2
    /* 080CCE4C (T) */  add     r7,#0x2
    /* 080CCE4E (T) */  add     r6,#0x2
    /* 080CCE50 (T) */  mov     r0,#0x1
    /* 080CCE52 (T) */  add     r8,r0
    /* 080CCE54 (T) */  mov     r1,r8
    /* 080CCE56 (T) */  cmp     r1,#0x1
    /* 080CCE58 (T) */  ble     _0x80CCE1E
    /* 080CCE5A (T) */  mov     r0,r9
    /* 080CCE5C (T) */  ldr     r2,[sp,#0x14]
    /* 080CCE5E (T) */  strh    r0,[r2]
    /* 080CCE60 (T) */  blh     IsThirdTraineePromotionAllowed, r0
    /* 080CCE64 (T) */  lsl     r0,r0,#0x18
    /* 080CCE66 (T) */  cmp     r0,#0x0
    /* 080CCE68 (T) */  lsl     r0,r0,#0x0
    /* 080CCE6A (T) */  mov     r1,r10
    /* 080CCE6C (T) */  ldr     r0,[r1,#0x4]
    /* 080CCE6E (T) */  ldrb    r0,[r0,#0x4]
    /* 080CCE70 (T) */  str     r0,[sp,#0x8]
    /* 080CCE72 (T) */  blh     #0x80E1920, r1
    /* 080CCE76 (T) */  cmp     r0,#0x0
    /* 080CCE78 (T) */  beq     _0x80CCF02
    /* 080CCE7A (T) */  b       _0x80CCE9A
    /* 080CCE7C (T) */  nop
    /* 080CCE7E (T) */  nop
    /* 080CCE80 (T) */  cmp     r4,#0xA8
    /* 080CCE82 (T) */  lsl     r2,r0,#0x8
    /* 080CCE84 (T) */  add     r4,#0xA8
    /* 080CCE86 (T) */  lsl     r2,r0,#0x8
    /* 080CCE88 (T) */  sub     r4,#0xA8
    /* 080CCE8A (T) */  lsl     r2,r0,#0x8
    /* 080CCE8C (T) */  strb    r6,[r7,r0]
    /* 080CCE8E (T) */  lsr     r6,r5,#0x4
    /* 080CCE90 (T) */  nop
    /* 080CCE92 (T) */  nop
    /* 080CCE94 (T) */  nop
    /* 080CCE96 (T) */  nop
    /* 080CCE98 (T) */  nop
	_0x80CCE9A:
    @/* 080CCE9A (T) */  strh    r0,[r5,#0x30]
    /* 080CCE9C (T) */  mov     r1,r0
    /* 080CCE9E (T) */  mov     r0,r5
    /* 080CCEA0 (T) */  add     r0,#0x36
    /* 080CCEA2 (T) */  mov     r2,r9
    /* 080CCEA4 (T) */  blh     GetClassAnimationIdForWeapon, r3
    /* 080CCEA8 (T) */  mov     r1,r5
    /* 080CCEAA (T) */  add     r1,#0x4C
    /* 080CCEAC (T) */  strb    r0,[r1]
    /* 080CCEAE (T) */  ldrh    r0,[r5,#0x30]
    /* 080CCEB0 (T) */  b       _0x80CCEE4
    /* 080CCEB2 (T) */  mov     r0,#0xB
    /* 080CCEB4 (T) */  strh    r0,[r5,#0x30]
    /* 080CCEB6 (T) */  mov     r0,r5
    /* 080CCEB8 (T) */  add     r0,#0x36
    /* 080CCEBA (T) */  mov     r1,#0xB
    /* 080CCEBC (T) */  mov     r2,r9
    /* 080CCEBE (T) */  blh     GetClassAnimationIdForWeapon, r3
    /* 080CCEC2 (T) */  mov     r1,r5
    /* 080CCEC4 (T) */  add     r1,#0x4C
    /* 080CCEC6 (T) */  strb    r0,[r1]
    /* 080CCEC8 (T) */  mov     r0,#0xB
    /* 080CCECA (T) */  b       _0x80CCEE4
    /* 080CCECC (T) */  mov     r0,#0x37
    /* 080CCECE (T) */  strh    r0,[r5,#0x30]
    /* 080CCED0 (T) */  mov     r0,r5
    /* 080CCED2 (T) */  add     r0,#0x36
    /* 080CCED4 (T) */  mov     r1,#0x37
    /* 080CCED6 (T) */  mov     r2,r9
    /* 080CCED8 (T) */  blh     GetClassAnimationIdForWeapon, r3
    /* 080CCEDC (T) */  mov     r1,r5
    /* 080CCEDE (T) */  add     r1,#0x4C
    /* 080CCEE0 (T) */  strb    r0,[r1]
    /* 080CCEE2 (T) */  mov     r0,#0x37
	_0x80CCEE4:
    /* 080CCEE4 (T) */  blh     GetClassData, r1
    /* 080CCEE8 (T) */  ldrh    r0,[r0,#0x2]
    /* 080CCEEA (T) */  strh    r0,[r5,#0x3C]
    /* 080CCEEC (T) */  b       _0x80CCF02
	_0x80CCEEE:
    /* 080CCEEE (T) */  add     r4,#0x1
    /* 080CCEF0 (T) */  mov     r0,r5
    /* 080CCEF2 (T) */  add     r0,#0x40
    /* 080CCEF4 (T) */  str     r0,[sp,#0xC]
    /* 080CCEF6 (T) */  mov     r1,r5
    /* 080CCEF8 (T) */  add     r1,#0x41
    /* 080CCEFA (T) */  str     r1,[sp,#0x10]
    /* 080CCEFC (T) */  cmp     r4,#0x3F
    /* 080CCEFE (T) */  bgt     _0x80CCF02
    /* 080CCF00 (T) */  b       _0x80CCDC0
	_0x80CCF02:
    /* 080CCF02 (T) */  ldrh    r0,[r5,#0x32]
    /* 080CCF04 (T) */  cmp     r0,#0x0
    /* 080CCF06 (T) */  bne     _0x80CCF12
    /* 080CCF08 (T) */  ldrh    r0,[r5,#0x34]
    /* 080CCF0A (T) */  cmp     r0,#0x0
    /* 080CCF0C (T) */  bne     _0x80CCF12
    /* 080CCF0E (T) */  strh    r0,[r5,#0x34]
    /* 080CCF10 (T) */  strh    r0,[r5,#0x32]
	_0x80CCF12:
    /* 080CCF12 (T) */  mov     r1,#0x0
    /* 080CCF14 (T) */  mov     r0,#0x1
    /* 080CCF16 (T) */  ldr     r2,[sp,#0xC]
    /* 080CCF18 (T) */  strb    r0,[r2]
    @/* 080CCF1A (T) */  ldr     r0,[sp,#0x10]
    @/* 080CCF1C (T) */  strb    r1,[r0]
    
    /* 080CCF4E (T) */  add     sp,#0x20
    /* 080CCF50 (T) */  pop     {r3-r5}
    /* 080CCF52 (T) */  mov     r8,r3
    /* 080CCF54 (T) */  mov     r9,r4
    /* 080CCF56 (T) */  mov     r10,r5
    /* 080CCF58 (T) */  pop     {r4-r7}
    /* 080CCF5A (T) */  pop     {r0}
	/* 080CCF5C {T} */  bx		r0
	