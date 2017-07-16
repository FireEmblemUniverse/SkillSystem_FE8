.thumb
.org 0x0

@r0=char data ptr
push {r4-r6, lr}
mov r4, r0              @Unit

  mov r1, r4
  @check AI
  mov r3, #0x41
  ldrb r3, [r1,r3] @AI byte 4
  cmp r3, #0x20
  beq NoMove
  mov r3, #0x30
  ldrb r3, [r1,r3] @status
  mov r0, #0xF
  and r3, r0
  cmp r3, #0x9 @freeze status
  bne GetMov
  NoMove:
  mov r5, #0
  b GoBack

GetMov:
ldr   r1,[r0,#0x4]
ldrb  r1,[r1,#0x12] @class mov
mov   r2,#0x1D
ldsb  r0,[r0,r2]
add   r0,r1 @total mov
mov r5, r0 @accumulator

ldr r6, AdditionalDataTable
ldrb r1, [r4 ,#0xB]     @Deployment number
lsl r1, r1, #0x3    @*8
add r6, r1          @r0 = *debuff data

@Rally Bonus
@40 bit of the 0x3 byte
ldrb r1, [r6, #0x3]
mov r0, #0x40
and r0, r1
cmp r0, #0x0
beq noMovRally
add r5, #0x1
noMovRally:

@nullifycheck
mov		r1,#0x41
ldrb	r1,[r0,r1]		@AI byte 4
mov		r2,#0x20
tst		r1,r2
beq		GetMov
mov		r5,#0x0
b		GoBack
@ GetMov:
@ ldr		r1,[r0,#0x4]
@ ldrb	r1,[r1,#0x12]	@class mov
@ mov		r2,#0x1D
@ ldsb	r0,[r0,r2]
@ add		r0,r1
GoBack:
mov r0, r5
pop {r4-r6}
pop		{r1}
bx		r1
