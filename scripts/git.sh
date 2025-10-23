#!/bin/bash

# ===============================
# Git
# ===============================

function git_fetch() {
    # Define parameters
    NAME=$1
    REPO=$2
    BRANCH=$3

    # If $NAME was not specified...
    if [ -z "$NAME" ]; then
        # Prompt the user to specify $NAME
        echo "git.sh: git_fetch error: \$NAME (aka \$1) was not specified"

        # Exit the script with a non-zero exit code
        exit 1
    fi

    # If $REPO was not specified...
    if [ -z "$REPO" ]; then
        # Prompt the user to specify $REPO
        echo "git.sh: git_fetch error: \$"

        # Exit the script with a non-zero exit code
        exit 1
    fi

    # If $BRANCH was not specified...
    if [ -z "$BRANCH" ]; then
        # Set $BRANCH to main
        BRANCH="main"
    fi

    # Create the _dep/$NAME directory if doesn't already exit
    mkdir -p "_dep/$NAME"

    # Attempt to go to _dep/$NAME directory and exit the script with an error message
    cd "_dep/$NAME" || echo "git.sh: git_fetch error: an unexpected error occurred" && exit 1

    # Clone the repository into _dep/$NAME
    echo "Cloning $NAME..."
    git clone REPO

    # Prompt the user that the repository was successfully cloned
    echo "$NAME was successfully cloned"

    # Exit the script
    exit 0
}

