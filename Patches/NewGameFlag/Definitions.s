.equ ChapterData, 0x202BCF0
.equ MemorySlot,0x30004B8
.macro blh to, reg=r3
  ldr \reg, =\to
  mov lr, \reg
  .short 0xf800
.endm
.macro blh2 to, reg=r3
  ldr \reg, \to
  mov lr, \reg
  .short 0xf800
.endm
