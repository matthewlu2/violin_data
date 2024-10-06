#!/bin/bash

# Directory where all the files are located

# Set the commit message
COMMIT_MSG="Adding files in batches"

# Set the batch size (number of files to add per commit)
BATCH_SIZE=1000

# Counter for keeping track of files added in the current batch
counter=0


# Find all files in the directory and subdirectories
find . -type f | while read file; do
    # Add the file to Git
    git add "$file"
    counter=$((counter + 1))

    # If the counter reaches the batch size, commit and push the changes
    if [ $counter -ge $BATCH_SIZE ]; then
        git commit -m "$COMMIT_MSG - batch $counter"
        git push origin main

        # Reset the counter for the next batch
        counter=0
    fi
done

# If there are any remaining files not committed, commit and push them
if [ $counter -gt 0 ]; then
    git commit -m "$COMMIT_MSG - final batch"
    git push origin main
fi

echo "All files added and pushed successfully."