{-# LANGUAGE OverloadedStrings #-}
module Election ( runElection
                 ) where

import           DataStructures (Candidate (..))
import           ElectionUtil   (ballotParser, convert, createCandidates,
                                 makeBallotsIntegers, toTuple)
import           Parser         (getCSVContents, toList)

runElection :: FilePath -> FilePath -> IO ()
runElection candidateFile ballotsFile = do
    candidatesContents  <- getCSVContents candidateFile
    ballotsContents     <- getCSVContents ballotsFile
    let ballots = organizeBallots ballotsContents -- set the string from the file to list of strings
    let candidates = createCandidates $ organizeCandidates candidatesContents -- set the string from the file to list of strings
    print ballots

organizeCandidates :: String -> [(String,Int)]
organizeCandidates candidates = toTuple $ toList candidates

organizeBallots :: String -> [(Int, [(Int,Int)])]
organizeBallots ballots = convert $ makeBallotsIntegers $ map (ballotParser (==':')) (toList ballots)



