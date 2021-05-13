module Parser
  ( getCSVContents
  , removeCommas
  , toList
  ) where

import           System.IO ()

getCSVContents :: FilePath -> IO String
getCSVContents file = do readFile file

removeCommas :: String -> String
removeCommas = map (\x -> if x==',' then ' ' else x)

toList :: String -> [String]
toList contents = words $ removeCommas contents
