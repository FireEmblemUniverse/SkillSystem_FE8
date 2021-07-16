
mov r0, #2 @ Eirika's deployment number 
@ BL 19430 // GetUnitStruct 
mov r0, r6 @ Eirika's unit struct 
@ ldr r3, =0x20255BB @ Idk, buffer return? or unused? 
ldr r4, =0x2025594 @ Idk, some ram location I guess 
str r0, [r4, #0x2C] @ 
mov r1, r4 
add r1, #0x30 
mov r2, r4 
add r2, #0x34 
mov r0, r5 @ Seth's ram unit struct pointer 

blh GetUnitDropLocation @ 32696
ldr r1, [r4, #0x30] @ X
ldr r2, [r4, #0x34] @ Y 

@ r8, r9, r10 all 0 













