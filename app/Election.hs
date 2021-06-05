{-# LANGUAGE OverloadedStrings #-}

module Election ( runElection
                , organizeBallots
                 ) where

import           DataStructures (Ballot (..), Candidate (..))
import           ElectionUtil   (createBallots, createCandidates, getIDVotes,
                                 output)
import           Parser         (ballotParser, convert, getCSVContents,
                                 makeBallotsIntegers, toList, toTuple)

runElection :: FilePath -> FilePath -> IO ()
runElection candidatesFile ballotsFile= do
    ballotsContents <- getCSVContents ballotsFile
    candidatesContents <- getCSVContents candidatesFile
    let ballots = createBallots $ organizeBallots ballotsContents
    let ballotVotes = map ballotsVotes ballots
    let candidates = createCandidates (organizeCandidates candidatesContents) ballotVotes
    output $ show candidates

organizeCandidates :: String -> [(String,Int)]
organizeCandidates candidates = toTuple $ toList candidates

organizeBallots :: String -> [(Int, [(Int,Int)])]
organizeBallots ballots = convert $ makeBallotsIntegers $ map (ballotParser (==':')) (toList ballots)


