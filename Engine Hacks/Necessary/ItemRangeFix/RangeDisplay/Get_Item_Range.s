.thumb
.org 0x0
@modifed version of tequila's displayed weapon/staff range display fix
.set Total, 0xFF @value used to represent total range
.set Bitfield_Constructor, 0xFFFE0000

.equ itemrange, OffsetList + 0x0
@arguments:
	@r0 = unit pointer
	@r1 = item/uses short
push 	{r4,r14}
@ldr 	r2, itemrange
@bl 	jump_r2
bl		GetItemRangeM	@return max range in r0 and min range in r1
cmp 	r0, #Total
bne NotTotal
mov 	r0,#0x0
mov 	r1,r0
b 	GoBack
NotTotal:
cmp 	r1, #0xF
bhi 	MakeHalfword
cmp 	r0, #0xF
bhi 	MakeHalfword
lsl 	r1, r1, #0x4
orr 	r0, r1
@here, we make the range bitfield
ldr		r1,=Bitfield_Constructor
@mov		r0,r4
Label1:
cmp		r0,#0x20
blt		Label2
lsl		r1,r1,#0x1
sub		r0,#0x10
b		Label1
Label2:
neg		r0,r0
add		r0,#0x1F
lsl		r1,r0
lsr		r1,r0
mov		r0,r1
lsr		r0,r0,#0x11
mov		r1,#0x0
b		GoBack
MakeHalfword:
lsl 	r1, r1, #0x8
orr 	r1, r0
mov 	r0, #0x0
GoBack:
pop 	{r4}
pop 	{r2}
jump_r2:
bx	r2
.ltorg
.align
OffsetList:
@item range getter
