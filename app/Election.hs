{-# LANGUAGE OverloadedStrings #-}

module Election ( runElection
                 ) where

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
    output (show $ ballotID $ last ballots) (name $ head candidates) (show (getOnes $ head candidates))

organizeCandidates :: String -> [(String,Int)]
organizeCandidates candidates = toTuple $ toList candidates

organizeBallots :: String -> [(Int, [(Int,Int)])]
organizeBallots ballots = convert $ makeBallotsIntegers $ map (ballotParser (==':')) (toList ballots)

getOnes :: Candidate -> Int
getOnes candidate = length $ filter (==1) (votes candidate)
