
@ talk event type 4 (asm) 
@ 0 completion flag 
@ event: PostBattleTalkEvent 
@ Talker = 0x00 (Any) 
@ Talkee = 0xE0, 0xE1, etc. 
@ blank ??, ?? 
@ asm function = this 

.macro blh to, reg=r3
  ldr \reg, =\to
  mov lr, \reg
  .short 0xf800
.endm

.align 4
.thumb 

.global PostBattleTalkUsability
.type PostBattleTalkUsability, %function 

PostBattleTalkUsability: 
push {r4-r7, lr} 



b ReturnTrue 

sub r1, #0xE0 @ Unit ID offset 

ldr r3, =0x202BCF0 @ Chapter Data 
ldrb r0, [r3, #0x0E] @ +0x0E	Byte	Chapter ID
lsl r0, #4 @ 16 trainers per area allowed 
add r0, r1 @ which trainer exactly 
ldrb r3, =TrainerDefeatedFlagOffset @0xA0 
lsl r1, r3, #3 @ 8 flags per byte so +0x500 
add r0, r1 @ Full offset 
mov r4, r0 
blh CheckNewFlag 
cmp r0, #1 
beq ReturnTrue 
b ReturnFalse 

ReturnTrue:
mov r0, #1 @ True that we can talk 
b Exit 

ReturnFalse: 
mov r0, #3 

Exit: 


pop {r4-r7}
pop {r1} 
bx r1 

@ get the unit we're talking to ? 

@sub r1, #0xE0 @ Unit ID offset 
@
@ldr r3, =0x202BCF0 @ Chapter Data 
@ldrb r0, [r3, #0x0E] @ +0x0E	Byte	Chapter ID
@lsl r0, #4 @ 16 trainers per area allowed 
@add r0, r1 @ which trainer exactly 
@ldrb r3, =TrainerDefeatedFlagOffset @0xA0 
@lsl r1, r3, #3 @ 8 flags per byte so +0x500 
@add r0, r1 @ Full offset 
@mov r4, r0 
@blh CheckNewFlag 
@cmp r0, #1 
@beq ExitDefeatedTrainer
@
@
@
@
@GetAdjacentUnits: @r0 = unit we're checking for adjacency to
@push {r4-r7,lr}
@mov r4, r0
@
@
@
@ldrb r5,[r4,#0x10] @x coord
@ldrb r6,[r4,#0x11] @y coord
@
@ldr r7, =0x202E4D8	@Unit map
@ldr		r7,[r7]			@Offset of map's table of row pointers
@
@cmp r5, #0 
@beq SkipXMinus1
@sub r0, r5, #1 @ X-1 
@
@
@SkipXMinus1:
@cmp r6, #0 
@beq SkipYMinus1
@sub r1, r6, #1 @ Y-Y 
@
@
@SkipYMinus1:
@
@
@
@lsl		r1,#0x2			@multiply y coordinate by 4
@add		r2,r1			@so that we can get the correct row pointer
@ldr		r2,[r2]			@Now we're at the beginning of the row data
@add		r2,r0			@add x coordinate
@ldrb	r0,[r2]			@load datum at those coordinates
@
@
@mov r0,r5
@sub r0,#1
@mov r1,r6
@blh GetTrapAt
@
@ldrb r1,[r0,#2]
@mov r2, #0x70
@cmp r1, r2
@beq RetTrap
@
@mov r0,r5
@mov r1,r6
@sub r1,#1
@blh GetTrapAt
@
@ldrb r1,[r0,#2]
@mov r2, #0x70
@cmp r1, r2
@beq RetTrap
@
@mov r0,r5
@add r0,#1
@mov r1,r6
@blh GetTrapAt
@ldrb r1,[r0,#2]
@
@mov r2, #0x70
@cmp r1, r2
@beq RetTrap
@
@mov r0,r5
@mov r1,r6
@add r1,#1
@blh GetTrapAt
@ldrb r1,[r0,#2]
@
@mov r2, #0x70
@cmp r1, r2
@beq RetTrap
@
@ReturnD:
@mov r0,#0	@no trap so return 0
@
@
@RetTrap:
@pop {r4-r7}
@pop {r1}
@bx r1
@
@











