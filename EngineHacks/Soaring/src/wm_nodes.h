//basically coords for all world map nodes

#ifndef __WM_NODES__
#define __WM_NODES__

//80bb628 gets the name given the coords (and wm unlock status)
//r0=struct (not used), r1 = x coord, r2 = y coord
//probably slow though


//use a lookup table

//if 170<y<854 ignore. so we have a 1024x684 table that needs to fit into 480x320
//or we could have 256x171?

// castle frelia: 88, 72

// player coord 184, 330

// 330-170 = 160

// 160>>7 = 88>>6
// 184>>7 ~ 72>>6

enum WMLocations{
	NoLoc,
	Frelia, //1
	Jehanna,//2
	Grado,  //3
	Renais, //4
	Rausten,//5
	Valni,  //6
	Lagdou  //7
};

#endif