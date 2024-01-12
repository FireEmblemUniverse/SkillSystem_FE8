.thumb 
.macro blh to, reg=r3
  ldr \reg, =\to
  mov lr, \reg
  .short 0xf800
.endm

.equ gBoolSramWorking, 0x203E88E @[203E88E]!! 
.equ MemorySlot,0x30004B8
.equ WriteAndVerifySRAMFast, 0x80d184c 
.equ gpVerifySramFast, 0x30067A4 
.equ gpReadSRAMFast, 0x030067A0
.equ IsSaveValid, 0x80a5218 
.equ gChapterData, 0x202BCF0 
.equ ReadLastGameSaveId, 0x80a4da0

.global CheckSRAMWorking 
.type CheckSRAMWorking, %function 
CheckSRAMWorking: @ 0x80D184C 
push {r4-r6, lr} 
@ldr r1, =gBoolSramWorking 
@ldrb r0, [r1] 
@blh ReadLastGameSaveId 
@b StoreValue 

ldr r0, =gChapterData 
ldrb r0, [r0, #0xC] 
blh IsSaveValid 
b StoreValue 



sub sp, #4 
mov r4, sp 
ldr r5, =0x12345678 
str r5, [r4] 
ldr r6, =0xE007FF8
mov r0, r4 @ sp 
@ r0 = sp holding 0x12345678 
mov r1, r6 @ dst 
mov r2, #4 @ 4 bytes 
blh WriteAndVerifySRAMFast
mov r0, #0 
str r0, [r4] 

mov r0, r6 @ src 
mov r1, r4 @ dst 
mov r2, #4 @ size 
ldr r3, =gpReadSRAMFast 
ldr r3, [r3] 
mov lr, r3 
.short 0xf800 
mov r11, r11 
ldr r0, [r4] 
add sp, #4 
cmp r0, r5 
beq SRAMWorking 
mov r0, #0 
b StoreValue 

SRAMWorking: 
mov r0, #1 
StoreValue: 
ldr r2, =MemorySlot 
str r0, [r2, #4*0x0C] 
Exit: 
pop {r4-r6} 
pop {r1} 
bx r1 
.ltorg 





