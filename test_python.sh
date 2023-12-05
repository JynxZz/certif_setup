#!/bin/bash

# ---------------------------------------------------------------------------------
# Author: JynxZz
# Date Created: [2023-12-05]
# Script Description: Test to check the good python verison install
# WIP / TODO :  Passing the Expected Version as an Argument
# ---------------------------------------------------------------------------------


# Expected Python version
expected_version="Python 3.10.6"

# Get the current Python version
current_version=$(python -V 2>&1)

# Check if the versions match
if [[ $current_version == $expected_version ]]; then
  echo "✅ Your Python version is correct: $current_version."
else
  echo "❌ Your Python version is $current_version but it should be $expected_version."
fi
