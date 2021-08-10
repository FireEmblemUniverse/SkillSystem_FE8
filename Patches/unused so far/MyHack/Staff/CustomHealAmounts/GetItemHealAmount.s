.equ RecoverItemList, MendItemList+0x4
.equ GetUnitMag, MendItemList+0x8
.equ ItemTable, MendItemList+0xC

.macro blh to, reg=r3
ldr \reg, =\to
mov lr, \reg
.short 0xF800
.endm

.thumb

PUSH {r4,lr}   //GetItemHealAmount
MOV r3 ,r0 // r3 = r0 input (unit)
MOV r2 ,r1 // r2 = r1 input (item)
MOV r4, #0x0 // r4 = 0
MOV r0, #0xFF // r0 = FF
AND r0 ,r2 // get low byte
MOV r1, r0

PUSH {r2} // idk whats in here

// item id check (r0)

LDR r1, MendItemList
MendLoopStart:
LDRB r2, [r1] // get next item
CMP r0, r2 // compare to current item
BEQ IsMend
ADD r1, #0x1 // move thru list
CMP r2, #0x0 // check terminator
BNE MendLoopStart

LDR r1, RecoverItemList
RecoverLoopStart:
LDRB r2, [r1] // get next item
CMP r0, r2 // compare to current item
BEQ IsRecover
ADD r1, #0x1 // move thru list
CMP r2, #0x0 // check terminator
BNE RecoverLoopStart

// else we assume heal
IsHeal:
MOV r4, #0xA // +10

CheckEnd:

POP {r2}

// check for something (presumably if staff or item)
MOV r1, #0xFF 
AND r1 ,r2 // get low byte
LSL r0 ,r1 ,#0x3
ADD r0 ,r0, r1
LSL r0 ,r0 ,#0x2
LDR r1, ItemTable
ADD r0 ,r0, r1
LDR r0, [r0, #0x8]
MOV r1, #0x4 // 0x4 = isStaff
AND r0 ,r1
CMP r0, #0x0
BEQ End

// add mag to heal amount
MOV r0 ,r3

// blh GetUnitMag
ldr r3, GetUnitMag
mov lr, r3
.short 0xF800

ADD r4 ,r4, r0
CMP r4, #0x50
BLE End
MOV r4, #0x50 // if healing above 80 set it to 80

End:
MOV r0 ,r4
POP {r4}
POP {r1}
BX r1

IsMend:
MOV r4, #0x14 // +20
B CheckEnd

IsRecover:
MOV r4, #0x50 // +80 (max)
B CheckEnd

.ltorg
.align

MendItemList:
@POIN MendItemList
@POIN RecoverItemList
@POIN GetUnitMag
@POIN ItemTable
