@echo off

SET startDir=C:\devkitPro\devkitARM\bin\

@rem Assemble into an elf
SET as="%startDir%arm-none-eabi-as"
%as% -g -mcpu=arm7tdmi -mthumb-interwork %1 -o "%~n1.elf"

pause