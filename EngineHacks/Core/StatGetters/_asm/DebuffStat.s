.thumb
.macro blh to, reg=r3
  ldr \reg, =\to
  mov lr, \reg
  .short 0xf800
.endm

.global MaxMovCap
.type MaxMovCap, %function 
MaxMovCap:
@ r0 = movement 
@ r1 = unit 
ldr r2, =MaxMovementValue_Link
ldr r2, [r2] 
cmp r0, r2 
ble NoCapHere
mov r0, r2 
NoCapHere: 
@ returns new movement 
bx lr 
.ltorg 

.equ NextRN_N, 0x08000C80
GetDebuffAmount: 
push {r4, lr} 
mov r4, r2 @ bit offset 
mov r0, r1 @ unit 
bl GetUnitDebuffEntry 
mov r1, r4 @ bit offset 
ldr r2, =DebuffStatNumberOfBits_Link
ldr r2, [r2] 
bl UnpackData_Signed 
pop {r4} 
pop {r1} 
bx r1 
.ltorg 
@ 203F310
.global prDebuffMag
.type prDebuffMag, %function 
prDebuffMag:
push {r4-r5, lr}
mov r5, r0 @stat
mov r4, r1 @unit
ldr r2, =DebuffStatBitOffset_Mag
ldr r2, [r2] 
bl GetDebuffAmount 
add r0, r5 
mov r1, r4
pop {r4-r5}
pop {r2} 
bx r2 
.ltorg


.global prDebuffStr
.type prDebuffStr, %function 
prDebuffStr:
push {r4-r5, lr}
mov r5, r0 @stat
mov r4, r1 @unit
ldr r2, =DebuffStatBitOffset_Str
ldr r2, [r2] 
bl GetDebuffAmount 
add r0, r5 
mov r1, r4
pop {r4-r5}
pop {r2} 
bx r2 
.ltorg

.global prDebuffSkl
.type prDebuffSkl, %function 
prDebuffSkl:
push {r4-r5, lr}
mov r5, r0 @stat
mov r4, r1 @unit
ldr r2, =DebuffStatBitOffset_Skl
ldr r2, [r2] 
bl GetDebuffAmount 
add r0, r5 
mov r1, r4
pop {r4-r5}
pop {r2} 
bx r2 
.ltorg


.global prDebuffSpd
.type prDebuffSpd, %function 
prDebuffSpd:
push {r4-r5, lr}
mov r5, r0 @stat
mov r4, r1 @unit
ldr r2, =DebuffStatBitOffset_Spd
ldr r2, [r2] 
bl GetDebuffAmount 
add r0, r5 
mov r1, r4
pop {r4-r5}
pop {r2} 
bx r2 
.ltorg

.global prDebuffDef
.type prDebuffDef, %function 
prDebuffDef:
push {r4-r5, lr}
mov r5, r0 @stat
mov r4, r1 @unit
ldr r2, =DebuffStatBitOffset_Def
ldr r2, [r2] 
bl GetDebuffAmount 
add r0, r5 
mov r1, r4
pop {r4-r5}
pop {r2} 
bx r2 
.ltorg

.global prDebuffRes
.type prDebuffRes, %function 
prDebuffRes:
push {r4-r5, lr}
mov r5, r0 @stat
mov r4, r1 @unit
ldr r2, =DebuffStatBitOffset_Res
ldr r2, [r2] 
bl GetDebuffAmount 
add r0, r5 
mov r1, r4
pop {r4-r5}
pop {r2} 
bx r2 
.ltorg

.global prDebuffLuk
.type prDebuffLuk, %function 
prDebuffLuk:
push {r4-r5, lr}
mov r5, r0 @stat
mov r4, r1 @unit
ldr r2, =DebuffStatBitOffset_Luk
ldr r2, [r2] 
bl GetDebuffAmount 
add r0, r5 
mov r1, r4
pop {r4-r5}
pop {r2} 
bx r2 
.ltorg

.global prDebuffMov
.type prDebuffMov, %function 
prDebuffMov:
push {r4-r5, lr}
mov r5, r0 @stat
mov r4, r1 @unit
ldr r2, =DebuffStatBitOffset_Mov
ldr r2, [r2] 
bl GetDebuffAmount 
add r0, r5 
mov r1, r4
pop {r4-r5}
pop {r2} 
bx r2 
.ltorg


