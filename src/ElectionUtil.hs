module ElectionUtil
  ( toTuple
  ) where

toTuple :: [String] -> [(String, Int)]
toTuple = makeTuple
  where
    makeTuple :: [String] -> [(String, Int)]
    makeTuple (x1:x2:xs) = (x1, read x2 :: Int):makeTuple xs
    makeTuple _          = []
