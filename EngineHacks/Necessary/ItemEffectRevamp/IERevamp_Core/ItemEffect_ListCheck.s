.thumb
@r0 holds item
@r1 holds pointer to list
push {r4,r14}
mov 	r4, r1
ldr 	r3, EIDGetter	@get effect id of item in r0
bl	Jump

LoopStart:
ldrb 	r2, [r4]
cmp 	r2, #0x0
beq 	LoopEnd
cmp 	r2, r0
beq 	LoopEnd
add 	r4, #0x1
b 	LoopStart
LoopEnd:
mov r0, r2
pop {r4}
pop {r3}
Jump:
bx r3
.align
EIDGetter:
