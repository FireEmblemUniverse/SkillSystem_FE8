@echo off
SET Png2Dmp="../../../../../../../EventAssembler/Tools/Png2Dmp.exe"

FOR %%A IN (*.png) DO (
  %Png2Dmp% %%A --lz77 )