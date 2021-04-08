#!/bin/bash

###################
### CANDIDATES ####
###################

# Get the number of candidates
echo -n "Enter the number of candidates: "
read candidates

# Check first if the files are already created
# and delete them to use new ones.
CAND_FILE="../res/candidates.csv"
BALLOTS_FILE="../res/ballots.csv"
if [[ -f "${CAND_FILE}" ]] ;
then
    rm -f "${CAND_FILE}"
else
    touch "${CAND_FILE}"
fi

if [[ -f "${BALLOTS_FILE}" ]] ;
then
    rm -f "${BALLOTS_FILE}"
else
    touch "${BALLOTS_FILE}"
fi

# Make sure it we get a number
while [[ ! $candidates =~ ^[0-9]+$ ]] ;
do
    echo -n "Please, enter a number: "
    read candidates
done

# Create array
CANDIDATES=()
for (( i=1 ; i <= $candidates ; i++ ))
do
    echo -n "Name of candidate $i: "
    read cand
    CANDIDATES["$i"]="$cand"
    echo "${cand}, ${i}" >> "${CAND_FILE}"
done

#################
### Ballots ####
################

echo -n "Enter the number of ballots: "
read ballots

while [[ ! $ballots =~ ^[0-9]+$ ]] ;
do
    echo -n "Please, enter a number: "
    read ballots
done

BALLOTS=()
for (( i=1 ; i <= $ballots ; i++ ))
do
    echo -n "$i," >> "${BALLOTS_FILE}"
    id=1
    for cnd in "${CANDIDATES[@]}"
    do
        echo -n "For Ballot $i, rank for $cnd: "
        read rank
        if [[ "$rank" -lt 1 || "$rank" -gt "$candidates" ]];
        then
            notInRange=true
            while $notInRange
            do
                echo -n "Rank must be between 1 or $candidates: "
                read rank
                if [[ !("$rank" -lt 1 || "$rank" -gt "$candidates") ]];
                then
                    notInRange=false
                fi
            done
        fi
        if  [[ "$id" -eq "$candidates" ]];
        then
            echo -n "$id:$rank" >> "${BALLOTS_FILE}"
        else
            echo -n "$id:$rank," >> "${BALLOTS_FILE}"
        fi
        id=$((id+1))
    done
    echo "" >> "${BALLOTS_FILE}"
done
