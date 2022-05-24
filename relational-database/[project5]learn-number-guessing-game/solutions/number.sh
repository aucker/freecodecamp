#!/bin/bash
PSQL="psql --username=freecodecamp --dbname=number_guess -t --no-align -c"

# echo -e "\n~~~~~ Number Guessing Game ~~~~~\n"
# NUMBER=$(shuf -i 1-1000 -n 1)
NUMBER=$(( $RANDOM % 1000 + 1 ))
# this number should be comment 
# echo $NUMBER
echo -e "Enter your username:"
# read -r username
read USERNAME
# echo $USERNAME

  # this is a valid username, do something 
  # first check the existence in the database
  CHECK_RESULT=$($PSQL "SELECT user_name FROM users WHERE user_name='$USERNAME'")
  if [[ -z $CHECK_RESULT ]]
  # this user is a new one
  then 
  # WIP, insert into database after the game
  # now just show a welcome
    echo -e "\nWelcome, $USERNAME! It looks like this is your first time here."


    # INSERT_RESULT=$($PSQL "INSERT INTO users(user_name) VALUES")
  else
  # this user played before
    GUESS_TIME=$($PSQL "SELECT guess_time FROM users WHERE user_name='$USERNAME'")
    SCORE=$($PSQL "SELECT score FROM users WHERE user_name='$USERNAME'")
    echo -e "\nWelcome back, $USERNAME! You have played $GUESS_TIME games, and your best game took $SCORE guesses."
  fi

echo -e "\nGuess the secret number between 1 and 1000:"
read GUESS
NUMBER_GUESS=0
CHECK_INT() {
  # while [[ ! "$GUESS" =~ ^[0-9]+$ ]] 
  # # this is not integer, need to guess again
  # do
  #   echo -e "\nThat is not an integer, guess again:"
  #   read GUESS
  # done
  if [[ ! "$GUESS" =~ ^[0-9]+$ ]]
  then 
    echo -e "\nThat is not an integer, guess again:"
    read GUESS

  fi
}
CHECK_INT
while [ "$GUESS" -ne "$NUMBER" ]
do 
  if [ "$GUESS" -gt "$NUMBER" ]
  then 
    echo -e "\nIt's higher than that, guess again:"
    read GUESS
    NUMBER_GUESS=$((NUMBER_GUESS+1))
  else [ "$GUESS" -lt "$NUMBER" ]
    echo -e "\nIt's lower than that, guess again:" 
    read GUESS
    NUMBER_GUESS=$((NUMBER_GUESS+1))
  fi
done
NUMBER_GUESS=$((NUMBER_GUESS+1))
echo -e "\nYou guessed it in $NUMBER_GUESS tries. The secret number was $NUMBER. Nice job!"
# echo $((NUMBER_GUESS))
# after the game, insert the user_info into the database
if [[ -z $CHECK_RESULT ]]
then
  # this user is new come, just insert
  INSERT_RESULT=$($PSQL "INSERT INTO users(user_name, guess_time, score) VALUES('$USERNAME', 1, $NUMBER_GUESS)")
  echo "$INSERT_RESULT"
else 
  # this user has played before, update the info
  GUESS_TIME=$((GUESS_TIME+1))
  if [ "$NUMBER_GUESS" -lt "$SCORE" ]
  then 
    # update this user's score
    SCORE=$NUMBER_GUESS
  fi
  UPDATE_RESULT=$($PSQL "UPDATE users SET guess_time=$GUESS_TIME, score=$SCORE WHERE user_name='$USERNAME'")

fi