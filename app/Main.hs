module Main where


import           DataStructures ()
import           ElectionUtil   ()
import           Parser         (getCSVContents, removePunc)


candidatesFile :: FilePath
candidatesFile = "/home/isaac/Projects/Stream/election/res/candidates.csv"

ballotsFile :: FilePath
ballotsFile = "/home/isaac/Projects/Stream/election/res/ballots.csv"

main :: IO ()
main = do
  candidatesFileContents <- getCSVContents candidatesFile -- Get candidates from file
  let candidates = words $ removePunc candidatesFileContents -- set the string from the file to list of strings
  ballotsFileContents <- getCSVContents ballotsFile -- Get candidates from file
  let ballots = words $ removePunc ballotsFileContents -- set the string from the file to list of strings
  let candidate = Candidate [1,2,3,4] (head candidates) (candidates!!1)
  candidate

{-
create a data for Candidate
data Candidate = Id [Vote]
where Id = Int
      Vote = Int

best data structure is:
for candidates
  HashSet id = key, candidate = value

for ballots
  List of doubly linked list
  new list for each ballot

PseudoCode
  parse files
  organize file contents in data structures
  determine if there is a winner by counting votes
  eg.
    first count 1s
    for list in ListofBallots
      for id, vote in zip(list)
          if vote == 1
              HashSet(id).counterOf1(+1)

-}
