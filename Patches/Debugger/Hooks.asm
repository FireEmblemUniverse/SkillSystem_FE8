
.thumb

.global CallDebuggerProc
.type CallDebuggerProc, %function 
CallDebuggerProc: 
push  {r14}
bl StartKeyListenerProc


ldr r0, =0x858791c 
ldr r0, [r0] @ 0x2024cc0
ldrh r1, [r0, #8] @ new button 
mov r0, #2 
tst r0, r1 
bne PressedB
mov r0, #1 
and r0, r1 
cmp r0, #0 
pop {r3} 
bx r3 
.ltorg 

PressedB: 


mov r0, r6 @ parent 
bl StartDebuggerProc
pop {r3} 
ldr r3, =0x801Cb65 
bx r3 
.ltorg 
