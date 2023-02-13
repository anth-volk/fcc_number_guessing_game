#!/bin/bash

# Declare constants
MAX_VALUE=1000
PSQL="psql --username=freecodecamp --dbname=<database_name> -t --no-align -c"

# Generate random number between 1 and $1 arg
function _generateRandomInt() {
  local randomInt=$[ $RANDOM % $1 + 1]
  echo $randomInt
}

# Authentication function, where $1 is username
function _authenticateUser() {
  local authOutput=$($PSQL "SELECT user_id FROM 


}

# Ask user to enter username
  # If not able to find in DB, indicate that it is user's first time

  # Otherwise, print account data

# Print line indicating user should guess
  # Initiate local counter

  # Begin loop

  # Read user's guess

  # Indicate whether user's guess is lower or higher

  # Increment counter or print end message, then update stats in DB

function _main() {

  # Generate random integer between 1 and MAX_VALUE
  randomInt=$(_generateRandomInt $MAX_VALUE)

  # Ask user to enter username and authenticate
  echo "Enter your username:"
  read username
  echo $(_authenticateUser $username)

}


_main