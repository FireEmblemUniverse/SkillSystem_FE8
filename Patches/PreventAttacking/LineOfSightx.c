#include "gbafe.h"



void LineOfSight(int range) {
	
// for each blocking terrain tile in terrain map, 
// delete obstructed range map tiles 
// only if outside of move map 
	struct Unit* unit = gActiveUnit;
	//BmMapFill(gMapMovement, 0);
	//FillMovementMapForUnit(unit);
	
	// MakeTargetListForWeapon 
	asm("mov r11, r11"); 
	int range_min = range & 0xFF; 
	int range_max = range & 0xFF0000; 
	//asm("mov r11, r11"); 
	// fillMove 
	//gMapTerrain
	//gMapMovement
	//gMapRange; 
	//gMapSize.x; 
	//gMapSize.y; 
	
	int sizeX = gMapSize.x; 
	int sizeY = gMapSize.y;
	
	int originX;
	int originY;
	
	bool actionPartial = (gActionData.moveCount); 
	
	//if ((actionType == 0x1F) || (actionType == 0x1E) || (actionType == 0)) { 
	if (actionPartial) { 
	originX = gActionData.xMove; 
	originY = gActionData.yMove; 
	} 
	else { 
	originX = unit->xPos; // used to make a line between point A and point B 
	originY = unit->yPos;
	} 
	
	for (int terrainY = 0; terrainY < sizeY; terrainY++) { 
		for (int terrainX = 0; terrainX < sizeX; terrainX++) {
			u8 currTerrain = gMapTerrain[terrainY][terrainX]; 
		if (((currTerrain == 0) || (currTerrain == 0x2E) || (currTerrain==0x1A)) && ((originX != terrainX) || (originY != terrainY))) { 
			// && gMapMovement[terrainY][terrainX] == 0xFF) { // should always be -1 movement at these terrains 
			// checked that we're not deleting range from our origin tile 
			
			
			// draw line from origin to here 
			// find opposite side of wall from player 
			// fill that to end of map as 0 / cannot attack 
			// but only if not in movement map 
			// eg. player is at [1,3] 
			// bad terrain at 7,3 
			// fill 8, 9, 10 etc. x coords with 0 
		
			if (!(actionPartial)) { // 9208BAC
			
			// find nearest tile in movement map to use as our origin if we haven't moved yet 
			int foundOrigin = false; 
			for (int xOffset = range_min; xOffset <= range_max; xOffset+=1) { 
			//for (int xOffset = range_min; xOffset <= range_max; xOffset+=1) { 
				if (foundOrigin || (xOffset+terrainX >= sizeX) || (terrainX-xOffset < 0)) break; 
				for (int yOffset = range_min; yOffset <= range_max; yOffset+=1) { 
				//for (int yOffset = range_min; yOffset <= range_max; yOffset+=1) { 
					if ((yOffset+terrainY >= sizeY) || (terrainY-yOffset < 0)) break; 
					if (gMapMovement[terrainY+yOffset][terrainX] != 0xFF) {
						foundOrigin = true; 
						originY = terrainY + yOffset; 
						originX = terrainX; 
					}
					if (gMapMovement[terrainY][terrainX+xOffset] != 0xFF) {
						foundOrigin = true; 
						originY = terrainY; 
						originX = terrainX + xOffset; 
					}
					if (gMapMovement[terrainY+yOffset][terrainX+xOffset] != 0xFF) {
						foundOrigin = true; 
						originY = terrainY + yOffset; 
						originX = terrainX + xOffset; 
					}
					if (gMapMovement[terrainY-yOffset][terrainX-xOffset] != 0xFF) {
						foundOrigin = true; 
						originY = terrainY - yOffset; 
						originX = terrainX - xOffset; 
					}
				
				
				} 
			}
			} 
			
			// don't remove range for tiles farther away than range_max from current position 
			//if (ABS(originX - terrainX) + ABS(originY - terrainY) <= range_max) { 
		
			int endHereX = originX; //initialize to origin in case lines are same length? 
			int endHereY = originY;
			int xDiff=0; // badness if we are standing on the wall? but it should be in movemap always 
			int yDiff=0; 
			if (originX > terrainX) { 
				// draw from terrainX-- until 0 
				xDiff = (-1); 
				endHereX = 0; 
			} 
			if (originY > terrainY) { 
				// draw from terrainY-- until 0 
				yDiff = (-1); 
				endHereY = 0; 
			} 
			if (originX < terrainX) { 
				// draw from terrainX++ until map size border  
				xDiff = 1; 
				endHereX = sizeX; 
			} 
			if (originY < terrainY) { 
				// draw from terrainY++ until map size border 
				yDiff = 1; 
				endHereY = sizeY; 
			} 
			
			int line_x_length = ABS(originX - terrainX); 
			int line_y_length = ABS(originY - terrainY); 
			
			if (line_x_length > line_y_length) {  
				int lineY; 
				for (int lineX = xDiff; (terrainX+lineX) != endHereX; lineX+=xDiff) { 
					if (yDiff>0) lineY = ((ABS(lineX) * line_y_length) / line_x_length);
					else lineY = 0 - ((ABS(lineX) * line_y_length) / line_x_length);
					// if we've reached a percentage that makes a full num, we add it 
					gMapRange[lineY+terrainY][lineX+terrainX] = 0; 
				} 
			} 
			
			
			if (line_y_length >= line_x_length) {  
				int lineX;
				for (int lineY = yDiff; (terrainY+lineY) != endHereY; lineY+=yDiff) { 
					if (xDiff>0) lineX = ((ABS(lineY) * line_x_length) / line_y_length );
					else lineX = 0 - ((ABS(lineY) * line_x_length) / line_y_length );
					// if we've reached a percentage that makes a full num, we add it 
					gMapRange[lineY+terrainY][lineX+terrainX] = 0; 
				} 
				
				
			} 
			//}
				
			} 
		} 
	} 
	
	return; 

} 




