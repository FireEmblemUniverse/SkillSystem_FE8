.thumb

.macro blh to, reg=r3
	ldr \reg, =\to
	mov lr, \reg
	.short 0xF800
.endm

AddRallyStr:
push {r4-r6, lr}
mov r5, r0 @unit
mov r4, r1 @stat
ldr r6, EALiterals
ldrb r1, [r4 ,#0xB]     @Deployment number
lsl r1, r1, #0x3    @*8
add r6, r1          @r0 = *debuff data

@Now get the debuff
@Speed debuff is LO nibble of 1st byte
ldr r0, [r6]
mov r1, #0xF
lsl r1, #0x8
and r0, r1 
lsr r0, #0x8
@Subtract the debuff off.
sub r5, r0


End:
mov r0, r5
mov r1, r4
pop {r4-r6,pc}
.ltorg
.align

EALiterals:
@POIN DebuffTable
