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

mov r1, #0x62 		@ In the Teq doq BattleStruct, byte 0x62 is the unit's Avoid 
					@ and is saved as a Short: "0x62	Short	Avoid"

ldrh r0, [r4, r1] 	@ put the value into r0 
					@ get the value from r4's, (attacker) 0x62nd ____ 
					@ ldrh is load HALFWORD (which is a short) 
					@ the most common is a byte, which uses "ldrb" and "strb" 
					
					@ so: load halfword into r0 using the Attacker+0x62 short 
					
					
add r0,#20			@ add decimal 20 to r0 
strh r0, [r4, r1]	@ store r0 into the attacker + r1 (0x62) short 

GoBack:
pop {r4-r7}
pop {r0}
bx r0

.align

SkillTester:
@POIN SkillTester
@WORD VigilanceID
