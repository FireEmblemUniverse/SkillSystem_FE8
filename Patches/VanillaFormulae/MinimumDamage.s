.align 4
.macro blh to, reg=r3
  ldr \reg, =\to
  mov lr, \reg
  .short 0xf800
.endm
.thumb

	.global MinimumDamage
	.type   MinimumDamage, function

@ in final PB calc loop and in negate def hack 
MinimumDamage:
push {r4-r5,lr}
mov r4, r0
mov r5, r1


mov r3, #0x5C @ Def
ldsh r0, [r5, r3]
cmp r0, #0 
bge NoCapDef1
mov r0, #0 
NoCapDef1:
mov r2, #0x5A @ Att 
ldsh r1, [r4, r2] @ Att
cmp r1, #0 
bge NoLowCapAtt1
mov r1, #0 
NoLowCapAtt1:
cmp r1, #99 
ble NoHighCapAtt1
mov r1, #99 
NoHighCapAtt1:
cmp r1, r0 
bgt CheckOther
add r0, #1
strh r0, [r4, r2] @ Store 

CheckOther:
mov r3, #0x5C @ Def
ldsh r0, [r4, r3]
cmp r0, #0 
bge NoCapDef2 
mov r0, #0 
NoCapDef2:
mov r2, #0x5A @ Att 
ldsh r1, [r5, r2] @ Att
cmp r1, #0 
bge NoLowCapAtt2
mov r1, #0 
NoLowCapAtt2:
cmp r1, #99 
ble NoHighCapAtt2
mov r1, #99 
NoHighCapAtt2:
cmp r1, r0 
bgt GoBack
add r0, #1
strh r0, [r5, r2] @ Store 

GoBack:
mov r0, r4
mov r1, r5
pop {r4-r5}
pop {r3}
bx r3

.align
.ltorg 

.global MaximumDamage
.type MaximumDamage, %function 
MaximumDamage:
push {r4-r5, lr} 
mov r4, r0 
mov r5, r1 
mov r1, #0x5A @ Att 
mov r3, #0x5C @ Def 
ldsh r0, [r4, r1] @ Att
ldsh r2, [r5, r3] @ Def
cmp r0, r2 
blt NoMaxDmg 
sub r0, r2 
cmp r0, #99 
ble NoMaxDmg 
mov r0, #99 
strh r0, [r4, r1] 
mov r2, #0 
strh r2, [r5, r3] 

NoMaxDmg: 

pop {r4-r5} 
pop {r0} 
bx r0 
.ltorg 


.global DamageModifierCalcLoopHook
.type DamageModifierCalcLoopHook, %function

DamageModifierCalcLoopHook: 
@push {r4-r6, lr} 
@mov r4, r0 
mov r6, r1 
ldr r5, [r4, #0x4c]
mov r0, #0x40 
and r5, r0 

push {lr} @ save lr so we can bl / blh 
mov r2, #0x4C 
ldr r2, [r4, r2] @ weapon ability word 
mov r3, #0x80 
lsl r3, #0xA @ Luna weapon bit 
and r2, r3 
cmp r2, #0 
bne DoNothing @ if the weapon negates def, we do the calc loop later 
mov r0, r4 @ Atkr 
mov r1, r6 @ Dfdr ?  
bl DamageModifierCalcLoopFunc
DoNothing:
mov r0, r4 @ atkr 
mov r1, r6 @ dfdr 

pop {r3}
mov r14, r3 
ldr r3, =0x802ADd9 @ return address 
bx r3 
.ltorg 
.align 

.type DamageModifierCalcLoopFunc, %function 
.global DamageModifierCalcLoopFunc 

DamageModifierCalcLoopFunc:
push {r4-r7, lr} 

mov r4, r0 @ atkr 
mov r5, r1 @ dfdr 
ldr r6, =DamageModifierCalcLoop @ a list of functions to go through 
sub r6, #4 
Loop:
add r6, #4 
ldr r3, [r6] 
cmp r3, #0 
beq Break
mov r0, r4 @ atkr 
mov r1, r5 @ dfdr 



mov r2, #1 
orr r3, r2 @ thumb mode 
mov r14, r3 
.short 0xF800 
b Loop 

Break:

pop {r4-r7} 
pop {r0} 

bx r0
.ltorg 
.align 




















