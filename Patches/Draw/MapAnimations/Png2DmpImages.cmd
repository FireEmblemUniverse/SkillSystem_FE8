@echo off

@set "Png2Dmp=%~dp0/../../../EventAssembler/Tools/Png2Dmp.exe"

@cd %~dp0/Png

@dir /b /a:d > subfolders.txt
@for /f "tokens=*" %%G in (subfolders.txt) do (
@cd %~dp0png\%%G
echo %~dp0png\%%G


@dir *.png /b > png.txt

@for /f "tokens=*" %%m in (png.txt) do ("%Png2Dmp%" "%%m" --lz77 -po "%%~nm_pal.dmp")

@cd %~dp0

@copy "%~dp0Png\%%G\*.dmp" "%~dp0Dmp" > nul

@del "%~dp0Png\%%G\*.dmp"

)

@del "%~dp0Png\subfolders.txt"

echo Done!

pause