.thumb

.macro blh to, reg=r3
  ldr \reg, \to
  mov lr, \reg
  .short 0xf800
.endm

push {r4-r7}

@ r4 is unit
ldr r6, [r4, #0x4] @ class

ldr r0, ChapterStruct
mov r1, #0x42
ldrb r1, [r0, r1]

mov r2, #0x20 @ Set if not easy mode
tst r1, r2
bne NotEasy

mov r5, #0
b EndDifficulty

NotEasy:
mov r1, #0x14
ldrb r1, [r0, r1]

mov r2, #0x40 @ hard mode
tst r1, r2
bne Hard

mov r5, #1 @normal
b EndDifficulty

Hard:
mov r5, #2 @hard

EndDifficulty:

ldr r0, ChapterStruct
ldrb r0, [r0, #0x0E] @ chapter ID
mov r1, #25 @ size of row
mul r0, r1
ldr r1, ModularAutolevelTable
add r0, r1
add r0, #1 @ offset of hmb

mov r1, #8 // number of stats
mul r5, r1
add r5, r0 // initial offset of current difficulty

ldrb r0, [r6, #0x1B] // hp growth
ldrb r1, [r5, #0x0] // hp hmb
blh GetAutoleveledStat
ldrb r1, [r4, #0x12]
add r1, r1, r0
strb r1, [r4, #0x12]

ldrb r0, [r6, #0x1C] // str growth
ldrb r1, [r5, #0x1] // str hmb
blh GetAutoleveledStat
ldrb r1, [r4, #0x14]
add r1, r1, r0
strb r1, [r4, #0x14]

ldrb r0, [r6, #0x1D] // skl growth
ldrb r1, [r5, #0x2] // skl hmb
blh GetAutoleveledStat
ldrb r1, [r4, #0x15]
add r1, r1, r0
strb r1, [r4, #0x15]

ldrb r0, [r6, #0x1E] // spe growth
ldrb r1, [r5, #0x3] // spe hmb
blh GetAutoleveledStat
ldrb r1, [r4, #0x16]
add r1, r1, r0
strb r1, [r4, #0x16]

ldrb r0, [r6, #0x1F] // def growth
ldrb r1, [r5, #0x4] // def hmb
blh GetAutoleveledStat
ldrb r1, [r4, #0x17]
add r1, r1, r0
strb r1, [r4, #0x17]

mov r0, #0x20
ldrb r0, [r6, r0] // res growth
ldrb r1, [r5, #0x5] // res hmb
blh GetAutoleveledStat
ldrb r1, [r4, #0x18]
add r1, r1, r0
strb r1, [r4, #0x18]

mov r0, #0x21
ldrb r0, [r6, r0] // luk growth
ldrb r1, [r5, #0x6] // luk hmb
blh GetAutoleveledStat
ldrb r1, [r4, #0x19]
add r1, r1, r0
strb r1, [r4, #0x19]

pop   {r4-r7}
blh Return


.align
GetAutoleveledStat:
.long 0x0802B9C4
ChapterStruct:
.long 0x0202BCF0
Return:
.long 0x080180FE
ModularAutolevelTable:
@ poin ModularAutolevelTable
