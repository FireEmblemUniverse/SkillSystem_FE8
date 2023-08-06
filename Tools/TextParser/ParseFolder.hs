-- Rescursively parse all files within a directory. Notes which files have errors. 

import FEParser (parseDefinitions, proccessFileWithDefinitions, Definitions)
import System.Directory
import System.IO (hFlush, stdout)
--import Data.Set 

getExtension::String->String
getExtension str = if elem '.' str 
    then ('.':) . reverse . takeWhile (/= '.') . reverse $ str
    else ""

--Using an old ghc library version, so make my own list directory
listDirectory dir = fmap (filter (\x->x/="."&&x/="..")) (getDirectoryContents dir)

parseFolder::Definitions->String->IO () --TODO: make it not revisit already visited directories (in case you have a cycle in folder structure.)
parseFolder definitions dir = do
        toProcess <- Main.listDirectory dir
        mapM_ appropriateProcess toProcess
        putStrLn $ "Done with folder \"" ++ dir ++ "\"\n"
    
    where 
      appropriateProcess loc = let fullPath = dir++'/':loc in
          doesFileExist fullPath >>= \x->(if x
            then if getExtension loc == ".txt" && fullPath /= "./ParseDefinitions.txt"
                then putStrLn ("Parsing \"" ++ fullPath ++ "\"") >> proccessFileWithDefinitions fullPath definitions
                else return ()
            else putStrLn ("\nEntering folder \"" ++ fullPath ++ "\"") >> parseFolder definitions (fullPath))

main::IO()
main = do
    --dir <- getCurrentDirectory
    definitions <- parseDefinitions "ParseDefinitions.txt" True
    parseFolder definitions "."
    
    putStr "Complete. Press enter to continue."
    hFlush stdout
    getLine
    
    return ()
    
