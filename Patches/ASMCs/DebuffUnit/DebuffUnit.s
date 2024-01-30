.macro blh to, reg=r3
  ldr \reg, =\to
  mov lr, \reg
  .short 0xf800
.endm
.macro blh_2 to, reg=r3 @ for EA literals 
  ldr \reg, \to
  mov lr, \reg
  .short 0xf800
.endm
.thumb

.equ GetUnitByEventParameter, 0x0800BC50
.equ MemorySlot, 0x30004B8 

.type DebuffUnitASMC, %function
.global DebuffUnitASMC 
DebuffUnitASMC:
push {r4-r5, lr}

ldr r3, =MemorySlot
ldr r0, [r3, #4] @ Unit ID 
blh GetUnitByEventParameter
cmp r0, #0
beq Error
mov r4, r0 

bl GetUnitDebuffEntry
mov r11, r11 
ldr r4, =MemorySlot
ldr r1, [r4, #4*3] @ Debuffs to do 
@r0 @ debuff entry 
@r1 debuff table to use 
@r2 entry ID of the given table 
mov r2, #0 
mov r3, r0 
bl DebuffGivenTableEntry 



End:
Error:



pop {r4-r5}
pop {r0}
bx r0

.ltorg 
.align 
GetDebuffs:



