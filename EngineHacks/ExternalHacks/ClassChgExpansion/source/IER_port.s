.thumb

.macro blh to, reg=r4
	ldr \reg, =\to
	mov r14, \reg
	.short 0xF800
.endm

@ ORG 0x8028b56
.global BmPromotionItemCheckUsage
.type BmPromotionItemCheckUsage, %function
BmPromotionItemCheckUsage:
    push {r4}
    mov r0, r4
    mov r1, r5
    blh CanUnitUsePromotionItemRework
    pop {r4}
    ldr r1, =0x8028BFF
    bx r1

@ ORG 0x802A0DA
.global PrepPromotionItemCheckUsage
.type PrepPromotionItemCheckUsage, %function
PrepPromotionItemCheckUsage:
    push {r4}
    mov r0, r5
    mov r1, r4
    blh CanUnitUsePromotionItemRework
    pop {r4}
    ldr r1, =0x802A0FB
    bx r1
