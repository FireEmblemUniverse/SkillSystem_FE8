.thumb
.macro blh to, reg=r3
  ldr \reg, \to
  mov lr, \reg
  .short 0xf800
.endm


@jumptohack from 0x37B48
ldr r0, ChapterStruct
ldrb r0, [r0, #0x0E] @ chapter ID
mov r1, #25
mul r0, r1
ldr r1, ModularAutolevelTable
add r0, r1
ldrb r0, [r0, #0] @ autolevel

End:
pop {r1}
bx r1

.align
ChapterStruct:
.word 0x202BCF0
ModularAutolevelTable:
@ poin ModularAutolevelTable
