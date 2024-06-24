
.thumb

.equ VeteranID, SkillTester+4

Veteran: @ Edited to fit the EXPCalcLoop. - Snek
@ This is called once per battle struct by the EXPCalcLoop.
@ r0 = current EXP, r1 = this battle struct, r2 = enemy battle struct. Return modified EXP.
push { r4, lr }
mov r4, r0
mov r0, r1
ldr r1, VeteranID
ldr r2, SkillTester
mov lr, r2
.short 0xF800
cmp r0, #0x00
beq End
	mov r2, #0x03
	mul r4, r4, r2 @ Multiply by 3
	lsr r4, r4, #0x01 @ Halve after mult by 3
End:
mov r0, r4
pop { r4 }
pop { r1 }
bx r1

SkillTester:
@POIN SkillTester
@WORD VeteranID
