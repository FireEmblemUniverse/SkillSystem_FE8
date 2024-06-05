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

sub r2, r3 @ max amount to heal by 
cmp r1, r2 @ do we have less exp than this 
bge HealAmountInR2 @ we have at least this much exp 
mov r2, r1 @ amount we can heal by 
HealAmountInR2: 
sub r1, r2 @ new exp 
strb r1, [r0, #9] 
mov r0, r2 @ amount to heal by 
bx lr 
.ltorg 


















