.thumb
.align


.global CombatArtsUsability
.type CombatArtsUsability, %function

.global CombatArtsEffect
.type CombatArtsEffect, %function




CombatArtsUsability:
push {r4-r7,r14}

@loop through all menu command usabilities looking for one that returns true

ldr r4,=CombatArtsMenu
add r4,#0xC @usability of first menu option

LoopStart:
ldr r0,[r4]
cmp r0,#0
beq RetFalse
mov r14,r0
.short 0xF800
cmp r0,#1
beq GoBack
add r4,#36
b LoopStart

RetFalse:
mov r0,#3

GoBack:
pop {r4-r7}
pop {r1}
bx r1

.ltorg
.align



.equ StartMenuAdjusted,0x804EB98

CombatArtsEffect:
push {r14}

@StartMenuAdjusted takes menu definition offset in r0

ldr r0,=StartMenuAdjusted
mov r14,r0
ldr r0,=CombatArtsMenuDef
mov r1,#0
mov r2,#0
mov r3,#0
.short 0xF800

mov r0,#0x94		@play beep sound & end menu on next frame & clear menu graphics
pop {r1}
bx r1

.ltorg
.align


