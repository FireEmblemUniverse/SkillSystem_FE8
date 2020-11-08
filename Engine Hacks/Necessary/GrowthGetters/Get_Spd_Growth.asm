.thumb
.org 0x0

.equ ClassGrowthOption, Extra_Growth_Boosts+4

@r0=battle struct or char data ptr
ldr		r1,[r0]
ldrb	r1,[r1,#31]	@spd growth
ldr 	r2,ClassGrowthOption
cmp		r2,#0
beq		GetExtraGrowthBoost
ldr 	r2,[r0,#4]
add		r2,#30
ldrb	r2,[r2]
add 	r1,r2

GetExtraGrowthBoost:
mov		r2,#13		@index of spd boost
ldr		r3,Extra_Growth_Boosts
bx		r3

.align
Extra_Growth_Boosts:
@
