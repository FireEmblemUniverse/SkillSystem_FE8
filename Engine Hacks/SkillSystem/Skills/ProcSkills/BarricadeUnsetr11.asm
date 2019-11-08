
.thumb

.global UnnamedUnsetr11
.type UnnamedUnsetr11, %function
UnnamedUnsetr11:
ldrb r2, [ r3, #0x02 ]
mov r0, #0x07
and r0, r2
orr r0, r1
strb r0, [ r3, #0x02 ]
mov r0, #0x00
mov r11, r0
add sp, #0x8
pop { r4 - r6 }
pop { r0 }
bx r0
