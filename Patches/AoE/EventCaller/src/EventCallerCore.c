
#include "EventCaller.h"

void EventCaller(Proc* proc, u32* EventDef)
{
	struct ProcEventCaller* procEC = (struct ProcEventCaller*)ProcStartBlocking(EventCallerProc,proc);
	procEC->EventDefination = EventDef;
	return;
}

void pEC_CallEvent(struct ProcEventCaller* proc){
	CallMapEventEngine(proc->EventDefination,1);
}

bool pEC_CheckForEventEngine(Proc* proc){
	if( 0 ==ProcFind(gProc_MapEventEngine) )
		return 0;
	return 1;
}

