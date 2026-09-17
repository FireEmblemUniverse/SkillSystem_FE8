.thumb
.align

@formerly in CanUnitWieldWeapon, this adds compatibility for things that happen before WRank check (i.e. weapon locks) and needs lumina/shadowgift to happen after

DoesUnitHaveWRank:
push {r4-r7,r14}

mov r4,r0 @character pointer
mov r5,r1 @item halfword
mov r6,r2 @rank

@get item's wrank requirement
mov r0,r5
mov r1,#0xFF
and r0,r1
mov r1,#0x24
mul r0,r1
ldr r1,ItemTable
add r0,r1
ldrb r0,[r0,#0x1C]
cmp r0,r6
ble RetTrue @if (item wrank <= user wrank)

RetFalse:
mov r0,#0
b GoBack

RetTrue:
mov r0,#1

GoBack:
pop {r4-r7}
pop {r1}
bx r1

.ltorg
.align


ItemTable:
