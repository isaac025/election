module ElectionUtil
  ( output
  , createCandidates
  , createBallots
  , getIDVotes
  ) where

import           DataStructures (Ballot (..), Candidate (..))

createCandidate :: (String,Int) -> [Int] -> Candidate
createCandidate tuple votes = Candidate (fst tuple) (snd tuple) votes

createCandidates :: [(String, Int)] -> [Int] -> [Candidate]
createCandidates list votes = map (createCandidate list) votes

getIDVotes :: Eq a1 => a1 -> [[(a1,a2)]] -> [a2]
getIDVotes id list = asList $ map (takeWhile  ((==id) . fst)) list
    where asList (x:xs) = head (map snd x):asList xs
          asList _      = []

createBallot :: (Int, [(Int, Int)]) -> Ballot
createBallot tuple = Ballot (fst tuple) (snd tuple)

createBallots :: [(Int, [(Int, Int)])] -> [Ballot]
createBallots list = map createBallot list

output :: String -> IO ()
output results = do
  let file = "/home/isaac/Projects/personal/election/res/output.txt"
  writeFile file results
  contents <- readFile file
  putStrLn contents


