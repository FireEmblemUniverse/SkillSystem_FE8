.thumb
@Overgrowth effect: exactly the same as attack except sets the Overgrowth flag
push {lr}
ldr r2, OvergrowthMarker
mov r3, #15
strb r3, [r2]
ldr r2, =0x8022b30
mov lr, r2
.short 0xf800
pop {r1}
bx r1
.align
OvergrowthMarker: 
.long 0x203f101
@0 is nothing 
@1 is rescue 
@2 is pair up 
@3 is lunge 
@4 is mercy
@5 is gamble
@6 is overgrowth
