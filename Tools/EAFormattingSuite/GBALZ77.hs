{-# LANGUAGE BangPatterns #-}

module GBALZ77 (gbaLZ77Compress) where--(gbaLZ77Compress{-, gbaLZ77Decompress-}) where

import Prelude hiding (length, take, drop, zip, takeWhile)
import qualified Prelude
import Data.List (foldl1')
import Data.Sequence
import Data.Foldable (toList)
import Data.ByteString (ByteString, pack, unpack)
import qualified Data.ByteString (length)
import Data.Word
{-
A module implementing the compression of ByteStrings into GBA LZ77 compressed ByteStrings
A more detailed explanation of the particulars of GBA's LZ77 format can be found here:
http://florian.nouwt.com/wiki/index.php/LZ77_(Compression_Format)

A lot of the commented out code is previous implementations of algorithms that were improved through benchmarking.
By: Crazycolorz5
-}

import Data.Bits (shift, (.&.), (.|.))
import Data.Char (ord)
import GBAUtilities (padTo4)
import Data.Vector (Vector, (!))
import qualified Data.Vector as V

data LZ77DataEntry = Literal Word8 | Compressed Int Int deriving Show
type LZ77Data = Seq LZ77DataEntry

gbaLZ77Compress::ByteString -> ByteString
gbaLZ77Compress dat = padTo4 . pack . toList $ gbaMakeHeader (Data.ByteString.length dat) >< (gbaProcessLZ77Data . lz77Compress 2 (shift 1 12 - 1 + 1) 3 (shift 1 4 - 1 + 3) . unpack $ dat)

gbaLZ77Decompress::ByteString -> ByteString
gbaLZ77Decompress compressed = undefined --TODO

gbaMakeHeader::Int -> Seq Word8
gbaMakeHeader len = fromList [0x10, fromIntegral $ len .&. 0xFF, fromIntegral $ (shift len (-8)) .&. 0xFF, fromIntegral $ (shift len (-16)) .&. 0xFF]

gbaProcessLZ77Data::LZ77Data -> Seq Word8 --Use a seq for efficiency reasons
gbaProcessLZ77Data compData 
    | length compData == 0 = empty
    | otherwise            = (makeTypesByte firstEight <| foldl makeData empty firstEight) >< gbaProcessLZ77Data rest
        where
            firstEight = take 8 compData
            rest = drop 8 compData
            makeTypesByte = foldl (\acc->(\e-> case snd e of
                Literal x -> acc
                Compressed x y -> acc .|. shift 1 (7 - fst e))) 0 . zip (fromList [0..7])
            makeData acc dat = acc >< case dat of
                Literal lit -> singleton lit
                Compressed lookBehind len -> let 
                    encodedLookbehind = (lookBehind - 1)
                    encodedLength = (len - 3)
                    in singleton (fromIntegral (shift (encodedLookbehind) (-8)) .|. shift (fromIntegral encodedLength) 4) |> (fromIntegral (encodedLookbehind .&. 0xFF))

lz77Compress::Int -> Int -> Int -> Int -> [Word8] -> LZ77Data
lz77Compress minLookbehind maxLookbehind minMatchLength maxMatchLength lst = lz77Compress_main minLookbehind maxLookbehind minMatchLength maxMatchLength (V.fromList lst) 0 empty

lz77Compress_main::Int -> Int -> Int -> Int -> Vector Word8 -> Int -> LZ77Data -> LZ77Data
lz77Compress_main minLookbehind maxLookbehind minMatchLength maxMatchLength lst offset acc
    | offset <= (minLookbehind-1) = lz77Compress_main minLookbehind maxLookbehind minMatchLength maxMatchLength lst (offset+1) (acc |> Literal (lst!offset))
    -- | offset >= V.length lst  = return ()
    | offset ==  (V.length lst) = acc
    | otherwise               = let
        windowStart::Int --In this case, we need to check if there is a match worth using.
        windowStart = max 0 (offset - maxLookbehind)
        windowEnd::Int
        windowEnd = min (offset - minLookbehind) (offset - 1) --Don't let the window start on offset.
        --matchLengths::[Int] -- Goes from windowStart to windowEnd inclusive
        --matchLengths = fmap (flip (matchLength lst offset) maxMatchLength) [windowStart..windowEnd] --Maybe more efficient if generated lazily?
        indexOfMaxMatch::Int
        matchLengthToUse::Int
        (indexOfMaxMatch, matchLengthToUse) = getMaxMatch lst maxMatchLength offset [windowStart..windowEnd] --(getIndexOfMax maxMatchLength matchLengths) + windowStart
        --matchLengthToUse = matchLength lst offset indexOfMaxMatch maxMatchLength
        --matchLengthToUse = min maxMatchLength (matchLengths!!(indexOfMaxMatch - windowStart))
    in
    if matchLengthToUse >= minMatchLength
        then lz77Compress_main minLookbehind maxLookbehind minMatchLength maxMatchLength lst (offset+matchLengthToUse) (acc |> Compressed (offset-indexOfMaxMatch) matchLengthToUse)
        else lz77Compress_main minLookbehind maxLookbehind minMatchLength maxMatchLength lst (offset+1) (acc |> Literal (lst!offset))

        
getMaxMatch::(Eq a)=>Vector a->Int->Int->[Int]->(Int, Int)
getMaxMatch lst maxMatchLength baseOffs offsets = foldl1 (\acc->(\e->if snd e >= snd acc then e else acc)) $ {-# SCC getMaxMatch_zip #-} Prelude.zip offsets $ takeWhileInclusive (< maxMatchLength) $ {-# SCC getMaxMatch_map #-} map (\otherOffs -> matchLength lst baseOffs otherOffs maxMatchLength){- (flip (matchLength lst baseOffs) maxMatchLength) -} offsets 

{-
getIndexOfMax::Int->[Int]->Int
getIndexOfMax maxMatchLength lst = fst . Prelude.foldl (\acc->(\e->if matchLength e >= snd acc then e else acc)) (0, 0) $ takeWhileInclusive (\elem -> snd elem <= maxMatchLength) $ Prelude.zip ({-Prelude.take (Prelude.length lst) $ -}[0..]) lst
-}
{-
takeWhileInclusive :: (a -> Bool) -> Seq a -> Seq a
takeWhileInclusive p xs 
 | Data.Sequence.null xs = empty
 | otherwise = (index xs 0) <| if p (index xs 0) then takeWhileInclusive p (drop 1 xs)
                                                 else empty
-}
takeWhileInclusive :: (a -> Bool) -> [a] -> [a]
takeWhileInclusive _ [] = []
takeWhileInclusive p (x:xs) = x : if p x then takeWhileInclusive p xs
                                         else []

matchLength::(Eq a)=>Vector a->Int->Int->Int->Int
matchLength lst off1 off2 maxMatchLength = if {-# SCC matchLength_check #-} lst!off1 /= lst!off2 then 0 
                                                                                                 else matchLength_inner maxMatchLength (toList $ V.drop (min off1 off2 + 1) lst) (toList $ V.drop (max off1 off2 + 1) lst) 1 --matchLength_inner maxMatchLength (V.drop (min off1 off2 + 1) lst) (V.drop (max off1 off2 + 1) lst) 1
    where
        matchLength_inner _ _ [] (!acc) = acc
        matchLength_inner maxMatchLength (lst1@(l1:l1s)) (lst2@(l2:l2s)) (!acc)
            |  acc >= maxMatchLength = maxMatchLength
            | l1 == l2 = matchLength_inner maxMatchLength l1s l2s (acc+1) 
            | otherwise = acc
    {-where
        matchLength_inner maxMatchLength lst1 lst2 (!acc) = if {-# SCC matchLength_inner_check #-} acc > maxMatchLength || {- V.null lst1 || lst2 is shorter than lst 1-} V.null lst2 
            then acc else case (V.head lst1) == (V.head lst2) of
          True -> matchLength_inner maxMatchLength (V.tail lst1) (V.tail lst2) (acc+1) 
          False -> acc -}
    --length . takeWhileL (\(a,b)->a==b) $ zip (drop off1 lst) (drop off2 lst) 
    {-if fromIntegral off1 >= length lst || fromIntegral off2 >= length lst || index lst (fromIntegral off1) /= index lst (fromIntegral off2)
      then 0
      else 1 + matchLength lst (succ off1) (succ off2)-}

--testString::ByteString
--testString = pack $ map (fromIntegral . ord) "aacaacabcabaaac"
{-
"aacaacabcabaaac"
[Literal 97,Literal 97,Literal 99,Compressed 3 4,Literal 98,Compressed 3 3,Literal 97,Compressed 9 3]


[16,0,0,15,42,97,97,99,0,33,98,0,32,97,0,128]
['0x10', '0x0', '0x0', '0xf', 
'0x2a' 0010 1010, 
0001 0101
'0x61', '0x61', '0x63', '0x0', '0x21', '0x62', '0x0', '0x20', '0x61', '0x0', '0x80']


-}
{-
lz77CompressFile::String -> IO (Lz77Data Word8)
lz77CompressFile = fmap (lz77Compress slidingmaxLookbehind . Bytes.unpack) . Bytes.readFile
-}

{-
lz77DataToByteString::Lz77Data Word8 -> Bytes.ByteString
lz77DataToByteString dat = Bytes.append (encode $ length dat) (foldr bytifyEntry Bytes.empty dat) where
    bytifyEntry (lookBehind, seqLength, Nothing) acc       = Bytes.append (encode lookBehind) $ Bytes.append (encode seqLength) (Bytes.cons (0::Word8) acc)
    bytifyEntry (lookBehind, seqLength, Just terminal) acc = Bytes.append (encode lookBehind) $ Bytes.append (encode seqLength) (Bytes.cons terminal acc)
-}
