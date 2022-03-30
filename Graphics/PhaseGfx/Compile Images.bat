@echo off

@set "Png2Dmp=%~dp0\..\..\EventAssembler\Tools\Png2Dmp.exe"

@dir *.png /b > png.txt

@for /f "tokens=*" %%1 in (png.txt) do ("%Png2Dmp%" "%%~1" --lz77 -po "%%~n1_pal.dmp")

@del png.txt

echo Done!

pause