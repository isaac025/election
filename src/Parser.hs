module Parser
  ( getCSVContents
  , removePunc
  ) where

import           System.IO ()

getCSVContents :: FilePath -> IO String
getCSVContents file = do readFile file

removePunc :: String -> String
removePunc contents = [x | x <- contents, x `notElem` ",:"]

