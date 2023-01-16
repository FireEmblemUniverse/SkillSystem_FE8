.thumb 

.global prRallyMag
.type prRallyMag, %function
prRallyMag:
push { r4 - r5, lr }
mov r5, r0 @ Stat
mov r4, r1 @ Unit
bl AddRallySpectrum 
add r5, r0 
mov r1, r4 
ldr r2, =MagRallyOffset_Link
ldr r2, [r2] 
bl IsRallySet
cmp r0, #0 
beq ExitMag 
ldr r0, =MagRallyAmount_Link 
ldr r0, [r0] 
add r5, r0 
ExitMag: 
mov r0, r5
pop {r4-r5}
pop {r2} 
bx r2 
.ltorg 

AddRallySpectrum: 
push {lr} 
mov r0, r1 @ unit 
bl GetUnitDebuffEntry 

ldr r1, =SpecRallyOffset_Link
ldr r1, [r1] 
bl CheckBit
cmp r0, #0 
beq AddZero 
ldr r0, =SpecRallyAmount_Link 
ldr r0, [r0] 

b ExitSpec 
AddZero: 
mov r0, #0 
ExitSpec: 
pop {r1} 
bx r1 
.ltorg 

IsRallySet: 
push {r4, lr} 
mov r4, r2 @ offset bit
mov r0, r1 @ unit 
bl GetUnitDebuffEntry 
mov r1, r4 
bl CheckBit
cmp r0, #0 
beq Exit @ no change 
mov r0, #1 
Exit: 
pop {r4} 
pop {r1} 
bx r1 
.ltorg 



.global prRallyStr
.type prRallyStr, %function
prRallyStr:
push { r4 - r5, lr }
mov r5, r0 @ Stat
mov r4, r1 @ Unit
bl AddRallySpectrum 
add r5, r0 
mov r1, r4 
ldr r2, =StrRallyOffset_Link
ldr r2, [r2] 
bl IsRallySet
cmp r0, #0 
beq ExitStr 
ldr r0, =StrRallyAmount_Link 
ldr r0, [r0] 
add r5, r0 
ExitStr: 
mov r0, r5
pop {r4-r5}
pop {r2} 
bx r2 
.ltorg 



.global prRallySkl
.type prRallySkl, %function
prRallySkl:
push { r4 - r5, lr }
mov r5, r0 @ Stat
mov r4, r1 @ Unit
bl AddRallySpectrum 
add r5, r0 
mov r1, r4 
ldr r2, =SklRallyOffset_Link
ldr r2, [r2] 
bl IsRallySet
cmp r0, #0 
beq ExitSkl 
ldr r0, =SklRallyAmount_Link 
ldr r0, [r0] 
add r5, r0 
ExitSkl: 
mov r0, r5
pop {r4-r5}
pop {r2} 
bx r2 
.ltorg 



.global prRallySpd
.type prRallySpd, %function
prRallySpd:
push { r4 - r5, lr }
mov r5, r0 @ Stat
mov r4, r1 @ Unit
bl AddRallySpectrum 
add r5, r0 
mov r1, r4 
ldr r2, =SpdRallyOffset_Link
ldr r2, [r2] 
bl IsRallySet
cmp r0, #0 
beq ExitSpd 
ldr r0, =SpdRallyAmount_Link 
ldr r0, [r0] 
add r5, r0 
ExitSpd: 
mov r0, r5
pop {r4-r5}
pop {r2} 
bx r2 
.ltorg 



.global prRallyDef
.type prRallyDef, %function
prRallyDef:
push { r4 - r5, lr }
mov r5, r0 @ Stat
mov r4, r1 @ Unit
bl AddRallySpectrum 
add r5, r0 
mov r1, r4 
ldr r2, =DefRallyOffset_Link
ldr r2, [r2] 
bl IsRallySet
cmp r0, #0 
beq ExitDef 
ldr r0, =DefRallyAmount_Link 
ldr r0, [r0] 
add r5, r0 
ExitDef: 
mov r0, r5
pop {r4-r5}
pop {r2} 
bx r2 
.ltorg 



.global prRallyRes
.type prRallyRes, %function
prRallyRes:
push { r4 - r5, lr }
mov r5, r0 @ Stat
mov r4, r1 @ Unit
bl AddRallySpectrum 
add r5, r0 
mov r1, r4 
ldr r2, =ResRallyOffset_Link
ldr r2, [r2] 
bl IsRallySet
cmp r0, #0 
beq ExitRes 
ldr r0, =ResRallyAmount_Link 
ldr r0, [r0] 
add r5, r0 
ExitRes: 
mov r0, r5
pop {r4-r5}
pop {r2} 
bx r2 
.ltorg 



.global prRallyLuk
.type prRallyLuk, %function
prRallyLuk:
push { r4 - r5, lr }
mov r5, r0 @ Stat
mov r4, r1 @ Unit
bl AddRallySpectrum 
add r5, r0 
mov r1, r4 
ldr r2, =LukRallyOffset_Link
ldr r2, [r2] 
bl IsRallySet
cmp r0, #0 
beq ExitLuk 
ldr r0, =LukRallyAmount_Link 
ldr r0, [r0] 
add r5, r0 
ExitLuk: 
mov r0, r5
pop {r4-r5}
pop {r2} 
bx r2 
.ltorg 



.global prRallyMov
.type prRallyMov, %function
prRallyMov:
push { r4 - r5, lr }
mov r5, r0 @ Stat
mov r4, r1 @ Unit
@bl AddRallySpectrum 
@add r5, r0 
mov r1, r4 
ldr r2, =MovRallyOffset_Link
ldr r2, [r2] 
bl IsRallySet
cmp r0, #0 
beq ExitMov 
ldr r0, =MovRallyAmount_Link 
ldr r0, [r0] 
add r5, r0 
ExitMov: 
mov r0, r5
pop {r4-r5}
pop {r2} 
bx r2 
.ltorg 








