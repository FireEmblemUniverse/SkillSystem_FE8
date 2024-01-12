all:
	ghc Png2Dmp.hs -o Png2Dmp -O2 -i../

Profile:
	ghc Png2Dmp.hs -o Png2Dmp -i../ -prof -fprof-auto

test:
	ghc LZ77Test.hs -O2 -o LZ77Test -i../ -prof -fprof-auto -rtsopts

lz77:
	ghc LZ77Test.hs -O2 -o LZ77Test -i../
