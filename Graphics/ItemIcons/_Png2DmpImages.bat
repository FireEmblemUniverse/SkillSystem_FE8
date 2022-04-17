@echo off

@set "Png2Dmp=%~dp0/../../EventAssembler/Tools/Png2Dmp.exe"

@dir *.png /b > png.txt
@for /f "tokens=*" %%m in (png.txt) do ("%Png2Dmp%" "%%m")
@del png.txt


@cd %~dp0/Pngs

@dir *.png /b > png.txt
echo Processing images...
@for /f "tokens=*" %%m in (png.txt) do ("%Png2Dmp%" "%%m")

@del png.txt

@cd %~dp0

@copy "%~dp0Pngs\*.dmp" "%~dp0Dmp" > nul

@del "%~dp0Pngs\*.dmp"


echo Removing "By*" from .dmp files...

py _RemoveBy.py

echo Done!

pause