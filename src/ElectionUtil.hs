module ElectionUtil
  ( createCandidate
  , createCandidates
  ) where

import           DataStructures (Candidate (..))

createCandidate :: (String,Int) -> Candidate
createCandidate tuple = Candidate (fst tuple) (snd tuple)

createCandidates :: [(String, Int)] -> [Candidate]
createCandidates list = map createCandidate list

output :: String -> IO ()
output results = do
  let file = "output.txt"
  writeFile file results
  putStrLn file

