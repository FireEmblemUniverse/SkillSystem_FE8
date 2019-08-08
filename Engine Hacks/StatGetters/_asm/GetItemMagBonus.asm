.thumb
.org 0x0

PUSH {lr}   @GetItemMagBonus
MOV r2,#0x0
CMP r0,#0x0
BEQ End

MOV r1,#0xFF
AND r0 ,r1
LSL r1 ,r0 ,#0x3
ADD r0 ,r0, r1
LSL r0 ,r0 ,#0x2
ldr r1, ItemTable
ADD r0 ,r0, r1
LDR r0, [r0,#0xC]
CMP r0,#0x0
BEQ End

two:
LDRB r2, [r0,#0x9]
LSL r2 ,r2 ,#0x18
ASR r2 ,r2 ,#0x18

End:
MOV r0,r2
POP {r1}
BX r1

.align
ItemTable:
