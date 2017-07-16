.thumb
@Additional Data Format:
@0-2: Debuffs, 4 bits each (str/skl/spd/def/res/luk)
@3: Rallys (bit 7 = rally move, bit 8 = rally spectrum)
@4: Str/Skl Silver Debuff (6 bits), bit 7 = half strength, HO bit = Hexing Rod
@5: Magic


@Original at 191B0
push {r4-r6, lr}
mov r4, r0              @Unit
mov r5, #0x14
ldsb r5, [r4, r5]       @Base strength

ldr r6, AdditionalDataTable
ldrb r1, [r4 ,#0xB]     @Deployment number
lsl r1, r1, #0x3    @*8
add r6, r1          @r0 = *debuff data
@r6 = &Additional Data

@Str/2 Debuff NOTE TO SELF: off of base only.
ldr r2, [r6, #0x4]
mov r1, #0x40
and r2, r1
cmp r2, #0x0
beq noHalfStr
lsr r2, r5, #0x1F
add r5, r2
asr r5, #0x1            @Signed divide by two.
noHalfStr:

@Now get the weapon bonus.
ldr r1, GetEquippedWeapon
bl gotoR1
ldr r1, GetWeaponStrBonus
bl gotoR1

@Add it to the accumulator.
add r5, r0

@Now get the debuff
@Strength debuff is LO nibble of 0th byte
ldrb r0, [r6]
mov r1, #0xF
and r0, r1 
@Subtract the debuff off.
sub r5, r0

@Silver debuff NOTE TO SELF: Recovers independantly of normal debuff
ldrb r0, [r6, #0x4]
mov r1, #0x1F           @Lower 5 bits
and r0, r1

@Subtract the debuff off
sub r5, r0

@Pair Up Bonus

@Rally Bonus
@LO byte of the 3rd byte
ldrb r1, [r6, #0x3]
mov r0, #0x1
and r0, r1
cmp r0, #0x0
beq noStrRally
add r5, #0x4
noStrRally:
@Rally Spectrum
mov r0, #0x80
and r0, r1
cmp r0, #0x0
beq noRallySpectrum
add r5, #0x2
noRallySpectrum:

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
GetWeaponStrBonus:
    .long 0x8016421
AdditionalDataTable:
    @Handled by installer.
    @.long 0x0203E894
