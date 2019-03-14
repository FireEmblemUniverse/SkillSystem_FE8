#include "PopupRework.h"

unsigned PopR_GetLength(struct PopupReworkProc* proc) {
	const u32* defintion = proc->pop.pDefinition;

	unsigned result = 0;

	if (defintion) {
		while (defintion[0] && gPopupComponentTypes[defintion[0]]) {
			const struct PopupComponentType* type = gPopupComponentTypes[defintion[0]];

			if (type->getLength)
				result += type->getLength(proc, defintion[1]);

			defintion += 2;
		}
	}

	return result;
}

void PopR_DisplayComponents(struct PopupReworkProc* proc, struct TextHandle* text) {
	const u32* defintion = proc->pop.pDefinition;

	if (defintion) {
		while (defintion[0] && gPopupComponentTypes[defintion[0]]) {
			const struct PopupComponentType* type = gPopupComponentTypes[defintion[0]];

			if (type->display)
				type->display(proc, text, defintion[1]);

			defintion += 2;
		}
	}
}
