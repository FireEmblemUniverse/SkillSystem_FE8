.thumb
.macro blh to, reg=r3
  ldr \reg, =\to
  mov lr, \reg
  .short 0xf800
.endm
.global HookCopyToPaletteBuffer
.type HookCopyToPaletteBuffer, %function 
.equ ProcFind, 0x08002E9C

.equ CPUSet, 0x80D1678
.equ CPUFastSet, 0x80D1674
.equ NextRN_N, 0x8000C80
HookCopyToPaletteBuffer: @ hooks $DCC 
push {r4-r7, lr} 

ldr r0, =0x20228A8 @ palette buffer 
add r1, r0 
lsr r2, r3, #0x1F 
add r2, r3 
lsl r2, #0xA 
lsr r2, #0xB

@ r4 already has src 
mov r5, r1 @ dst 
mov r6, r2 @ config 
 
mov r0, r4 
mov r1, r5 
mov r2, r6 
blh CPUSet 

ldr r0, =0x859AD50 @ MOVELIMITVIEW 
blh ProcFind 
cmp r0, #0 
bne DontFilter

mov r0, #10 
blh NextRN_N 
sub r0, #7 
push {r0} 
mov r0, #10 
blh NextRN_N 
sub r0, #7 
push {r0} 
mov r0, #10 
blh NextRN_N 
sub r0, #7 
mov r3, r0 
pop {r1-r2} @ random numbers as colour filters 
sub sp, #4 
str r4, [sp] 
mov r0, r5 @ dst 
bl FilterPalette
add sp, #4 
DontFilter: 

pop {r4-r7} 
pop {r3} 
bx r3 

.ltorg 
@   r0: dst 
@   r1: RModifier, [-31, 31]
@   r2: GModifier, [-31, 31]
@   r3: BModifier, [-31, 31]
@   [sp]: Palette address

.global HookCopyToPaletteBuffer2
.type HookCopyToPaletteBuffer2, %function 

HookCopyToPaletteBuffer2: @ hooks $DEC  
push {r4-r7, lr} 

mov r2, r3 
cmp r2, #0 
bge Skip 
add r2, #3 
Skip: 
lsl r2, #9 
lsr r2, #0xB 

@ r4 already has source 
@ void CpuFastSet(const void* src, void* dst, unsigned config);
mov r5, r1 @ dst 
mov r6, r2 @ config 



mov r0, r4 
mov r1, r5 
mov r2, r6 
blh CPUFastSet 



ldr r0, =0x859AD50 @ MOVELIMITVIEW 
blh ProcFind 
cmp r0, #0 
bne DontFilter2

mov r0, #10 
blh NextRN_N 
sub r0, #7 
push {r0} 
mov r0, #10 
blh NextRN_N 
sub r0, #7 
push {r0} 
mov r0, #10 
blh NextRN_N 
sub r0, #7
mov r3, r0 
pop {r1-r2} @ random numbers as colour filters 
sub sp, #4 
str r4, [sp] 
mov r0, r5 @ dst 
bl FilterPalette
add sp, #4 
DontFilter2: 
pop {r4-r7} 
pop {r3} 
bx r3 

.ltorg 










