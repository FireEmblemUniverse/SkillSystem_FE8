all: remove ParseFile ParseFileJIS ParseFolder

ParseFile: removeParser FEParser
	ghc -O2 "ParseFile.hs" -i../ -o "ParseFile"

ParseFileJIS: removeParser FEParserJIS
	ghc -O2 "ParseFile.hs" -iJIS/:../ -o "ParseFileJIS"

removeParser: 
	rm -f "../FEParser.hi"

FEParserJIS: GBAUtilities
	ghc -O2 -c "JIS/FEParser.hs" -i../ -ohi "JIS/FEParser.hi"

FEParser: GBAUtilities
	ghc -O2 -c "../FEParser.hs" -i../ -ohi "../FEParser.hi"

GBAUtilities:
	ghc -O2 -c "../GBAUtilities.hs" -i../


Profile:
	ghc -O2 "ParseFile.hs" -i../ -prof -fprof-auto -rtsopts

ParseFolder:
	ghc -O2 "ParseFolder.hs" -i../

clean:
	rm -f *.hi
	rm -f *.o

remove:
	rm -f ParseFile
	rm -f ParseFileJIS
	rm -f ParseFolder
