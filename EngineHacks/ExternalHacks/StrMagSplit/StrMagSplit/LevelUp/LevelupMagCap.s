.thumb
@Hook 0802C008
@r2  keep  RAMUnit
@r5  keep  ? preBattleUnit?
@r12 keep  BattleUnit

mov r0, #0x3A  @mag
ldsb r0, [r2, r0] @Unit->Mag

mov r3, r12
add r3, #0x7A
mov r1, #0x0
ldsb r1, [r3, r1] @BattleUnit->ConGrow (Mag)
add r0 ,r0, r1    @Unit->Mag + BattleUnit->ConGrow (Mag)

@get mag cap
mov r3, r12
ldr r3, [r3, #0x4]
ldrb r3, [r3, #0x4]  @BattleUnit->Class->ID
lsl r3, #0x2 @ ClassID * 4

mov r1, r0 
ldr r0, MagClassTable
add r3, r0

ldrb r0, [r3, #0x2] @MagClassTable[ClassID].MagicCap
push {r2} 
push {lr} 
mov r0, r12 @ bunit 
mov r1, r2 @ unit 
@mov r2, @ unit  
bl RandomizeStatCaps
pop {r3} 
pop {r2} 



@Resend breaking code
mov r0, #0x19
ldsb r0, [r2, r0]
mov r3, r12
add r3, #0x79

ldr r1, =0x0802C010|1
bx r1

.ltorg
.align 4
MagClassTable:
