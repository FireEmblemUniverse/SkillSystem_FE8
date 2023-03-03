SET Png2Dmp="%~p0\..\..\..\..\..\EventAssembler\Tools\Png2Dmp.exe"

%Png2Dmp% "%~1" --palette-only -po "%~dpn1_pal.dmp"