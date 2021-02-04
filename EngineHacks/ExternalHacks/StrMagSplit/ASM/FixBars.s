.thumb
.org 0x00
.macro blh to, reg=r3
  ldr \reg, =\to
  mov lr, \reg
  .short 0xf800
.endm
@80870F0
push {lr}
ldr r2, [sp, #0x38]
cmp r2, #30
ble End
mov r3, #30
mul r7, r3
mov r0, r7
mov r1, r2
blh 0x80D167D @ Div
mov r7, r0
mov r5, r7
add r1, r6, #1
add r1, r8
mov r3, #30
str r3, [sp, #0x38]

End:
pop {r0}
bx r0
