@echo off
@set "Png2Dmp=%~dp0/../../EventAssembler/Tools/Png2Dmp.exe"
(%Png2Dmp% "%~1" --lz77 -po "%~n1_pal.dmp")

pause