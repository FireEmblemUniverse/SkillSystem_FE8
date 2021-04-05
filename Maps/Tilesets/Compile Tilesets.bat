@echo off

@set "Png2Dmp=%~dp0/../../Event Assembler/Tools/Png2Dmp.exe"
@set "Compress=%~dp0/../../Event Assembler/Tools/compress_tofile.exe"

@cd %~dp0/Png

@dir *.png /b > png.txt

@dir *.mapchip_config /b > mapchip.txt

@for /f "tokens=*" %%m in (png.txt) do ("%Png2Dmp%" "%%m" --lz77 -po "%%m_pal.dmp")

@for /f "tokens=*" %%m in (mapchip.txt) do ("%Compress%" "%%m" "%%m_comp.dmp")

@del png.txt

@del mapchip.txt

@cd %~dp0

@copy "%~dp0Png\*.dmp" "%~dp0Dmp" > nul

@del "%~dp0Png\*.dmp"

echo Done!

pause