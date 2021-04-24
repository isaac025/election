module ElectionUtil
  ( toTuple
  ) where

toTuple :: [String] -> [(String, String)]
toTuple = makeTuple
  where
    makeTuple :: [String] -> [(String, String)]
    makeTuple (x1:x2:xs) = (x1, x2):makeTuple xs
    makeTuple _          = []
