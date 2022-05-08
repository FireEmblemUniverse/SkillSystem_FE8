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

.type DebuffUnit, %function
.global DebuffUnit 
DebuffUnit:
push {r4-r5, lr}

ldr r3, =MemorySlot
ldr r0, [r3, #4] @ Unit ID 
blh GetUnitByEventParameter
cmp r0, #0
beq Error
mov r4, r0 

blh_2 GetDebuffs
mov r5, r0 @ ram address of unit's debuffs - 8 bytes 
ldr r4, =MemorySlot
ldr r3, [r4, #4*3] @ Debuffs to do 

mov r11, r11 
ldrb r0, [r5] @ (str/skl/spd/def/res/luk)
orr r0, r3 
strb r0, [r5] 
lsr r3, #8 @ for next byte 

ldrb r0, [r5, #1]
orr r0, r3 
strb r0, [r5, #1] 
lsr r3, #8 

ldrb r0, [r5, #2] 
orr r0, r3
strb r0, [r5, #2] 
lsr r3, #8 

ldrb r0, [r5, #5] 
orr r0, r3 
strb r0, [r5, #5] 

@lsl r0, #28
@lsr r0, #28 @ mag only 



Error:



pop {r4-r5}
pop {r0}
bx r0

.ltorg 
.align 
GetDebuffs:



