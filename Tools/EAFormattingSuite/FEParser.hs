{-# LANGUAGE BangPatterns #-}

module FEParser (parse, unparse, parseFile, parseFileWithDefinitions, proccessFileWithDefinitions, parseDefinitions, Definitions) where

{-
The main parser for Formatted Fire Emblem Talk Conversations.
Created by Crazycolorz5 of FEU

For example, parses:
[OpenRight][LoadPortrait][0x01][0x01]
[OpenLeft][LoadPortrait][0x02][0x02]
[OpenRight]
Eliwood, let me tell you[NL]
about a lost art.[A][X]

into (in hex):
0B 10 01 01 0A 10 02 02 0B 45 6C 69 77 6F 6F 64 2C 20 6C 65 74 20 6D 65 20 74 65 6C 6C 20 79 6F 75 01 61 62 6F 75 74 20 61 20 6C 6F 73 74 20 61 72 74 2E 03 00

which is then insertable by Event Assembler.

This module also includes functions for un-parsing formatted text.
-}

import System.IO
import Data.Word
import Data.Char
import Data.ByteString as ByteString (ByteString, pack, unpack, uncons, null, splitAt)
import qualified Data.ByteString as ByteString (take, drop, empty)
import Data.ByteString (hPut)
import Data.Map.Strict (Map, (!), empty, member, insert)
import Control.Monad (join, foldM)
import Control.Exception (try, IOException)
import GBAUtilities (intToHex, stripExtension)
import Prelude hiding (null)
import qualified Prelude
--import Control.Exception --TODO: Make syntax errors imformative.
type Definitions = Map String [Word8]

prepadWithToLength str chr len = if length str < len then Prelude.take (len - length str) (repeat chr) ++ str else str

propogateError::(Either b c)->(b->d)->Either d c
propogateError e f = case e of
    Left b -> Left $ f b
    Right c -> Right c

lrApply::(Either a b)->(a->c)->(b->d)->Either c d
lrApply val lfunc rfunc = case val of
    Left l -> Left (lfunc l)
    Right r -> Right (rfunc r)

parse::Definitions->String->Either ByteString (Int, String)
parse specials = flip propogateError pack . flip (parseText specials 1) (\x->Left [])

parseText::Definitions->Int->String->(String->Either [Word8] (Int, String))->Either [Word8] (Int, String)
parseText specials lineNum ('[':'X':']':xs) cont = if not $ containsData xs then lrApply (cont []) (0x00:) (const (0, "Something went very wrong.")) else Right (lineNum, "Data to be inserted after [X].")
parseText specials lineNum [] cont = Right (lineNum, "Text did not end in [X].")
parseText specials lineNum ('#':xs) cont = parseText specials lineNum (dropWhile (/='\n') xs) cont
parseText specials lineNum ('\n':xs) cont = parseText specials (lineNum+1) xs cont
parseText specials lineNum x cont = parseCode specials lineNum x (flip (parseText specials lineNum) $ cont) --Continue by parsing a Code then parse the rest of the text.

containsData::String->Bool
containsData [] = False
containsData ('\n':xs) = containsData xs
containsData ('#':xs) = containsData (dropWhile (/='\n') xs)
containsData _ = True

parseCode::Definitions->Int->String->(String->Either [Word8] (Int, String))->Either [Word8] (Int, String)
parseCode specials lineNum ('[':xs) cont = parseSpecial specials lineNum xs (cont . tail) --tail to get rid of the ']'
parseCode specials lineNum (x:xs) cont = let value = fromIntegral (ord x) in
    if validASCII value
        then propogateError (cont xs) (value:)
        --then propogateError (cont xs) ((fromChar x)<>)
        else Right (lineNum, "ASCII character out of range: " ++ show value) --Check this error first to catch the first error in the file.

validASCII x = (x >= 0x20 && x <= 0x7F) || x >= 0xC0 || x `elem` [0x93, 0x94, 0xA1, 0xAB, 0xBB, 0xBF] -- Punctuation marks.

parseSpecial::Definitions->Int->String->(String->Either [Word8] (Int, String))->Either [Word8] (Int, String)
parseSpecial specials lineNum ('0':'x':xs) cont = parseNumber specials lineNum xs cont
--Take advantage of the fact that all Specials are terminated by a ']'
parseSpecial specials lineNum x cont = let special = takeWhile (/= ']') x in 
    case (matchSpecial specials special) of
        Left match -> propogateError (cont (drop (length special) x)) (match++) 
        Right innerErr -> Right (lineNum, innerErr)
    
  

parseNumber::Definitions->Int->String->(String->Either [Word8] (Int, String))->Either [Word8] (Int, String)
parseNumber specials lineNum (a:b:xs) cont = 
{-  if isHexDigit a 
      then-} if isHexDigit b
        then propogateError (cont xs) ((fromIntegral $ 0x10 * digitToInt a + digitToInt b):)
        else propogateError (cont (b:xs)) ((fromIntegral . digitToInt $ a):)

matchSpecial::Definitions->String -> Either [Word8] String
matchSpecial specials x
  | member x specials = Left $ specials ! x
  | otherwise         = matchDefault x

matchDefault::String -> Either [Word8] String
matchDefault "NL"       = Left [0x01]
matchDefault "2NL"      = Left [0x02]
matchDefault "A"        = Left [0x03]
matchDefault "...."     = Left [0x04]
matchDefault "....."    = Left [0x05]
matchDefault "......"   = Left [0x06]
matchDefault "......."  = Left [0x07]
matchDefault "OpenFarLeft"  = Left [0x08]
matchDefault "OpenMidLeft"  = Left [0x09]
matchDefault "OpenLeft"     = Left [0x0A]
matchDefault "OpenRight"    = Left [0x0B]
matchDefault "OpenMidRight" = Left [0x0C]
matchDefault "OpenFarRight" = Left [0x0D]
matchDefault "OpenFarFarLeft"   = Left [0x0E]
matchDefault "OpenFarFarRight"  = Left [0x0F]
matchDefault "LoadFace" = Left [0x10]
matchDefault "LoadPortrait" = Left [0x10]  --Alias
matchDefault "ClearFace"    = Left [0x11]
matchDefault "ClearPortrait"= Left [0x11] -- Alias again
matchDefault "NormalPrintFE6"   = Left [0x12] --FE6 Only codes NormalPrint, FastPrint
matchDefault "FastPrintFE6"     = Left [0x13]
matchDefault "CloseSpeechFast"  = Left [0x14]
matchDefault "CloseSpeechSlow"  = Left [0x15]
matchDefault "ToggleMouthMove"  = Left [0x16]
matchDefault "ToggleSmile"  = Left [0x17]
matchDefault "Yes"      = Left [0x18]
matchDefault "No"       = Left [0x19]
matchDefault "Buy/Sell" = Left [0x1A]
matchDefault "ShopContinue" = Left [0x1B] --FE8 Only
matchDefault "SendToBack"   = Left [0x1C]
matchDefault "FastPrint"    = Left [0x1D]
--no 0x1E code?
matchDefault "."        = Left [0x1F]
--0x20-0x7F standard ASCII
matchDefault "LoadOverworldFaces" = Left [0x80, 0x04]
matchDefault "Events"       = Left [0x80, 0x04] --Alias
matchDefault "G"        = Left [0x80, 0x05]
matchDefault "MoveFarLeft"  = Left [0x80, 0x0A]
matchDefault "MoveMidLeft"  = Left [0x80, 0x0B]
matchDefault "MoveLeft"     = Left [0x80, 0x0C]
matchDefault "MoveRight"    = Left [0x80, 0x0D]
matchDefault "MoveMidRight" = Left [0x80, 0x0E]
matchDefault "MoveFarRight" = Left [0x80, 0x0F]
matchDefault "MoveFarFarLeft"   = Left [0x80, 0x10]
matchDefault "MoveFarFarRight"  = Left [0x80, 0x11]
matchDefault "EnableBlinking"   = Left [0x80, 0x16]
matchDefault "DelayBlinking"    = Left [0x80, 0x18]
matchDefault "PauseBlinking"    = Left [0x80, 0x19]
matchDefault "DisableBlinking"  = Left [0x80, 0x1B]
matchDefault "OpenEyes"     = Left [0x80, 0x1C]
matchDefault "CloseEyes"    = Left [0x80, 0x1D]
matchDefault "HalfCloseEyes"= Left [0x80, 0x1E]
matchDefault "Wink"         = Left [0x80, 0x1F]
matchDefault "Tact"     = Left [0x80, 0x20]
matchDefault "ToggleRed"= Left [0x80, 0x21]
matchDefault "Item"     = Left [0x80, 0x22]
matchDefault "SetName"  = Left [0x80, 0x23]
matchDefault "ToggleColorInvert"    = Left [0x80, 0x25]
matchDefault "#" = Left [0x23] -- ASCII #
matchDefault x = Right $ "Unrecognized control code: "++x


unparse::ByteString->String
unparse = flip unparseCode id

unparseCode::ByteString->(String->String)->String
unparseCode code cont = if null code
    then cont []
    else case uncons code of 
         Just (x, xs) -> case x of 
             0x00      -> unparseCode xs (cont . ("[X]"++))
             0x23      -> unparseCode xs (cont . ("[#]"++))
             otherwise ->if not (x < 0x20 || x > 0x7F)
                         then unparseCode xs (cont . (chr (fromIntegral x):))
                         else if x == 0x80
                         then unparseMovement code cont
                         else unparseControl code cont
         Nothing      -> []

unparseMovement::ByteString->(String->String)->String
unparseMovement code cont = 
    let rest = (ByteString.drop 2 $ code) 
        !move = case uncons . ByteString.drop 1 $ code of 
            Just (x, xs) -> case x of
                0x04 -> "[Events]"
                0x05 -> "[G]"
                0x0A -> "[MoveFarRight]"
                0x0B -> "[MoveMidLeft]"
                0x0C -> "[MoveLeft]"
                0x0D -> "[MoveRight]"
                0x0E -> "[MoveMidRight]"
                0x0F -> "[MoveFarRight]"
                0x10 -> "[MoveFarFarLeft]"
                0x11 -> "[MoveFarFarRight]"
                0x16 -> "[EnableBlinking]"
                0x18 -> "[DelayBlinking]"
                0x19 -> "[PauseBlinking]"
                0x1B -> "[DisableBlinking]"
                0x1C -> "[OpenEyes]"
                0x1D -> "[CloseEyes]"
                0x1E -> "[HalfCloseEyes]"
                0x1F -> "[Wink]"
                0x20 -> "[Tact]"
                0x21 -> "[ToggleRed]"
                0x22 -> "[Item]"
                0x23 -> "[SetName]"
                0x25 -> "[ToggleColorInvert]"
                otherwise -> "[0x80][0x" ++ prepadWithToLength (intToHex x) '0' 2 ++ "]"
            Nothing      -> []
    in unparseCode rest $ (move++) . cont
        

unparseControl::ByteString->(String->String)->String
unparseControl code cont = case uncons code of
    Just (x, xs) -> case x of
        0x10 -> let (srt, end) = ByteString.splitAt 2 xs 
                    unpackedStart = unpack srt in
            if length unpackedStart == 2
            then let (x:y:emp) = unpackedStart in unparseCode end (cont . (("[LoadFace]" ++ "[0x" ++ intToHex x ++ "][0x" ++ intToHex y ++ "]\n") ++))
            else unparseCode xs $ cont . ("[LoadFace]"++) --Contingency.
        
        otherwise -> let !control = case x of
                            0x01 -> "[NL]\n"
                            0x02 -> "[2NL]\n"
                            0x03 -> "[A]"
                            0x04 -> "[....]"
                            0x05 -> "[.....]"
                            0x06 -> "[......]"
                            0x07 -> "[.......]"
                            0x08 -> "\n\n[OpenFarLeft]\n"
                            0x09 -> "\n\n[OpenMidLeft]\n"
                            0x0A -> "\n\n[OpenLeft]\n"
                            0x0B -> "\n\n[OpenRight]\n"
                            0x0C -> "\n\n[OpenMidRight]\n"
                            0x0D -> "\n\n[OpenFarRight]\n"
                            0x0E -> "\n\n[OpenFarFarLeft]\n"
                            0x0F -> "\n\n[OpenFarFarRight]\n"
                            0x11 -> "[ClearFace]\n"
                            0x12 -> "[NormalPrintFE6]"
                            0x13 -> "[FastPrintFE6]"
                            0x14 -> "[CloseSpeechFast]"
                            0x15 -> "[CloseSpeechSlow]"
                            0x16 -> "[ToggleMouthMove]"
                            0x17 -> "[ToggleSmile]"
                            0x18 -> "[Yes]"
                            0x19 -> "[No]"
                            0x1A -> "[Buy/Sell]"
                            0x1B -> "[ShopContinue]"
                            0x1C -> "[SendToBack]"
                            0x1D -> "[FastPrint]"
                            0x1F -> "[.]"
                            otherwise -> "[0x"++ prepadWithToLength (intToHex x) '0' 2 ++"]"
                    in unparseCode xs $ cont . (control++)
    Nothing -> cont []


parseFile::String->IO (Either ByteString (Int, String))
parseFile = flip parseFileWithDefinitions empty

parseFileWithDefinitions::String->Definitions->IO (Either ByteString (Int, String))
parseFileWithDefinitions inputFileName defns = (try ( do
        inputHandle <- openFile inputFileName ReadMode
        hSetEncoding inputHandle utf8
        contents <- hGetContents inputHandle
        return contents) ::IO (Either IOException String)) >>= \result-> case result of
    Left exception -> return $ Right (0, "Could not read file.")
    Right rawInput -> return (parse defns rawInput)

proccessFileWithDefinitions::String->Definitions->IO ()
proccessFileWithDefinitions inputFileName defns = do
    result <- parseFileWithDefinitions inputFileName defns
    case result of
      Left out -> do
        let outputFileName = (stripExtension inputFileName) ++ ".dmp"

        outputHandle <- openFile outputFileName WriteMode
        hPut outputHandle out
        hClose outputHandle
        return ()
      Right (lineNum, err) ->
                putStrLn $ "Error in file: " ++ inputFileName ++ ": Line " ++ show lineNum ++ ": " ++ err

parseADefinition::Definitions->String->Either [Word8] String--input of the form "[0x12]texttoo[0x34][OtherDefns][0x56]"
parseADefinition otherDefn text = case (parse otherDefn (text++"[X]"))  of
    Left res -> Left $ (init . unpack) res
    Right (lineNum, err) -> Right err

putStrLnIf bool arg = if bool then putStrLn arg else return ()

parseDefinitions::String -> Bool -> IO (Definitions)
parseDefinitions fname verbose = (try (readFile fname)::IO (Either IOException String)) >>= \result -> case result of
    Left exception -> putStrLnIf verbose "Error reading definitions file.\n" >> return empty
    Right rawInput -> do
        putStrLnIf verbose "Parsing definitions file."
        let definitionLines = lines rawInput
        newDefs <- foldM (addDefinition) (empty) definitionLines
        putStrLnIf verbose "Done parsing definitions file.\n"
        return newDefs
        where
            addDefinition::Definitions -> String -> IO(Definitions)
            addDefinition defs [] = return defs
            addDefinition defs aLine = do
                let lineWords = words aLine
                let leftSide = head lineWords
                if length lineWords < 3
                then putStrLnIf verbose ("Error in definition " ++ leftSide ++ ": No definition given.") >> return defs
                else if (head . tail) lineWords /= "="
                then putStrLnIf verbose ("Error in definition " ++ leftSide ++ ": \'=\' not used to give definition.") >> return defs
                else if head leftSide == '[' && last leftSide == ']' 
                then case parseADefinition defs . join . tail . tail $ lineWords of -- Ignore the head and the '='
                    Left aDef -> return $ insert (init . tail {- Ignore the [] -} $ leftSide ) (aDef) defs
                    Right err -> putStrLnIf verbose ("Error in definition " ++ leftSide ++ ": " ++ err) >> return defs
                else putStrLnIf verbose ("Error in definition " ++ leftSide ++ ": Not enclosed by []") >> return defs
                    
                