-- Utilities for parsing commandline options
module FlagUtilities where

isFlag::String->Bool
isFlag [] = False
isFlag x = (=='-') . head $ x

isOption::String->Bool
isOption = (=="--") . take 2

getFlags::[String]->[String]
getFlags = filter isFlag

getOptions::[String]->[String]
getOptions = filter isOption

getParams::[String]->[String]
getParams = filter (not . isFlag)

getUnflaggedParams::[String]->[String]
getUnflaggedParams [] = []
getUnflaggedParams argv = (map snd . filter (\(a,b)->(not (isFlag a) || isOption a) && not (isFlag b)) $ ([], head argv):zip argv (tail argv))

getParamAfterFlag::String->[String]->Maybe String
getParamAfterFlag flag [] = Nothing
getParamAfterFlag flag (arg:args) = 
    if flag == arg
    then case args of 
        [] -> Nothing
        (x:xs) -> Just x
    else getParamAfterFlag flag args

hasFlag::[String]->String->Bool
hasFlag = flip elem
