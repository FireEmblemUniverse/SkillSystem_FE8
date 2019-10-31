.thumb
.align

@hook at 2c846
@make a loop for this first check

.equ gTargetBattleUnit,0x203A56C
.equ CannotCounterReturn,0x802c857
.equ CanCounterReturn,0x802c865


@push {r4,r14}
ldr r1,=gTargetBattleUnit
ldr r0,[r1,#4]
ldrb r0,[r0,#4] @r0=class ID
mov r12,r1



@check for class ID in r0 to equal the value from the list
ldr r2,NoCounteringList
LoopStart:
ldrb r1,[r2]
cmp r1,#0
beq False
cmp r0,r1
beq True
add r2,#1
b LoopStart

True:
ldr r0, =CannotCounterReturn
b GoBack

False:
ldr r0, =CanCounterReturn

GoBack:
bx r0

.ltorg
.align
NoCounteringList:
@POIN NoCounteringList
