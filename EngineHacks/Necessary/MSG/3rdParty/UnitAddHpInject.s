.thumb

@.org 0x080193a4
.equ BASE, 0x080193a4
.equ GetUnitCurrentHp, (0x08019150-BASE)
.equ GetUnitMaxHp, (0x08019190-BASE)

@ r0 = struct Unit* unit
@ r1 = int amt

Start:
push {r4, r5, lr}
mov r4, r0 @ r4 = unit
mov r5, r1 @ r5 = amt
bl Start + GetUnitCurrentHp @ r0 is still unit, so r0->currentHP
add r5, r0 @ r5 += curHp
mov r0, r4
bl Start + GetUnitMaxHp
cmp r5, r0 @ if resultHp > maxHp
ble CheckNeg
mov r5, r0

CheckNeg:
cmp r5, #0
bge Done
mov r5, #0

Done:
strb r5, [r4, #0x13]
pop {r4, r5}
pop {r0}
bx r0
