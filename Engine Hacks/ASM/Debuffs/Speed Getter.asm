.thumb
@Additional Data Format:
@0-2: Debuffs, 4 bits each (str/skl/spd/def/res/luk)
@3: Rallys (bit 7 = rally move, bit 8 = rally spectrum)
@4: Str/Skl Silver Debuff (6 bits), bit 7 = half strength, HO bit = Hexing Rod
@5: Magic
@6: LO Nibble = Dual Guard Meter?

@Original at 19210
push {r4-r6, lr}
mov r4, r0              @Unit
mov r5, #0x16
ldsb r5, [r4, r5]       @Base speed

ldr r6, AdditionalDataTable
ldrb r1, [r4 ,#0xB]     @Deployment number
lsl r1, r1, #0x3    @*8
add r6, r1          @r0 = *debuff data
@r6 = &Additional Data

@Now get the weapon bonus.
ldr r1, GetEquippedWeapon
bl gotoR1
ldr r1, GetWeaponSpdBonus
bl gotoR1

@Add it to the accumulator.
add r5, r0

@Now get the debuff
@Speed debuff is LO nibble of 1st byte
ldr r0, [r6]
mov r1, #0xF
lsl r1, #0x8
and r0, r1 
lsr r0, #0x8
@Subtract the debuff off.
sub r5, r0


@Pair Up Bonus
@TODO: Read the bit that stores whether Rescue rules are in effect or Pair Up rules are in effect, and halve accordingly


@Rally Bonus
@4 bit of the 0x3 byte
ldrb r1, [r6, #0x3]
mov r0, #0x4
and r0, r1
cmp r0, #0x0
beq noSpdRally
add r5, #0x4
noSpdRally:
@Rally Spectrum
mov r0, #0x80
and r0, r1
cmp r0, #0x0
beq noRallySpectrum
add r5, #0x2
noRallySpectrum:

@Rescue - halve final stat
mov r0, r4
ldr r0, [r0, #0xc]
mov r1, #0x10 @rescuing
and r0, r1
cmp r0, #0
beq noRescue
  lsr r5, #1 @halve
noRescue:

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
GetWeaponSpdBonus:
    .long 0x8016481
AdditionalDataTable:
    @Handled by installer.
    @.long 0x0203E894
