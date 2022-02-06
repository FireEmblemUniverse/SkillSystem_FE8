.thumb 
.include "_FE8Definitions.h.s"
.set Item_GetUsesLeft, 0x08017584

push {r4-r7, lr}
mov 	r7, r10
mov 	r6, r9
mov 	r5, r8
push 	{r5-r7}
add 	sp, #-0x24
str 	r0, [sp, #0x8]
str 	r1, [sp, #0x20]
_blh 	Unit_GetItemCount
str 	r0, [sp, #0xC]
ldr 	r0, [sp, #0x8]
mov 	r1, #0xD
_blh 	0x080349D4
str 	r0, [sp, #0x10]
mov 	r0, #0xD
str 	r0, [sp]
ldr 	r0, [sp, #0xC]
str 	r0, [sp, #0x4]
mov 	r0, #0x0
ldr 	r1, [sp, #0x8]
ldr 	r2, [sp, #0x10]
mov 	r3, #0x0
_blh 	0x0803483C, r4
mov 	r1, #0x0
mov 	r10, r1
ldr 	r1, [sp, #0xC]
cmp 	r10, r1
bge 	End
ldr 	r1, [sp, #0x10]
add 	r1, #0x6B
str 	r1, [sp, #0x14]
ldr 	r1, [sp, #0x10]
add 	r1, #0x63
str 	r1, [sp, #0x18]
mov 	r1, #0x60
str 	r1,[sp, #0x1C]
mov 	r7, r0
add 	r7, #0x38
LoopStart:
mov 	r1, r10
lsl 	r0, r1, #0x1
ldr 	r1, [sp, #0x8]
add 	r1, #0x1E
add 	r1, r1, r0
ldrh 	r6, [r1]
mov 	r0, r6
ldr 	r3, [sp, #0x20]
_blr 	r3
mov 	r4, r0
mov 	r0, r7
_blh 	0x8003DC8
mov 	r1, #0x0
lsl 	r4, r4, #0x18
asr 	r4, r4, #0x18
mov 	r9, r4
cmp 	r4, r0
bne 	Skip1
mov 	r1, #0x1
Skip1:
mov 	r0, r7
_blh 	0x8003E60
mov 	r0, r6
_blh 	0x80174F4
mov 	r1, r0
mov 	r0, r7
_blh 	0x8004004
ldr 	r0, [sp, #0x18]
lsl 	r1, r0, #0x1
ldr 	r0, =pBG0TileMap
mov 	r8, r0
add 	r1, r8
mov 	r0, r7
_blh 0x8003E70
ldr 	r1, [sp, #0x14]
lsl 	r0, r1, #0x1
mov 	r1, r8
add 	r4, r0, r1
mov 	r5, #0x1
mov 	r0, r9
cmp 	r0, #0x0
beq 	Skip2
mov 	r5, #0x2
Skip2:
mov 	r0, r6
_blh 	0x08017584
mov 	r2, r0
mov 	r0, r4
mov 	r1, r5
_blh 	0x8004B94
ldr 	r4, [sp, #0x1C]
add 	r4, #0x1
ldr 	r1, [sp, #0x10]
add 	r4, r4, r1
lsl 	r4, r4, #0x1
add 	r4, r8
mov 	r0, r6
_blh 0x8017700
mov 	r1, r0
mov 	r0, r4
mov 	r2, #0x80
lsl 	r2, r2, #0x7
_blh 0x80036BC
ldr 	r0, [sp, #0x14]
add 	r0, #0x40
str 	r0, [sp, #0x14]
ldr 	r1, [sp, #0x18]
add 	r1, #0x40
str 	r1, [sp, #0x18]
ldr 	r0, [sp, #0x1C]
add 	r0, #0x40
str 	r0, [sp, #0x1C]
add 	r7, #0x8
mov 	r1, #0x1
add 	r10, r1
ldr 	r0, [sp, #0xC]
cmp 	r10, r0
blt 	LoopStart
End: 
add 	sp, #0x24
pop 	{r3-r5}
mov 	r8, r3
mov 	r9, r4
mov 	r10, r5
pop 	{r4-r7}
pop 	{r0}
bx 	r0
.align
.ltorg
OffsetList:
