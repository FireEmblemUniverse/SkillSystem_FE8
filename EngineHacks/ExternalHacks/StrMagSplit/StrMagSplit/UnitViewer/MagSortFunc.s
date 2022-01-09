.thumb
.align


.global MagSortFunc
.type MagSortFunc, %function

.macro blh to,reg=r3
	push {\reg}
	ldr \reg,=\to
	mov r14,\reg
	pop {\reg}
	.short 0xF800
.endm
.equ gSortedUnitList,0x200D6E0

MagSortFunc: //goes in a jump table
cmp r2,#0
bne ReverseSort

NormalSort:
mov r3,#0
mov r10,r3
mov r1,#0
ldr r3,=#0x200F158
ldrb r0,[r3]
sub r0,#1
cmp r2,r0
blt OuterLoop 

blh #$8094fce //sort exit handler

.ltorg
.align

OuterLoop:
mov r5,#0
ldrb r0,[r3]
add r1,#1
sub r0,r0,r1
mov r8,r1
cmp r5,r0
bge LoopExit

ldr r7,=gSortedUnitList
mov r9,r7

LoopStart:
add r7,r5,#1
lsl r0,r7,#2
mov r1,r9
add r6,r0,r1
ldr r0,[r6]
ldr r0,[r0]
blh prGotoMagGetter //stat getter
mov r4,r0
lsl r0,r5,#2
mov r2,r9
add r5,r0,r2
ldr r0,[r5]
ldr r0,[r0]
blh prGotoMagGetter
cmp r4,r0
ble SkipReorderUnit

ldr r1,[r5]
ldr r0,[r6]
str r0,[r5]
str r1,[r6]
mov r3,#1
mov r10,r3

SkipReorderUnit:
lsl r0,r7,#24
lsr r5,r0,#24
ldr r0,=#0x200F158
ldrb r0,[r0]
mov r7,r8
sub r0,r0,r7
cmp r5,r0
blt LoopStart 

LoopExit:
mov r1,r8
lsl r0,r1,#24
lsr r1,r0,#24
ldr r3,=#0x200F158
ldrb r0,[r3]
sub r0,#1
cmp r1,r0
blt OuterLoop

blh #$8094fce //sort exit handler

.ltorg
.align

ReverseSort:
mov r3,#0
mov r10,r3
mov r1,#0
ldr r2,=#0x200F158
ldrb r0,[r2]
sub r0,#1
cmp r10,r0
blt OuterLoop2

blh #$8094fce //sort exit handler

.ltorg
.align

OuterLoop2:
mov r5,#0
ldrb r0,[r2]
add r1,#1
sub r0,r0,r1
mov r8,r1
cmp r5,r0
bge LoopExit2

ldr r7,=gSortedUnitList
mov r9,r7

LoopStart2:
add r7,r5,#1
lsl r0,r7,#2
mov r1,r9
add r6,r0,r1
ldr r0,[r6]
ldr r0,[r0]
blh prGotoMagGetter //stat getter
mov r4,r0
lsl r0,r5,#2
mov r2,r9
add r5,r0,r2
ldr r0,[r5]
ldr r0,[r0]
blh prGotoMagGetter
cmp r4,r0
bge SkipReorderUnit2

ldr r1,[r5]
ldr r0,[r6]
str r0,[r5]
str r1,[r6]
mov r3,#1
mov r10,r3

SkipReorderUnit2:
lsl r0,r7,#24
lsr r5,r0,#24
ldr r0,=#0x200F158
ldrb r0,[r0]
mov r7,r8
sub r0,r0,r7
cmp r5,r0
blt LoopStart2 

LoopExit2:
mov r1,r8
lsl r0,r1,#24
lsr r1,r0,#24
ldr r2,=#0x200F158
ldrb r0,[r2]
sub r0,#1
cmp r1,r0
blt OuterLoop2

blh #$8094fce //sort exit handler

.ltorg
.align
