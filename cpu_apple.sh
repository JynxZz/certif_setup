#!/bin/bash

# Get the machine hardware name (architecture) using 'uname -m' command
arch_name="$(uname -m)"

# Check if the architecture is 'x86_64' (Intel 64-bit)
if [ "${arch_name}" = "x86_64" ]; then
    # Check if Rosetta 2 translation is active
    if [ "$(sysctl -in sysctl.proc_translated)" = "1" ]; then
        echo "Your computer uses Apple Silicon (Rosetta) 🌟"
    else
        echo "Your computer has an Intel processor 🤖"
    fi
# Check if the architecture is 'arm64' (Apple Silicon)
elif [ "${arch_name}" = "arm64" ]; then
    echo "Your computer uses Apple Silicon 🌟"
else
    # If the architecture is neither 'x86_64' nor 'arm64', it's unknown
    echo "Unknown architecture: ${arch_name}, please contact support 🤔"
fi
