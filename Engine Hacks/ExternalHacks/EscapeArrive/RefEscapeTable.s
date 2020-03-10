.thumb
.align 4

push {r14}
ldr r0,SVAL
ldr r2,SVAL
ldrb r0,[r0]
@r0 = char ID
mov r1,#2
mul r0,r1
ldr r1,TextTable
add r0,r1
ldrh r0,[r0]
strh r0,[r2]
pop {r1}
bx r1

.ltorg
.align 4

SVAL:
.word 0x30004C0
TextTable:
@POIN EscapeTextTable
