.thumb
@this is an asmc that sends to convoy
@slot 1 is the offset of a list of items using SHLI
@i.e. one byte per item, zero terminated

push {r4-r7, lr}
ldr r4, =0x30004bc @slot 1
ldr r4,[r4]
@8031594 does this put the item in storage?
@r0 is item
ldr r3, =0x80315bc @size of convoy
ldrb r5, [r3] @normally 0x63
ldr r2, =0x80315b4 @pointer to convoy
ldr r6, [r2] @203a81c usually
sub r6, #2
add r5, #2
NextSupply:
cmp r5, #0 @how many spaces remain in supply?
beq End
sub r5, #1
add r6, #2
ldrh r1, [r6]
cmp r1, #0 @empty slot?
bne NextSupply
@now r2 is the empty supply spot, let's start storing
Loop:
ldrb r0, [r4]
cmp r0, #0
beq End
ldr r3, =0x8016540+1 @takes item in r0 and returns YYXX where YY is uses and XX is item
bl goto_r3
strh r0,[r6] @store the item
add r6, #2
sub r5, #1
cmp r5, #0
beq End 
add r4, #1 @get the next one
b Loop

End:
pop {r4-r7}
pop {r3}
goto_r3:
bx r3
