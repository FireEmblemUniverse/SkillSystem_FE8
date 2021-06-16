@echo off

@set "PortraitFormatter=%~dp0/../../EventAssembler/Tools/PortraitFormatter.exe"

@cd %~dp0/Png

@dir *.png /b > png.txt

@for /f "tokens=*" %%m in (png.txt) do ("%PortraitFormatter%" "%%m")

@del png.txt

@cd %~dp0

@copy "%~dp0Png\*.dmp" "%~dp0Dmp" > nul

@del "%~dp0Png\*.dmp"

echo Done!

pause