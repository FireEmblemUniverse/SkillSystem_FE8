.thumb 
.type MakeThumb, %function 
.global MakeThumb 

MakeThumb:
push {lr}
@ given function address in r0 and parameter in r1, execute function 

mov r3, #0x8 
lsl r3, #24 
orr r0, r3 
mov r14, r0 
mov r0, r1 @ Unit in this case 
.short 0xF800 

pop {r1}
bx r1 

.align 










