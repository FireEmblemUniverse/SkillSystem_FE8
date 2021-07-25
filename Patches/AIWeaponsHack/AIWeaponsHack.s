.thumb 

mov r7, #0 
mov r0, #0x1E 
mov r8, r0 @ Item 
ldr r0, =TestTable 
mov r6, #0x0 
ldrh r4, [r0] 
@strh r4, [r5, #0x1E]
ldrh r4, [r5, #0x1E]
cmp r4, #0x0 

ldr r3, =0x80398AD @ A few lines into GetUnitAIAttackPriority 
bx r3 




