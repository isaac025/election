module Parser
  ( getCSVContents
  , removeCommas
  , toList
  , ballotParser
  , toTuple
  , convert
  , makeBallotsIntegers
  ) where

import           System.IO ()

getCSVContents :: FilePath -> IO String
getCSVContents file = do readFile file

removeCommas :: String -> String
removeCommas = map (\x -> if x==',' then ' ' else x)

toList :: String -> [String]
toList contents = words $ removeCommas contents

toTuple :: [String] -> [(String, Int)]
toTuple = makeTuple
  where
    makeTuple :: [String] -> [(String, Int)]
    makeTuple (x1:x2:xs) = (x1, (read x2::Int)):makeTuple xs
    makeTuple _          = []

convert :: Foldable t => t [a] -> [(a, [(a, a)])]
convert = snd . foldr cons nil
        where nil = ([],[])
              cons [x,y] (z,w) = ((x,y):z,w)
              cons [x] (y,z)   = ([], (x,y):z)

ballotParser :: (Char -> Bool) -> String -> [String]
ballotParser p s = case dropWhile p s of
                "" -> []
                s' -> w : ballotParser p s''
                      where (w, s'') = break p s'

makeBallotsIntegers :: [[String]] -> [[Int]]
makeBallotsIntegers xs = map (\x -> map (\y -> read y :: Int) x) xs


