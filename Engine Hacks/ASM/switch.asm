@switch
@e904b0 to e90530

@waitroutine in fe8 is at 8022738
@changed 3004e50 to 202be4c and swapped the turn statuses, unit map has 0

@ok so when breaking: set 0x21 and 0x11, then switch the 3004e50 (no, we need to change 203a964 instead)

.thumb
.org 0

@original wait routine
push {r4-r6,lr}

mov r6,r0 @need this later!

ldr r4,=0x203a958
ldrb r0,[r4,#0xc] @deployment no of char
ldr r5,=0x8019430
mov lr,r5
.short 0xf800
ldrb r1,[r0,#0x1b] @r1 = deployment no of other char
strb r1,[r4,#0xC] @other char is now in front

@set r0 from 0x10 to 0x20
ldr r2,[r0,#0xC]
mov r3,#0x10
eor r2,r3
mov r3,#0x20
orr r3,r2
str r3,[r0,#0xc]

@swap and set from 0x20 to 0x10
mov r0,r1
mov lr,r5
.short 0xf800
ldr r3, [r0,#0xC]
mov r1, #0x20
eor r3,r1
mov r1, #0x10
orr r3,r1
str r3, [r0,#0xc]
@r0 contains chardata, write it to 3004e50
ldr r5,=0x3004e50
str r0,[r5]

mov r0,#0x1d @this makes it like if you selected trade but didn't go through with it

strb r0,[r4,#0x11]

@copying parts from 801d008
@r4=r6
@r5=3004e50
mov r4,r6
ldr r0,[r5]
ldr r2, =0x802810c
mov lr,r2
.short 0xf800
ldr r2, =0x80790a4
mov lr,r2
.short 0xf800
ldr r0,[r5]
ldr r2, =0x8078464
mov lr,r2
.short 0xf800
mov r0,r4
mov r1,#1
ldr r2, =0x8002f24
mov lr,r2
.short 0xf800

mov r0,#0x17
pop {r4-r6}
pop {r1}
bx r1


@801cd34 starts the draw unit menu routine
@804f3c8 clears the unit menu
@maybe I could call 80271a0? 1d008?
@for 1d008 i need r0
  @2025018 - 0859aad8 0859abc0 

@need a way to change back when cancelling move
@at 1d158 is what I want
@Room for a bl to replace
@ldr r0,202bcb0
@add r0,3d

@when you first press a, find where it sets the active char. Set both!
@1ca9c bl to e19b4
@r0 is chardata, byte 0xb is deployment no
@write deployment no to 203a958+d
@call 801865c with r0=chardata again