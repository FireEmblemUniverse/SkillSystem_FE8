.thumb
.align


.global CombatArtsUsability
.type CombatArtsUsability, %function

.global CombatArtsEffect
.type CombatArtsEffect, %function




CombatArtsUsability:
push {r4-r7,r14}







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
.short 0xF800

mov r0,#0x94		@play beep sound & end menu on next frame & clear menu graphics
pop {r1}
bx r1

.ltorg
.align


