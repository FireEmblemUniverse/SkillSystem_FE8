.macro blh to, reg=r3
  ldr \reg, =\to
  mov lr, \reg
  .short 0xf800
.endm
.thumb

@.equ ClearBG0BG1, 0x804E884 
.equ EventEngine, 0x800D07C
@.equ GetUnitStruct, 0x8019430 
.equ UnitAddItem, 0x8017948 
.equ gActionData, 0x203A958 
@.equ MemorySlot, 0x30004B8 
@.equ GetUnitByEventParameter, 0x0800BC51	
.equ Defender, 0x203A56C
@.equ CurrentUnit, 0x3004E50
.equ HandleNewItemGetFromDrop, 0x801E098 
.equ Attacker, 0x203A4EC

.type StealInvFull, %function 
.global StealInvFull
StealInvFull: 
push {lr} 
ldr r3, =0x203E1F0+0x62 
ldrb r3, [r3] 
cmp r3, #1 
bne Exit 
mov r2, r0 @ proc 
ldr r0, =Attacker 
ldr r1, =Defender 
add r1, #0x48 
ldrh r1, [r1] 
ldrh r3, [r0, #0x26] 
cmp r3, #0 
bne Handle 

blh UnitAddItem 
b Exit 
Handle: 

ldr r3, =gActionData 
mov r0, #0 
strb r0, [r3, #0x12] @ inv # 

ldr r0, =CallSteal2 
mov r1, #1 
blh EventEngine 


@blh HandleNewItemGetFromDrop 
Exit: 
pop {r0} 
bx r0 
.ltorg 

.type Steal2, %function 
.global Steal2 
Steal2:
push {lr} 
mov r2, r0 @ proc 
ldr r0, =Attacker 
ldr r1, =Defender 
add r1, #0x48 
ldrh r1, [r1] 
blh HandleNewItemGetFromDrop 
pop {r0} 
bx r0 
.ltorg 


