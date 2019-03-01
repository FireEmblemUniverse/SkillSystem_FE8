.thumb
@Additional Data Format:
@0-2: Debuffs, 4 bits each (str/skl/spd/def/res/luk)
@3: Rallys (bit 7 = rally move, bit 8 = rally spectrum)
@4: Str/Skl Silver Debuff (6 bits), bit 7 = half strength, HO bit = Hexing Rod
@5: Magic


@Original at 19190
push {r4-r6, lr}
mov r4, r0              @Unit
mov r5, #0x12
ldrb r5, [r4, r5]       @Base HP
@Load it unsigned in case we want to do some kind of unsigned HP hack later.

ldr r6, AdditionalDataTable
ldrb r1, [r4 ,#0xB]     @Deployment number
lsl r1, r1, #0x3    @*8
add r6, r1          @r0 = *debuff data
@r6 = &Additional Data

@Hexing Rod Debuff NOTE TO SELF: off of base only.
ldrb r0, [r6, #0x4]
mov r1, #0x80
and r0, r1
cmp r0, #0x0
beq noHalfHP
lsr r0, r5, #0x1        @Unsigned divide by two.
noHalfHP:

@Now get the weapon bonus.
ldr r1, GetEquippedWeapon
bl gotoR1
ldr r1, GetWeaponHPBonus
bl gotoR1

@Add it to the accumulator.
add r5, r0

@No MaxHP Debuffs

@No MaxHP Pair Up Bonus

@No MaxHP Rally Bonus

@Return the acccumulator.
mov r0, r5

cmp r0, #0x0
bge end
mov r0, #0x0
end:
pop {r4-r6}
pop {r1}
gotoR1:
bx r1

.align
GetEquippedWeapon:
    .long 0x8016B29
GetWeaponHPBonus:
    .long 0x80163F1
AdditionalDataTable:
    @Handled by installer.
    @.long 0x0203E894
