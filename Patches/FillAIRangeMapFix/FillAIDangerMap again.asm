.thumb

.global NuAiFillDangerMap
.type NuAiFillDangerMap, %function

.equ origin, 0x0803e320
.equ GetUnitStruct, . + 0x08019430 - origin
.equ AreUnitsAllied, . + 0x08024D8C - origin
.equ CanUnitUseAsWeapon, . + 0x08016574 - origin
.equ GetItemMight, . + 0x080175DC - origin
.equ CouldUnitBeInRangeHeuristic, . + 0x0803AC90 - origin
.equ FillMovementAndRangeMapForItem, . + 0x0803B558 - origin
.equ GetUnitPower, . + 0x080191B0 - origin

@int i, j, ix, iy;
@sp+0x4 = i (unit deploy id)
@r7 = j = item count


NuAiFillDangerMap:
    PUSH    {r4-r7, lr}
    SUB     SP, #0x14
    MOV     r3, #0x1
    STR     r3, [SP, #0x4]  @ unit deploy ID = 1
    
    get_unit:
        LDR     r0, [SP, #0x4]
        BL      GetUnitStruct
        MOV     r4, r0
        BNE     fill_continue
        B       loop_advance
    
fill_continue:
    LDR     r3, [r0, #0x0]
    CMP     r3, #0x0
    BEQ     loop_advance    @ if unit->personal_info == NULL
    LDR     r2, [r0, #0xC]
    LDR     r3, =0x0000100D
    TST     r2, r3
    BNE     loop_advance    @ if unit->state & (hidden|dead|undeployed|bit12)
    MOV     r1, #0xB
    LDR     r3, =0x0202BE44 @ gActiveUnitIndex
    LDSB    r1, [r0, r1]
    LDRB    r0, [r3, #0x0]
    BL      AreUnitsAllied
    MOV     r5, r0
    BNE     loop_advance    @ if allied with activeUnit
    LSL     r3, r4, #0x0
    LSL     r7, r4, #0x0
    ADD     r3, #0x28
    STR     r3, [SP, #0xC]  @ end of inventory
    STR     r0, [SP, #0x8]  @ max_might = 0
    ADD     r7, #0x1E

weapon_check_loop:
    LDRH    r6, [r7, #0x0]
    CMP     r6, #0x0
    BEQ     no_more_weapons
    
        LSL     r1, r6, #0x0
        LSL     r0, r4, #0x0
        BL      CanUnitUseAsWeapon
        CMP     r0, #0x0
        BEQ     check_next_weapon
        
            LSL     r0, r6, #0x0
            BL      GetItemMight
            LDR     r3, [SP, #0x8]  @ if result > max_might
            CMP     r0, r3
            BLE     check_next_weapon
            
                LSL     r5, r6, #0x0    @ r5 = item
                STR     r0, [SP, #0x8]
                
        check_next_weapon:
            LDR     r3, [SP, #0xC]
            ADD     r7, #0x2
            CMP     r3, r7
            BNE     weapon_check_loop
    
    no_more_weapons:
        CMP     r5, #0x0
        BEQ     loop_advance    @ if item == 0
        
        LDR     r3, =0x03004E50 @ gActiveUnit
        LSL     r2, r5, #0x0
        LDR     r0, [r3, #0x0]
        LSL     r1, r4, #0x0
        BL      CouldUnitBeInRangeHeuristic
        CMP     r0, #0x0
        BEQ     loop_advance    @ if !canReachWithItem
        
        LSL     r1, r5, #0x0
        LSL     r0, r4, #0x0
        BL      FillMovementAndRangeMapForItem
        LSL     r0, r4, #0x0
        BL      GetUnitPower
        
        LDR     r3, =0x0202E4D4 @gMapSize
        MOV     r12, r3
        MOV     r2, #0x2
        LDSH    r2, [r3, r2] @MapHeight
        LDR     r3, [SP, #0x8]
        ADD     r0, r3, r0
        ASR     r0, r0, #0x1
        LSL     r0, r0, #0x18
        LDR     r6, =0x0202E4E4 @gMapRange
        LDR     r7, =0x0202E4F0 @gMapMovement2
        SUB     r2, #0x1
        LSR     r0, r0, #0x18

loop_map_y:
    CMP     r2, #0x0
    BLT     loop_advance
    MOV     r3, r12
    MOV     r1, #0x0
    LDSH    r3, [r3, r1]
    LSL     r4, r2, #0x2
    SUB     r3, #0x1

loop_map_x:
    CMP     r3, #0x0
    BGE     continue_map_x
        SUB     r2, #0x1
        B       loop_map_y
    
continue_map_x:
    LDR     r1, [r6, #0x0]
    LDR     r1, [r1, r4]
    LDRB    r1, [r1, r3]
    CMP     r1, #0x0
    BEQ     skip_map_store

        LDR     r1, [r7, #0x0]
        LDR     r5, [r1, r4]
        LDRB    r1, [r5, r3]
        ADD     r1, r0, r1
        STRB    r1, [r5, r3]
    
skip_map_store:
    SUB     r3, #0x1
    B       loop_map_x
    
loop_advance:
    LDR     r3, [SP, #0x4]
    ADD     r3, #0x1
    STR     r3, [SP, #0x4]
    CMP     r3, #0xC0
    BNE     get_unit
    ADD     SP, #0x14
    POP     {r4-r7}
    POP     {r0}
    BX      r0

    .align
    .ltorg
