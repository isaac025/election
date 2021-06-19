module Parser
  ( getCSVContents
  , removeCommas
  , toList
  , ballotParser
  , toTuple
  , convert
  , makeBallotsIntegers
  , output
  ) where

import           System.IO ()

-- read CSV like file
-- read from FilePath file
getCSVContents :: FilePath -> IO String
getCSVContents file = do readFile file

-- remove commas from the CSV file
removeCommas :: String -> String
removeCommas = map (\x -> if x==',' then ' ' else x)

-- set the csv contents (comma separeted to list) as a list
toList :: String -> [String]
toList contents = words $ removeCommas contents

-- take a list like := ["Name", "1", "Name2", "2",...]
-- and transform it to [("Name",1),("Name2",2),..]
toTuple :: [String] -> [(String, Int)]
toTuple = makeTuple
  where
    makeTuple :: [String] -> [(String, Int)]
    makeTuple (x1:x2:xs) = (x1, (read x2::Int)):makeTuple xs
    makeTuple _          = []

-- Converts a list of list onto a list of tuples as per
-- ballots needs that is: [(Int1, [(Int2, Int3)..])..]
-- where: Int1 = ballots ID
--        Int2 = Candidate ID
--        Int3 = Vote to the candidate
convert :: Foldable t => t [a] -> [(a, [(a, a)])]
convert = snd . foldr cons nil
        where nil = ([],[])
              cons [x,y] (z,w) = ((x,y):z,w)
              cons [x] (y,z)   = ([], (x,y):z)

-- Separetes a string to a list of strings given a condition
-- Example: ballotParser (==',') "comma,separeted,string" -> ["comma","separated","string"]
ballotParser :: (Char -> Bool) -> String -> [String]
ballotParser p s = case dropWhile p s of
                "" -> []
                s' -> w : ballotParser p s''
                      where (w, s'') = break p s'

makeBallotsIntegers :: [[String]] -> [[Int]]
makeBallotsIntegers xs = map (\x -> map (\y -> read y :: Int) x) xs

-- Desired output from the problem statement
output :: String -> String -> IO ()
output winnerName winnerVotes = do
  let file = "/home/isaac/Projects/training/election/res/output.txt"
  writeFile file string
  contents <- readFile file
  putStrLn contents
    where string = "Winner: " ++ winnerName ++ "Votes: "

finalOutput :: String
finalOutput = "Number of ballots: " ++ "Number of blank ballots: " ++ "Number of invalid ballots: "
