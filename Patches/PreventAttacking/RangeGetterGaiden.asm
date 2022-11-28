.thumb 
.type RangeGetterGaiden, %function 
.global RangeGetterGaiden 
RangeGetterGaiden: 
push {r4-r6, lr} 
mov r4, r0 @ unit 
mov r5, r1 @ item 
bl ItemRangeGetter
mov r6, r0 @ min max range 

mov r0, r4 
mov r1, r5 
bl Get_Item_Range
mov r1, r6 @ min max range 

pop {r4-r6} 
pop {r2} 
bx r2 
.ltorg 


