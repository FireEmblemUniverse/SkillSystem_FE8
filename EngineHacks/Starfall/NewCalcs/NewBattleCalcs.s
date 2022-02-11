.thumb

.macro blh to, reg
    ldr \reg, =\to
    mov lr, \reg
    .short 0xF800
.endm

.equ ThrowBoostID, SkillTester+4
.equ HeavyBowID, ThrowBoostID+4

.equ GetItemHit, 0x80175F5
.equ GetItemCrit, 0x8017625
.equ GetItemAttributes, 0x801756D
.equ GetItemWeight, 0x801760D
.equ GetItemType, 0x8017549
.equ GetItemMaxRange, 0x8017685

.global CalcHit
.type CalcHit, %function

CalcHit:
    push {r4, lr}
    mov  r4, r0
    add  r0, #0x48
    ldrh r0, [r0]
    blh  GetItemHit, r3

    @okay, get dex, double it, and add it to weapon hit
    mov  r1, #0x15
    ldsb r1, [r4, r1]
    lsl  r1, #0x1
    add  r0, r1

    @store that value!
    mov  r1, #0x60
    add  r1, r4
    strh r0, [r1]

    pop  {r4}
    pop  {r0}
    bx   r0

.align
.ltorg

.global CalcAS
.type CalcAS, %function

CalcAS:
    push {r4-r6, lr}
    mov  r4, r0
    add  r0, #0x48
    ldrh r0, [r0]

    @save the item data for later
    mov  r5, r0

    blh  GetItemWeight, r3

    @save the item weight for later
    mov  r6, r0

    @r4=attacker data, r5=equipped weapon before use, r6=weapon weight

    @check if weapon is a sword, axe, or lance before granting the bonus
    CheckThrowBoost:
        mov  r0, r5
        blh  GetItemType, r3
        cmp  r0, #0x2
        bgt  CheckHeavyBow

            @now check for the throwboost trait
            mov  r0, r4
            ldr  r1, ThrowBoostID
            ldr  r3, SkillTester
            mov  lr, r3
            .short 0xF800
            cmp  r0, #0x0
            beq  CheckHeavyBow

                @check item max range
                mov  r0, r5
                blh  GetItemMaxRange, r3
                cmp  r0, #0x1
                ble  CheckHeavyBow
                    sub  r6, #0x4 @whatever value
                    cmp  r6, #0x0
                    bgt  CheckHeavyBow
                        mov  r6, #0x0

    CheckHeavyBow:
        mov  r0, r5
        blh  GetItemType, r3
        cmp  r0, #0x3
        bne  SubtractWeight

            @check for the heavy bow skill
            mov  r0, r4
            ldr  r1, HeavyBowID
            ldr  r3, SkillTester
            mov  lr, r3
            .short 0xF800
            cmp  r0, #0x0
            beq  SubtractWeight
                mov r0, r5
                blh GetItemAttributes, r3
                mov r1, #0x80 @whatever bit
                lsl r1, #0x18 @shift whatever amount
                and r0, r1
                cmp r0, #0x0
                beq SubtractWeight
                    sub  r6, #0x4
                    cmp  r6, #0x0
                    bgt  SubtractWeight
                        mov  r6, #0x0


    SubtractWeight:
    @get unit's speed
    mov  r0, r6
    mov  r1, r4
    mov  r2, #0x0
    add  r1, #0x16
    ldsb r1, [r1, r2]

    @subtract weight from speed, and floor it at 0
    sub  r0, r1, r0
    cmp  r0, #0x0
    bge  StoreAS
        mov  r0, #0x0

    @store the result in the unit's AS
    StoreAS:
    mov  r1, #0x5E
    add  r1, r4
    strh r0, [r1]

    pop  {r4-r6}
    pop  {r0}
    bx   r0

.align
.ltorg

.global CalcAvoid
.type CalcAvoid, %function

CalcAvoid:
    push {r4, lr}
    mov  r4, r0

    @get unit luck, then double it
    add  r0, #0x19
    mov  r1, #0x0
    ldsb r0, [r0, r1]
    lsl  r0, #0x1

    mov  r1, #0x57
    add  r1, r4
    ldrb r1, [r1]
    add  r0, r1

    @store the value
    mov  r1, r4
    add  r1, #0x62
    strh r0, [r1]

    pop  {r4}
    pop  {r0}
    bx   r0

.align
.ltorg

.global CalcCrit
.type CalcCrit, %function

CalcCrit:
    push {r4, lr}
    mov  r4, r0
    add  r0, #0x48
    ldrh r0, [r0]
    blh  GetItemCrit, r3

    mov  r1, r4
    add  r1, #0x66
    strh r0, [r1]

    pop  {r4}
    pop  {r0}
    bx   r0

.align
.ltorg

SkillTester:
@POIN SkillTester
@WORD ThrowBoostID
@WORD HeavyBowID
