#!/bin/bash

# This script responds to the task: Write a Shell Script that accepts a file name, starting and ending line numbers as arguments and displays all lines between the given line numbers.

# Usage: ./show_range.sh file_name start_line end_line

# Ensure the script fails fast with any failing command and prevent silent errors from unset arguments
set -eu



# Validate the script usage ensuring it's called with the proper format and all arguments are passed successfully
if [ "$#" -ne 3 ]; then
	echo "Usage: $0 <file_name> <start_line> <end_line>"
	exit 2
fi



# Set the argument values ($1, $2, $3) to variables
file_name="$1"
start_line="$2"
end_line="$3"



# Validate the file by checking if it exists and if it's a regular file and not a directory
if [ ! -e "$file_name" ]; then
	echo "Error: file '$file_name' doesn't exist"
	exit 3 # Specifically assigning the error code 3 to this particular error. It has no real difference
fi

if [ ! -f "$file_name" ]; then
	echo "Error: file '$file_name' is not a regular file"
	exit 4 # Specifically assigning the error code 3 to this particular error. It has no real difference
fi



# Validate the input format (must only accept positive integers)
number_line_format='^[1-9][0-9]*$' #The input cannot accept leading 0 as input eg. 01, 05...

if ! [[ $start_line =~ $number_line_format ]] || ! [[ $end_line =~ $number_line_format ]]; then
	echo "Error: Start and end lines must be positive integers"
	exit 5
fi



# Converting the values in the arguments to be integers to perform numeric operations such as comparison (<=, ==, >=)
start_line=$((start_line))
end_line=$((end_line))

if [ "$start_line" -gt "$end_line" ]; then
	echo "Error: Start line ($start_line) must be less than end line ($end_line)."
	exit 6
fi



# Printing the requested range only
echo "Printing from line ($start_line) to line ($end_line) inclusively..."
sed -n "${start_line},${end_line}p" -- "$file_name"
