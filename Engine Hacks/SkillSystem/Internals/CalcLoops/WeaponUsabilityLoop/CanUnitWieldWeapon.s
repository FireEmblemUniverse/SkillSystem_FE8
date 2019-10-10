.thumb
.align
.equ LookupList,ItemTable+4
.equ ExternalLoop,LookupList+4

.macro blh to, reg
    ldr \reg, =\to
    mov lr, \reg
    .short 0xF800
.endm

CanUnitWieldWeapon:
push {r4-r7,r14}

mov r4,r0 @r4= char struct pointer
mov r5,r1 @r5= item halfword
cmp r5,#0
bne HasAWeapon
b CannotWield

HasAWeapon:
mov r1,#0xFF
and r1,r5 @get just item ID in r1
mov r0,#0x24
mul r0,r1
ldr r1,ItemTable
add r0,r1 @r0= item table data offset
ldr r2,[r0,#8] @r2 = weapon ability word
mov r0,#1
and r0,r2 
mov r3,r1 @r3 = item table offset
cmp r0,#0 @check if the "is a weapon" bit is set
bne IsAWeapon @if so, continue
b CannotWield

IsAWeapon:
ldr r0,=#0x003D3C00 @word to be &ed to the item ability word 
and r0,r2
cmp r0,#0
bne HasWeaponLocks
b IsUnitStatused

HasWeaponLocks:

@this is terrible so let's redo it entirely
@1. lookup list; each entry is 8 bytes, ties item ability bit to character/class ability bit in a word for each (this alone is 1/4 the size of the current function and is data that will likely be larger than the replacement for the current function!!)
@2. BEGIN with the check for no ability bits to be set on character/class, then skip the whole loop if there are none (This will free up cycles so it doesn't have to run all of this every time even if it's unnecessary!!)
@3. loop that goes through the list, testing for each bit set in both 
@4. list is terminated by 0xFFFFFFFF word, at which point it continues (since it will have exited from the loop with a return false if it's found a combination that doesn't work)
@this should get rid of a ton of the bloat in this function which lets us put more things inline along with this!!!


ldr r0,[r4]
ldr r0,[r0,#0x28]
ldr r1,[r4,#4]
ldr r1,[r1,#0x28]
orr r0,r1
mov r6,r0 @r6= char/class ability word

ldr r0,=#0xF0070000
tst r0,r6
beq CannotWield @don't run the loop if we don't have any weapon locks set, we know we can't use it since to reach this point it needs to have a lock

mov r1,#0xFF
and r1,r5
mov r0,#0x24
mul r1,r0
ldr r0,ItemTable
add r1,r0
ldr r0,[r1,#8]
mov r3,r0 @r3= item ability word

ldr r7,LookupList @r7= current lookup list position

LoopStart:
ldr r0,[r7]
ldr r1,=#0xFFFFFFFF
cmp r0,r1
beq IsUnitStatused @if we've reached the end, leave

@otherwise, check for our current lock on our current item

TestItemAbilityByte:
tst r0,r3 @if this returns true, then the current lock is not set on the weapon
beq RestartLoop 

@otherwise, check if the equivalent char/class ability bit is set
ldr r0,[r7,#4]

TestCharClassAbilityByte:
tst r0,r6
beq CannotWield

RestartLoop:
add r7,#8
b LoopStart


@the original function here, commented out so you can see how ridiculous it is:

@mov r0,#0x80
@lsl r0,r0,#4
@and r2,r0 @weapon ability word anded with 0x800
@cmp r2,#0 @this is checking ephraim lock specifically?
@beq HasValidLocksOrSomething
@ldr r0,[r4]
@ldr r1,[r4,#4]
@ldr r0,[r0,#0x28]
@ldr r1,[r1,#0x28]
@orr r0,r1 @r0= combined character and class ability words
@mov r1,#0x80
@lsl r1,r1,#9
@and r0,r1 @checking reaver effect bit?
@cmp r0,#0
@bne LockCheck2
@b CannotWield

@LockCheck2:
@mov r1,#0xFF
@and r1,r5
@lsl r0,r1,#3
@add r0,r1
@lsl r0,r0,#2
@add r0,r3
@ldr r0,[r0,#8]
@mov r1,#0x80
@lsl r1,r1,#0xB
@and r0,r1
@cmp r0,#0
@beq LockCheck3
@ldr r0,[r4]
@ldr r1,[r0,#0x28]
@ldr r0,[r0,#0x28]
@ldr r1,[r1,#0x28]
@orr r0,r1
@mov r1,#0x80
@lsl r1,r1,#0x15
@and r0,r1
@cmp r0,#0
@bne LockCheck3
@b CannotWield

@LockCheck3:
@mov r1,#0xFF
@and r1,r5
@lsl r0,r1,#3
@add r0,r1
@lsl r0,r0,#2
@add r0,r3
@ldr r0,[r0,#8]
@mov r1,#0x80
@lsl r1,r1,#0xC
@and r0,r1
@cmp r0,#0
@beq CannotWield
@ldr r0,[r4]
@ldr r1,[r4,#4]
@ldr r0,[r0,#0x28]
@ldr r1,[r1,#0x28]
@orr r0,r1
@mov r1,#0x80
@lsl r1,r1,#0x16
@and r0,r1
@cmp r0,#0
@beq LockCheck4
@ldr r0,[r4]
@ldr r1,[r4,#4]
@ldr r0,[r0,#0x28]
@ldr r1,[r1,#0x28]
@orr r0,r1
@mov r1,#0x80
@lsl r1,r1,#0x17
@and r0,r1
@cmp r0,#0
@beq CannotWield

@LockCheck4:
@mov r1,#0xFF
@and r1,r5
@lsl r0,r1,#3
@add r0,r1
@lsl r0,r0,#2
@add r0,r3
@ldr r0,[r0,#8]
@mov r1,#0x80
@lsl r1,r1,#0xE
@and r0,r1
@cmp r0,#0
@beq LockCheck5
@ldr r0,[r4]
@ldr r1,[r4,#4]
@ldr r0,[r0,#0x28]
@ldr r1,[r1,#0x28]
@orr r0,r1
@cmp r0,#0
@bge CannotWield

@LockCheck5:
@mov r1,#0xFF
@and r1,r5
@lsl r0,r1,#3
@add r0,r1
@lsl r0,r0,#2
@add r0,r3
@ldr r0,[r0,#8]
@mov r1,#0x80
@lsl r1,r1,#5
@and r0,r1
@cmp r0,#0
@beq LockCheck6
@ldr r0,[r4]
@ldr r1,[r4,#4]
@ldr r0,[r0,#0x28]
@ldr r1,[r1,#0x28]
@orr r0,r1
@mov r1,#0x80
@lsl r1,r1,#0xA
@and r0,r1
@cmp r0,#0
@beq CannotWield

@LockCheck6:
@mov r0,#0xFF
@and r0,r5
@lsl r1,r0,#3
@add r1,r0
@lsl r1,r1,#2
@add r1,r3
@ldr r1,[r1,#8]
@mov r0,#0x80
@lsl r0,r0,#3
@and r0,r1
@cmp r0,#0
@beq LockCheck7
@ldr r0,[r4]
@ldr r1,[r4,#4]
@ldr r0,[r0,#0x28]
@ldr r1,[r1,#0x28]
@orr r0,r1
@mov r1,#0x80
@lsl r1,r1,#0xB
@and r0,r1
@cmp r0,#0
@beq CannotWield
@mov r0,#1
@b 16748 //166CC

.ltorg
.align

LockCheck7:
mov r0,#0x80
lsl r0,r0,#9
and r1,r0
cmp r1,#0
beq IsUnitStatused
mov r0,r4
mov r1,r5
blh 0x8016716,r1
lsl r0,r0,#0x18
cmp r0,#0
beq CannotWield

IsUnitStatused:
mov r0,r4
add r0,#0x30
ldrb r1,[r0] @This is the status byte?
mov r0,#0xF @status 0xF = stone
and r0,r1 
ldr r3,ItemTable 
cmp r0,#3 
bne DoesUnitHaveWRank
mov r1,#0xFF
and r1,r5
lsl r0,r1,#3
and r0,r1
lsl r0,r0,#2
add r0,r3
ldr r0,[r0,#8]
mov r1,#2
and r0,r1
cmp r0,#0
beq DoesUnitHaveWRank

CannotWield:
mov r1,#0
b GoBack

.ltorg
.align

DoesUnitHaveWRank:
mov r1,#0xFF
and r1,r5
lsl r0,r1,#3
add r0,r1
lsl r0,r0,#2
add r0,r3
ldrb r2,[r0,#0x1C] @get weapon's required weapon level
mov r1,#0xFF
cmp r5,#0
beq SkipWeaponTypeCheck
ldrb r1,[r0,#7] @loads item's weapon type into r1
SkipWeaponTypeCheck:
mov	r6,r2	@rank
mov	r7,r1	@item type
mov	r0,r4
add	r0,#0x28
add	r0,r1
ldrb	r0,[r0]
cmp	r0,r2
bhs	ExitLoop

@here we gonna put our external function loop
ldr r7,ExternalLoop
ExternalLoopStart:
ldr r3,[r7]
cmp r3,#0
beq ExitLoop
mov r0,r4
mov r1,r5
mov r2,r6
mov lr,r3
.short 0xF800
cmp r0,#0
beq CannotWield
add r7,#4
b ExternalLoopStart

ExitLoop:
mov r1,#1

GoBack:
mov r0,r1
Reeg:
pop {r4-r7}
pop {r1}
bx r1

.ltorg
.align

ItemTable:
@POIN Shadowgift
