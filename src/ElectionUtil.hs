module ElectionUtil
  ( toTuple
  , ballotParser
  ) where

toTuple :: [String] -> [(String, Int)]
toTuple = makeTuple
  where
    makeTuple :: [String] -> [(String, Int)]
    makeTuple (x1:x2:xs) = (x1, (read x2::Int)):makeTuple xs
    makeTuple _          = []

ballotParser :: (Char -> Bool) -> String -> [String]
ballotParser p s = case dropWhile p s of
                "" -> []
                s' -> w : ballotParser p s''
                      where (w, s'') = break p s'

--createCandidate :: [String] -> Candidate
