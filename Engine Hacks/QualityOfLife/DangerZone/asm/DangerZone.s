.thumb
.org 0x00000000

Dangerzone_Hack_Start:
@mimic $0801CAE2
ldrh r1,[r2,#0x4]
mov r0,#0x4
and r0,r1
cmp r0,#0x0
beq Select_Not_Pressed
ldr r0, Clear_Screen
bl GOTO_R0
ldr r2, MS_R2
ldr r1, [r2,#0x18]
ldr r0, [r2,#0x14]
ldr r3, MS_Hook
bl MS_GOTO_R3
ldr r0, Dangerzone
bl GOTO_R0

ldr r0,Back

GOTO_R0:
bx r0

.align
Dangerzone:
.long 0x080226F9
Clear_Screen:
.long 0x0808D151
MS_R2:
.long 0x0202BCB0
MS_Hook:
.long 0x08027ACB

Select_Not_Pressed:
ldr r2, Something
mov r1, #0x16
ldsh r0,[r2,r1]
ldr r1, Something_2
ldr r1,[r1]
ldr r3, Start_cont
b GOTO_R3

.align
Something:
.long 0x0202BCB0
Something_2:
.long 0x0202E4D8
Start_cont:
.long 0x0801CAF7
Back:
.long 0x0801CB39

MS_GOTO_R3:
push {r4,r14}
GOTO_R3:
bx r3
