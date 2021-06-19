# Alternate Voting Method with Haskell

## To get started
### Install Haskell
- [MacOSX](https://www.haskell.org/platform/#osx)
- [Linux](https://www.haskell.org/platform/#linux)
- [Windows](https://www.haskell.org/platform/#windows)

### Run Script
``` shell
$ ./app/script.sh
```
**I do not know how to run a script in Windows sorry! I understand that [Powershell](https://docs.microsoft.com/en-us/powershell/scripting/install/installing-powershell-core-on-windows?view=powershell-7.1) can run it.**
Then follow what it asks you 

## How it works
Two CSV files are created:
One with the candidates
One with the ballots and votes

1. The program parses the csv files.
2. Then creates the "data" of Candidates and Ballots:
     Eg. Candidates = name :: String, id :: Int, Ballots = ballotID :: Int, votes :: [(Int,Int)]
3. After creating the data the election runs to determine the winner.

Finally an output file called output.txt is created with the election results.

*NOTE* There are special cases which I recommend checking on the pdf.

If you wish to build your own read [this pdf](./p1_c4020_i4035_192.pdf) provided
in the repo. You can and should implement it in any language!


