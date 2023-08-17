.thumb

pop {r3}
b ReturnSequence
ldr r0, GetRandomNumberFunction
bl bxr0


ldr r0, AttackerData
ldr r0, [r0]
cmp r0, #0x00000000
beq or1

and1:
ldr r0, PhasePointer
ldrb r0, [r0, #0x00]
cmp r0, #0x00
bne ReturnSequence

@ldr r0, GetRandomNumberFunction
@bl bxr0
@b ReturnSequence

or1:
ldr r0, ActiveUnitDeploymentNumber
ldrb r0, [r0]
cmp r0, #0x00
bne and1

ReturnSequence:
@overwritten code
ldr r0, =0x2024CB8
ldr r0, [r0]
cmp r0, #0x0
beq Return
bl bxr0

Return:
pop {r0} 
ldr r1, RandomizerReturnTo
bx r1

bxr0:
bx r0
.ltorg 
.align 4
RandomizerReturnTo:
.long 0x08001344|1
GetRandomNumberFunction:
.long 0x08000C64|1
AttackerData:
.long 0x0203A4EC
PhasePointer:
.long 0x0202BCFF
ActiveUnitDeploymentNumber:
.long 0x03004E6A
