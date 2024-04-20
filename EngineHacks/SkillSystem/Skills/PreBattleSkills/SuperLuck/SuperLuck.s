.thumb
.equ SuperLuckID, SkillTester+4

push {r4, lr}
mov	r4,r0		    @get user into r4 for later

@go to skill check
ldr	r1,SuperLuckID
ldr	r2,SkillTester	@test for SuperLuck skill
mov	r14,r2
.short	0xF800
cmp	r0,#0x00
beq	End		        @if skill not found do nothing

@apply skill
mov r0,#0x66        @crit offset
mov r2,#0x19        @luck offset
ldrb r2,[r4,r2]     @load luck offset value (as byte)
strh r2,[r4,r0]     @store luck as crit (short)

End:
pop	{r4}
pop	{r0}
bx	r0

.align
.ltorg
SkillTester:
@POIN SkillTester
@WORD SuperLuckID
