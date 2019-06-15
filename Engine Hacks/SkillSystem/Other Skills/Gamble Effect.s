.thumb
@Gamble effect: exactly the same as attack except sets the Gamble flag
push {lr}
ldr r2, GambleMarker
mov r3, #5
strb r3, [r2]
ldr r2, =0x8022b30
mov lr, r2
.short 0xf800
pop {r1}
bx r1
.align
GambleMarker: @1 is rescue, 2 is pair up, 0 is nothing, 3 is Lunge, 4 is Mercy, 5 is Gamble
.long 0x203f101
