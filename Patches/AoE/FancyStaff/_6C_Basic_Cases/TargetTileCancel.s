.thumb
.align 4 

.macro blh to, reg=r3
  ldr \reg, =\to
  mov lr, \reg
  .short 0xf800
.endm

	.set pr6C_New,                        0x08002C7C @ arguments: r0 = pointer to ROM 6C code, r1 = parent; returns: r0 = new 6C pointer (0 if no space available)
	.equ CurrentUnit, 0x3004E50
push {r4, r14}
mov r4, r0

bl AoE_ClearRangeMap

blh 0x801dacc @HideMoveRangeGraphics
blh 0x0804E884   @//ClearBG0BG1


ldr r3, =CurrentUnit
ldr r3, [r3]
ldrb r0, [r3, #0x10]
ldrb r1, [r3, #0x11]

blh 0x8015bbc @SetCursorMapPosition

ldr r0, =0x859b600 @gProc_GoBackToUnitMenu
mov r1, #3

blh pr6C_New



mov r0, #0x0A @ Ends selection & Plays boop sound
pop {r4}

pop {r1}
bx r1

.ltorg
.align
