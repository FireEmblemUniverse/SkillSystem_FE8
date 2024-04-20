.thumb
.equ TechnicianID, SkillTester+4
.equ ItemTable, 0x8809B10
push {r4-r7, lr}
mov r4, r0 @atkr
mov r5, r1 @dfdr


@has Technician
ldr r0, SkillTester
mov lr, r0
mov r0, r4 @Attacker data
ldr r1, TechnicianID
.short 0xf800
cmp r0, #0
beq End

@load the item table values for the user's equipped weapon
mov r3,#0x4a        @get the equipped item short
ldrb r2,[r4,r3]     @load it as a byte value (essentially loading just the item id, instead of the id plus the weapon uses)
mov r3,#0x24        @item struct length
mul r2,r3           @item ID * item struct length
ldr r3,=ItemTable   @load the item table
add r2,r3           @add both values together to start at the correct item struct

@check to see if the weapon is E ranked
mov r3,#0x22        @get weapon experience byte (00-FF determines E-S rank)
ldrb r1,[r2,r3]     @load weapon experience byte
cmp r1,#1           @compare this byte to 1
bgt End             @if greater, we're dealing with a weapon above E rank and so branch to the end

@now produce the Technician boost
mov r3,#0x15        @get weapon strength byte
ldrb r2,[r2,r3]     @load weapon strength byte
lsr  r2,#1          @half it (50%)

@now add the Technician boost to the user's attack
mov r1, #0x5A       @get attack byte    
ldrh r0, [r4,r1]    @load attack byte
add r0, r2          @add on the modified weapon strength value
strh r0, [r4,r1]    @store the result


End:
pop {r4-r7, r15}

.align
.ltorg
SkillTester:
@Poin SkillTester
@WORD TechnicianID
