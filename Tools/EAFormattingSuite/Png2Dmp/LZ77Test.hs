import Data.ByteString (readFile, writeFile)
import Prelude hiding (readFile, writeFile)
import GBALZ77 (gbaLZ77Compress)
import System.Environment (getArgs)

main = getArgs >>= \x -> fmap gbaLZ77Compress (readFile $ head x) >>= writeFile "a.out"
