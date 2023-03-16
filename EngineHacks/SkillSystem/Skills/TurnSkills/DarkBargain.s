.thumb 

.global DarkBargain_CanUnitHeal
.type DarkBargain_CanUnitHeal, %function 
DarkBargain_CanUnitHeal:
ldrb r1, [r0, #9] @ exp 
cmp r1, #0 
beq CannotHeal 
cmp r1, #100 
bge CannotHeal 
mov r0, #1 
b Exit_DarkBargain_CanUnitHeal 

CannotHeal: 
mov r0, #0 
Exit_DarkBargain_CanUnitHeal: 
bx lr 
.ltorg 


.global DarkBargain_HealAmount
.type DarkBargain_HealAmount, %function 
DarkBargain_HealAmount: 
ldrb r1, [r0, #9] @ exp 
ldrb r2, [r0, #0x12] @ max hp 
ldrb r3, [r0, #0x13] @ current hp 
sub r2, r3 
cmp r1, r2 
ble NoCapHeal 
mov r1, r2 @ only heal by this much exp 
NoCapHeal: 
mov r2, r1 
sub r2, r1 @ final exp 
strb r2, [r0, #9] 
mov r0, r1 @ amount to heal by 
bx lr 
.ltorg 


















