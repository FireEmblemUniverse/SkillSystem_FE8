.thumb 
.macro blh to, reg=r3
    ldr \reg, =\to
    mov lr, \reg
    .short 0xF800
.endm
.equ ReturnAddress, 0x8027344|1 
.equ POIN_SMS_Table, 0x8026C88 
.equ gSMSGfxIndexLookup, 0x80268C4 

@ r0 and r2 are important 
@ SMS vram obj tile to use (eg. 0xE080 as palette E and first SMS square to use) 
strh r0, [r5, #8] 

@mov r2, r9 @ vanilla uses the address in r9 to load the value of SMS size 
@ldrh r0, [r2] 
@strb r0, [r5, #0xB] 

ldr r3, =gSMSGfxIndexLookup 
ldr r3, [r3] 
@ r2 is provided by an edit to SMS_RegisterUsage
sub r2, r3 @ SMS index 

ldr r3, =POIN_SMS_Table @ POIN SMS table 
ldr r3, [r3] 
lsl r2, #3 @ 8 bytes per entry 
add r2, r3 @ regular SMS table entry 
add r2, #2 @ sms entry + offset 0x02 Size 
@ default is 0x8AFBB2 as light rune trap SMS size for everything but ballistas, I think 
mov r9, r2 @ vanilla has the address of light rune +0x02 size
ldrh r2, [r2] 
strb r2, [r5, #0x0B] @ size 

ldr r3, =ReturnAddress 
bx r3 
.ltorg 


