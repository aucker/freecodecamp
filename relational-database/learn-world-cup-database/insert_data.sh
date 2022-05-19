#! /bin/bash
# Script to insert data from games.csv into worldcup database

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi

# Do not change code above this line. Use the PSQL variable above to query your database.
echo $($PSQL "TRUNCATE teams, games")
cat games.csv | while IFS="," read YEAR ROUND WINNER OPPONENT WINNER_GOALS OPPONENT_GOALS
do
  if [[ $WINNER != winner ]]
  then 
    # get team id?
    TEAM_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$WINNER'")

    # if not found 
    if [[ -z $TEAM_ID ]]
    then
      # insert team
      INSERT_TEAM_RESULT=$($PSQL "INSERT INTO teams(name) VALUES('$WINNER')")
      if [[ $INSERT_TEAM_RESULT == "INSERT 0 1" ]]
      then
        echo Inserted into teams, $WINNER
      fi

      # get new team_id
      TEAM_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$WINNER'")
    fi

    # get team_id again? hahaha
    TEAM_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$OPPONENT'")

    # if not found, we insert it again<3
    if [[ -z $TEAM_ID ]]
    then 
      INSERT_TEAM_RESULT1=$($PSQL "INSERT INTO teams (name) VALUES('$OPPONENT')")
      if [[ $INSERT_TEAM_RESULT1 == "INSERT 0 1" ]]
      then
        echo Inserted into teams, $OPPONENT
      fi
      TEAM_ID=$($PSQL "SELECT team_id FROM teams WHERE name=('$OPPONENT')")
    fi 
  fi 
done


cat games.csv | while IFS="," read YEAR ROUND WINNER OPPONENT WINNER_GOALS OPPONENT_GOALS
do
  if [[ $YEAR != year ]]
  then
    # get winner_id
    WINNER_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$WINNER'")
    # get opponent_id 
    OPPONENT_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$OPPONENT'")

    # get the game_id 
    GAME_ID=$($PSQL "SELECT game_id FROM games WHERE year='$YEAR' AND round='$ROUND' AND winner_id='$WINNER_ID' AND opponent_id='$OPPONENT_ID' AND winner_goals='$WINNER_GOALS' AND opponent_goals='$OPPONENT_GOALS'")

    # if not exist, then insert
    if [[ -z $GAME_ID ]]
    then 
      INSERT_GAME_RESULT=$($PSQL "INSERT INTO games (year, round, winner_id, opponent_id, winner_goals, opponent_goals) VALUES ('$YEAR', '$ROUND', '$WINNER_ID', '$OPPONENT_ID', '$WINNER_GOALS', '$OPPONENT_GOALS')")      

      if [[ $INSERT_GAME_RESULT == "INSERT 0 1" ]]
      then
        echo Inserted game info, $YEAR, $ROUND, $WINNER_ID, $OPPONENT_ID, $WINNER_GOALS, $OPPONENT_GOALS
      fi

      # this time we can get the game_id now 
      GAME_ID=$($PSQL "SELECT game_id FROM games WHERE year='$YEAR' AND round='$ROUND' AND winner_id='$WINNER_ID' AND opponent_id='$OPPONENT_ID' AND winner_goals='$WINNER_GOALS' AND opponent_goals='$OPPONENT_GOALS'")
    fi
  fi  
done