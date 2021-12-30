
.thumb

.macro blh to, reg
    ldr \reg, =\to
    mov lr, \reg
    .short 0xF800
.endm

.global CreatorClassDisplayLoop
.type CreatorClassDisplayLoop, %function
CreatorClassDisplayLoop:
                        push    {r4-r7,r14}
    /* 080CD016 (T) */  mov     r7,r10
    /* 080CD018 (T) */  mov     r6,r9
    /* 080CD01A (T) */  mov     r5,r8
    /* 080CD01C (T) */  push    {r5-r7}
    /* 080CD01E (T) */  sub     sp,#0x5C
    /* 080CD020 (T) */  mov     r9,r0
    /* 080CD022 (T) */  ldr     r0,=#0x30053A0
    /* 080CD024 (T) */  ldr     r1,[r0,#0x14]
    /* 080CD026 (T) */  str     r1,[sp,#0x50]
    /* 080CD028 (T) */  ldr     r2,[r0,#0x18]
    /* 080CD02A (T) */  str     r2,[sp,#0x54]
    /* 080CD02C (T) */  ldr     r1,=#0x201FADC
    /* 080CD02E (T) */  ldr     r7,[r1,#0x14]
    /* 080CD030 (T) */  ldr     r1,[r1,#0x18]
    /* 080CD032 (T) */  mov     r10,r1
    /* 080CD034 (T) */  mov     r3,r9
    /* 080CD036 (T) */  add     r3,#0x40
    /* 080CD038 (T) */  ldrb    r1,[r3]
    /* 080CD03A (T) */  mov     r4,r0
    /* 080CD03C (T) */  cmp     r1,#0x1
    /* 080CD03E (T) */  beq     _0x80CD042
    /* 080CD040 (T) */  b       _0x80CD164
	_0x80CD042:
    /* 080CD042 (T) */  ldrh    r2,[r7,#0x32]
    /* 080CD044 (T) */  mov     r0,#0x32
    /* 080CD046 (T) */  ldsh    r1,[r7,r0]
    /* 080CD048 (T) */  ldr     r0,=#0x117
    /* 080CD04A (T) */  cmp     r1,r0
    /* 080CD04C (T) */  bgt     _0x80CD08C
    /* 080CD04E (T) */  mov     r0,r2
    /* 080CD050 (T) */  add     r0,#0xC
    /* 080CD052 (T) */  strh    r0,[r7,#0x32]
    /* 080CD054 (T) */  mov     r1,r10
    /* 080CD056 (T) */  ldrh    r0,[r1,#0x32]
    /* 080CD058 (T) */  add     r0,#0xC
    /* 080CD05A (T) */  strh    r0,[r1,#0x32]
    /* 080CD05C (T) */  ldr     r2,[sp,#0x50]
    /* 080CD05E (T) */  ldrh    r0,[r2,#0x2]
    /* 080CD060 (T) */  add     r0,#0xC
    /* 080CD062 (T) */  strh    r0,[r2,#0x2]
    /* 080CD064 (T) */  ldr     r3,[sp,#0x54]
    /* 080CD066 (T) */  strh    r0,[r3,#0x2]
    /* 080CD068 (T) */  b       _0x80CD090
	.ltorg
    /* 080CD06A (T)  lsl     r0,r0,#0x0
    080CD06C (T)   strh    r0,[r4,r6]
    080CD06E (T)   lsl     r0,r0,#0xC
    080CD070 (T)   bl      lr+#0x5B8
    080CD072 (T)   lsl     r1,r0,#0x8
    080CD074 (T)   lsl     r7,r2,#0x4
    080CD076 (T)   lsl     r0,r0,#0x0*/
	_0x80CD078:
    /* 080CD078 (T) */  ldr     r0,=CharPaletteTable
    /* 080CD07A (T) */  add     r0,r2,r0
    /* 080CD07C (T) */  ldrb    r0,[r0]
    /* 080CD07E (T) */  sub     r0,#0x1
    /* 080CD/* 080 (T) */  lsl     r0,r0,#0x10
    /* 080CD082 (T) */  lsr     r0,r0,#0x10
    /* 080CD084 (T) */  str     r0,[sp,#0x58]
    /* 080CD086 (T) */  b       _0x80CD130
    /* 080CD088 (T) */  add     r0,sp,#0x160
    /* 080CD08A (T) */  lsr     r0,r3,#0x5
	_0x80CD08C:
    /* 080CD08C (T) */  mov     r0,#0x2
    /* 080CD08E (T) */  strb    r0,[r3]
	_0x80CD090:
    /* 080CD090 (T) */  mov     r0,r9
    /* 080CD092 (T) */  add     r0,#0x40
    /* 080CD094 (T) */  ldrb    r0,[r0]
    /* 080CD096 (T) */  cmp     r0,#0x2
    /* 080CD098 (T) */  beq     _0x80CD09C
    /* 080CD09A (T) */  b       _0x80CD1AC
	_0x80CD09C:
    /* 080CD09C (T) */  blh     EndEkrAnimeDrvProc, r0
    /* 080CD0A0 (T) */  ldr     r0,=#0x30053A0
    /* 080CD0A2 (T) */  blh     #0x805AA28, r1
    /* 080CD0A6 (T) */  mov     r1,r9
    /* 080CD0A8 (T) */  add     r1,#0x42
    /* 080CD0AA (T) */  ldrh    r4,[r1]
    /* 080CD0AC (T) */  sub     r4,#0x1
    /* 080CD0AE (T) */  lsl     r4,r4,#0x10
    /* 080CD0B0 (T) */  lsr     r4,r4,#0x10
    /* 080CD0B2 (T) */  mov     r0,#0x41
    /* 080CD0B4 (T) */  add     r0,r9
    /* 080CD0B6 (T) */  mov     r8,r0
    /* 080CD0B8 (T) */  ldrb    r0,[r0]
    /* 080CD0BA (T) */  lsl     r0,r0,#0x1
    /* 080CD0BC (T) */  mov     r5,r9
    /* 080CD0BE (T) */  add     r5,#0x2C
    /* 080CD0C0 (T) */  add     r0,r5,r0
    /* 080CD0C2 (T) */  ldrh    r6,[r0]
    /* 080CD0C4 (T) */  ldr     r2,=#0xFFFF
    /* 080CD0C6 (T) */  str     r2,[sp,#0x58]
    /* 080CD0C8 (T) */  ldrh    r0,[r1]
    /* 080CD0CA (T) */  blh     GetUnitByCharId, r1
    /* 080CD0CE (T) */  mov     r1,r0
    /* 080CD0D0 (T) */  add     r0,sp,#0x4
    /* 080CD0D2 (T) */  mov     r2,#0x48
    /* 080CD0D4 (T) */  blh     memcpy, r3
    /* 080CD0D8 (T) */  mov     r3,r8
    /* 080CD0DA (T) */  ldrb    r0,[r3]
    /* 080CD0DC (T) */  lsl     r0,r0,#0x1
    /* 080CD0DE (T) */  add     r5,r5,r0
    /* 080CD0E0 (T) */  ldrh    r0,[r5]
    /* 080CD0E2 (T) */  blh     GetClassData, r1
    /* 080CD0E6 (T) */  str     r0,[sp,#0x8]
    /* 080CD0E8 (T) */  ldr     r5,[r0,#0x34]
    /* 080CD0EA (T) */  add     r0,sp,#0x4
    /* 080CD0EC (T) */  blh     GetUnitEquippedItem, r1
    /* 080CD0F0 (T) */  mov     r2,r0
    /* 080CD0F2 (T) */  lsl     r2,r2,#0x10
    /* 080CD0F4 (T) */  lsr     r2,r2,#0x10
    @/* 080CD0F6 (T) */  add     r3,sp,#0x4C
    /* 080CD0F8 (T) */  add     r0,sp,#0x4
    /* 080CD0FA (T) */  mov     r1,r5
    /* 080CD0FC (T) */  ldr     r3, =GetBattleAnimationId
						mov		lr, r3
						add		r3, sp, #0x4C
						.short  0xF800
    /* 080CD100 (T) */  lsl     r0,r0,#0x10
    /* 080CD102 (T) */  lsr     r0,r0,#0x10
    /* 080CD104 (T) */  mov     r8,r0
    /* 080CD106 (T) */  mov     r1,#0x0
    /* 080CD108 (T) */  ldr     r5,=CharClassTable
    /* 080CD10A (T) */  lsl     r4,r4,#0x10
    /* 080CD10C (T) */  asr     r4,r4,#0x10
    /* 080CD10E (T) */  lsl     r0,r4,#0x3
    /* 080CD110 (T) */  sub     r3,r0,r4
    /* 080CD112 (T) */  lsl     r6,r6,#0x10
    /* 080CD114 (T) */  asr     r6,r6,#0x10
	_0x80CD116:
    /* 080CD116 (T) */  lsl     r0,r1,#0x10
    /* 080CD118 (T) */  asr     r1,r0,#0x10
    /* 080CD11A (T) */  add     r2,r1,r3
    /* 080CD11C (T) */  add     r0,r2,r5
    /* 080CD11E (T) */  ldrb    r0,[r0]
    /* 080CD120 (T) */  cmp     r0,r6
    /* 080CD122 (T) */  beq     _0x80CD078
    /* 080CD124 (T) */  add     r0,r1,#0x01
    /* 080CD126 (T) */  lsl     r0,r0,#0x10
    /* 080CD128 (T) */  lsr     r1,r0,#0x10
    /* 080CD12A (T) */  asr     r0,r0,#0x10
    /* 080CD12C (T) */  cmp     r0,#0x6
    /* 080CD12E (T) */  ble     _0x80CD116
	_0x80CD130:
    /* 080CD130 (T) */  mov     r1,r8
    /* 080CD132 (T) */  lsl     r0,r1,#0x10
    /* 080CD134 (T) */  asr     r0,r0,#0x10
    /* 080CD136 (T) */  ldr     r2,[sp,#0x58]
    /* 080CD138 (T) */  lsl     r1,r2,#0x10
    /* 080CD13A (T) */  asr     r1,r1,#0x10
    /* 080CD13C (T) */  ldrh    r2,[r7,#0x32]
    /* 080CD13E (T) */  add     r2,#0x28
    /* 080CD140 (T) */  lsl     r2,r2,#0x10
    /* 080CD142 (T) */  asr     r2,r2,#0x10
    /* 080CD144 (T) */  mov     r3,#0x6
    /* 080CD146 (T) */  str     r3,[sp]
    @/* 080CD148 (T) */  mov     r3,#0x3C
    /* 080CD14A (T) */  ldr     r3, =#0x80CD47C
						mov 	lr, r3
						ldr		r3, =gCreatorBattleSpriteHeight
						ldrb	r3, [ r3 ]
						.short 0xF800
    /* 080CD14E (T) */  ldr     r0,=#0x201FADC
    /* 080CD150 (T) */  blh     #0x805AE14, r2
    /* 080CD154 (T) */  mov     r3,r9
						mov 	r2, #0x50
						ldrb	r0,[r3,r2]
    @/* 080CD156 (T) */  ldrb    r0,[r3,#0x50] @ Sometimes this gets loaded as something bad and loading only the byte fixes it? I wish I understood it better to doc better...
    /* 080CD158 (T) */  mov     r2,#0x32
    /* 080CD15A (T) */  ldsh    r1,[r7,r2]
    /* 080CD15C (T) */  mov     r3,#0x3A
    /* 080CD15E (T) */  ldsh    r2,[r7,r3]
    /* 080CD160 (T) */  blh     #0x80CD408, r3
	_0x80CD164:
    /* 080CD164 (T) */  mov     r1,r9
    /* 080CD166 (T) */  add     r1,#0x40
    /* 080CD168 (T) */  ldrb    r0,[r1]
    /* 080CD16A (T) */  ldr     r4,=#0x30053A0
    /* 080CD16C (T) */  cmp     r0,#0x2
    /* 080CD16E (T) */  bne     _0x80CD1AC
    /* 080CD170 (T) */  ldrh    r2,[r7,#0x32]
    /* 080CD172 (T) */  mov     r3,#0x32
    /* 080CD174 (T) */  ldsh    r0,[r7,r3]
    /* 080CD176 (T) */  cmp     r0,#0x82
    /* 080CD178 (T) */  ble     _0x80CD1A8
    /* 080CD17A (T) */  mov     r1,#0xC
    /* 080CD17C (T) */  sub     r0,r2,r1
    /* 080CD17E (T) */  strh    r0,[r7,#0x32]
    /* 080CD180 (T) */  mov     r2,r10
    /* 080CD182 (T) */  ldrh    r0,[r2,#0x32]
    /* 080CD184 (T) */  sub     r0,r0,r1
    /* 080CD186 (T) */  strh    r0,[r2,#0x32]
    /* 080CD188 (T) */  ldr     r3,[sp,#0x50]
    /* 080CD18A (T) */  ldrh    r0,[r3,#0x2]
    /* 080CD18C (T) */  sub     r0,r0,r1
    /* 080CD18E (T) */  strh    r0,[r3,#0x2]
    /* 080CD190 (T) */  ldr     r1,[sp,#0x54]
    /* 080CD192 (T) */  strh    r0,[r1,#0x2]
    /* 080CD194 (T) */  b       _0x80CD1AC
	.ltorg
    /*080CD196 (T)   lsl     r0,r0,#0x0
    080CD198 (T)   strh    r0,[r4,r6]
    080CD19A (T)   lsl     r0,r0,#0xC
    080CD19C (T)   bl      lr+#0xFFE
    080CD19E (T)   lsl     r0,r0,#0x0
    080CD1A0 (T)   add     r7,sp,#0x150
    080CD1A2 (T)   lsr     r0,r3,#0x5
    080CD1A4 (T)   bl      lr+#0x5B8
    080CD1A6 (T)   lsl     r1,r0,#0x8*/
	_0x80CD1A8:
    /* 080CD1A8 (T) */  mov     r0,#0x0
    /* 080CD1AA (T) */  strb    r0,[r1]
	_0x80CD1AC:
    /* 080CD1AC (T) */  mov     r0,r4
    /* 080CD1AE (T) */  blh     #0x805A96C, r1
    /* 080CD1B2 (T) */  lsl     r0,r0,#0x18
    /* 080CD1B4 (T) */  cmp     r0,#0x0
    /* 080CD1B6 (T) */  beq     _0x80CD1BE
    /* 080CD1B8 (T) */  mov     r0,r4
    /* 080CD1BA (T) */  blh     #0x805A990, r1
	_0x80CD1BE:
    /* 080CD1BE (T) */  mov     r0,r9
    /* 080CD1C4 (T) */  add     sp,#0x5C
    /* 080CD1C6 (T) */  pop     {r3-r5}
    /* 080CD1C8 (T) */  mov     r8,r3
    /* 080CD1CA (T) */  mov     r9,r4
    /* 080CD1CC (T) */  mov     r10,r5
    /* 080CD1CE (T) */  pop     {r4-r7}
    /* 080CD1D0 (T) */  pop     {r0}
	/* 080CD1D2 (T) */  bx		r0
	