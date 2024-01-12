@echo off


@dir *.png /b > png.txt

@for /f "tokens=*" %%m in (png.txt) do ("%~dp0Png2Dmp" "%%~m" --lz77 -po "%%~nm_pal.dmp")

@del png.txt

echo Done!

pause