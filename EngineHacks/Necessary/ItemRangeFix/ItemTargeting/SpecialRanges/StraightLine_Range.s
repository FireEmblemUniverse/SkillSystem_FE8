
.thumb
@arguments
	@r0= char pointer; 
	@r1= item id
@returns:
@	r0: 0 if this item/unit uses straight lines only 
@	r1: 0
.global StraightLine_Range 
.type StraightLine_Range, %function 
StraightLine_Range:
push 	{r4-r5, lr}
mov r4, r0 
mov r5, r1 
b UseStraightLines 
mov r0, #1 @ no straight lines 
b End 

UseStraightLines:
mov r0, r4 
mov r1, r5 
bl BuildStraightLineRangeFromUnitAndItem

mov r0, #1 
mov r1, #1 


End: 

pop {r4-r5} 
pop {r3}
bx	r3
.align
.ltorg


@ 18A1C

