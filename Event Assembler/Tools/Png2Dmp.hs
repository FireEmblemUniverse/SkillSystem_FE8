module Main where

--import Codec.Picture
import GBAGraphics
import GBAUtilities (stripExtension, makeError)
import FlagUtilities
import GBALZ77 (gbaLZ77Compress)
import System.Environment (getArgs)
import System.IO (stdout)
import Data.ByteString (hPut, readFile, writeFile)
import Prelude hiding (writeFile, readFile)

main::IO ()
main = do 
    argv <- getArgs
    let options = getOptions argv
    let params = getUnflaggedParams argv
    let toStdOut = elem "--to-stdout" options

    if elem "--help" options
    then putStr $ makeError toStdOut "Usage: ./Png2Dmp <filename.png> [--lz77] [-up <palettein.dmp>(not implemented)] [-po <paletteout.dmp>]  [--palette-only] [--to-stdout] [--help]"
    else if length params /= 1
    then putStr $ makeError toStdOut  "Incorrect number of parameters. Use ./Png2Dmp --help for usage."
    else do
    let inputFileName = head params
    let paletteOnly = elem "--palette-only" options
    inputData <- readFile inputFileName
    case pngToGba inputData of
        Left err -> putStr $ makeError toStdOut err
        Right (plt, img) -> do
            let finalData = case elem "--lz77" options of True -> gbaLZ77Compress img; False -> img
            if toStdOut && (not paletteOnly)
                then hPut stdout finalData
                else writeFile (stripExtension inputFileName ++ ".dmp") finalData
            if elem "-po" argv
                then case (getParamAfterFlag "-po" argv) of
                    Nothing -> putStr $ makeError toStdOut "No output for the palette specified!"
                    Just outputPaletteName -> writeFile outputPaletteName plt
                else if paletteOnly then hPut stdout plt else return ()
