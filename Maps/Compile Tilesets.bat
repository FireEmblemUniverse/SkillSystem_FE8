@echo off

@set "Png2Dmp=%~dp0\..\EventAssembler\Tools\Png2Dmp"
@set "Compress=%~dp0\..\EventAssembler\Tools\compress_tofile.exe"

@cd %~dp0/ConfObj

@dir *.png /b > png.txt

@dir *.mapchip_config /b > mapchip.txt

@for /f "tokens=*" %%m in (png.txt) do ("%Png2Dmp%" "%%m" --lz77 -po "%%~nm_pal.dmp")

@for /f "tokens=*" %%m in (mapchip.txt) do ("%Compress%" "%%m" "%%~nm_comp.dmp")

@del png.txt

@del mapchip.txt

@cd %~dp0 

@copy "%~dp0ConfObj\*.dmp"  "%~dp0Dmp" > nul 

@del "%~dp0ConfObj\*.dmp" 


echo Done!

pause