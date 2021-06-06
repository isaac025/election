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

output :: String -> String -> String -> IO ()
output numOfBallots winnerName winnerVotes = do
  let file = "/home/isaac/Projects/personal/election/res/output.txt"
  writeFile file string
  contents <- readFile file
  putStrLn contents
    where string = "•Number of ballots received: " ++ numOfBallots ++ "\n•Number of blank ballots (no candidates were selected):\n" ++
                   "•Number of invalid ballots:\n•Round results:\n\t◦Number of 1’s that the candidate received at the moment of elimination\n"++
                   "\t◦Round in which the candidate was eliminated.\n\t◦Use the following format: “Round <num>: <Candidate name> was eliminated with <num> #1’s”\n" ++
                   "•Winner: " ++ winnerName ++ " wins with " ++ winnerVotes ++ " #1’s."

