@at 808cce4 gotohack_r3
@r0 is deployment number

@edited 808c52e to never branch --- didn't work, but it's getting close
@808c50e does the flashing - calls 808c360

.thumb
.include "header.h"
blh GetCharData
mov r6, r0
cmp r0, #0
bne HasUnit @ go back, everything fine
@no unit? check for dragon vein
bl DV_check @r0 is text id, or 0 if no text/not a dv
cmp r0, #0
beq NoDV
@ there is a dv and the pointer is in r0. the hack proper begins here
bl DrawDVBox

NoDV:
ldr r1, Return_normal
bx r1

HasUnit:
ldr r1, Return_HasUnit
bx r1

.align
DefaultUnit:
.long 0x0202be4c
Return_HasUnit:
.long 0x0808CCEE+1
Return_normal:
.long 0x0808CD5C+1

DV_check:
push {r4-r6}
ldr r2, =0x202bcb0 @misc ram data
mov r1, #0x14
ldrsh r5, [r2, r1] @cursor x
mov r1, #0x16
ldrsh r6, [r2, r1] @cursor y
ldr r4, =0x203a614-8 @start of trapdata
Loop:
add r4, #8
ldrb r0, [r4, #2] @type
cmp r0, #0 @none = end?
beq End
cmp r0, #6 @dragon vein?
bne Loop
@it is a dragon vein, good. do the coords match?
mov r0, #0
ldrsb r0, [r4,r0] @x
cmp r0, r5
bne Loop
mov r1, #1
ldrsb r1, [r4,r1] @y
cmp r1, r6
bne Loop
@great it matched. Return the text ID to display.
ldrh r0, [r4, #4]
End:
pop {r4-r6}
bx lr


.set MMBStructType, 0x08A018AC
.set BoxControlTable, 0x08A01820
.set WindowPosCheck, 0x0808BBCC
.set MiscRamData, 0x0202bcb0
@@ This returns 0-3 based on cursor position
@@ Uses the same misc. RAM data
@@ This function is used by all window elements
@@ here (goal, terrain, minimug), so don't edit it

.set WindowType, 0x0808BBAC
@@ 'Type' is inaccurate, it's still position
@@ but for label purposes I'm calling it type
@@ This routine returns 0-3 depending
@@ on whether r0 and r1 are negative, positive, 
@@ or zero, from the box control table.
@@ Used when determining where to draw terrain,
@@ goal, and minimug windows.

.set StructFinder, 0x08002E9C
@@ This routine finds 0x6C structs based on
@@ a pointer given in r0. If it can't find the struct, 
@@ it returns 0 in r0. If it can, it returns the
@@ offset of the struct in r0.

.set ERAMBGBuffer, 0x02003D2C

@@ This is the BG buffer dedicated to window 
@@ tilemaps, such as the tilemaps for the terrain
@@ window, goal window, and minimug box

.set ERAMBufferConst, 0x1000060

@@ CPUFastSet has its parameters input via r2
@@ bit 24 being set allows for repeated writing of 
@@ the word at the offset in r0 to be written to
@@ the area instead of copying. In the case of how it's
@@ used here, the routine first stores 00000000 to the stack 
@@ and then puts the stack pointer in r0 before calling
@@ CPUFastSet. 

DrawDVBox:
push {r4-r7, lr}
mov     r7, r0              @@ save text ID to draw

@copied from mmb routine
mov     r1, r4              @@ 0808CCEE 1C21        @@ \
add     r1, #0x55           @@ 0808CCF0 3155        @@ Set 0x6C struct byte to 1
mov     r0, #0x01           @@ 0808CCF2 2001        @@ 
strb    r0, [r1]            @@ 0808CCF4 7008        @@ /
blh      WindowPosCheck      @@ 0808CCF6 F7FEFF69    @@ Get window position byte
mov     r1, r4              @@ 0808CCFA 1C21        @@ \
add     r1, #0x50           @@ 0808CCFC 3150        @@ Stores window position control byte
strb    r0, [r1]            @@ 0808CCFE 7008        @@ /
ldr     r0, =BoxControlTable@@ 0808CD00 481A        @@ See notes on table
ldrb    r1, [r1]            @@ 0808CD02 7809        @@ Grabs control byte
lsl     r1, r1, #0x18       @@ 0808CD04 0609        @@ \
asr     r1, r1, #0x18       @@ 0808CD06 1609        @@ This is a compiler derp
lsl     r1, r1, #0x03       @@ 0808CD08 00C9        @@ multiply by 8
add     r1, r1, r0          @@ 0808CD0A 1809        @@ 
mov     r0, #0x02           @@ 0808CD0C 2002        @@ 
ldsb    r0, [r1, r0]        @@ 0808CD0E 5608        @@ These are inputs for the window
ldrb    r1, [r1, #0x03]     @@ 0808CD10 78C9        @@ type function below
lsl     r1, r1, #0x18       @@ 0808CD12 0609        @@ Because r0 was loaded as signed, only
asr     r1, r1, #0x18       @@ 0808CD14 1609        @@ r1 needs this FF-floodfiller
blh      WindowType          @@ 0808CD16 F7FEFF49    @@ Get window type byte
mov     r5, r0              @@ 0808CD1A 1C05        @@ Move the result out of the way

MMBCompSkipped:
mov     r0, r4              @@ 0808CD36 1C20        @@ \

add     r0, #0x55 @@don't draw hp numbers
mov     r1, #0
strh    r1, [r0]

add     r0, #0x2           @@ 0808CD38 3057        @@ Store control byte in old one's place
strb    r5, [r0]            @@ 0808CD3A 7005        @@ /
ldr     r0, =MiscRamData         @@ 0808CD3C 4809        @@ \
ldrh    r1, [r0, #0x14]     @@ 0808CD3E 8A81        @@ Gets cursor position the same
mov     r2, r4              @@ 0808CD40 1C22        @@ way as before, but it stores
add     r2, #0x4E           @@ 0808CD42 324E        @@ the coordinates in the
strb    r1, [r2]            @@ 0808CD44 7011        @@ 0x6C struct
ldrh    r0, [r0, #0x16]     @@ 0808CD46 8AC0        @@ 
mov     r1, r4              @@ 0808CD48 1C21        @@ 
add     r1, #0x4F           @@ 0808CD4A 314F        @@ 
strb    r0, [r1]            @@ 0808CD4C 7008        @@ /
mov     r0, r4              @@ 0808CD4E 1C20        @@ 0x6C struct
mov     r1, r6              @@ 0808CD50 1C31        @@ Unit's RAM data
bl      DVMMBBuilder @custom routine
mov     r0, r4              @@ 0808CD56 1C20        @@ \
blh      0x8002E94            @@ 0808CD58 F776F89C    @@ Clears a long in a 0x6C struct

MMBSetupEnd:

pop     {r4-r7}             @@ 0808CD5C BC70        @@ \
pop     {r0}                @@ 0808CD5E BC01        @@ Cleanup
bx      r0                  @@ 0808CD60 4700        @@ /


    .set TextBufferWriter, 0x0800A240
    @@ This routine writes text from text ID
    @@ in r0 to a buffer at 0x0202A6AC
    
    .set TextBufferID, 0x0202B6AC
    @@ This is where the text ID of the text currently in the buffer goes
    
    .set TextTableOffset, 0x0815D48C
    @@ This is the location of FE8's text table.
    @@ It contains pointers to most pieces of text
    @@ in the game.
    
    .set TextBufferOffset, 0x0202A6AC
    @@ This is the buffer text is written to.

    .set NameCenterer, 0x08003F90
    @@ This routine puts the name in 
    @@ the center of the same alotted
    @@ for it.
    .set NameVRAMClearer, 0x08003DC8

DVMMBBuilder: @copied from 8c5d0
    push    {r4-r7, lr}         @@ 0808C5D0 B5F0     @@ \
    mov     r7, r10             @@ 0808C5D2 4657     @@ Register saving
    mov     r6, r9              @@ 0808C5D4 464E     @@ 
    mov     r5, r8              @@ 0808C5D6 4645     @@ 
    push    {r5-r7}             @@ 0808C5D8 B4E0     @@ /
    add     sp, #-0x08          @@ 0808C5DA B082     @@ Reserves 2 words
    mov     r7, r0              @@ 0808C5DC 1C07     @@  
    mov     r8, r1              @@ 0808C5DE 4688     @@ 
    mov     r0, #0x00           @@ 0808C5E0 2000     @@ This is for a CPUFastSet
    mov     r10, r0             @@ 0808C5E2 4682     @@ trick explained above
    str     r0, [sp, #0x04]     @@ 0808C5E4 9001     @@ /
    ldr     r1, =ERAMBGBuffer    @@ 0808C5E6 4928     @@ \
    mov     r9, r1              @@ 0808C5E8 4689     @@ 
    ldr     r2, =ERAMBufferConst     @@ 0808C5EA 4A28     @@ Clears buffer by CPUFastSet
    add     r0, sp, #0x04       @@ 0808C5EC A801     @@ repeated cleared long
    swi 0xc @CPUFastSet
    @mov     r1, r8              @@ 0808C5F2 4641     @@ \
    @ldr     r0, [r1]            @@ 0808C5F4 6808     @@ Grabs unit name hword
    @ldrh    r0, [r0]            @@ 0808C5F6 8800     @@ /
    mov r0, sp
    add r0, #0x20 @@ ugly... grabs the r7 that was pushed.
    ldrh r0, [r0]
    blh      TextBufferWriter    @@ 0808C5F8 F77DFE22 @@ Writes name to 0x0202A6AC buffer
    mov     r6, r0              @@ 0808C5FC 1C06     @@ \

    DrawLine:
    mov     r0, #(8*11)           @@ 0808C5FE 2038     @@ Gets distance to center name based on
    mov     r1, r6              @@ 0808C600 1C31     @@ (0x08*tiles available(0x07)) and name's length
    blh      NameCenterer        @@ 0808C602 F777FCC5 @@ /
    mov     r5, r0              @@ 0808C606 1C05     @@ \
    mov     r4, r7              @@ 0808C608 1C3C     @@ Uses 0x6C struct info to 
    add     r4, #0x2C           @@ 0808C60A 342C     @@ clear VRAM area for name to
    mov     r0, r4              @@ 0808C60C 1C20     @@ be written to
    mov r1, #0x0B @11 tiles wide
    strb r1, [r0, #4]
    blh      NameVRAMClearer     @@ 0808C60E F777FBDB @@ /
    mov     r0, r4              @@ 0808C612 1C20     @@ \
    mov     r1, r5              @@ 0808C614 1C29     @@ Stores centering distance and text color
    mov     r2, #0x05           @@ 0808C616 2205     @@ to the 0x6C struct info it used
    strb    r1, [r0, #0x02]
    strb    r2, [r0, #0x03]
    mov     r0, r4              @@ 0808C61C 1C20     @@ \
    mov     r1, r6              @@ 0808C61E 1C31     @@ Writes name to VRAM using info
    blh     0x8004004
    mov     r1,r9               @@ 0808C624 4649     @@ \

    add     r1,#0x42              @@ 0808C626 314A     @@ Write name tilemap to ERAM buffer (was 4A, moved it left)
    
    mov     r0,r4               @@ 0808C628 1C20     @@ the 0x4A is where in the buffer to write name
    blh      0x8003E70            @@ 0808C62A F777FC21 @@ /

    @@@@@@@@@@@@@@@ SECOND ROW OF TEXT
    TextBufferLoop:
    ldrb r0, [r6]
    add r6, #1
    cmp r0, #1
    bhi TextBufferLoop
    cmp r0, #0
    beq DVMMBBuilderEnd
    mov r0, r9
    add r0, #0x80
    mov r9, r0
    b DrawLine

    DVMMBBuilderEnd:
    mov r0, #0
    mov r1, #3
    blh 0x808c2cc
    add     sp, #8               @@ 0808C6F4 B002     @@ \
    pop     {r3-r5}               @@ 0808C6F6 BC38     @@ Wrap up
    mov     r8,r3               @@ 0808C6F8 4698     @@ 
    mov     r9,r4               @@ 0808C6FA 46A1     @@ 
    mov     r10,r5              @@ 0808C6FC 46AA     @@ 
    pop     {r4-r7}               @@ 0808C6FE BCF0     @@ 
    pop     {r0}                  @@ 0808C700 BC01     @@ 
    bx      r0                  @@ 0808C702 4700     @@ /
