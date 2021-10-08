.thumb

mov r0, r6
ldr r3, AnewEffect
mov lr, r3
.short 0xF800
ldr r1,=#0x802FF77
bx r1

.ltorg
.align

AnewEffect:
@POIN AnewEffect
