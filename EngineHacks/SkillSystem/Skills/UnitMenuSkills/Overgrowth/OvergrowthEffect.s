.thumb
.equ TerrainBoosts, 0x202ED74
.equ TerrainMap, 0x202E4DC
.equ MapWidth, 0x202E4D4
.equ MapHeight, 0x202E4D6
.equ TerrainRaw, 0x2032F8C

@Overgrowth effect: sets a forest tile where the unit is standing and sets the Overgrowth flag

@Also, be aware that this doesn't edit the appearence of the tile, and it resets on suspend

push {lr}
ldr r2, OvergrowthMarker
mov r3, #15
strb r3, [r2]
ldr r2, =0x8023E58   @chest effect - we choose this as it doesn't require combat
mov lr, r2
.short 0xf800

ldr r4,=#0x3004E50   @currently active unit
ldr r4,[r4]          @load character struct of unit we find
push {r0-r3}         @save these as we'll need to restore them after we're done
ldrb r0,[r4,#0x10]   @x-coordinate of skill holder
ldrb r1,[r4,#0x11]   @y-coordinate of skill holder

@set the effect of the tile underneath the unit to a forest
ldr  r2,=TerrainMap  @load the base map index address
ldr  r2,[r2]         @offset of map's table of row pointers
lsl  r1,#2           @multiply the y-coordinate by 4
add  r2,r1           @add it to the base address (as the pointers are indexed by row)
ldr  r2,[r2]         @load the value stored there
add  r2,r0           @add the x-coordinate to get the boost of the tile the unit is standing on
mov  r3,#0xC         @forest tile boost ID
strb r3,[r2]         @store the new tile

@now set the tile itself into a forest
ldr  r2,=TerrainRaw  @load the base map address
add  r2,r1           @add on the y-coordinate from before
ldr  r2,[r2]         @now load the address we land on
lsl  r0,#1           @the physical tiles are stored as shorts, so we need to double our x-coordinate to navigate to the right tile
add  r2,r0           @add it on to the address we have in r0
ldr  r3,=#0x0DC0     @load the short for a forest tile
strh r3,[r2]         @store it in the location that corresponds to the active unit's coordinates
pop {r0-r3}          @restore the pushed registers from earlier

pop {r1}
bx r1
.align
OvergrowthMarker: 
.long 0x203f101
@0 is nothing 
@1 is rescue 
@2 is pair up 
@3 is lunge 
@4 is mercy
@5 is gamble
@15 is overgrowth
