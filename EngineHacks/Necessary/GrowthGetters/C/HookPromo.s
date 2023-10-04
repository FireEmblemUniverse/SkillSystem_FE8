.thumb 
.type CallNewPromoHandler_SetInitStat, %function 
.global CallNewPromoHandler_SetInitStat 
CallNewPromoHandler_SetInitStat:
push {lr} 
bl NewPromoHandler_SetInitStat
pop {r1} 
bx r1 
.ltorg 


