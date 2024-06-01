.thumb 
.macro blh to, reg=r3
  ldr \reg, =\to
  mov lr, \reg
  .short 0xf800
.endm

.equ MemorySlot,0x30004B8
.equ GetUnitByEventParameter, 0x0800BC50
	
.global SetUnitDebuff_ASMC 
.type SetUnitDebuff_ASMC, %function 
SetUnitDebuff_ASMC: 
push {r4, lr} 
ldr r3, =MemorySlot 
ldr r0, [r3, #4*1] @ s1 as unit 
blh GetUnitByEventParameter 
mov r4, r0 @ unit 
bl IsUnitOnField 
cmp r0, #0 
beq ExitSet 
mov r0, r4 @ unit 
bl GetUnitDebuffEntry

ldr r3, =MemorySlot 
ldr r1, [r3, #4*3] @ what stat? 
cmp r1, #7 
bhi ExitSet @ do nothing for invalid stats 
ldr r2, =DebuffStatNumberOfBits_Link 
ldr r2, [r2] 
mul r1, r2 @ bit offset 
ldr r3, [r3, #4*4] @ s4 as new value for the stat 
bl PackData_Signed @ r0 = debuff entry, r1 = bit offset, r2 = # of bits, r3 = value 


ExitSet: 
pop {r4} 
pop {r0} 
bx r0 
.ltorg


@ turn based events occur before process debuffs/turn calc loop 

.global AddUnitDebuff_ASMC 
.type AddUnitDebuff_ASMC, %function 
AddUnitDebuff_ASMC: 
push {r4, lr} 
ldr r3, =MemorySlot 
ldr r0, [r3, #4*1] @ s1 as unit 
blh GetUnitByEventParameter 
mov r4, r0 @ unit 
bl IsUnitOnField 
cmp r0, #0 
beq ExitAdd
mov r0, r4 @ unit 
bl GetUnitDebuffEntry
mov r4, r0 @ debuff entry 

ldr r3, =MemorySlot 
ldr r1, [r3, #4*3] @ what stat? 
cmp r1, #7 
bhi ExitAdd @ do nothing for invalid stats 
ldr r2, =DebuffStatNumberOfBits_Link 
ldr r2, [r2] 
mul r1, r2 @ bit offset 
bl UnpackData_Signed 
@ r0 as old value 
ldr r3, =MemorySlot 
ldr r1, [r3, #4*3] @ what stat? 
ldr r2, =DebuffStatNumberOfBits_Link 
ldr r2, [r2] 
mul r1, r2 @ bit offset 
ldr r3, [r3, #4*4] @ s4 as value for the stat to add 
add r3, r0 
mov r0, r4 @ debuff entry 
bl PackData_Signed @ r0 = debuff entry, r1 = bit offset, r2 = # of bits, r3 = value 

ExitAdd: 
pop {r4} 
pop {r0} 
bx r0 
.ltorg 

.global SubUnitDebuff_ASMC 
.type SubUnitDebuff_ASMC, %function 
SubUnitDebuff_ASMC: 
push {r4, lr} 
ldr r3, =MemorySlot 
ldr r0, [r3, #4*1] @ s1 as unit 
blh GetUnitByEventParameter 
mov r4, r0 @ unit 
bl IsUnitOnField 
cmp r0, #0 
beq ExitSub
mov r0, r4 @ unit 
bl GetUnitDebuffEntry
mov r4, r0 @ debuff entry 

ldr r3, =MemorySlot 
ldr r1, [r3, #4*3] @ what stat? 
cmp r1, #7 
bhi ExitSub @ do nothing for invalid stats 
ldr r2, =DebuffStatNumberOfBits_Link 
ldr r2, [r2] 
mul r1, r2 @ bit offset 
bl UnpackData_Signed 
@ r0 as old value 
ldr r3, =MemorySlot 
ldr r1, [r3, #4*3] @ what stat? 
ldr r2, =DebuffStatNumberOfBits_Link 
ldr r2, [r2] 
mul r1, r2 @ bit offset 
ldr r3, [r3, #4*4] @ s4 as value for the stat to add 
sub r0, r3
mov r3, r0  
mov r0, r4 @ debuff entry 
bl PackData_Signed @ r0 = debuff entry, r1 = bit offset, r2 = # of bits, r3 = value 

ExitSub: 
pop {r4} 
pop {r0} 
bx r0 
.ltorg 


@ This version overwrites the entire debuff entry including 
@ rallies etc. and assumes a size of 8 bytes 
.global OverwriteUnitDebuff_ASMC 
.type OverwriteUnitDebuff_ASMC, %function 
OverwriteUnitDebuff_ASMC: 
push {r4, lr} 

ldr r3, =DebuffEntrySize_Link 
ldr r3, [r3] 
cmp r3, #8 
bne ExitOverwrite @ if not a size of 8, do not run 

ldr r3, =MemorySlot 
ldr r0, [r3, #4*1] @ s1 as unit 
blh GetUnitByEventParameter 
mov r4, r0 @ unit 
bl IsUnitOnField 
cmp r0, #0 
beq ExitOverwrite 
mov r0, r4 @ unit 
bl GetUnitDebuffEntry

ldr r3, =MemorySlot 
ldr r1, [r3, #4*3] @ s3 as first word 
str r1, [r0] 
ldr r2, [r3, #4*4] @ s4 as second word 
str r2, [r0, #4] 


ExitOverwrite: 
pop {r4} 
pop {r0} 
bx r0 
.ltorg  














