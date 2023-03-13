#!/bin/bash

# Initializing the color codes.
GREY='\033[0;100m'
GREEN='\033[0;42m'
YELLOW='\033[0;43m'
NOCOLOR='\033[0m'
word=`sort -R words.txt | awk 'NR == 1 {print $1}'`
echo $word
# echo -e "I ${GREY}love ${YELLOW}Linux ${GREEN}TEST ${NOCOLOR}"
# printf "I ${GREY}love ${YELLOW}Linux ${GREEN}TEST ${NOCOLOR}"

guess_counter=0
while [ $guess_counter -ne 6 ]; do
    guess_counter=$(( $guess_counter + 1 ))
    echo -e "\n"; echo -n "Enter your guess ($guess_counter / 6): "
    read guess
    if [ "${#guess}" -eq 5 ]; then
        
        echo -e "\n"; echo $guess
    else 
        guess_counter=$(( $guess_counter - 1 ))
        echo -e "\n"; echo "Invalid input, try again..."
    fi
done

# test=10
# if [[ $test =~ [0-19] ]]; then
#     echo "Ok"
# else 
#     echo "No"
# fi