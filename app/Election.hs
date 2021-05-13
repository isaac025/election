{-# LANGUAGE OverloadedStrings #-}
module Election ( runElection
                 ) where

import           DataStructures (Candidate (..))
import           ElectionUtil   (ballotParser, toTuple)
import           Parser         (getCSVContents, toList)

runElection :: FilePath -> FilePath -> IO ()
runElection candidateFile ballotsFile = do
    candidatesContents  <- getCSVContents candidateFile
    ballotsContents     <- getCSVContents ballotsFile
    let candidates = organizeCandidates candidatesContents -- set the string from the file to list of strings
    let ballots = organizeBallots ballotsContents -- set the string from the file to list of strings
    let cand1 = Candidate (fst $ head candidates) (snd $ head candidates)
    print ballots
organizeCandidates :: String -> [(String,Int)]
organizeCandidates candidates = toTuple $ toList candidates

organizeBallots :: String -> [[String]]
organizeBallots ballots = map (ballotParser (==':')) (toList ballots)

--countVoteNumber :: Int -> Candidate -> Int
--countVoteNumber vote candidate = length (filter (==vote) votes candidate)
