.thumb
.org 0x0

.set MagCharTable, Extra_Growth_Boosts+4
.set MagClassTable, MagCharTable+4
.set ClassGrowthOption, MagClassTable+4

@r0=battle struct or char data ptr
ldr		r1,[r0]
ldrb	r1,[r1,#4]	@unit ID growth
ldr 	r2, MagCharTable
lsl 	r1, #1 @index in mag char table
add 	r1, #1 @growth
ldrb 	r1, [r2, r1]
ldr 	r2,ClassGrowthOption
cmp		r2,#0
beq		GetExtraGrowthBoost

ldr		r2, [r0,#4]
ldrb	r2, [r2,#4]
ldr		r3, MagClassTable
lsl		r2, #2
add		r2, #1
ldrb	r2, [r3, r2]
add		r1, r2

GetExtraGrowthBoost:
mov		r2,#11		@index of str boost
ldr		r3,Extra_Growth_Boosts
bx		r3

.align
Extra_Growth_Boosts:
@
