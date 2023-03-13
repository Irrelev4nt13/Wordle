#!/bin/bash

# Initializing the color codes.
GREY='\033[2;37m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
NOCOLOR='\033[0m'
# echo -e "I ${GREY}love ${YELLOW}Linux ${GREEN}TEST ${NOCOLOR}"

# A function that prints the rules of the game
promt () {
    echo "You will play the game of Wordle."
    echo "You will have 6 tries to guess a five-letter word, chosen randomly from a file with all five-letter words."
    echo "If a letter from the word that you will give exists in the chosen word but it is not in the correct order it will be marked with the yellow color. " 
    echo "If it is placed correctly it will be marked with green color. Other color means that the letter does not exists in the word."

}
words=("What")

# A function that counts the words of the file and choosing a "random" word from it.
choosing_word () {
    # The number of words are the same as the lines, because every line has only one word.
    # Count the total words and assign them into a variable.
    total_words=`wc -w < words.txt` 
    
    # Choose a random word in range [1, number of words].
    # word_number=$(( $RANDOM % $total_words + 1 ))
    word_number=1
    echo
    echo "The number is:" $word_number
    
    # Find the line of the file which match the word.
    word=`head -n $word_number words.txt | tail -n +$word_number`
    echo $word
    echo
}

check_char() {
    echo " "
}

check_word () {
    echo " "
}

# 
read_word () {
    read user_word
    letters=${#user_word}
    # if [ $letters -ne 5 ]
    # then
    #     echo "Nope"
    # else 
    #     echo "Ok"
    # fi
}


# Call the function that explaines the rules of the game.
# promt

choosing_word
read_word
echo
echo ${words[@]}
echo