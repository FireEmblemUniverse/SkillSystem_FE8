.thumb
.include "mss_defs.s"

.global MSS_page4
.type MSS_page4, %function


MSS_page4:

page_start

draw_textID_at 13, 3, textID=0xd4c, width=16, colour=Blue

@ first like
mov    r0,r8
ldr    r1,[r0]               @load character pointer
ldrb   r1,[r1,#0x4]	         @load character number
ldr    r0,=PersonalDataTable  @load first like
@ldr    r0,[r0]
mov    r2,#12
mul    r1,r2
@add    r1,#2
add	   r0,r1
ldrh   r0,[r0]		@load textid
mov    r3, r7
mov r1, #12
ldrh r2,[r3] @current number
add r2,r1 @for the next one.
strb r1, [r3, #4] @store width
strb r2, [r3, #8] @assign the next one.
blh String_GetFromIndex
mov    r2, #0x0
str    r2, [sp]
str    r0, [sp, #4]
mov    r2, #0 @colour
mov    r0, r7
ldr    r1, =(tile_origin+(0x20*2*3)+(2*17))
mov    r3, #0
blh    DrawTextInline, r4
add    r7, #8

b LiteralJump1
.ltorg
.align
LiteralJump1:

@ second like
mov    r0,r8
ldr    r1,[r0]               @load character pointer
ldrb   r1,[r1,#0x4]	         @load character number
ldr    r0,=PersonalDataTable  @load first like
@ldr    r0,[r0]
mov    r2,#12
mul    r1,r2
add    r1,#2
ldrh   r0,[r0,r1]		@load textid
mov    r3, r7
mov r1, #12
ldrh r2,[r3] @current number
add r2,r1 @for the next one.
strb r1, [r3, #4] @store width
strb r2, [r3, #8] @assign the next one.
blh String_GetFromIndex
mov    r2, #0x0
str    r2, [sp]
str    r0, [sp, #4]
mov    r2, #0 @colour
mov    r0, r7
ldr    r1, =(tile_origin+(0x20*2*5)+(2*17))
mov    r3, #0
blh    DrawTextInline, r4
add    r7, #8

draw_textID_at 13, 7, textID=0xd4d, width=16, colour=Blue

b LiteralJump2
.ltorg
.align
LiteralJump2:


@ first dislike
mov    r0,r8
ldr    r1,[r0]               @load character pointer
ldrb   r1,[r1,#0x4]	         @load character number
ldr    r0,=PersonalDataTable  @load first like
@ldr    r0,[r0]
mov    r2,#12
mul    r1,r2
add    r1,#4
ldrh   r0,[r0,r1]		@load textid
mov    r3, r7
mov r1, #12
ldrh r2,[r3] @current number
add r2,r1 @for the next one.
strb r1, [r3, #4] @store width
strb r2, [r3, #8] @assign the next one.
blh String_GetFromIndex
mov    r2, #0x0
str    r2, [sp]
str    r0, [sp, #4]
mov    r2, #0 @colour
mov    r0, r7
ldr    r1, =(tile_origin+(0x20*2*7)+(2*17))
mov    r3, #0
blh    DrawTextInline, r4
add    r7, #8

@ second dislike
mov    r0,r8
ldr    r1,[r0]               @load character pointer
ldrb   r1,[r1,#0x4]	         @load character number
ldr    r0,=PersonalDataTable  @load first like
@ldr    r0,[r0]
mov    r2,#12
mul    r1,r2
add    r1,#6
ldrh   r0,[r0,r1]		@load textid
mov    r3, r7
mov r1, #12
ldrh r2,[r3] @current number
add r2,r1 @for the next one.
strb r1, [r3, #4] @store width
strb r2, [r3, #8] @assign the next one.
blh String_GetFromIndex
mov    r2, #0x0
str    r2, [sp]
str    r0, [sp, #4]
mov    r2, #0 @colour
mov    r0, r7
ldr    r1, =(tile_origin+(0x20*2*9)+(2*17))
mov    r3, #0
blh    DrawTextInline, r4
add    r7, #8

draw_textID_at 13, 11, textID=0xd4f, width=16, colour=Blue

b LiteralJump3
.ltorg
.align
LiteralJump3:


@ age
mov    r0,r8
ldr    r1,[r0]               @load character pointer
ldrb   r1,[r1,#0x4]	         @load character number
ldr    r0,=PersonalDataTable  @load first like
@ldr    r0,[r0]
mov    r2,#12
mul    r1,r2
add    r1,#8
ldrh   r0,[r0,r1]		@load textid
mov    r3, r7
mov r1, #5
ldrh r2,[r3] @current number
add r2,r1 @for the next one.
strb r1, [r3, #4] @store width
strb r2, [r3, #8] @assign the next one.
blh String_GetFromIndex
mov    r2, #0x0
str    r2, [sp]
str    r0, [sp, #4]
mov    r2, #0 @colour
mov    r0, r7
ldr    r1, =(tile_origin+(0x20*2*11)+(2*16))
mov    r3, #0
blh    DrawTextInline, r4
add    r7, #8

draw_textID_at 21, 11, textID=0xd4e, width=16, colour=Blue

b LiteralJump4
.ltorg
.align
LiteralJump4:


@ height
mov    r0,r8
ldr    r1,[r0]               @load character pointer
ldrb   r1,[r1,#0x4]	         @load character number
ldr    r0,=PersonalDataTable  @load first like
@ldr    r0,[r0]
mov    r2,#12
mul    r1,r2
add    r1,#10
ldrh   r0,[r0,r1]		@load textid
mov    r3, r7
mov r1, #5
ldrh r2,[r3] @current number
add r2,r1 @for the next one.
strb r1, [r3, #4] @store width
strb r2, [r3, #8] @assign the next one.
blh String_GetFromIndex
mov    r2, #0x0
str    r2, [sp]
str    r0, [sp, #4]
mov    r2, #0 @colour
mov    r0, r7
ldr    r1, =(tile_origin+(0x20*2*11)+(2*25))
mov    r3, #0
blh    DrawTextInline, r4
add    r7, #8

@ Next let's draw Gaiden spells if the hack is installed.
draw_gaiden_spells_at 13, 13, GaidenStatScreen @ GaidenStatScreen is a pointer to the routine, GaidenStatScreen.

page_end

.align
.ltorg
