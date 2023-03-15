#!/bin/bash

# Initializing the color codes.
GREY='\033[0;100m'
GREEN='\033[0;42m'
YELLOW='\033[0;43m'
BLUE='\033[0;104m'
RED='\033[0;41m'
NOCOLOR='\033[0m'
happy_face='\xF0\x9F\x98\x81'
unhappy_face='\xF0\x9F\xA4\xA8'
word=`sort -R words.txt | awk 'NR == 1 {print $1}'`
echo $word

guess_counter=0
while [ $guess_counter -ne 6 ]; do
    guess_counter=$(( $guess_counter + 1 ))
    echo -e "\n"; echo -n "Enter your guess ($guess_counter / 6): "
    read guess; guess=`echo "$guess" | tr '[A-Z]' '[a-z]'`
    if [[ ${#guess} -eq 5 && $guess =~ ^[A-Za-z]+$ ]]; then
        if [[ "$guess" == "$word" ]]; then 
            echo -e "\n"; for i in {0..4}; do echo -e -n "${GREEN} ${word:$i:1} ${NOCOLOR}"; done
            echo -e "\n\n\n${BLUE}You won${NOCOLOR} $happy_face \n\n"; exit;
        else
            echo -e "\n"
            for i in {0..4}; do
                index=`echo "$word" | awk -v myvar="${guess:$i:1}" '{print match($0, myvar)}'`
                if [[ $(( $index - 1 )) == $i ]]; then
                    echo -e -n "${GREEN} ${guess:$i:1} ${NOCOLOR}"
                elif [[ $(( $index - 1 )) == -1 ]]; then
                    echo -e -n "${GREY} ${guess:$i:1} ${NOCOLOR}"
                else
                    echo -e -n "${YELLOW} ${guess:$i:1} ${NOCOLOR}"
                fi
            done
            echo
        fi     
    else 
        guess_counter=$(( $guess_counter - 1 ))
        echo -e "\n"; echo "Invalid input, try again..."
    fi
done
if [[ $guess_counter -eq 6 ]]; then echo -e "\n\n${RED}You lost${NOCOLOR} $unhappy_face\n\n"; fi