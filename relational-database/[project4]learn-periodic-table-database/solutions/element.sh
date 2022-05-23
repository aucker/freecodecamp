#!/bin/bash
PSQL="psql -X --username=freecodecamp --dbname=periodic_table --tuples-only -c"

EXIT() {
  echo -e "I could not find that element in the database."
}

# delete a row with atomic_number = 1000
EXIST=$($PSQL "SELECT atomic_number FROM elements WHERE atomic_number=1000")
echo "$EXIST"
EXIST_NOW=$(echo "$EXIST" | xargs)
if [[ "$EXIST_NOW" == 1000 ]]
then 
  echo "$($PSQL "DELETE FROM elements WHERE atomic_number=1000;DELETE FROM properties WHERE atomic_number=1000")"
  # echo $($PSQL "")
fi

if [[ $1 ]]
then 
  # test if you can read it or not
  # echo -e "$1"
  if [[ "$1" =~ ^[0-9]+$ ]]
  # this is atomic_number
  then 
    ID=$1
    ATOMIC_NUMBER=$($PSQL "SELECT atomic_number FROM elements WHERE atomic_number = $ID")
    if [[ -z $ATOMIC_NUMBER ]]
    then 
      EXIT
    else
      ELE_NAME=$($PSQL "SELECT name FROM elements WHERE atomic_number=$ATOMIC_NUMBER")
      ELE_SYMBOL=$($PSQL "SELECT symbol FROM elements WHERE atomic_number=$ATOMIC_NUMBER")
      SYMBOL=$(echo $ELE_SYMBOL | xargs)
      TYPE_ID=$($PSQL "SELECT type_id FROM properties WHERE atomic_number=$ATOMIC_NUMBER")
      # TYPE=$($PSQL "SELECT type FROM types INNER JOIN properties WHERE atomic_number=$ATOMIC_NUMBER")
      ELE_TYPE=$($PSQL "SELECT type FROM types WHERE type_id=$TYPE_ID")
      ELE_MASS=$($PSQL "SELECT atomic_mass FROM properties WHERE atomic_number=$ATOMIC_NUMBER")
      ELE_MELT=$($PSQL "SELECT melting_point_celsius FROM properties WHERE atomic_number=$ATOMIC_NUMBER")
      ELE_BOIL=$($PSQL "SELECT boiling_point_celsius FROM properties WHERE atomic_number=$ATOMIC_NUMBER")
    fi
    
    # GET_ELEMENT_ID
    echo The element with atomic number $ATOMIC_NUMBER is $ELE_NAME\($SYMBOL\). It\'s a $ELE_TYPE, with a mass of $ELE_MASS amu. $ELE_NAME has a melting point of $ELE_MELT celsius and a boiling point of $ELE_BOIL celsius.
  elif [[ "$1" =~ ^[A-Z][a-z]?$ ]]
  then 
    # GET_ELEMENT_SYMBOL
    # SYMBOL=$1
    # echo 111$SYMBOL
    ATOMIC_SYMBOL=$($PSQL "SELECT symbol FROM elements WHERE symbol = '$1'")
    echo 111$ATOMIC_SYMBOL
    if [[ -z $ATOMIC_SYMBOL ]]
    then 
      EXIT
    else
      ATOMIC_NUMBER=$($PSQL "SELECT atomic_number FROM elements WHERE symbol='$1'")
      echo $ATOMIC_NUMBER2
      ELE_NAME=$($PSQL "SELECT name FROM elements WHERE symbol='$1'")
      echo $ELE_NAME   
      TYPE_ID=$($PSQL "SELECT type_id FROM properties WHERE atomic_number=$ATOMIC_NUMBER")
      # TYPE=$($PSQL "SELECT type FROM types INNER JOIN properties WHERE atomic_number=$ATOMIC_NUMBER")
      ELE_TYPE=$($PSQL "SELECT type FROM types WHERE type_id=$TYPE_ID")
      ELE_MASS=$($PSQL "SELECT atomic_mass FROM properties WHERE atomic_number=$ATOMIC_NUMBER")
      ELE_MELT=$($PSQL "SELECT melting_point_celsius FROM properties WHERE atomic_number=$ATOMIC_NUMBER")
      ELE_BOIL=$($PSQL "SELECT boiling_point_celsius FROM properties WHERE atomic_number=$ATOMIC_NUMBER")
    fi
    echo The element with atomic number $ATOMIC_NUMBER is $ELE_NAME\($1\). It\'s a $ELE_TYPE, with a mass of $ELE_MASS amu. $ELE_NAME has a melting point of $ELE_MELT celsius and a boiling point of $ELE_BOIL celsius.
  elif [[ "$1" =~ ^[A-Z][a-z][a-z]+$ ]]
  then 
    # GET_ELEMENT_NAME
    NAME=$1
    ATOMIC_NAME=$($PSQL "SELECT name FROM elements WHERE name = '$NAME'")

    if [[ -z $ATOMIC_NAME ]]
    then 
      EXIT
    else
      ELE_SYMBOL=$($PSQL "SELECT symbol FROM elements WHERE name='$NAME'")
      SYMBOL=$(echo $ELE_SYMBOL | xargs)
      # echo $test
      # echo $ELE_SYMBOL | xargs
      ATOMIC_NUMBER=$($PSQL "SELECT atomic_number FROM elements WHERE name='$NAME'")
      TYPE_ID=$($PSQL "SELECT type_id FROM properties WHERE atomic_number=$ATOMIC_NUMBER")
      # TYPE=$($PSQL "SELECT type FROM types INNER JOIN properties WHERE atomic_number=$ATOMIC_NUMBER")
      ELE_TYPE=$($PSQL "SELECT type FROM types WHERE type_id=$TYPE_ID")
      ELE_MASS=$($PSQL "SELECT atomic_mass FROM properties WHERE atomic_number=$ATOMIC_NUMBER")
      ELE_MELT=$($PSQL "SELECT melting_point_celsius FROM properties WHERE atomic_number=$ATOMIC_NUMBER")
      ELE_BOIL=$($PSQL "SELECT boiling_point_celsius FROM properties WHERE atomic_number=$ATOMIC_NUMBER")
    fi
    echo The element with atomic number $ATOMIC_NUMBER is $NAME\($SYMBOL\). It\'s a $ELE_TYPE, with a mass of $ELE_MASS amu. $ELE_NAME has a melting point of $ELE_MELT celsius and a boiling point of $ELE_BOIL celsius.
  else
    EXIT
  fi
else
  echo -e "Please provide an element as an argument."
fi
# # get element by atomic_number
# GET_ELEMENT_ID() {
#   ATOMIC_NUMBER=$($PSQL "SELECT atomic_number FROM elements WHERE atomic_number = $ID")
#   if [[ -z $ATOMIC_NUMBER ]]
#   then 
#     EXIT
#   else
#     NAME=$($PSQL "SELECT name FROM elements WHERE atomic_number=$ATOMIC_NUMBER")
#     SYMBOL=$($PSQL "SELECT symbol FROM elements WHERE atomic_number=$ATOMIC_NUMBER")
#     TYPE=$($PSQL "SELECT type FROM types INNER JOIN properties WHERE atomic_number=$ATOMIC_NUMBER")
#     MASS=$($PSQL "SELECT atomic_mass FROM properties WHERE atomic_number=$ATOMIC_NUMBER")
#     MELT=$($PSQL "SELECT melting_point_celsius FROM properties WHERE atomic_number=$ATOMIC_NUMBER")
#     BOIL=$($PSQL "SELECT boiling_point_celsius FROM properties WHERE atomic_number=$ATOMIC_NUMBER")
#   fi
# }

# GET_ELEMENT_SYMBOL() {

# }

# GET_ELEMENT_NAME() {

# }

