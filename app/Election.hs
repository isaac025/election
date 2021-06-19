{-# LANGUAGE OverloadedStrings #-}

module Election ( runElection
                 ) where

import qualified Data.Function  as F
import qualified Data.List      as L
import           DataStructures (Ballot (..), Candidate (..))
import           ElectionUtil   (createBallots, createCandidates, getIDVotes)
import           Parser         (ballotParser, convert, getCSVContents,
                                 makeBallotsIntegers, output, toList, toTuple)

runElection :: FilePath -> FilePath -> IO ()
runElection candidatesFile ballotsFile= do
    ballotsContents <- getCSVContents ballotsFile
    candidatesContents <- getCSVContents candidatesFile
    let ballots = createBallots $ organizeBallots ballotsContents
    let ballotVotes = map ranks ballots
    let candidates = createCandidates (organizeCandidates candidatesContents) ballotVotes
    output (show $ (winner candidates (totalBallots ballots))) (show $ numberOfVotesOf (head candidates) 1)

organizeCandidates :: String -> [(String,Int)]
organizeCandidates candidates = toTuple $ toList candidates

organizeBallots :: String -> [(Int, [(Int,Int)])]
organizeBallots ballots = convert $ makeBallotsIntegers $ map (ballotParser (==':')) (toList ballots)

totalBallots :: [Ballot] -> Int
totalBallots ballots = ballotID $ last ballots

numberOfVotesOf :: Candidate -> Int -> Int
numberOfVotesOf candidate rank = length $ filter (==rank) (votes candidate)

isWinner :: Candidate -> Int -> Bool
isWinner c total = ((numberOfVotesOf c 1) `div` total) < 2

winner :: [Candidate] -> Int -> Candidate
winner (x:xs) total = case (isWinner x total) of
                  True  -> x
                  False -> winner (eliminate lowest xs) total
                    where lowest = x

eliminated :: Candidate -> [Candidate] -> Candidate
eliminated c (x:xs)
  | (numberOfVotesOf c 1) > (numberOfVotesOf x 1) = eliminated x xs
  | (numberOfVotesOf c 1) < (numberOfVotesOf x 1) = eliminated c xs
  | (numberOfVotesOf c 1) == (numberOfVotesOf x 1) = eliminated (lowest x c 2) xs
  where lowest x c n
          | (numberOfVotesOf c n) < (numberOfVotesOf x n) = c
          | (numberOfVotesOf c n) > (numberOfVotesOf x n) = x
          | otherwise = lowest x c (n+1)
eliminated x _ = x

eliminate :: Candidate -> [Candidate] -> [Candidate]
eliminate c xs = [x | x <- xs , x /= (eliminated c xs)]

