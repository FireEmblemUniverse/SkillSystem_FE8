
@echo off

set png2dmp="Png2Dmp.exe"

for %%a in (%*) do (
	echo Assembling "%%~nxa"...
	%png2dmp% %%a
)

pause