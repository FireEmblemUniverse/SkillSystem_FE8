@echo off
@set "Png2Dmp=%~dp0\..\..\EventAssembler\Tools\Png2Dmp.exe"
@rem call with palette output and compression
"%Png2Dmp%" "%~1" --lz77 -po "%~n1_pal.dmp"

pause