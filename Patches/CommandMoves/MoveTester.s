


.thumb
.align 4

.macro blh to, reg=r3
  ldr \reg, =\to
  mov lr, \reg
  .short 0xf800
.endm

.global MoveTester
.type MoveTester, %function 

@ given r0 = unit struct, r1 = move ID, return T/F whether unit knows this move 
MoveTester:
push {r4, lr} 

mov r4, #0 @ False by default 

mov r3, #0x27  
Loop:
add r3, #1 
cmp r3, #0x2D 
bge ExitLoop 
ldrb r2, [r0, r3] 
cmp r2, r1 
bne Loop 
mov r4, #1 @ True 

ExitLoop: 
mov r0, r4 

pop {r4}
pop {r1}
bx r1 










