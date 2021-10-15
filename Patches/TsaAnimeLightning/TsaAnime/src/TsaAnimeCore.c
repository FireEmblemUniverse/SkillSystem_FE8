#include "TsaAnimeCore.h"

void EventStartAnime(Proc* proc){
	u16 x = 0xFF & gEventSlot[0xB];
	u16 y = 0xFF & (gEventSlot[0xB]>>0x10);
	StartTsaAnime(proc,TsaAnime_Lightning,&TsaAnimeInfo_Lightning,x,y);
	return;
}

void StartTsaAnime(Proc* proc, TsaAnime AnimeSet[],TsaAnimeInfo* animeInfo, s8 x, s8 y){
	ProcTsaAnime* NewProc = NULL;
	if( 0 == proc )
		return;
	else
		NewProc = (ProcTsaAnime*)ProcStartBlocking( gProc_TsaAnime, proc );
	
	NewProc->xPos = x;
	NewProc->yPos = y;
	NewProc->Animes = AnimeSet;
	NewProc->AnimeInfo = animeInfo;
	return;
}


void pTSA_SetLcd(ProcTsaAnime* proc){
	gLCDIOBuffer.bgControl[0].priority = 0;
	gLCDIOBuffer.bgControl[1].priority = 0;
	gLCDIOBuffer.bgControl[2].priority = 0;
	gLCDIOBuffer.bgControl[3].priority = 0b10;
	
	gLCDIOBuffer.dispControl.enableBg0 = 1;
	gLCDIOBuffer.dispControl.enableBg1 = 0;
	gLCDIOBuffer.dispControl.enableBg2 = 1;
	gLCDIOBuffer.dispControl.enableBg3 = 1;
	gLCDIOBuffer.dispControl.enableObj = 1;
	
	gLCDIOBuffer.winControl.win0_enableBlend = 0;
	gLCDIOBuffer.winControl.win1_enableBlend = 0;
	
	SetColorEffectsFirstTarget(1,0,1,0,0);
	SetColorEffectBackdropFirstTarget(0);
	
	SetColorEffectsSecondTarget(0,0,0,1,1);
	SetColorEffectBackdropSecondTarget(1);
	
	SetColorEffectsParameters(1,0x10,0x10,0);
	SetBgPosition(0,0,0);
	//SetBgPosition(2,proc->xPos,proc->yPos);
	SetBgPosition(2,proc->AnimeInfo->x - proc->xPos*0x10,proc->AnimeInfo->y - proc->yPos*0x10 - 0x14);
	
	gPaletteBuffer[0x3F] = 0x7FFF;
	EnablePaletteSync();
	
	proc->GfxIndex = 0;
	proc->Timer = 0;
	proc->Page_Flip = 0;
	proc->PalFix = 0x77;
	proc->IsSoundStart = 0;
	return; 
}

void pTSA_SetPal(ProcTsaAnime* proc){
	u16 tmp0 = proc->PalFix<<5;
	s16 tmp1 = (s16)__divsi3( (s32)tmp0, 0x78 );
	
	gPaletteBuffer[0x7E/2] = RGB15(tmp1,tmp1,tmp1);
	EnablePaletteSync();
	
	if( --proc->PalFix <= 0x1E )
		BreakProcLoop((Proc*)proc);
	return;
}

void pTSA_Idle(ProcTsaAnime* proc){
	if( 0 == proc->Timer )
	{
		if( 0 == proc->GfxIndex )
		{
			// loc_807FE3A
			gLCDIOBuffer.dispControl.enableBg0 = 0;
			gLCDIOBuffer.dispControl.enableBg1 = 0;
			gLCDIOBuffer.dispControl.enableBg2 = 1;
			gLCDIOBuffer.dispControl.enableBg3 = 1;
			gLCDIOBuffer.dispControl.enableObj = 1;
		}
		else if( 0 == proc->Animes[proc->GfxIndex].Gfx /*proc->GfxIndex > (FramNum&0xFF)*/ )
		{
			proc->GfxIndex = proc->Timer;
			BreakProcLoop((Proc*)proc);
			return;
		}
		
		if( 0 == proc->IsSoundStart )
		{
			m4aSongNumStart(proc->AnimeInfo->SoundIndex);
			proc->IsSoundStart = 1;
		}
		
		// loc_807FE58
		u32* tmp0 = proc->Animes[proc->GfxIndex].Gfx;
		u32* tmp1 =(u32*)( 0x6000000 | (FlipPageGfxOffset[proc->Page_Flip]<<5) );
		Decompress(tmp0,tmp1);
		
		u32* tmp2 = proc->Animes[proc->GfxIndex].TSA;
		Decompress(tmp2,gGenericBuffer);
		
		MaybeSaveSomethingForGfx(gBg2MapBuffer,gGenericBuffer,0,0,FlipPageGfxOffset[proc->Page_Flip]|FlipPagePalOffset[proc->Page_Flip]<<0xC);
		EnableBgSyncByMask(0x4);
		
		if( proc->PalFix<0 )
		{
			CopyToPaletteBuffer(proc->Animes[proc->GfxIndex].Pal,FlipPagePalOffset[proc->Page_Flip],0x20);
			EnablePaletteSync();
		}
		
		// loc_807FEFA
		proc->PalIndex = proc->GfxIndex++;
		proc->Timer = 0x4;
		proc->Page_Cur = proc->Page_Flip;
		proc->Page_Flip ^= 1;
	}	// if( 0 == proc->Timer )
	
	//loc_807FF20
	proc->Timer--;
	if( proc->PalFix<0 )
	{
		proc->PalFix = 0x1E;
		return;
	}
	s32 tmp2 = __divsi3( proc->PalFix<<5, 0xF0 );
	u8 iR2=1;
	u8 iR5=1;
	u16 iColorR=0;
	u16 iColorG=0;
	u16 iColorB=0;
	for(s8 iCount=0xE; iCount>=0; iCount-- )
	{
		iColorR = tmp2 + (0x1F & proc->Animes[proc->PalIndex].Pal[iR2]);
		iColorG = tmp2 + (0x1F & proc->Animes[proc->PalIndex].Pal[iR2]>>0x5);
		iColorB = tmp2 + (0x1F & proc->Animes[proc->PalIndex].Pal[iR2]>>0xA);
		if(iColorR>0x1F)
			iColorR = 0x1F;
		if(iColorG>0x1F)
			iColorG = 0x1F;
		if(iColorB>0x1F)
			iColorB = 0x1F;
		gPaletteBuffer[iR5 + (FlipPagePalOffset[proc->Page_Cur]<<4)] = RGB15(iColorR,iColorG,iColorB);
		iR5++;
		iR2++;
	}
	EnablePaletteSync();
	proc->PalFix -= 1;
	return;
}

void pTSA_ResetMap(ProcTsaAnime* proc){
	return;
}

void pTSA_ResetLcd(ProcTsaAnime* proc){
	*(proc->Animes->Gfx) = *(proc->Animes->Gfx)+1;
	return;
}