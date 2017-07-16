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

MS_GOTO_R3:
push {r4,r14}
GOTO_R3:
bx r3

Select_Not_Pressed:


ldr r2, =0x203aab0
ldrb r0, [r2]
cmp r0, #10
bne Reset
push {lr}
ldr r3, =0x800D07D @run event
mov r0, #0
strb r0, [r2] @zero it again
mov r1, #0
ldr r0, KonamiCode
bl goto_r3
pop {r0}
mov lr, r0
b return_nothing
Reset:
mov r0, #0
strb r0, [r2]
Normal:
mov r0, #4
and r0, r1
cmp r0, #0
bne return_nothing
ldr r2, Something
mov r1, #0x16
ldsh r0,[r2,r1]
ldr r1, Something_2
ldr r1,[r1]
ldr r3, Start_cont
goto_r3:
bx r3

return_nothing:
ldr r0, =0x801cb39
bx r0

.ltorg
Something:
.long 0x0202BCB0
Something_2:
.long 0x0202E4D8
Start_cont:
.long 0x0801CAF7
Back:
.long 0x0801CB39
.align
KonamiCode:
@POIN event