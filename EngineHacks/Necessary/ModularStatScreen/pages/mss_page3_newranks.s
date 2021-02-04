.thumb
.include "mss_defs.s"

.global MSS_page3
.type MSS_page3, %function


MSS_page3:

page_start

mov r0, r8
push {r5-r7}
mov r5, #0x0 	@counter for bar id 
mov r7, #0x28 	@weapon rank offset (starts at sword)

LoopWeapons:
mov r6, r8 		@unit
ldrb r6, [r6, r7]
cmp r6, #0x0    @does unit have rank?
ble NoRank

mov     r0, r5        @bar id
SetX:
mov     r1, r5        @tile_x = even 1 odd 9
mov     r2, #0x1
and     r1, r2
cmp     r1, #0x1
beq     OddRank
mov     r1, #0x1
b SetY
OddRank:
mov		r1, #0x9

SetY:
mov     r2, r5        @tile_y = 1 1 3 3 5 5 7 7
lsr     r2, r2, #0x1
lsl     r2, r2, #0x1  @clear last bit and add 1
add     r2, #0x1      
mov     r3, r7        @weapon id - calculate from currentOffset
sub     r3, r3, #0x28
blh     DrawWeaponRank, r4        @08087864

add 	r5, #0x1 @increment bar counter
  
NoRank:
add r7, #0x1
cmp r7, #0x2F
ble LoopWeapons
b EndRanks

.ltorg

EndRanks:
pop {r5-r7}

blh      DrawSupports

page_end
