-- Module for data
module DataStructures
            ( Candidate (..)
            , Ballot (..)
            ) where

-- Data for Candidate
data Candidate = Candidate
    { name  :: String
    , id    :: Int
    , votes :: [Int]
    } deriving (Show, Eq)

-- Data for Ballot
data Ballot = Ballot
    { ballotID :: Int
    , ranks    :: [(Int,Int)]
    } deriving (Show, Eq)


