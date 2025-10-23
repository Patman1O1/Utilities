#!/bin/bash

# ===============================
# git_fetch
# ===============================

# Exit the script whenever a non-zero exit status is returned
set -e

# Define variables
REPO_URL="$1"
BRANCH="${2:-main}"
TARGET_DIR="${3:-$(basename "$REPO_URL" .git)}"

# If the user did not specify the repository URL...
if [ -z "$REPO_URL" ]; then
    # Prompt the user to enter the URL
    echo "git_fetch: error: the Git repository was not specified"
    echo "git_fetch: usage: $0 <repo-url> [branch] [target-dir]"

    # Exit the script
    exit 1
fi

# If the Git repository already exists in the target directory...
if [ -d "$TARGET_DIR/.git" ]; then
    # Prompt the user that the latest version of the repository is being fetched
    echo "git_fetch: note: fetching branch '$BRANCH' in $TARGET_DIR..."

    # Fetch the latest version of the repository
    git -C "$TARGET_DIR" fetch origin "$BRANCH"
    git -C "$TARGET_DIR" checkout "$BRANCH"
    git -C "$TARGET_DIR" pull origin "$BRANCH"
else
    # Otherwise, prompt the user that the repository is
    # being cloned in the target directory
    echo "git_fetch: note: cloning branch '$BRANCH' from $REPO_URL..."

    # Clone the repository
    git clone -b "$BRANCH" "$REPO_URL" "$TARGET_DIR"
fi
