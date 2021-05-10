.thumb
.align

.equ VigilanceID,SkillTester+4

push {r4-r7,lr}
@goes in the battle loop.
@r0/r4 is the attacker battle struct 
@r1/r5 is the defender battle struct 
mov r4, r0
mov r5, r1

ldr r0, SkillTester
mov lr, r0
mov r0, r4
ldr r1, VigilanceID
.short 0xf800
cmp r0, #0
beq GoBack

mov r1, #0x62 		
ldrh r0, [r4, r1] 	
add r0,#20			
strh r0, [r4, r1]	

GoBack:
pop {r4-r7}
pop {r0}
bx r0

.align

SkillTester:
@POIN SkillTester
@WORD VigilanceID
