@r4=battle struct or char data ptr, r5 = growth so far (from char data), r6=index in stat booster pointer of growth

.thumb
push {r7, r14}

MetisCheck:
ldr     r7,Growth_Options
ldr		r0,[r4,#0xC]	@status word
mov		r1,#0x20
lsl		r1,#0x8			@metis tome
tst		r0,r1
beq		End
lsl		r0,r7,#0x10		@strip event id bits
lsr		r0,#0x18		@and remove the rest of the options
add		r5,r0			@metis tome boost

End:
pop {r7}
pop {r2}
bx r2

.align
.ltorg

Growth_Options:
