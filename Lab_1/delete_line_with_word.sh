#!/bin/bash

# This script responds to the task: Write a shell script that deletes all lines containing the specified word in one or more files supplied as arguments to it.

# Usage: ./delete_line_with_word.sh word file1 [file2...]

# Ensure the script fails fast with any failing command and prevent silent errors from unset arguments
set -eu



# Validate the script usage ensuring it's called with the proper format and all arguments are passed successfully
if [ "$#" -lt 2 ]; then
	echo "Usage: $0 <word-or-pattern> <file1> [file2...]"
	exit 2
fi



# Extract the word pattern passed as an argument
word_pattern="$1"
shift # Saves the pattern to the variable then frees the argument for the next file arguments



# Process each file as passed in the arguments
for file in "$@"; do
	if [ ! -e "$file" ]; then
		echo "Skipping! The file '$file' doesn't exist"
		continue
	fi
	
	if [ ! -f "$file" ]; then
		echo "Skipping! The file '$file' is not a regular file"
		continue
	fi
	
	if grep -q -- "$word_pattern" "$file"; then
		cp -- "$file" "$file.bak" || { echo "Failed to backup $file"; continue; }
		sed -i "/$word_pattern/d" -- "$file"
		echo "Edited '$file' (backup: '$file.bak')"
	else
		echo "No match in '$file'; nothing changed."
	fi
done
