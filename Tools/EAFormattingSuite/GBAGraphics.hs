--Provides tools for working with tile-by-tile graphics
module GBAGraphics (toROMPalette, toGBAColor, copySectionFromTo, copyTileFromTo, tileFold, getTile, toROMFormat, gbaPalettize, pngToGba, readPngWithPalette) where

import Data.Word
import Data.Bits
import Data.Sequence hiding (take, reverse)
import Data.ByteString hiding (take, dropWhile, head, tail, reverse)
import Data.Foldable (toList)
import Control.Monad (foldM)
import Control.Monad.Primitive (PrimState)
import PalettedPng

import Codec.Picture
import Codec.Picture.Types

toROMPalette::Palette -> ByteString
toROMPalette pal = let rawString = pack . toList . pixelFold (\acc x y px->acc><toGBAColor px) Data.Sequence.empty $ pal in
  if Data.ByteString.length rawString < 0x20
  then append rawString (pack $ take (0x20 - Data.ByteString.length rawString) $ repeat 0)
  else rawString

toGBAColor::PixelRGB8 -> Seq Word8
toGBAColor (PixelRGB8 red green blue) = let bigEndian::Word16; bigEndian = shift (fromIntegral (shift blue (-3))) 10 .|. shift (fromIntegral (shift green (-3))) 5 .|. (fromIntegral (shift red (-3)))
    in fromIntegral (bigEndian .&. 0xFF) <| Data.Sequence.singleton (fromIntegral (shift bigEndian (-8)))
    
copySectionFromTo xFrom yFrom img xTo yTo width height mutable =
    foldM (\writable->(\xyoffs->
      copyTileFromTo (xFrom+fst xyoffs) (yFrom+snd xyoffs) img
        (xTo+fst xyoffs) (yTo+snd xyoffs) writable
      )) mutable [(x,y) | x<-take width [0..], y<-take height [0..]]

copyTileFromTo::(Pixel p) => Int -> Int -> Image p -> Int -> Int -> (MutableImage (PrimState IO) p) -> IO (MutableImage (PrimState IO) p)
copyTileFromTo xFrom yFrom img xTo yTo mutable = 
    foldM (\writable->(\xyoffs->
      writePixel writable (8*xTo + fst xyoffs) (8*yTo + snd xyoffs) 
      (pixelAt img (8*xFrom + fst xyoffs) (8*yFrom + snd xyoffs)) >> return writable
      )) mutable [(x,y) | x<-[0..7], y<-[0..7]]

tileFold::(Pixel p) => (acc -> [p] -> acc) -> acc -> Image p -> acc
tileFold f i image = Prelude.foldl f i [(getTile image x y) | y<-take (div (imageHeight image) 8) [0..], x<-take (div (imageWidth image) 8) [0..]]

getTile img x y = [pixelAt img (8*x+xOff) (8*y+yOff) | yOff<-[0..7], xOff<-[0..7]]
--writeTile til mutable x y = foldM (\writable->(\dat->writePixel writable (8*x + fst xyoffs) (8*yTo + snd xyoffs) ))

toROMFormat::Image Pixel8 -> ByteString
toROMFormat im = let
        myByteSeq = (tileFold (\acc til-> acc >< fromList til) Data.Sequence.empty im)::Seq Word8
        in pack . nibblePack . toList $ myByteSeq

nibblePack::[Word8] -> [Word8]
nibblePack (x:y:xs) = ((x .&. 0xF) .|. (shift (y .&. 0xF) 4)):nibblePack xs
nibblePack (x:[]) = [(x .&. 0xF)]
nibblePack [] = []

{-
pixelFold::(Pixel a)=>(b->a->b)->b->Image a->b
pixelFold f i img = Prelude.foldl f i (Prelude.map (uncurry $ pixelAt img) [(a,b) | b <- take (imageHeight img) [0..], a <- take (imageWidth img) [0..]])
-}

gbaPalettize::Image PixelRGB8->(Image PixelRGB8, Image Pixel8)
gbaPalettize img = let paletteSeq = pixelFold (\acc x y pix -> case elemIndexL pix acc of Just index -> acc; Nothing -> acc |> pix) Data.Sequence.empty img in
    (generateImage (\x y->let ind = x+16*y in if ind < Data.Sequence.length paletteSeq then Data.Sequence.index paletteSeq (x+16*y) else (PixelRGB8 0 0 0)) 16 1, generateImage (\x y-> case elemIndexL (pixelAt img x y) paletteSeq of Just index -> fromIntegral index; Nothing -> 0) (imageWidth img) (imageHeight img))

toIndices::Image PixelRGB8 -> Image PixelRGB8 -> Image Pixel8
toIndices image palette = let paletteSeq = pixelFold (\acc x y pix -> acc |> pix) Data.Sequence.empty palette in 
    generateImage (\x y-> case elemIndexL (pixelAt image x y) paletteSeq of Just index -> fromIntegral index; Nothing -> 0) (imageWidth image) (imageHeight image)

readPngWithPalette::ByteString -> Either String (Image PixelRGB8, Image Pixel8)
readPngWithPalette fileDat = case decodePng fileDat of
    Left err -> Left err
    Right img -> case extractPalette fileDat of
        Nothing -> Right (gbaPalettize $ convertRGB8 img)
        Just pal -> Right (pal, toIndices (convertRGB8 img) pal)

pngToGba::ByteString -> Either String (ByteString, ByteString)
pngToGba fileDat = case readPngWithPalette fileDat of
    Left err -> Left err
    Right pngWithPal -> let (plt, img) = pngWithPal in Right (toROMPalette plt, toROMFormat img)