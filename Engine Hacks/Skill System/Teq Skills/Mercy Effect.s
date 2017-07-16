.thumb
@Mercy effect: exactly the same as attack except sets the Mercy flag
push {lr}
ldr r2, MercyMarker
mov r3, #4
strb r3, [r2]
ldr r2, =0x8022b30
mov lr, r2
.short 0xf800
pop {r1}
bx r1
.align
MercyMarker: @1 is rescue, 2 is pair up, 0 is nothing, 3 is lunge, 4 is mercy, 5 is gamble
.long 0x203f101
