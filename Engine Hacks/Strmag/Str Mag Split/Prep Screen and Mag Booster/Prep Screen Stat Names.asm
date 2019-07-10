.thumb
.org 0x0

@r4 is counter, r5=table (later 0), r6=2013498, r7=2023D88
mov		r4,#0x0
ldr		r5,PrepScreenStatNameTable
ldr		r7,Ptr1
LoopThroughNames:
ldrh	r0,[r5,#0x2]
bl		WriteTextToRam
str		r0,[sp,#0x4]
mov		r0,r6
add		r6,#0x8
ldrh	r1,[r5]
add		r1,r1,r7
mov		r2,#0x3
mov		r3,#0x0
str		r3,[sp]
bl		DrawStatName
add		r4,#0x1
add		r5,#0x4
cmp		r4,#0xA
blt		LoopThroughNames
mov		r0,#0x80
lsl		r0,r0,#0x1
add		r7,r7,r0
mov		r5,#0x0
b		End+4

.align
Ptr1:
.long 0x02023D88
WriteTextToRam:
.long 0x0800A240
DrawStatName:
.long 0x0800443C
PrepScreenStatNameTable:

End:
