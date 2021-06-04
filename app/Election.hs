{-# LANGUAGE OverloadedStrings #-}

module Election ( runElection
                 ) where

import           DataStructures (Ballot (..), Candidate (..))
import           ElectionUtil   (createBallots, createCandidates, getIDVotes,
                                 output)
import           Parser         (ballotParser, convert, getCSVContents,
                                 makeBallotsIntegers, toList, toTuple)

runElection :: FilePath -> FilePath -> IO ()
runElection candidateFile ballotsFile = do
    candidatesContents  <- getCSVContents candidateFile
    ballotsContents     <- getCSVContents ballotsFile
    let ballots = createBallots $ organizeBallots ballotsContents -- set the string from the file to list of strings
    let tuplesOfCands = organizeCandidates candidatesContents
    let candidates = createCandidates $ tuplesOfCands (getIDVotes (fst tuplesOfCands) (map ballotsVotes ballots))
    output $ show candidates

organizeCandidates :: String -> [(String,Int)]
organizeCandidates candidates = toTuple $ toList candidates

organizeBallots :: String -> [(Int, [(Int,Int)])]
organizeBallots ballots = convert $ makeBallotsIntegers $ map (ballotParser (==':')) (toList ballots)

