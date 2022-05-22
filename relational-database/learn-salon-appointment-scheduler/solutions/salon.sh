#!/bin/bash
PSQL="psql -X --username=freecodecamp --dbname=salon --tuples-only -c"

echo -e "\n~~~~~ MY SALON ~~~~~"
MAIN_MENU() {
  if [[ $1 ]]
  then 
    echo -e "\n$1"
  fi

  echo -e "\nWelcome to My Salon, how can I help you?"
  echo -e "\n1) hair\n2) nails\n3) beauty\n4) barbering"
  read SERVICE_ID_SELECTED

  case $SERVICE_ID_SELECTED in 
  1) echo "you choose hair service" ;;
  2) echo "you choose nails service" ;;
  3) echo "you choose beauty service" ;;
  4) echo "you choose barbering service" ;;
  *) MAIN_MENU ;;
  esac
  echo -e "\nPlease input your phone number:"
  read CUSTOMER_PHONE
  NAME=$($PSQL "SELECT name FROM customers WHERE phone='$CUSTOMER_PHONE'")
  # if phone not exist
  if [[ -z $NAME ]]
  # which means not a customer
  then 
    # get customer name
    GET_NAME
      
    # get appointment time
    GET_TIME
  else 
    # already a customer
    GET_TIME
  fi
  # insert customer's appointment info to appointment table  
  # get customer_id
  GET_ID

  # insert into appointment table 
  INSERT_APPOINTMENT
  # give customer a feedback
  # get service name
  SERVICE_NAME=$($PSQL "SELECT name FROM services WHERE service_id = $SERVICE_ID_SELECTED")
  echo -e "\nI have put you down for a $SERVICE_NAME at $SERVICE_TIME, $CUSTOMER_NAME."
} 
GET_NAME() {
  echo -e "\nPlease input your name:"
  read CUSTOMER_NAME
  if [[ -z $CUSTOMER_NAME ]]
  then 
    GET_NAME "\nPlease input you name:"
  else 
    # insert this customer into customers table 
    INSERT_CUSTOMER_RESULT=$($PSQL "INSERT INTO customers(phone, name) VALUES('$CUSTOMER_PHONE', '$CUSTOMER_NAME')")
  fi
}
GET_ID() {
  # get customer_id
  CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers WHERE phone='$CUSTOMER_PHONE'")
}
GET_TIME() {
  echo -e "\nPlease input your appointment time:"
  read SERVICE_TIME
  if [[ -z $SERVICE_TIME ]]
  then 
    GET_TIME "\nPlease input your appointment time:"
  fi
}
INSERT_APPOINTMENT() {
  INSERT_APPOINTMENT_RESULT=$($PSQL "INSERT INTO appointments(time, customer_id, service_id) VALUES('$SERVICE_TIME', $CUSTOMER_ID, $SERVICE_ID_SELECTED)")

}
EXIT() {
  echo -e "\nThank you for stopping in.\n"
}
MAIN_MENU