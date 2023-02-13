#!/bin/bash

# Declare constants
MAX_VALUE=1000


# Generate random number between 1 and $1 arg
function _generateRandomInt() {

  local randomInt=$[ $RANDOM % $1 + 1]
  echo $randomInt

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

  randomInt=$(_generateRandomInt $MAX_VALUE)
  echo $randomInt

}


_main