module DataStructures
            ( Vote
            , BallotID
            , ID
            , Name
            , Candidate
            , Ballot
            ) where

newtype Vote        = MakeNatural Int deriving (Show, Eq)
newtype BallotID    = MakeNatural Int deriving (Show, Eq)
newtype ID          = MakeNatural Int deriving (Show, Eq)
newtype Name        =  String

toNatural :: Int -> Natural
toNatural x
    | x < 0     = error "IDs and/or Votes must be positive"
    | otherwise = MakeNatural x

fromNatural :: Natural -> Int
fromNatural (MakeNatural i) = i

instance Num Natural where
  fromInteger   = toNatural
  x + y         = toNatural (fromNatural x + fromNatural y)
  x - y         = let r = fromNatural x - fromNatural y in
                    if r < 0 then error "Unnatural substraction"
                    else toNatural r
  x * y         = toNatural (fromNatural x * fromNatural y)

data Candidate = Candidate
    { votes :: [Vote]
    , id    :: ID
    , name  :: Name
    } deriving (Show, Eq)

data Ballot = Ballot
    { ballotID :: BallotID
    , votes    :: [Vote]
    , id       :: [ID]
    } deriving (Show, Eq)


