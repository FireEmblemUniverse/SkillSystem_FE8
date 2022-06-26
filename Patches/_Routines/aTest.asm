.thumb
ldr r3, Address
mov lr, r3
.short 0xF800
b After
.align 
Address: .word Addr
After:




