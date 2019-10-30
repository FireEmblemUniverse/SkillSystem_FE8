@ at 0x2AFFE
.thumb
cmp r0, #0xC    @Cannot double effect
beq retFalse

.org 0x10
retFalse: