#!/bin/bash

# ===============================
# Get Distributor
# ===============================

# Exit the script immediately if any command returns a non-zero exit status
set -e

# Check the Unix distribution
if [ -f /etc/os-release ]; then # Linux
    . /etc/os-release
    
    # Capitialize the first character and convert all other characters to lowercase
    LINUX="$(tr '[:upper:]' '[:lower:]' <<< "$ID")"
    echo "${LINUX^}"
elif [ "$(uname -s)" = "Darwin" ]; then # macOS
    echo "macOS"
elif [ -n "$PREFIX" ] && [ -x "$(command -v pkg)" ]; then # Termux (Android)
    echo "Termux"
else
    echo "Unknown"
fi
