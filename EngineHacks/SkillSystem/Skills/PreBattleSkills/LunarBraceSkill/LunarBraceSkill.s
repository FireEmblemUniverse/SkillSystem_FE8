.thumb
.equ LunarBraceID, SkillTester+4

push {r4-r7, lr}
mov r4, r0 @attacker
mov r5, r1 @defender

@check for the defender having Lunar Brace
ldr r0, SkillTester
mov lr, r0
mov r0, r5 @defender data
ldr r1, LunarBraceID
.short 0xf800
cmp r0, #0
beq End

@skip if unit isn't the defender
mov 	r0, r5
ldr     r2,=0x203a4ec @defender
cmp     r0,r2
bne     End

@and set attacker (def or res)=(def or res)*.75
mov r1, #0x5C
ldrh r0, [ r4, r1 ] @Load def/res
mov r2, #0x3 
mul r0,r2 @Multiply def/res by 3
lsr r0,r0,#0x2 @Divide def/res by 4
strh r0, [ r4, r1 ]


End:
pop {r4-r7, r15}
.align
.ltorg
SkillTester:
@POIN SkillTester
@WORD LunarBraceID
