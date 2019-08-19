
.thumb
.align
.equ BlossomID, SkillTester+4

Blossom: @this is just very slightly edited Paragon
@ This is called once per battle struct by the EXPCalcLoop.
@ r0 = current EXP, r1 = this battle struct, r2 = enemy battle struct. Return modified EXP.
push { r4, lr }
mov r4, r0
mov r0, r1
ldr r1, BlossomID
ldr r2, SkillTester
mov lr, r2
.short 0xF800
cmp r0, #0x00
beq End
	
lsr r4, r4, #0x01 @ Halve EXP if they have Blossom.
cmp r4,#0
bne End
add r4,#1	

End:
mov r0, r4
pop { r4 }
pop { r1 }
bx r1

.ltorg
.align

SkillTester:
@POIN SkillTester
@WORD BlossomID
