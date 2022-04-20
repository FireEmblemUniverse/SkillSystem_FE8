@GetRandomNumber
@
@
@Author 7743
@
.align 4
.macro blh to, reg=r3
  ldr \reg, =\to
  mov lr, \reg
  .short 0xf800
.endm
.thumb

push {r4,lr}

@ldr  r3,=0x030004B0 @MemorySlot FE8J
ldr  r3,=0x030004B8 @MemorySlot FE8U
add r3, #3*4 @ Slot 3 
ldrh r0, [r3, #0]	@Slot3 hhhhllll @ high / low 
ldrh r1, [r3, #2]	@Slot3
cmp r0, r1
bge Error
mov r4, r0

sub r0, r1, r0
add r0,#0x01

cmp r0, #0x0  @オーバーフローしたら嫌なのでもう一度確認する
beq Error

@blh 0x08000c58   @NextRN_N	@{J}
blh 0x08000c80   @NextRN_N	@{U}

add r0, r4
b Exit

Error:
mov r0,#0x0
b Store 

Exit:

ldr  r3,=0x030004B8 @MemorySlot FE8U
add r3, #3*4 @ Slot 3 
ldrh r1, [r3, #2]	@Slot3

cmp r0, r1 
blt RetFalse
mov r0, #1 
b Store 
RetFalse:
mov r0, #0 
Store:
ldr  r3,=0x030004B8 @MemorySlot FE8U
str  r0,[r3,#0x0C * 4]    @MemorySlotC (Result Value)
mov r11, r11 
pop {r4}
pop {r1}
bx r1
