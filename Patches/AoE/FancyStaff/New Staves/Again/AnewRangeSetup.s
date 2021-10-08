.equ Item_TURange, TargetFunc+4

.thumb

push {lr}

ldr r1, TargetFunc
ldr r3, Item_TURange
mov lr, r3
.short 0xF800

pop {r3}
bx r3

.ltorg
.align

TargetFunc:
@POIN TargetFunc
@POIN Item_TURange
