.thumb
.macro blh to, reg=r3
  ldr \reg, =\to
  mov lr, \reg
  .short 0xf800
.endm
.equ CurrentUnit, 0x3004E50
.equ GetUnit, 0x8019430 
.equ GetTarget, 0x804FD34 
.equ ShowUnitSMS, 0x8028130 
.equ HideUnitSMS, 0x802810C 
.equ MU_Create, 0x8078464
@push {r4-r6, lr} 
push {lr} 
@mov r6, r0 
@add r0, #0x4C 
@mov r1, #0 
@ldsh r0, [r0, r1] 
@blh GetTarget 
@mov r4, r0 
@mov r0, #0x2 
@ldsb r0, [r4, r0] 
@blh GetUnit 
@mov r5, r0 
@ldr r3, =CurrentUnit 
@ldr r3, [r3] 
@cmp r3, r5 
@bne Exit 




@ldr r0, [r3, #0x0C] @ state 
@mov r1, #1 
@orr r0, r1 @ hide 
@@ bic r0, r1 @ no hide 
@str r0, [r3, #0x0C] 

@mov r0, r3 @ unit 
@blh ShowUnitSMS 
@blh HideUnitSMS 

ldr r3, =CurrentUnit 
ldr r3, [r3] 
mov r0, r3
blh MU_Create 


Exit: 
@pop {r4-r6} 
pop {r0} 
bx r0 
.ltorg 

