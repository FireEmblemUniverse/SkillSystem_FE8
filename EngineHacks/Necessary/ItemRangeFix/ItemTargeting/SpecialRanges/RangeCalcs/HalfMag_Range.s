.thumb
@arguments
@	r0: unit pointer
@	r1: item id
@returns:
@	r0: new max range
@	r1: new min range

push 	{lr}
ldr 	r3, HalfMagRange
mov r14, r3
.short 0xF800
mov 	r1, #0x1
pop {r3}
bx	r3
.align
.ltorg
HalfMagRange:
