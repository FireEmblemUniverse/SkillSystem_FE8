
.thumb

.macro blh to, reg
    ldr \reg, =\to
    mov lr, \reg
    .short 0xF800
.endm

.equ ComputeEXPFromBattle, 0x0802C534

.global EXPCalcLoop
.type EXPCalcLoop, %function
EXPCalcLoop: @ Autohook to 0x0802b960. This is gonna be kinda weird tbh.
@ THE PLAN: Loop through EXPCalcFunctions twice: Once for the attacker and once for the defender.
@ Also edit any functions called to take a character (really battle I suppose) struct as an argument. (Also assume they return the changed EXP value)
@ r0 = attacker's EXP, r4 = defense struct, r5 = attack struct.
mov r6, r5
add r6, r6, #0x6E @ r6 is used later in the vanilla function to load EXP. Use r4 and r5.
push { r7 }
@cmp r0, #0x00
@beq AttackerStore @ Immediately end if 0 EXP is passed through.
@NO, this means that any AI units are never check on their phase
@ Now to loop through all functions in EXPCalcFunctions for the attacker.
ldr r7, =EXPCalcFunctions
AttackerLoop:
ldr r3, [ r7 ]
cmp r3, #0x00
beq EndAttackerLoop
	mov r1, r5 @ Attack struct.
	mov r2, r4 @ Defense struct.
	mov lr, r3
	.short 0xF800 @ Each function takes EXP as the first parameter and returns their edited value.
	add r7, r7, #0x04
	b AttackerLoop
EndAttackerLoop:
@ So r0 = EXP to store.
cmp r0, #100
ble AttackerStore
	mov r0, #100 @ As a final measure, ensure EXP doesn't exceed 100.
AttackerStore:
strb r0, [ r6 ]
@ Same deal now except for the defender. First calculate defender's EXP.
mov r0, r4 @ Defense struct
mov r1, r5 @ Attack struct
blh ComputeEXPFromBattle, r2
@cmp r0, #0x00
@beq DefenderStore @ Immediately end if 0 EXP is passed through.
ldr r7, =EXPCalcFunctions
DefenderLoop:
ldr r3, [ r7 ]
cmp r3, #0x00
beq EndDefenderLoop
	mov r1, r4 @ Defense struct
	mov r2, r5 @ Attack struct.
	mov lr, r3
	.short 0xF800 @ Each function takes EXP as the first parameter and returns their edited value.
	add r7, r7, #0x04
	b DefenderLoop
EndDefenderLoop:
@ r0 = final EXP.
cmp r0, #100
ble DefenderStore
	mov r0, #100
DefenderStore:
mov r1, r4
add r1, r1, #0x6E
strb r0, [ r1 ]
pop { r7 }
ldr r1, =#0x0802B975
bx r1
