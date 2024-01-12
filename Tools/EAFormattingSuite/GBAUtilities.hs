{-
Just some useful functions when working with ROM images/ raw hex.
-}

module GBAUtilities (hexToInt, intToHex, readWordAt, stripExtension, padTo4, makeError) where

import qualified Data.ByteString (ByteString, length, append, pack)
import Data.ByteString.Lazy (ByteString, unpack, take, drop)
import Data.Bits
import Data.List (foldl')
import Prelude hiding (take, drop)
import qualified Prelude (take, drop)

hexToInt::(Integral a)=>String->a
hexToInt = foldl' (\acc e->acc*16 + hexDigitToInt e) 0

intToHexDigit::(Integral a)=>a->Char
intToHexDigit 0 = '0'
intToHexDigit 1 = '1'
intToHexDigit 2 = '2'
intToHexDigit 3 = '3'
intToHexDigit 4 = '4'
intToHexDigit 5 = '5'
intToHexDigit 6 = '6'
intToHexDigit 7 = '7'
intToHexDigit 8 = '8'
intToHexDigit 9 = '9'
intToHexDigit 10 = 'A'
intToHexDigit 11 = 'B'
intToHexDigit 12 = 'C'
intToHexDigit 13 = 'D'
intToHexDigit 14 = 'E'
intToHexDigit 15 = 'F'

intToHex::(Integral a)=>a->String
intToHex n = intToHex_tco n []

intToHex_tco::(Integral a)=>a->String->String
intToHex_tco n acc = case (div n 16) of
    0 -> intToHexDigit (mod n 16):acc
    dividend -> intToHex_tco dividend (intToHexDigit (mod n 16) : acc)


hexDigitToInt::(Integral a)=>Char->a
hexDigitToInt '0' = 0
hexDigitToInt '1' = 1
hexDigitToInt '2' = 2
hexDigitToInt '3' = 3
hexDigitToInt '4' = 4
hexDigitToInt '5' = 5
hexDigitToInt '6' = 6
hexDigitToInt '7' = 7
hexDigitToInt '8' = 8
hexDigitToInt '9' = 9
hexDigitToInt 'A' = 10
hexDigitToInt 'B' = 11
hexDigitToInt 'C' = 12
hexDigitToInt 'D' = 13
hexDigitToInt 'E' = 14
hexDigitToInt 'F' = 15


readWordAt::Data.ByteString.Lazy.ByteString->Int->Int
readWordAt dat off = let (a:b:c:d:emp) = (unpack . take 4 . drop (fromIntegral off)) dat in
    fromIntegral a + (shift (fromIntegral b) 8) + (shift (fromIntegral c) 16) + (shift (fromIntegral d) 24)


stripExtension::String->String
stripExtension str = let base = reverse . tail $ dropWhile (/= '.') (reverse str) in
    case base of 
        [] -> str
        x  -> x

padTo4::Data.ByteString.ByteString -> Data.ByteString.ByteString
padTo4 dat = let remainder = mod (Data.ByteString.length dat) 4 in
    if remainder == 0 
    then dat
    else Data.ByteString.append dat (Data.ByteString.pack $ Prelude.take (4- remainder) (repeat 0x0))

makeError::Bool->String->String
makeError True = ("ERROR: " ++)
makeError False = (++"\n")