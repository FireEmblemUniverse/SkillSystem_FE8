.thumb
.equ MapWidth, 0x202E4D4
.equ MapHeight, 0x202E4D6

@Stride effect: boosts mov of all allied units by +3 within a 3 tile radius

@Also, be aware that it resets on suspend

push {lr}
ldr r2, StrideMarker
mov r3, #15
strb r3, [r2]
ldr r2, =0x8023E58   @chest effect - we choose this as it doesn't require combat
mov lr, r2
.short 0xf800

ldr r4,=#0x3004E50   @currently active unit
ldr r4,[r4]          @load character struct of unit we find
push {r0-r3}         @save these as we'll need to restore them after we're done
ldrb r0,[r4,#0x10]   @x-coordinate of skill holder
ldrb r1,[r4,#0x11]   @y-coordinate of skill holder



pop {r1}
bx r1
.align
StrideMarker: 
.long 0x203f101
@0 is nothing 
@1 is rescue 
@2 is pair up 
@3 is lunge 
@4 is mercy
@5 is gamble
@16 is stride