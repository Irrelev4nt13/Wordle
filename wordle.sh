#!/bin/bash

# Initializing the color codes.
GREY='\033[0;100m'
GREEN='\033[0;42m'
YELLOW='\033[0;43m'
BLUE='\033[0;104m'
RED='\033[0;41m'
NOCOLOR='\033[0m'

# Codes for emojis.
happy_face='\xF0\x9F\x98\x81'
unhappy_face='\xF0\x9F\xA4\xA8'

# Get the "random" word from the .txt file.
word=`sort -R words.txt | awk 'NR == 1 {print $1}'`
# If you uncomment the command below it will show the choosen word.
# echo $word

# Initializing the counter which holds the total number of tries.
guess_counter=0

# In the game of wordle you can guess up to six times.
while [ $guess_counter -ne 6 ]; do
    guess_counter=$(( $guess_counter + 1 ))
    # Promt the user for the current number of guess. 
    echo -e "\n"; echo -n "Enter your guess ($guess_counter / 6): "
    read guess; guess=`echo "$guess" | tr '[A-Z]' '[a-z]'` # Convert any uppercase characters to lowercase.
    # Check that the input has only letters.
    if [[ ${#guess} -eq 5 && $guess =~ ^[a-z]+$ ]]; then
        # Win case print the word with green color, a win message and exit.
        if [[ "$guess" == "$word" ]]; then 
            echo -e "\n"; for i in {0..4}; do echo -e -n "${GREEN} ${word:$i:1} ${NOCOLOR}"; done
            echo -e "\n\n\n${BLUE}You won${NOCOLOR} $happy_face \n\n"; exit 0;
        # Check each character of the input if it matches any of the characters of choosen word.
        else
            echo -e "\n"
            for i in {0..4}; do
                index=`echo "$word" | awk -v myvar="${guess:$i:1}" '{print match($0, myvar)}'`
                # If it does and the positions of the two characters are the same then print it in green color.
                if [[ $(( $index - 1 )) == $i ]]; then
                    echo -e -n "${GREEN} ${guess:$i:1} ${NOCOLOR}"
                # If it exists but it's not in the same position print it with yellow color.
                elif [[ $(( $index - 1 )) == -1 ]]; then
                    echo -e -n "${GREY} ${guess:$i:1} ${NOCOLOR}"
                # Otherwise print it with grey color.
                else
                    echo -e -n "${YELLOW} ${guess:$i:1} ${NOCOLOR}"
                fi
            done
            echo
        fi     
    # If the input is not valid promt the user to try again.
    else 
        guess_counter=$(( $guess_counter - 1 ))
        echo -e "\n"; echo "Invalid input, try again..."
    fi
done
# Print lose message only if the number of tries are more than six.
if [[ $guess_counter -eq 6 ]]; then echo -e "\n\n${RED}You lost${NOCOLOR} $unhappy_face\n\n"; fi