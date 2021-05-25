module ElectionUtil
  ( toTuple
  , ballotParser
  , createCandidates
  , convert
  , makeBallotsIntegers
  ) where

import           DataStructures (Candidate (..))
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

createCandidate :: (String,Int) -> Candidate
createCandidate tuple = Candidate (fst tuple) (snd tuple)

createCandidates :: [(String, Int)] -> [Candidate]
createCandidates list = map createCandidate list
