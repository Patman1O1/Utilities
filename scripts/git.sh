#!/bin/bash

# ===============================
# Git
# ===============================

function add_all() {
    # For each file in the working directory...
    find . -type f | while read -r file ; do
        # Attempt to add the current file
        git add "$file"

        # If adding the current file failed...
        if [ $? -ne 0 ]; then
            # Prompt the user
            echo "git.sh: error: failed to add $file"

            # Exit the function with an error code
            exit 1
        fi

        # Otherwise, prompt the user that the file was successfully added
        echo "git.sh: note: $file was successfully added"
    done

    # Prompt the user that the all files were successfully added in the working directory
    echo "git.sh: note: all files in $(pwd) were successfully added"
}


