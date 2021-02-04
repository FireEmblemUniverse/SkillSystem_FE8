echo off
cd %~dp0
cd ..
echo on

Core Doc -output:"Event assembler language.txt" -docHeader:"%~dp0Header.txt" -docFooter:"%~dp0Footer.txt"

pause