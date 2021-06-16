
setlocal enabledelayedexpansion

SET startDir=C:\devkitPro\devkitARM\bin\
SET as="%startDir%arm-none-eabi-as"

SET lyn=%~dp0\..\..\EventAssembler\Tools\lyn
SET png2dmp=%~dp0\..\..\EventAssembler\Tools\Png2Dmp

cd %~dp0Internal

%as% -g -mcpu=arm7tdmi -mthumb -mthumb-interwork -I %~dp0Internal Definitions.s -o Definitions.o

for %%s in (*.s) do (
    %as% -g -mcpu=arm7tdmi -mthumb -mthumb-interwork -I %%~dps %%s -o "%%~ns.o"
    %lyn% "%%~ns.o" "%~dp0Internal\Definitions.o" > "%%~ns.lyn.event"
)

cd %~dp0Modules

for %%s in (*.s) do (
    %as% -g -mcpu=arm7tdmi -mthumb -mthumb-interwork -I %%~dps %%s -o "%%~ns.o"
    %lyn% "%%~ns.o" "%~dp0Internal\Definitions.o" > "%%~ns.lyn.event"
)

for %%i in (*.png) do %png2dmp% %%i -o "%%~ni.4bpp"

rm *.o

cd %~dp0Internal

rm *.o

pause
