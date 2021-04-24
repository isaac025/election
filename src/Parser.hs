module Parser
  ( getCSVContents
  , removePunc
  , toList
  ) where

import           System.IO ()

getCSVContents :: FilePath -> IO String
getCSVContents file = do readFile file

removePunc :: String -> String
removePunc = map (\x -> if x==',' then ' ' else x)

toList :: String -> [String]
toList contents = words $ removePunc contents
