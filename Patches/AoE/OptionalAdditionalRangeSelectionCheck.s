.equ GetTrapAt, 0x802E1F0
.equ gMapUnit, 0x202E4D8
.equ MoveCostClear, 0x880BB96
.equ gMapTerrain, 0x202E4DC

.macro blh to, reg=r3
    ldr \reg, =\to
    mov lr, \reg
    .short 0xF800
.endm

.thumb

PUSH {r4,r5,r6,lr}

// input
// r0 = xCoord
// r1 = yCoord

// output - boolean - r0

b retTrue

MOV r4 ,r0
MOV r5 ,r1
LDR r0, =gMapUnit
LDR r0, [r0, #0x0]
LSL r6 ,r5 ,#0x2
ADD r0 ,r6, R0
LDR r0, [r0, #0x0]
ADD r0 ,r0, R4
LDRB r0, [r0, #0x0]
CMP r0, #0x0
BNE retFalse
    MOV r0 ,r4
    blh GetTrapAt
    CMP r0, #0x0
    BNE retFalse
        LDR r1, =MoveCostClear
        LDR r0, =gMapTerrain
        LDR r0, [r0, #0x0]
        ADD r0 ,r6, R0
        LDR r0, [r0, #0x0]
        ADD r0 ,r0, R4
        LDRB r0, [r0, #0x0]
        ADD r0 ,r0, R1
        LDRB r0, [r0, #0x0]
        LSL r0 ,r0 ,#0x18
        ASR r0 ,r0 ,#0x18
        CMP r0, #0x0
        BLE retFalse
            // retTrue
			retTrue:
            MOV r0, #0x1
            B end
        retFalse:
        MOV r0, #0x0
end:
POP {r4,r5,r6}
POP {r1}
BX r1
