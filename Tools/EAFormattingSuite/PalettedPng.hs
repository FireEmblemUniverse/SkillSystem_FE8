--A small modification to a similar method in JuicyPixels, except it returns the Palette rather than the image.

module PalettedPng where
import qualified Data.ByteString as B
import PngType
import Data.List (find)
import Data.Binary( Binary( get) )
extractPalette :: B.ByteString -> Maybe PngPalette
extractPalette byte =  do 
        case runGetStrict get byte of
            Left error -> Nothing
            Right rawImg -> do
                p <- find (\c -> pLTESignature == chunkType c) $ chunks rawImg
                case parsePalette p of
                    Left _ -> Nothing
                    Right plte -> return plte