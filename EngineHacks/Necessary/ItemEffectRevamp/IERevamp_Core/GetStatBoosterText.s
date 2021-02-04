.thumb
.global GetStatBoosterText
.type GetStatBoosterText, %function

@arguments:
	@r0 = item id
@returns
	@r0 = text id
	@r1 = routine pointer

GetStatBoosterText:
ldr 	r3, =StatBoosterTextTable
loop:
ldrh 	r1, [r3]
cmp 	r1, r0	@compare item id to entry
beq 	match
cmp 	r1, #0x0	@check if at end of table
beq 	match
reloop:
add 	r3, #0x8 	@increment to next entry
b 	loop
match:
ldrh 	r0, [r3, #0x2]
ldr 	r1, [r3, #0x4]
bx 	lr
.align
