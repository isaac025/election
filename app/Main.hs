{-# LANGUAGE OverloadedStrings #-}
module Main where

import           Election (runElection)

candidatesFile :: FilePath
candidatesFile = "/home/isaac/Projects/personal/election/res/candidates.csv"

ballotsFile :: FilePath
ballotsFile = "/home/isaac/Projects/personal/election/res/ballots.csv"

main :: IO ()
main = runElection candidatesFile ballotsFile
