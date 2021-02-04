echo off
cd %~dp0
cd ..
echo on

Core D FE6 Block 0x68CB44 none 0x52C -input:%1 "-output:%~dp1Ch1.event" -addEndGuards
Core D FE6 Block 0x68D070 none 0xF0 -input:%1 "-output:%~dp1Ch2.event" -addEndGuards
Core D FE6 Block 0x68D160 none 0x1C4 -input:%1 "-output:%~dp1Ch3.event" -addEndGuards
Core D FE6 Block 0x68D324 none 0x14C -input:%1 "-output:%~dp1Ch4.event" -addEndGuards
Core D FE6 Block 0x68D470 none 0xF4 -input:%1 "-output:%~dp1Ch5.event" -addEndGuards
Core D FE6 Block 0x68D564 none 0x140 -input:%1 "-output:%~dp1Ch6.event" -addEndGuards
Core D FE6 Block 0x68D6A4 none 0x1A0 -input:%1 "-output:%~dp1Ch7.event" -addEndGuards
Core D FE6 Block 0x68D844 none 0xD8 -input:%1 "-output:%~dp1Ch8.event" -addEndGuards
Core D FE6 Block 0x68F894 none 0x94 -input:%1 "-output:%~dp1Ch8x.event" -addEndGuards
Core D FE6 Block 0x68D91C none 0x1EC -input:%1 "-output:%~dp1Ch9.event" -addEndGuards

Core D FE6 Block 0x68DB08 none 0x1D8 -input:%1 "-output:%~dp1Ch10A.event" -addEndGuards
Core D FE6 Block 0x68E020 none 0xA8 -input:%1 "-output:%~dp1Ch10B.event" -addEndGuards
Core D FE6 Block 0x68DCE0 none 0x154 -input:%1 "-output:%~dp1Ch11A.event" -addEndGuards
Core D FE6 Block 0x68E0C8 none 0x12C -input:%1 "-output:%~dp1Ch11B.event" -addEndGuards
Core D FE6 Block 0x68DE34 none 0x1EC -input:%1 "-output:%~dp1Ch12.event" -addEndGuards
Core D FE6 Block 0x68F928 none 0xE0 -input:%1 "-output:%~dp1Ch12x.event" -addEndGuards
Core D FE6 Block 0x68E1F4 none 0x20C -input:%1 "-output:%~dp1Ch13.event" -addEndGuards
Core D FE6 Block 0x68E524 none 0xE0 -input:%1 "-output:%~dp1Ch14.event" -addEndGuards
Core D FE6 Block 0x68FA08 none 0x84 -input:%1 "-output:%~dp1Ch14x.event" -addEndGuards

Core D FE6 Block 0x68E524 none 0xE0 -input:%1 "-output:%~dp1Ch15.event" -addEndGuards
Core D FE6 Block 0x68E604 none 0x238 -input:%1 "-output:%~dp1Ch16.event" -addEndGuards
Core D FE6 Block 0x68FA8C none 0xE8 -input:%1 "-output:%~dp1Ch16x.event" -addEndGuards
Core D FE6 Block 0x68E83C none 0x270 -input:%1 "-output:%~dp1Ch17A.event" -addEndGuards
Core D FE6 Block 0x68EE24 none 0x23C -input:%1 "-output:%~dp1Ch17B.event" -addEndGuards
Core D FE6 Block 0x68EAAC none 0xE0 -input:%1 "-output:%~dp1Ch18A.event" -addEndGuards
Core D FE6 Block 0x68F060 none 0x10C -input:%1 "-output:%~dp1Ch18B.event" -addEndGuards
Core D FE6 Block 0x68EB8C none 0xF4 -input:%1 "-output:%~dp1Ch19A.event" -addEndGuards
Core D FE6 Block 0x68F16C none 0x154 -input:%1 "-output:%~dp1Ch19B.event" -addEndGuards
Core D FE6 Block 0x68EC80 none 0x1A4 -input:%1 "-output:%~dp1Ch20A.event" -addEndGuards

Core D FE6 Block 0x68F2C0 none 0x11C -input:%1 "-output:%~dp1Ch20B.event" -addEndGuards
Core D FE6 Block 0x68FB74 none 0xA0 -input:%1 "-output:%~dp1Ch20Ax.event" -addEndGuards
Core D FE6 Block 0x68FC14 none 0xBC -input:%1 "-output:%~dp1Ch20Bx.event" -addEndGuards
Core D FE6 Block 0x68F3DC none 0x190 -input:%1 "-output:%~dp1Ch21.event" -addEndGuards
Core D FE6 Block 0x68FCD0 none 0xE4 -input:%1 "-output:%~dp1Ch21x.event" -addEndGuards
Core D FE6 Block 0x68F56C none 0xFC -input:%1 "-output:%~dp1Ch22.event" -addEndGuards
Core D FE6 Block 0x68F668 none 0x11C -input:%1 "-output:%~dp1Ch23.event" -addEndGuards
Core D FE6 Block 0x68F784 none 0x110 -input:%1 "-output:%~dp1Ch24.event" -addEndGuards
Core D FE6 Block 0x68C9B8 none 0x18C -input:%1 "-output:%~dp1Tutorial.event" -addEndGuards

pause