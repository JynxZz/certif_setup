#!/bin/bash

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
