.thumb
.org 0x0

@Entrap_Target_Func
push	{r14}
ldr		r1,TargeterPtr
str		r0,[r1]			@stores current character's data ptr
ldr		r0,Clear_Map_Func
mov		r14,r0
ldr		r0,RangeMap
ldr		r0,[r0]
mov		r1,#0x0
.short	0xF800
ldr		r0,Fill_Range_Map_Func
mov		r14,r0
ldr		r0,Entrap_Target_Check
.short	0xF800
pop		{r0}
bx		r0


.align
TargeterPtr:
.long 0x02033F3C
Clear_Map_Func:
.long 0x080197E4
RangeMap:
.long 0x0202E4E4
Fill_Range_Map_Func:
.long 0x0802506C
Entrap_Target_Check:
@
