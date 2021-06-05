module ElectionUtil
  ( output
  , createCandidates
  , createBallots
  , getIDVotes
  ) where

import           DataStructures (Ballot (..), Candidate (..))

getIDVotes  :: Eq a1 => a1 -> [[(a1, a2)]] -> [a2]
getIDVotes id xs = [snd y | x <- xs, y <- x, (fst y) == id]


createCandidate :: (String, Int) -> [[(Int, Int)]] -> Candidate
createCandidate tuple votes = Candidate (fst tuple) (snd tuple) (getIDVotes (snd tuple) votes)

createCandidates :: [(String, Int)] -> [[(Int, Int)]] -> [Candidate]
createCandidates list votes = map (\x -> createCandidate x votes) list

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


