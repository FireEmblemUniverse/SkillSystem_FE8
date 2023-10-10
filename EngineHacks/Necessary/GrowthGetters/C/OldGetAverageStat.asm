.thumb 

.global OldGetAverageStat
.type OldGetAverageStat, %function 
OldGetAverageStat: 
push {r4-r5, lr} 

mov		r4,r0			@ save the growth, we'll need it
mul		r0,r1			@ multiply growth by # of levels
bl		DivideBy100		@ growth*level mod 100
mov r5, r1 @ avg level? 
add		r0,r4			@ add growth to remainder (if this >100, stat increases)
bl		DivideBy100		@ gotta do this just in case it goes over 200
mov r0, r1 @ result 
add r0, r5 @ avg lvl 
pop {r4-r5} 
pop {r1} 
bx r1 
.ltorg 

DivideBy100:
@takes r0=number, divides by 100, returns remainder in r0 and quotient in r1
mov		r1,#0
Label4:
cmp		r0,#100
blt		RetDiv
sub		r0,#100
add		r1,#1
b		Label4
RetDiv:
bx		r14
.ltorg 

