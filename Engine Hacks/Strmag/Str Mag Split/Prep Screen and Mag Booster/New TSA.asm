.thumb
.org 0x0

mov		r3,#0
ldr 	r0,NewTSA
ldr 	r1,BG1MapBuffer
loop:
ldr		r2,[r0]
str		r2,[r1]
add		r0,#4
add		r1,#4
add		r3,#1
ldr		r2,=0x200
cmp		r3,r2
bhs		stoploop
b		loop
stoploop:
ldr		r0,=0x0809C676|1
bx		r0

.align
.ltorg
BG1MapBuffer:
.long 0x020234A8
NewTSA:
