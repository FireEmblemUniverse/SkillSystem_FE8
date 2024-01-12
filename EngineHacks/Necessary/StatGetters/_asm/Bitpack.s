.thumb 
@ given r0 = address, r1 = bit offset, r2 = number of bits, load only that data 
@ return the data we asked for 
@ top bit of the data makes the whole int negative 
.global UnpackData_Signed 
.type UnpackData_Signed, %function 
UnpackData_Signed: 
push {r4-r5}
mov r4, r1 
cmp r2, #32 
blt NoCapBits 
mov r2, #32 
NoCapBits: 
mov r5, r2 

lsr r1, #3 @ 8 bits per byte 
add r0, r1 @ starting address 
lsl r1, #3 @ only bits that don't make a byte 
sub r4, r1 @ starting bit of the offset 

mov r3, #7 
add r3, r2 @ number of bits + 7 for rounding 
add r3, r4 @ bit offset (ignoring bits that made a byte) 
lsr r3, #3 @ bits / 8 rounded up as # of bytes to load 
@ r3 as the number of bytes to load (0-indexed) 
cmp r3, #3 
ble NoCap 
mov r3, #3 @ only load up to 4 bytes 
NoCap: 
mov r2, r0 @ starting address 

mov r1, #0 
Loop: 
ldrb r0, [r2, r3] 
sub r3, #1 
lsl r1, #8 
orr r1, r0 
cmp r3, #0 
blt Break 
b Loop 

Break: 
@ r1 has the data we need 
@ r4 = bit to start at 
@ r5 = number of bits to load 
lsr r1, r4 
mov r2, #32 
sub r2, r5 

mov r0, #1 
mov r3, r5 
sub r3, #1 
lsl r0, r3 @ only top bit set 

lsl r1, r2 
lsr r1, r2 @ data we asked for not yet signed 

tst r1, r0 
beq ReturnData
bic r1, r0 @ remove top bit 
neg r1, r1 

ReturnData: 
mov r0, r1
pop {r4-r5} 
bx lr
.ltorg 


@ given r0 = address, r1 = bit offset, r2 = number of bits, r3 = data to store
@ return nothing
@ if data exceeds the space, cap it at all bits set for negative, or all bits except top bit if positive 
@ top bit of the data makes the whole int negative 
.global PackData_Signed 
.type PackData_Signed, %function 
PackData_Signed: 
push {r4-r7}


mov r4, r1 
mov r6, r3 @ data to store 

cmp r2, #32 
blt NoCapBitsStore 
mov r2, #32 
NoCapBitsStore: 
mov r5, r2 

lsr r1, #3 @ 8 bits per byte 
add r0, r1 @ starting address 
lsl r1, #3 @ only bits that don't make a byte 
sub r4, r1 @ starting bit of the offset 


mov r3, #7 
add r3, r2 @ number of bits + 7 for rounding 
add r3, r4 @ bit offset (ignoring bits that made a byte) 
lsr r3, #3 @ bits / 8 rounded up as # of bytes to load 
mov r7, r3 


@ r3 as the number of bytes to load (0-indexed) 
cmp r3, #3 
ble NoCap2 
mov r3, #3 @ only load up to 4 bytes 
NoCap2: 
mov r2, r0 @ starting address 
mov r1, #0 
Loop2: 
ldrb r0, [r2, r3] 
sub r3, #1 
lsl r1, #8 
orr r1, r0 
cmp r3, #0 
blt Break2 
b Loop2 

Break2: 
@ r1 has the data we need 
@ r4 = bit to start at 
@ r5 = number of bits to store
mov r0, #1 
mov r3, r5 
sub r3, #1 
lsl r0, r3 @ only top bit set (the negative determining one) 

cmp r6, #0 
blt Negative 
@ positive 
cmp r6, r0 
blt NoCapStorePositiveData 
sub r0, #1 
mov r6, r0 @ maximum possible positive value 
NoCapStorePositiveData: 
b StoreData 
Negative: 

neg r6, r6 @ swap negative into positive 
mov r3, r6 @ value to add 
cmp r6, r0 
blt NoCapStoreNegativeData
mov r3, r0 
sub r3, #1 @ all bits except top 
add r3, r0 @ capped as all bits 
NoCapStoreNegativeData: 
mov r6, r3 
mov r3, #1 
mov r0, r5 
sub r0, #1 
lsl r3, r0 @ # of bits -1 so we'll be at the final, negative bit 
orr r6, r3 @ negative bit is set 

StoreData: 
@ don't lsr chop anything off in loaded data, just bic the bits we are going to store to 
@ remove any set bits in original data 
mov r3, #1 
lsl r3, r5 @ # of bits 
sub r3, #1 @ all bits to remove are set 
lsl r3, r4 @ bit offset 
bic r1, r3 @ remove any set bits for what we're overwriting 

@ r1 as data 
@ r2 as address to store into 
@ r6 as new data 
lsl r6, r4 @ bit offset 
orr r1, r6 @ new data is here! 

@ now store them back byte by byte 
mov r3, #0 
Loop3: 
strb r1, [r2, r3] 
lsr r1, #8 
add r3, #1 
cmp r3, r7 
blt Loop3 

Exit: 
pop {r4-r7} 
bx lr
.ltorg 

.global CheckBit 
.type CheckBit, %function 
CheckBit: 
@ given r0 = address 
@ r1 = bitoffset 
@ return if the bit is set or not 
lsr r2, r1, #3 @ the byte offset 
ldrb r0, [r0, r2] @ the byte we care about 
lsl r2, #3 
sub r1, r2 @ only the bit 
mov r2, #1 
lsl r2, r1 @ the bit we care about 
and r0, r2 @ the bit we want to check is here 
cmp r0, #0 
beq ReturnZero 
mov r0, #1 
ReturnZero: 
bx lr 
.ltorg 

.global SetBit 
.type SetBit, %function 
SetBit: 
@ given r0 = address 
@ r1 = bitoffset 
@ set the bit 
lsr r3, r1, #3 @ the byte offset 
lsl r3, #3 
sub r1, r3 @ the bit only 
mov r2, #1 
lsl r2, r1 @ the bit we care about 
lsr r1, r3, #3 @ the byte offset 
ldrb r3, [r0, r1] @ the byte we care about 
orr r3, r2 @ the bit we want to set is here 
strb r3, [r0, r1] 
bx lr 
.ltorg 

.global UnsetBit 
.type UnsetBit, %function 
UnsetBit: 
@ given r0 = address 
@ r1 = bitoffset 
@ set the bit 
lsr r3, r1, #3 @ the byte offset 
lsl r3, #3 
sub r1, r3 @ the bit only 
mov r2, #1 
lsl r2, r1 @ the bit we care about 
lsr r1, r3, #3 @ the byte offset 
ldrb r3, [r0, r1] @ the byte we care about 
bic r3, r2 @ the bit we want to unset is here 
strb r3, [r0, r1] 
bx lr 
.ltorg 




.global UnpackData
.type UnpackData, %function 
UnpackData: 
push {r4-r5}
mov r4, r1 
cmp r2, #32 
blt NoCapBitsA 
mov r2, #32 
NoCapBitsA: 
mov r5, r2 

lsr r1, #3 @ 8 bits per byte 
add r0, r1 @ starting address 
lsl r1, #3 @ only bits that don't make a byte 
sub r4, r1 @ starting bit of the offset 

mov r3, #7 
add r3, r2 @ number of bits + 7 for rounding 
add r3, r4 @ bit offset (ignoring bits that made a byte) 
lsr r3, #3 @ bits / 8 rounded up as # of bytes to load 
@ r3 as the number of bytes to load (0-indexed) 

cmp r3, #3 
ble NoCapA 
mov r3, #3 @ only load up to 4 bytes 
NoCapA: 
mov r2, r0 @ starting address 
mov r1, #0 
LoopA: 
ldrb r0, [r2, r3] 
sub r3, #1 
lsl r1, #8 
orr r1, r0 
cmp r3, #0 
blt BreakA 
b LoopA 

BreakA: 
@ r1 has the data we need 
@ r4 = bit to start at 
@ r5 = number of bits to load 
lsr r1, r4 
mov r2, #32 
sub r2, r5 

mov r0, #1 
mov r3, r5 
sub r3, #1 
lsl r0, r3 @ only top bit set 

lsl r1, r2 
lsr r1, r2 @ data we asked for 
mov r0, r1
pop {r4-r5} 
bx lr
.ltorg 


@ given r0 = address, r1 = bit offset, r2 = number of bits, r3 = data to store
@ return nothing
@ if data exceeds the space, cap it at max value 

.global PackData
.type PackData, %function 
PackData: 
push {r4-r7}


mov r4, r1 
mov r6, r3 @ data to store 

cmp r2, #32 
blt NoCapBitsStore2 
mov r2, #32 
NoCapBitsStore2: 
mov r5, r2 

lsr r1, #3 @ 8 bits per byte 
add r0, r1 @ starting address 
lsl r1, #3 @ only bits that don't make a byte 
sub r4, r1 @ starting bit of the offset 

mov r3, #7 
add r3, r2 @ number of bits + 7 for rounding 
add r3, r4 @ bit offset (ignoring bits that made a byte) 
lsr r3, #3 @ bits / 8 rounded up as # of bytes to load 
mov r7, r3 
@ r3 as the number of bytes to load (0-indexed) 

cmp r3, #3 
ble NoCap3 
mov r3, #3 @ only load up to 4 bytes 
NoCap3: 
mov r2, r0 @ starting address 
mov r1, #0 
Loop4: 
ldrb r0, [r2, r3] 
sub r3, #1 
lsl r1, #8 
orr r1, r0 
cmp r3, #0 
blt Break3 
b Loop4

Break3: 
@ r1 has the data we need 
@ r4 = bit to start at 
@ r5 = number of bits to store
mov r0, #1 
mov r3, r5 
lsl r0, r3 @ only top bit set 

mov r3, r6 @ value to add 
cmp r6, r0 
blt NoCapStoreData2
mov r3, r0 
sub r3, #1 @ all bits except top 
add r3, r0 @ capped
NoCapStoreData2: 
mov r6, r3 

StoreData2: 
@ don't lsr chop anything off in loaded data, just bic the bits we are going to store to 
@ remove any set bits in original data 

mov r3, #1 
lsl r3, r5 @ # of bits 
sub r3, #1 @ all bits to remove are set 
lsl r3, r4 @ bit offset 
bic r1, r3 @ remove any set bits for what we're overwriting 

@ r1 as data 
@ r2 as address to store into 
@ r6 as new data 
lsl r6, r4 @ bit offset 
orr r1, r6 @ new data is here! 

@ now store them back byte by byte 
mov r3, #0 
Loop5: 
strb r1, [r2, r3] 
add r3, #1 
lsr r1, #8 
cmp r3, r7 
blt Loop5 

Exit2: 
pop {r4-r7} 
bx lr
.ltorg 










