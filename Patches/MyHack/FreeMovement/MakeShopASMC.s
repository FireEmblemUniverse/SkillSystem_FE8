.thumb
.align

.equ MakeShop,0x80B4241
.macro blh to,reg=r3
	push {\reg}
	ldr \reg,=\to
	mov r14,\reg
	pop {\reg}
	.short 0xF800
.endm
.equ MemorySlot1,0x030004BC
.equ MemorySlot2,0x030004C0
.equ MemorySlot3,0x030004C4
.equ GetUnitByCharId,0x801829D

.global MakeShopASMC
.type MakeShopASMC, %function

MakeShopASMC:
push {r4-r7,r14}
ldr r0,=#0x3004E50
ldr r0,[r0]
mov r4,r0 @r4 = unit ptr
ldr r0,=MemorySlot2
ldr r5,[r0] @r5 = shop list
ldr r0,=MemorySlot3
ldr r6,[r0] @r6 = shop type

mov r0,r4
mov r1,r5
mov r2,r6
mov r3,r7

blh MakeShop

pop {r4-r7}
pop {r0}
bx r0

.ltorg
.align

