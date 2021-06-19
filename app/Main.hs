{-# LANGUAGE OverloadedStrings #-}
module Main where

import           Election (runElection)

candidatesFile :: FilePath
candidatesFile = "/home/isaac/Projects/training/election/res/candidates.csv"

ballotsFile :: FilePath
ballotsFile = "/home/isaac/Projects/training/election/res/ballots.csv"

main :: IO ()
main = runElection candidatesFile ballotsFile
