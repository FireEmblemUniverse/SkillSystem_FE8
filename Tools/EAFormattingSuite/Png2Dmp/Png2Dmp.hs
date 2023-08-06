{-
Converts any old PNG image to the GBA's format (tiles in raster order, raster order within tiles, 1 nibble per pixel)
Support output to stdout, lz77 compression of output, and output of palette.
By: Crazycolorz5
-}
module Main where

--import Codec.Picture
import GBAGraphics
import GBAUtilities (stripExtension, makeError)
import FlagUtilities
import GBALZ77 (gbaLZ77Compress)
import System.Environment (getArgs)
import System.IO (stdout)
import Control.Exception (try, IOException)
import Data.ByteString (ByteString, hPut, readFile, writeFile)
import Prelude hiding (writeFile, readFile)

main::IO ()
main = do
    argv <- getArgs
    let options = getOptions argv
    let params = getUnflaggedParams argv
    let toStdOut = elem "--to-stdout" options
    let compression = if elem "--lz77" options then gbaLZ77Compress else id

    if elem "--help" options
    then putStr $ makeError toStdOut "Usage: ./Png2Dmp <filename.png> [--lz77] [-up <palettein.dmp>(not implemented)] [-po <paletteout.dmp>] [-o <outputfile.dmp>] [--palette-only] [--to-stdout] [--help]"
    else if length params /= 1
    then putStr $ makeError toStdOut  "Incorrect number of parameters. Use ./Png2Dmp --help for usage."
    else if elem "-o" argv && getParamAfterFlag "-o" argv == Nothing
    then Prelude.putStr $ makeError toStdOut "No output file specified."
    else do
    let inputFileName = head params
    let paletteOnly = elem "--palette-only" options
    result <- (try (readFile inputFileName)::IO (Either IOException ByteString))
    case result of
        Left exception -> putStr $ makeError toStdOut ("Could not find or read file " ++ inputFileName ++ ".")
        Right inputData -> case pngToGba inputData of
            Left err -> putStr $ makeError toStdOut err
            Right (plt, img) -> do
                let finalData = compression img
                if not paletteOnly
                then if toStdOut
                    then hPut stdout finalData >> case getParamAfterFlag "-o" argv of
                        Just name -> writeFile name finalData
                        Nothing -> return ()
                    else case getParamAfterFlag "-o" argv of
                        Just name -> writeFile name finalData
                        Nothing -> writeFile (stripExtension inputFileName ++ ".dmp") finalData
                else return ()
                if elem "-po" argv
                    then case (getParamAfterFlag "-po" argv) of
                        Nothing -> putStr $ makeError toStdOut "No output for the palette specified!"
                        Just outputPaletteName -> writeFile outputPaletteName plt
                    else if paletteOnly then hPut stdout (compression plt) else return ()
