#include "gbafe.h"



void LineOfSight(void) {
	
	
// for each coord in range map, 
// determine if blocking terrain is in the way of that coord 
// or.. 
// for each blocking terrain tile in terrain map, 
// delete obstructed range map tiles 
// only if outside of move map 
	struct Unit* unit = gActiveUnit;
	BmMapFill(gMapMovement, 0);
	FillMovementMapForUnit(unit);
	
	int sizeX = gMapSize.x; 
	int sizeY = gMapSize.y;
	
	int originX = unit->xPos; // used to make a line between point A and point B 
	int originY = unit->yPos;
	
	for (int terrainY = 0; terrainY < sizeY; terrainY++) { 
		for (int terrainX = 0; terrainX < sizeX; terrainX++) {
			u8 currTerrain = gMapTerrain[terrainY][terrainX]; 
		if ((currTerrain == 0) | (currTerrain == 0x2E) | (currTerrain==0x1A)) {
				// draw line from origin to here 
				// find opposite side of wall from player 
				// fill that to end of map as 0 / cannot attack 
				// but only if not in movement map 
				// eg. player is at [1,3] 
				// bad terrain at 7,3 
				// fill 8, 9, 10 etc. x coords with 0 
				if (gMapMovement[terrainY][terrainX] == 0xFF) { 
					int endHereX;
					int endHereY;
					int xDiff; 
					int yDiff; 
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
					//freqY = line_x_length / line_y_length; 
						int lineY = 0; 
						for (int lineX = 0; (terrainX+lineX) != endHereX; lineX+=xDiff) { 
							lineY+=yDiff; 
							//lineY = (lineX * line_y_length / line_x_length) * yDiff;
							// if we've reached a percentage that makes a full num, we add it 
							gMapRange[lineY+terrainY][lineX+terrainX] = 0; 
						} 
					} 
					
					
					if (line_y_length > line_x_length) {  
					//freqY = line_x_length / line_y_length; 
						int lineX = 0;
						for (int lineY = 0; (terrainY+lineY) != endHereY; lineY+=yDiff) { 
							lineX+=xDiff; 
							//lineX = (lineY * line_x_length / line_y_length) * xDiff;
							// if we've reached a percentage that makes a full num, we add it 
							gMapRange[lineY+terrainY][lineX+terrainX] = 0; 
						} 
					} 
					
					
				} 
				
			} 
		} 
	} 
	
	// MakeTargetListForWeapon 
	
	// fillMove 
	//gMapTerrain
	//gMapMovement
	//gMapRange; 
	//gMapSize.x; 
	//gMapSize.y; 
	
	
	return; 

} 




