.thumb 
push {r4, lr}
ldr r4, HackLocation
bl gotoR4
pop {r4}
pop {r1}
bx r1
gotoR4:
bx r4
.align
HackLocation:
    .long 0xDEADBEEF
