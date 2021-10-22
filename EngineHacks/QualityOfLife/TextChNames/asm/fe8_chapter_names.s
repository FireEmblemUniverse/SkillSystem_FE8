@fe8 routine at 8089624. Replace that routine with this one from fe7 to show text instead of gfx
@@ TODO: fix skirmish text
.thumb
.include "header.h"
@main
sub_8082308:
@r0 is 0xb40 (position?)
@r1 is chapter number. 0x54 is no data?
@r2 is a bool; true for save screen and false otherwise. The purpose of this is so that you cannot see the chapter's name from the save screen; instead, you put something generic like 'Chapter 1' and then the actual name appears on the fancy intro thingy. Idea courtesy of PwnageKirby.

push    {r4-r7,r14}               @@ 08082308 B5F0     
mov     r7,r8               @@ 0808230A 4647     
push    {r7}                @@ 0808230C B480     
add     sp,#-0x4                @@ 0808230E B081     
mov     r4,r0               @@ 08082310 1C04     
mov     r0,r1               @@ 08082312 1C08    
mov		r1,r2 
bl      LoadChapterName               @@ 08082314 F7FFFFC6 @not in fe8?? 
mov     r7,r0               @@ 08082318 1C07     
lsl     r0,r4,#0x5                @@ 0808231A 0160     
mov     r1,#0x0C0               @@ 0808231C 21C0     
lsl     r1,r1,#0x13               @@ 0808231E 04C9     
add     r1,r1,r0                @@ 08082320 1809     
mov     r8,r1               @@ 08082322 4688     
mov     r0,r7               @@ 08082324 1C38     
bl      sub_8082224               @@ 08082326 F7FFFF7D  @also not in fe8
lsl     r0,r0,#0x18               @@ 0808232A 0600     
lsr     r5,r0,#0x18               @@ 0808232C 0E05     
mov     r6,r5               @@ 0808232E 1C2E     
ldr     r1,=0x203E78C               @@ 08082330 4908    @is 203e78c 
ldr     r2,=0x3FF               @@ 08082332 4A09     
mov     r0,r2               @@ 08082334 1C10     
and     r4,r0               @@ 08082336 4004     
mov     r0,#0x0               @@ 08082338 2000     
strh    r4,[r1,#0x2]                @@ 0808233A 804C     
str     r0,[sp]               @@ 0808233C 9000     
ldr     r2,=0x1000200               @@ 0808233E 4A07   @constant: used for cpufastset   
mov     r0,r13                @@ 08082340 4668     
mov     r1,r8               @@ 08082342 4641     

@bl      0x80BFA0C                @@ 08082344 F03DFB62 
swi #0xC

ldr     r0, Font_Graphic_Ptr                @@ 08082348 4805  @font graphic - compressed 
ldr     r1,=0x2020188               @@ 0808234A 4906  @unknown - buffer , was 2020140
blh      0x8012f50                @@ 0808234C F790FF0C @decompress image to buffer
b       loc_80823C6               @@ 08082350 E039     
  .ltorg
 
loc_8082368:
mov     r0,r7               @@ 08082368 1C38     
bl      MapTextCharacterToFont               @@ 0808236A F7FFFEBD 
mov     r2,r0               @@ 0808236E 1C02     
cmp     r2,#0x80                @@ 08082370 2A80     
bne     loc_8082386               @@ 08082372 D108     
cmp     r6,r5               @@ 08082374 42AE     
bls     loc_808237C               @@ 08082376 D901     
add     r0,r6,#3                @@ 08082378 1CF0     
b       loc_808237E               @@ 0808237A E000     
loc_808237C:
add     r0,r5,#3                @@ 0808237C 1CE8     
loc_808237E:
lsl     r0,r0,#0x18               @@ 0808237E 0600     
lsr     r5,r0,#0x18               @@ 08082380 0E05     
mov     r6,r5               @@ 08082382 1C2E     
b       loc_80823C4               @@ 08082384 E01E   
loc_8082386:  
lsl     r1,r2,#0x3                @@ 08082386 00D1     
ldr     r0, FontDimensionsTable     @=0x8CC2784  
add     r4,r1,r0                @@ 0808238A 180C     
ldrb    r3,[r4]               @@ 0808238C 7823     
sub     r1,r6,r3                @@ 0808238E 1AF1     
ldrb    r3,[r4,#0x1]                @@ 08082390 7863     
sub     r0,r5,r3                @@ 08082392 1AE8     
cmp     r1,r0               @@ 08082394 4281     
ble     loc_80823A0               @@ 08082396 DD03     
mov     r5,r6               @@ 08082398 1C35     
b       loc_80823A2               @@ 0808239A E002     
.ltorg
loc_80823A0:    
mov     r6,r5               @@ 080823A0 1C2E   
loc_80823A2:  
ldr     r0,=0x2020188               @@ 080823A2 480E      @buffer again, changed from 140
mov     r1,r8               @@ 080823A4 4641     
mov     r3,r6               @@ 080823A6 1C33     
bl      sub_8082168               @@ 080823A8 F7FFFEDE 
mov     r0,r6               @@ 080823AC 1C30     
add     r0,#0x0FF               @@ 080823AE 30FF     
ldrb    r1,[r4,#0x2]                @@ 080823B0 78A1     
add     r0,r1,r0                @@ 080823B2 1808     
lsl     r0,r0,#0x18               @@ 080823B4 0600     
lsr     r6,r0,#0x18               @@ 080823B6 0E06     
mov     r0,r5               @@ 080823B8 1C28     
add     r0,#0x0FF               @@ 080823BA 30FF     
ldrb    r4,[r4,#0x3]                @@ 080823BC 78E4     
add     r0,r4,r0                @@ 080823BE 1820     
lsl     r0,r0,#0x18               @@ 080823C0 0600     
lsr     r5,r0,#0x18               @@ 080823C2 0E05  
loc_80823C4:   
add     r7,#0x1               @@ 080823C4 3701   
loc_80823C6:  
ldrb    r0,[r7]               @@ 080823C6 7838     
cmp     r0,#0x0               @@ 080823C8 2800     
beq     loc_80823D0               @@ 080823CA D001     
cmp     r0,#0x1F                @@ 080823CC 281F     
bne     loc_8082368               @@ 080823CE D1CB   
loc_80823D0:
add     sp,#0x4               @@ 080823D0 B001     
pop     {r3}                @@ 080823D2 BC08     
mov     r8,r3               @@ 080823D4 4698     
pop     {r4-r7}             @@ 080823D6 BCF0     
pop     {r0}                @@ 080823D8 BC01     
bx      r0                @@ 080823DA 4700   
.ltorg  

LoadChapterName:
push    {r4,r14}                @@ 080822A4 B510     
mov     r4,r0               @@ 080822A6 1C04     
cmp     r4,#0x0               @@ 080822A8 2C00     
bge     loc_80822AE               @@ 080822AA DA00     
mov     r4,#0x4A                @@ 080822AC 244A  
loc_80822AE:   
cmp     r4,#0x55                @@ 080822AE 2C4B     
beq     epilogue_text               @@ 080822B0 D00E     
cmp     r4,#0x4B                @@ 080822B2 2C4B     
bgt     loc_80822BC               @@ 080822B4 DC02     
cmp     r4,#0x4A                @@ 080822B6 2C4A     
beq     nodata_text               @@ 080822B8 D003     
b       chapter_text                @@ 080822BA E015   
loc_80822BC:  
cmp     r4,#0x57                @@ 080822BC 2C4C     
beq     postgame_text               @@ 080822BE D00D     
b       chapter_text                @@ 080822C0 E012  

nodata_text:   
ldr     r0,=0xCC  @NO DATA              @@ 080822C2 4802      @@text ID --NO DATA--: 0x5d2
blh     0x800a240    @0x8012C60               @@ 080822C4 F790FCCC  @text ID 
b       end_80822a4               @@ 080822C8 E01B     

epilogue_text:    
ldr     r0,=0x7cf @Epilogue (song name)             @@ 080822D0 4801     @@text ID --EPILOGUE--: 0x5d3
blh     0x800a240    @0x8012C60               @@ 080822D2 F790FCC5 
b       end_80822a4               @@ 080822D6 E014     

postgame_text:   
ldr     r0,=0x7D0 @????             @@ 080822DC 4801     @@text ID --TRIAL--: 0x5d4
blh      0x800a240                @@ 080822DE F790FCBF 
b       end_80822a4               @@ 080822E2 E00E     
.ltorg

chapter_text:
cmp		r1,#1
beq		LoadAltTitle    
mov     r0,#0x7F                @@ 080822E8 207F     
and     r0,r4               @@ 080822EA 4020     
blh     0x8034618 @0x8031574                @@ 080822EC F7AFF942  @get data for chapter r0
asr     r1,r4,#0x7                @@ 080822F0 11E1     
mov     r2,#0x1               @@ 080822F2 2201     
and     r1,r2               @@ 080822F4 4011     
lsl     r1,r1,#0x1                @@ 080822F6 0049     
add     r0,#0x70                @@ 080822F8 3070   @byte 112, text IDs for 0xeac mode. Still true for fe8 tho not labeled.   
add     r0,r0,r1                @@ 080822FA 1840     
ldrh    r0,[r0]               @@ 080822FC 8800
b		CopyTitleText

LoadAltTitle:
lsl		r0,#1
ldr		r1,AltChapterTitleTable
ldrh	r0,[r1,r0]

@at this point we should expect to have the chapter title text ID (160 fe8, 58c fe7) 
@(sort of, 160 is the short title for the credits, at 55c in fe7)
CopyTitleText:
blh     0x800a240      @0x8012C60               @@ 080822FE F790FCAF
end_80822a4: 
pop     {r4}                @@ 08082302 BC10     
pop     {r1}                @@ 08082304 BC02     
bx      r1                @@ 08082306 4708     

.ltorg

sub_8082224:
push    {r4-r6,r14}               @@ 08082224 B570     
mov     r6,r0               @@ 08082226 1C06     
mov     r5,#0x0               @@ 08082228 2500     
mov     r4,#0x0               @@ 0808222A 2400     
b       loc_8082288               @@ 0808222C E02C   
loop_808222E:  
mov     r0,r6               @@ 0808222E 1C30     
bl      MapTextCharacterToFont               @@ 08082230 F7FFFF5A 
cmp     r0,#0x80                @@ 08082234 2880     
bne     loc_8082250               @@ 08082236 D10B     
cmp     r4,r5               @@ 08082238 42AC     
bls     loc_8082246               @@ 0808223A D904     
add     r0,r4,#3                @@ 0808223C 1CE0     
lsl     r0,r0,#0x18               @@ 0808223E 0600     
lsr     r4,r0,#0x18               @@ 08082240 0E04     
mov     r5,r4               @@ 08082242 1C25     
b       loc_8082286               @@ 08082244 E01F  
loc_8082246:   
add     r0,r5,#3                @@ 08082246 1CE8     
lsl     r0,r0,#0x18               @@ 08082248 0600     
lsr     r5,r0,#0x18               @@ 0808224A 0E05     
mov     r4,r5               @@ 0808224C 1C2C     
b       loc_8082286               @@ 0808224E E01A   
loc_8082250:  
lsl     r1,r0,#0x3                @@ 08082250 00C1     
ldr     r0,FontDimensionsTable @0x8CC2784               @@ 08082252 4805     
add     r2,r1,r0                @@ 08082254 180A     
ldrb    r0,[r2]               @@ 08082256 7810     
sub     r1,r4,r0                @@ 08082258 1A21     
ldrb    r3,[r2,#0x1]                @@ 0808225A 7853     
sub     r0,r5,r3                @@ 0808225C 1AE8     
cmp     r1,r0               @@ 0808225E 4281     
ble     loc_808226C               @@ 08082260 DD04     
mov     r5,r4               @@ 08082262 1C25     
b       loc_808226E               @@ 08082264 E003     
lsl     r0,r0,#0x0                @@ 08082266 0000     
mov     r7,#0x84                @@ 08082268 2784     
lsr     r4,r1,#0x3                @@ 0808226A 08CC  
loc_808226C:   
mov     r4,r5               @@ 0808226C 1C2C   
loc_808226E:  
mov     r0,r4               @@ 0808226E 1C20     
add     r0,#0x0FF               @@ 08082270 30FF     
ldrb    r1,[r2,#0x2]                @@ 08082272 7891     
add     r0,r1,r0                @@ 08082274 1808     
lsl     r0,r0,#0x18               @@ 08082276 0600     
lsr     r4,r0,#0x18               @@ 08082278 0E04     
mov     r0,r5               @@ 0808227A 1C28     
add     r0,#0x0FF               @@ 0808227C 30FF     
ldrb    r2,[r2,#0x3]                @@ 0808227E 78D2     
add     r0,r2,r0                @@ 08082280 1810     
lsl     r0,r0,#0x18               @@ 08082282 0600     
lsr     r5,r0,#0x18               @@ 08082284 0E05  
loc_8082286:   
add     r6,#0x1               @@ 08082286 3601   
loc_8082288:  
ldrb    r0,[r6]               @@ 08082288 7830     
cmp     r0,#0x0               @@ 0808228A 2800     
beq     loc_8082292               @@ 0808228C D001     
cmp     r0,#0x1F                @@ 0808228E 281F     
bne     loop_808222E                @@ 08082290 D1CD 
loc_8082292:    
add     r1,r4,r5                @@ 08082292 1961     
asr     r1,r1,#0x1                @@ 08082294 1049     
mov     r0,#0x0C0               @@ 08082296 20C0     
sub     r0,r0,r1                @@ 08082298 1A40     
asr     r0,r0,#0x1                @@ 0808229A 1040     
pop     {r4-r6}               @@ 0808229C BC70     
pop     {r1}                @@ 0808229E BC02     
bx      r1                @@ 080822A0 4708     
.ltorg

MapTextCharacterToFont:
push    {r14}    
add     sp,#-0x20   
mov     r3,r0    
ldrb    r2,[r3]    
mov     r0,r2    
sub     r0,#0x41     
lsl     r0,r0,#0x18     
lsr     r0,r0,#0x18    
cmp     r0,#0x19   
bhi     NotUppercase    
ldrb    r0,[r3]        @uppercase
sub     r0,#0x41     
b       GotTextCharacterIndex 
NotUppercase:    
mov     r0,r2    
sub     r0,#0x61     
lsl     r0,r0,#0x18     
lsr     r0,r0,#0x18    
cmp     r0,#0x19    
bhi     NotLowercase    
ldrb    r0,[r3]        @lowercase
sub     r0,#0x47    
b       GotTextCharacterIndex    
NotLowercase:
mov     r0,r2   
sub     r0,#0x30    
lsl     r0,r0,#0x18     
lsr     r0,r0,#0x18    
cmp     r0,#0x9    
bhi     NotNumeral    
ldrb    r0,[r3]        @numerals
add     r0,#0x4    
b       GotTextCharacterIndex

	NotNumeral:       @\& symbol
	mov  r1, r2
	cmp  r1, #0x26
	bne Check_Apostrophe
	
		mov  r0, #0x3E
		b    GotTextCharacterIndex
		
	Check_Apostrophe:
	cmp r1, #0x27
	bne Check_HyphenPeriodSlash
		
		mov  r0, #0x3F
		b    GotTextCharacterIndex
	
	Check_HyphenPeriodSlash:
	mov r0, r2
	sub r0, #0x2C
	lsl r0, r0, #0x18
	lsr r0, r0, #0x18
	cmp r0, #0x2
	bhi Check_Colon

		@-./ symbols
		ldrb r0, [r3]
		add r0, #0x14
		b GotTextCharacterIndex
		
	Check_Colon:
	cmp     r1,#0x3A     
	bne     Check_CD     
	mov     r0,#0x43     
	b       GotTextCharacterIndex  
	
	Check_CD:        @Í
	cmp     r1,#0xCD
	bne     Check_9C    
	mov     r0,#0x44   
	b       GotTextCharacterIndex 
	
	Check_9C:        @œ
	cmp     r1,#0x9C
	bne     Check_E0
	mov     r0,#0x45
	b       GotTextCharacterIndex 
	
	Check_E0:        @à
	cmp     r1,#0xE0
	bne     Check_E1
	mov     r0,#0x46
	b       GotTextCharacterIndex
	
	Check_E1:
	ldrb    r0,[r3]
	mov     r1,r0
	cmp     r1,#0xE1
	bne     Check_E2
	mov     r0,#0x47
	b       GotTextCharacterIndex
	
	Check_E2:
	cmp     r1,#0xE2
	bne     Check_E4
	mov     r0,#0x48
	b       GotTextCharacterIndex
	
	Check_E4:
	cmp     r1,#0xE4
	bne     Check_E8
	mov     r0,#0x49
	b       GotTextCharacterIndex
	
	Check_E8:
	cmp     r1,#0xE8
	bne     Check_E9
	mov     r0,#0x4A
	b       GotTextCharacterIndex
	
	Check_E9:
	cmp     r1,#0xE9
	bne     Check_EA
	mov     r0,#0x4B
	b       GotTextCharacterIndex
	
	Check_EA:
	cmp     r1,#0xEA
	bne     Check_ED
	mov     r0,#0x4C
	b       GotTextCharacterIndex
	
	Check_ED:
	cmp     r1,#0xED
	bne     Check_EE
	mov     r0,#0x4D
	b       GotTextCharacterIndex
	
	Check_EE:
	cmp     r1,#0xEE
	bne     Check_F1
	mov     r0,#0x4E
	b       GotTextCharacterIndex
	
	Check_F1:
	cmp     r1,#0xF1
	bne     Check_F2
	mov     r0,#0x56
	b       GotTextCharacterIndex
	
	Check_F2:
	cmp     r1,#0xF2
	bne     Check_F3
	mov     r0,#0x4F
	b       GotTextCharacterIndex
	
	Check_F3:
	cmp     r1,#0xF3
	bne     Check_F4
	mov     r0,#0x50
	b       GotTextCharacterIndex
	
	Check_F4:
	cmp     r1,#0xF4
	bne     Check_F6
	mov     r0,#0x51
	b       GotTextCharacterIndex
	
	Check_F6:
	cmp     r1,#0xF6
	bne     Check_FC
	mov     r0,#0x52
	b       GotTextCharacterIndex
	
	Check_FC:
	cmp     r1,#0xFC
	bne     Check_Parenthese_Open
	mov     r0,#0x53
	b       GotTextCharacterIndex
	
	Check_Parenthese_Open:
	cmp     r1,#0x28
	bne     Check_Parenthese_Close
	mov     r0,#0x54
	b       GotTextCharacterIndex
	
	Check_Parenthese_Close:
	cmp     r1,#0x29
	bne     MapToSpaceChar
	mov     r0,#0x55
	b       GotTextCharacterIndex
	
@anything unrecognized is now a space.

MapToSpaceChar:   
mov     r0,#0x80
GotTextCharacterIndex:  
add     sp,#0x20     
pop     {r1}    
bx      r1
.align 
.ltorg

sub_8082168:
push    {r4-r7,r14}               @@ 08082168 B5F0     
mov     r7,r10                @@ 0808216A 4657     
mov     r6,r9               @@ 0808216C 464E     
mov     r5,r8               @@ 0808216E 4645     
push    {r5-r7}               @@ 08082170 B4E0     
add     sp,#-0x18               @@ 08082172 B086     
str     r0,[sp]               @@ 08082174 9000     
str     r1,[sp,#0x4]                @@ 08082176 9101     
mov     r4,r2               @@ 08082178 1C14     
str     r3,[sp,#0x8]                @@ 0808217A 9302     
mov     r0,r4               @@ 0808217C 1C20     
bl      sub_80820CC                @@ 0808217E F7FFFFA5 
mov     r1,#0x0FF               @@ 08082182 21FF     
and     r1,r0               @@ 08082184 4001     
str     r1,[sp,#0x0C]               @@ 08082186 9103     
asr     r0,r0,#0x8                @@ 08082188 1200     
lsl     r0,r0,#0x4                @@ 0808218A 0100     
str     r0,[sp,#0x10]               @@ 0808218C 9004     
lsl     r4,r4,#0x3                @@ 0808218E 00E4     
ldr     r0,FontDimensionsTable @0x8CC2784               @@ 08082190 4801     
add     r6,r4,r0                @@ 08082192 1826     
ldrb    r2,[r6,#0x6]                @@ 08082194 79B2     
b       loc_808220E               @@ 08082196 E03A     
mov     r7,#0x84                @@ 08082198 2784     
lsr     r4,r1,#0x3                @@ 0808219A 08CC   
loc_808219C:  
mov     r5,#0x0               @@ 0808219C 2500     
add     r1,r2,#1                @@ 0808219E 1C51     
str     r1,[sp,#0x14]               @@ 080821A0 9105     
ldrb    r0,[r6,#0x5]                @@ 080821A2 7970     
cmp     r5,r0               @@ 080821A4 4285     
bge     loc_808220C               @@ 080821A6 DA31     
ldr     r1,[sp,#0x10]               @@ 080821A8 9904     
add     r0,r1,r2                @@ 080821AA 1888     
asr     r1,r0,#0x3                @@ 080821AC 10C1     
lsl     r1,r1,#0x0A               @@ 080821AE 0289     
mov     r10,r1                @@ 080821B0 468A     
mov     r7,#0x7               @@ 080821B2 2707     
and     r0,r7               @@ 080821B4 4038     
lsl     r0,r0,#0x2                @@ 080821B6 0080     
mov     r9,r0               @@ 080821B8 4681     
asr     r0,r2,#0x3                @@ 080821BA 10D0     
lsl     r0,r0,#0x0A               @@ 080821BC 0280     
mov     r8,r0               @@ 080821BE 4680     
and     r2,r7               @@ 080821C0 403A     
lsl     r2,r2,#0x2                @@ 080821C2 0092     
mov     r12,r2                @@ 080821C4 4694     
loc_80821C6:
@loops to here.
ldr     r2,[sp,#0x0C]               @@ 080821C6 9A03     
add     r0,r2,r5                @@ 080821C8 1950     
ldr     r1,[sp,#0x8]                @@ 080821CA 9902     
add     r4,r1,r5                @@ 080821CC 194C     
asr     r1,r0,#0x3                @@ 080821CE 10C1     
lsl     r1,r1,#0x5                @@ 080821D0 0149     
ldr     r2,[sp]               @@ 080821D2 9A00     
add     r1,r2,r1                @@ 080821D4 1851     
add     r1,r10                @@ 080821D6 4451     
add     r1,r9               @@ 080821D8 4449     
and     r0,r7               @@ 080821DA 4038     
lsl     r3,r0,#0x2                @@ 080821DC 0083     
mov     r0,#0x0F                @@ 080821DE 200F     
lsl     r0,r3               @@ 080821E0 4098     
ldr     r2,[r1]               @@ 080821E2 680A     
and     r2,r0               @@ 080821E4 4002     
cmp     r2,#0x0               @@ 080821E6 2A00     
beq     loc_8082204               @@ 080821E8 D00C     
asr     r0,r4,#0x3                @@ 080821EA 10E0     
lsl     r0,r0,#0x5                @@ 080821EC 0140     
ldr     r1,[sp,#0x4]                @@ 080821EE 9901     
add     r0,r1,r0                @@ 080821F0 1808     
add     r0,r8               @@ 080821F2 4440     
add     r0,r12                @@ 080821F4 4460     
lsr     r2,r3               @@ 080821F6 40DA     
and     r4,r7               @@ 080821F8 403C     
lsl     r1,r4,#0x2                @@ 080821FA 00A1     
lsl     r2,r1               @@ 080821FC 408A     
ldr     r1,[r0]               @@ 080821FE 6801     
orr     r1,r2               @@ 08082200 4311     

@@@@@@@@@@@@@HERE it stores to vram.

str     r1,[r0]               @@ 08082202 6001   
loc_8082204:  
add     r5,#0x1               @@ 08082204 3501     
ldrb    r2,[r6,#0x5]                @@ 08082206 7972     
cmp     r5,r2               @@ 08082208 4295     
blt     loc_80821C6               @@ 0808220A DBDC  
loc_808220C:   
ldr     r2,[sp,#0x14]               @@ 0808220C 9A05  
loc_808220E:   
ldrb    r0,[r6,#0x7]                @@ 0808220E 79F0     
cmp     r2,r0               @@ 08082210 4282     
blt     loc_808219C               @@ 08082212 DBC3     
add     sp,#0x18                @@ 08082214 B006     
pop     {r3-r5}               @@ 08082216 BC38     
mov     r8,r3               @@ 08082218 4698     
mov     r9,r4               @@ 0808221A 46A1     
mov     r10,r5                @@ 0808221C 46AA     
pop     {r4-r7}               @@ 0808221E BCF0     
pop     {r0}                @@ 08082220 BC01     
bx      r0                @@ 08082222 4700     
.ltorg

sub_80820CC:
mov     r2,#0x0               @@ 080820CC 2200     
ldr     r1,FontDimensionsTable @=0x8CC2784                @@ 080820CE 4905     
cmp     r0,#0x0               @@ 080820D0 2800     
beq     loc_80820E0               @@ 080820D2 D005  
loc_80820D4:   
ldrb    r3,[r1,#0x4]                @@ 080820D4 790B     
add     r2,r3,r2                @@ 080820D6 189A     
add     r1,#0x8               @@ 080820D8 3108     
sub     r0,#0x1               @@ 080820DA 3801     
cmp     r0,#0x0               @@ 080820DC 2800     
bne     loc_80820D4               @@ 080820DE D1F9   
loc_80820E0:  
mov     r0,r2               @@ 080820E0 1C10     
bx      r14               @@ 080820E2 4770     
.ltorg

.align
Font_Graphic_Ptr:
.set FontDimensionsTable, Font_Graphic_Ptr+4
.set AltChapterTitleTable, FontDimensionsTable+4
