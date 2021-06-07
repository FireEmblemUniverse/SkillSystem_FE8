@echo off

@rem call with palette output and compression


@cd %~dp0/Png

@dir *.png /b > png.txt

@for /f "tokens=*" %%m in (png.txt) do ("%~dp0Png2Dmp" "%%m" --lz77)

@del png.txt

@cd %~dp0

@copy "%~dp0Png\*.dmp" "%~dp0Dmp" > nul

@del "%~dp0Png\*.dmp"

echo Done!

pause