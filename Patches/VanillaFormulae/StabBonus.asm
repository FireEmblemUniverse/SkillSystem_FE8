@ callhack with r3 at 2AAD0 (in BattleLoadAttack / BC_Power)

.thumb
.align 4

.macro blh to, reg=r3
  ldr \reg, =\to
  mov lr, \reg
  .short 0xf800
.endm

@ r0 = item might 
@ r6 = attacker 
@ r8 = defender 

.global StabBonusFunc
.type StabBonusFunc, %function 

StabBonusFunc: 
push {r4-r7, lr} 
mov r4, r6 @ attacker  
mov r5, r8 @ dfdr 
mov r6, r0 @ wep might 


mov r1, #0x48 
ldrh r0, [r4, r1] @ atkr wep after bttl and is what vanilla uses so whatever - 4A before  

ldr r1, [r4, #4] 
ldrb r1, [r1, #4] @ Class ID 

bl ShouldWeaponHaveStabBonus



mov r0, r6 @ wep might 
@ r0 should be weapon might at this point 

pop {r4-r7} 

@ vanilla stuff at end 

mov r1, r6
add r1, #0x54 
ldrb r1, [r1]
lsl r1, #24  
asr r1, #24 
add r1, r0 
@mov r4, r6 

pop {r2} 
bx r2 


ShouldWeaponHaveStabBonus:
@ given r0 = wep and r1 = class id, determine if they should have stab bonus or not 
push {r4-r7, lr} 




False_WeaponStabBonus:

True_WeaponShouldHaveStabBonus:


Exit_WeaponHaveStabBonus:

pop {r4-r7} 
pop {r1} 
bx r1 


EquateStabBonus:
@ give r0 = mt, add 50% mt 
push {r4-r7, lr} 


pop {r4-r7} 
pop {r1} 
bx r1 

