.equ Item_Table, Growth_Options+4
.equ Passive_Boost_Bit, Item_Table+4
@r4=battle struct or char data ptr, r5 = growth so far (from char data), r6=index in stat booster pointer of growth

.thumb
push {r7, r14}

ldr r7,Growth_Options
ScrollCheck:
mov		r3,#0
mov		r0,#0x4
and		r7,r0			@bit is set if scrolls stack
ScrollLoop:
mov		r0,r4
add		r0,#0x1E
ldrh	r0,[r0,r3]
cmp		r0,#0
beq		End
lsl		r0,#0x18
lsr		r0,#0x18
mov		r1,#0x24
mul		r0,r1
ldr		r1,Item_Table
add		r0,r1
mov		r1,#0x8
ldr		r1,[r0,r1]
ldr		r2,Passive_Boost_Bit @bit signifying it's a scroll
tst		r1,r2
beq		NextItem
ldr		r0,[r0,#0xC]	@stat bonuses pointer
cmp		r0,#0x0
beq		NextItem
ldsb	r0,[r0,r6]
add		r5,r0
cmp		r7,#0x0
beq		End
NextItem:
add		r3,#0x2
cmp		r3,#0x8
ble		ScrollLoop

End:

pop {r7}
pop {r2}
bx r2

.align
.ltorg

Growth_Options:
