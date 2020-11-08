.thumb
@Master Key Usability
@r0 holds ram character pointer

push {r4,r14}
mov 	r4, r0
ldr 	r3, ChestCheck	@check if on top of a chest tile?
bl Jump
lsl 	r0,r0, #0x18
cmp 	r0, #0x0
bne TrueCase
mov 	r0, r4
ldr r3, DoorCheck		@check if next to a door tile?
bl Jump
lsl 	r0,r0, #0x18
cmp 	r0, #0x0
bne TrueCase
mov 	r0, r4
ldr r3, Routine3
bl Jump
lsl 	r0,r0, #0x18
cmp 	r0, #0x0
bne TrueCase
mov r0, #0x0
b PopBack
TrueCase:
mov 	r0, #0x1
PopBack:
pop {r4}
pop {r1}
bx r1
Jump:
bx r3
.align
ChestCheck:
.long 0x80290FC | 1
DoorCheck:
.long 0x8029138 | 1
Routine3:
.long 0x802914C | 1
