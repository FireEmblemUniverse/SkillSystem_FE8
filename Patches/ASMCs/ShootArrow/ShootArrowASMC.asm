.thumb 
.macro blh to, reg=r3
  ldr \reg, =\to
  mov lr, \reg
  .short 0xf800
.endm
.equ ProcStartBlocking, 0x8002CE0 

push {lr} 


mov r1, r0 @ parent proc 
ldr r0, MyProc 
blh ProcStartBlocking 

pop {r0} 
bx r0 
.ltorg 

MyProc: 



