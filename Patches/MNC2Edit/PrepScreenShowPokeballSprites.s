.thumb 

.align 4

.global PrepScreenShowPokeballSprites
.type PrepScreenShowPokeballSprites, %function 

PrepScreenShowPokeballSprites:
@ if chapter = Pokecenter, show pokeball sprites 
cmp r0, #0
bne Exit2 

ldr r0, [r2, #4] 
ldrb r0, [r0, #6] @ SMS Index to use 

ldr r3, =0x202BCF0 @ gChapterData 
ldrb r3, [r3, #0x0E] @ Chapter # 
ldr r1, =PokecenterChLabel
ldrb r1, [r1] 

cmp r3, r1 
bne Exit1 
ldr r0, =RedPokeballSMS
lsl r0, #24 
lsr r0, #24 @ Pokeball sprite 


Exit1:
ldr r3, =0x8017945 
bx r3 


Exit2:
ldr r3, =0x801791B 
bx r3 


