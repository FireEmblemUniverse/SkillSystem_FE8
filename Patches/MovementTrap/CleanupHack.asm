.thumb 
.macro blh to, reg=r3
  ldr \reg, =\to
  mov lr, \reg
  .short 0xf800
.endm

.equ EnsureCameraOntoActiveUnitPosition, 0x801D31C
.equ SomePlayerPhaseRoutine, 0x801D344 

push {r4-r5, lr} 
mov r4, r0 @ parent proc 

blh EnsureCameraOntoActiveUnitPosition 
mov r5, r0 @ yield or not 

mov r0, r4 @ parent proc 
blh SomePlayerPhaseRoutine 

mov r0, r5 
pop {r4-r5} 
pop {r1} 
bx r1 
.ltorg 




