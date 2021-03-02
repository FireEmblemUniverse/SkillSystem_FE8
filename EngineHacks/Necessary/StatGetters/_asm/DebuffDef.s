.thumb

.macro blh2 to, reg=r3
	ldr \reg, \to
	mov lr, \reg
	.short 0xF800
.endm

GetDebuffs = EALiterals+0x0

AddDebuffDef:
push {r4-r5, lr}
mov r5, r0 @stat
mov r4, r1 @unit
mov r0,r4
blh2 GetDebuffs
mov r2,r0
@ ldr r6, EALiterals
@ ldrb r1, [r4 ,#0xB]     @Deployment number
@ lsl r1, r1, #0x3    @*8
@ add r6, r1          @r0 = *debuff data

@Now get the debuff
@Def debuff is HO nibble of 1st byte
ldr r0, [r2]
mov r1, #0xF
lsl r1, #0xC
and r0, r1 
lsr r0, #0xC
@Subtract the debuff off.
sub r5, r0

End:
mov r0, r5
mov r1, r4
pop {r4-r5,pc}
.ltorg
.align

EALiterals:
@POIN GetDebuffs
