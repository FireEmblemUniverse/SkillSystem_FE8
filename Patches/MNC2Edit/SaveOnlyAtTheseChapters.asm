.thumb
.macro blh to, reg=r3
  ldr \reg, =\to
  mov lr, \reg
  .short 0xf800
.endm
.global SaveOnlyAtTheseChapters
.type SaveOnlyAtTheseChapters, %function 
SaveOnlyAtTheseChapters: 
push {r4, lr} 
mov r4, r1 @ proc parent probably 
ldr r3, =SaveOnlyAtTheseChapters_List 
Loop: 
ldrb r1, [r3] 
cmp r1, #0xFF 
beq Break 
add r3, #1 
cmp r1, r0 
beq ReturnTrue 
b Loop 

ReturnTrue: 
mov r0, r4 
blh 0x80AA518 @ loadIceCrystal void int a1 (no idea) 

Break: 

pop {r4} 
pop {r0} 
bx r0 
.ltorg 

@ [0202BE5F]!
.global HealOnlyAtTheseChapters
.type HealOnlyAtTheseChapters, %function 
HealOnlyAtTheseChapters: 
push {lr} 
@  r1 as hp to set 

ldr r2, =0x202BCF0 @ ChapterData 
ldrb r2, [r2, #0x0E] @ chapter ID 
ldr r3, =HealOnlyAtTheseChapters_List 
Loop2: 
ldrb r0, [r3] 
cmp r0, #0xFF 
beq Break2 
add r3, #1 
cmp r0, r2 
bne Loop2 
@ Heal 
mov r0, r4 @ vanilla (unit struct) 
@ r1 already has hp to set 
blh 0x8019368 @SetUnitHp 
mov r0, r4 
mov r1, #0 
blh 0x80178D8 @SetUnitNewStatus @ eg. remove burn etc. 

Break2: 
pop {r0} 
bx r0 
.ltorg 


