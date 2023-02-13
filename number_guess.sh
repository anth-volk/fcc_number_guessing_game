#!/bin/bash

# Declare constants
MAX_VALUE=1000
PSQL="psql --username=freecodecamp --dbname=number_guess -t --no-align -c"

# Generate random number between 1 and $1 arg
function _generateRandomInt() {
  local randomInt=$[ $RANDOM % $1 + 1]
  echo $randomInt
}

# Authentication function, where $1 is username
function _authenticateUser() {

  # Declare var that represents $1
  local username=$1

  # Attempt to locate user using input username
  local authOutput=$($PSQL "SELECT user_id, games_played, best_game FROM users WHERE username='$username';")

  # If not able to find in DB, indicate that it is user's first time
  if [[ -z $authOutput ]]
  then
    createUser=$($PSQL "INSERT INTO users(username) VALUES('$username');")

    # Were this to not be for an FCC challenge (the tests will probably fail if implemented),
    # here is where the script would check if insertion failed because username
    # must be a unique value

    echo "Welcome, $username! It looks like this is your first time here."
  else
    echo $authOutput | while IFS="|" read userId gamesPlayed bestGame
    do
      echo "Welcome back, $username! You have played $gamesPlayed games, and your best game took $bestGame guesses."
    done
  fi


}

# Ask user to enter username
  

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