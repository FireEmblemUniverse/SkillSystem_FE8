@Allows one to customize the walking sounds of a class
.thumb

.org 0x78D78
@r0 has class id

ldr 	r1, table1
ldrb 	r0,[r1,r0]
ldr 	r1,table2
lsl 	r0,r0,#0x2
add 	r1,r1,r0
ldr 	r5,[r1]
b 		next

.align
table1:
.long 0x08078D90
table2:
.long 0x08078E90

.org 0x78FEE
next:
