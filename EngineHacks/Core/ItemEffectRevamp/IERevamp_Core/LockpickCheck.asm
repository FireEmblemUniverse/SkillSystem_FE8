.thumb
@lockpick ability check
@r0 holds character pointer
@result returned in r0

push {r14}
ldr 	r1, [r0, #0x4]
ldr 	r0, [r0]
ldr 	r0, [r0, #0x28]
ldr 	r1, [r1, #0x28]
orr 	r0, r1
mov 	r1, #0x8
and 	r0, r1
pop {r1}
bx r1
.align
