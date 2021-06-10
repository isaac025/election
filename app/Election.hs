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
    output (totalBallots ballots) (show $ eliminate candidates) (show $ numberOfVotesOf (head candidates) 1)

organizeCandidates :: String -> [(String,Int)]
organizeCandidates candidates = toTuple $ toList candidates

organizeBallots :: String -> [(Int, [(Int,Int)])]
organizeBallots ballots = convert $ makeBallotsIntegers $ map (ballotParser (==':')) (toList ballots)

totalBallots :: [Ballot] -> String
totalBallots ballots = show $ ballotID $ last ballots

numberOfVotesOf :: Candidate -> Int -> Int
numberOfVotesOf candidate rank = length $ filter (==rank) (votes candidate)

isWinner :: Candidate -> Int -> Bool
isWinner candidate total = (div total (numberOfVotesOf candidate 1)) < 2

eliminate :: [Candidate] -> [Candidate]
eliminate xs = [x | x <- xs, x /= lowest]
    where lowest ls = length $ L.minimumBy (compare `F.on` length) (map votes ls)
