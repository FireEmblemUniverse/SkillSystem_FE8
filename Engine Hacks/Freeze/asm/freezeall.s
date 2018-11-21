.thumb
@freeze all enemies

push {r4-r6,lr}
mov r4, #0x81 @first enemy
ldr r5, =0x8019430 @get ram from dplynum
mov r6, #0x30 @status byte
NextEnemy:
mov r0, r4
mov lr, r5
.short 0xf800
@r0 is now ram
mov r1, #0x19
strb r1, [r0, r6]
add r4, #1
cmp r4, #0xC0
blt NextEnemy
pop {r4-r6}
pop {r0}
bx r0
