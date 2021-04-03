.thumb

.macro blh2 to, reg=r3
	ldr \reg, \to
	mov lr, \reg
	.short 0xF800
.endm

GetDebuffs = EALiterals+0x0

AddDebuffStr:
push {r4-r6, lr}
mov r5, r0 @stat
mov r4, r1 @unit
mov r0,r4
blh2 GetDebuffs
mov r6,r0
@ ldr r6, EALiterals
@ ldrb r1, [r4 ,#0xB]     @Deployment number
@ lsl r1, r1, #0x3    @*8
@ add r6, r1          @r0 = *debuff data

@Str/2 Debuff NOTE TO SELF: off of base only.
ldr r2, [r6, #0x4]
mov r1, #0x40
and r2, r1
cmp r2, #0x0
beq noHalfStr
lsr r2, r5, #0x1F
add r5, r2
asr r5, #0x1            @Signed divide by two.
noHalfStr:

@Now get the debuff
@Strength debuff is LO nibble of 0th byte
ldrb r0, [r6]
mov r1, #0xF
and r0, r1 
@Subtract the debuff off.
sub r5, r0

@Silver debuff NOTE TO SELF: Recovers independantly of normal debuff
ldrb r0, [r6, #0x4]
mov r1, #0x1F           @Lower 5 bits
and r0, r1

@Subtract the debuff off
sub r5, r0

End:
mov r0, r5
mov r1, r4
pop {r4-r6,pc}
.ltorg
.align

EALiterals:
@POIN GetDebuffs
