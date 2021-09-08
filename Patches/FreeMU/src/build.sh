FileName='FreeMUcore'

rm $FileName.o $FileName.asm $FileName.lyn.event
cd include
rm *.o
cd ..
make $FileName.asm
make $FileName.o
make "include/_Definitions.h.o"
make "include/MokhaRAMSpace.o"
make $FileName.lyn.event
rm *.o
cd include
rm *.o