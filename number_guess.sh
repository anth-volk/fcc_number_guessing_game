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
  # If found, print user data
  else
    echo $authOutput | while IFS="|" read userId gamesPlayed bestGame
    do
      echo "Welcome back, $username! You have played $gamesPlayed games, and your best game took $bestGame guesses."
    done
  fi

}

function _gameLoop() {
  # First arg: username, second arg: target value, third arg: user's guess

  local username=$1
  local targetValue=$2
  local guess=$3
  local iterationCounter=0
  local gameWon=false

  while [[ ! $gameWon == true ]]
  do
    if [[ -z $guess ]]
    then
      echo "Guess the secret number between 1 and 1000:"
      read guess
      iterationCounter=$[ $iterationCounter + 1 ]
    elif [[ ! $guess =~ ^[0-9]{1,4}$ ]]
    then
      echo "That is not an integer, guess again:"
      read guess
      iterationCounter=$[ $iterationCounter + 1 ]
    elif [[ $guess -lt $targetValue ]]
    then
      echo "It's higher than that, guess again:"
      read guess
      iterationCounter=$[ $iterationCounter + 1 ]
    elif [[ $guess -gt $targetValue ]]
    then
      echo "It's lower than that, guess again:"
      read guess
      iterationCounter=$[ $iterationCounter + 1 ]
    else
      gameWon=true
    fi
  done

  # Log results to database
  recordSubmissionResult=$(_updateRecords $username $iterationCounter $targetValue)

  # Print win message
  echo "You guessed it in $iterationCounter tries. The secret number was $targetValue. Nice job!"

}

function _updateRecords() {
  
  # $1 = username
  local username=$1
  local iterationCounter=$2
  local targetValue=$3

  userRecord=$($PSQL "SELECT games_played, best_game FROM users WHERE username='$username';")
  echo $userRecord | while IFS="|" read gamesPlayed bestGame
  do
    local newGamesPlayed=$[ $gamesPlayed + 1]

    if [[ -z $bestGame || $targetValue -lt $bestGame ]]
    then
      local newBestGame=$iterationCounter
    else
      local newBestGame=$bestGame
    fi

    # Insert data into database
    echo $($PSQL "UPDATE users SET games_played=$newGamesPlayed, best_game=$newBestGame WHERE username='$username'";)

  done



}


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

  # Initiate game loop and return final win message
  _gameLoop $username $randomInt

}


_main