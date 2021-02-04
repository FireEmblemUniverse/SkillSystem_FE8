.thumb

.macro blh to, reg=r3
	ldr \reg, =\to
	mov lr, \reg
	.short 0xF800
.endm

AddRallyStr:
push {r4-r6, lr}
mov r5, r0 @stat
mov r4, r1 @unit
ldr r6, EALiterals
ldrb r1, [r4 ,#0xB]     @Deployment number
lsl r1, r1, #0x3    @*8
add r6, r1          @r0 = *debuff data

@hp/2 Debuff NOTE TO SELF: off of base only.
ldr r2, [r6, #0x4]
mov r1, #0x80
and r2, r1
cmp r2, #0x0
beq noHex
lsr r2, r5, #0x1F
add r5, r2
asr r5, #0x1            @Signed divide by two.
noHex:

End:
mov r0, r5
mov r1, r4
pop {r4-r6,pc}
.ltorg
.align

EALiterals:
@POIN DebuffTable
