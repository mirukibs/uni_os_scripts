#!/usr/bin/env bash

# This bash script is a program that simulates a simple student record's management system. A user can add, delete and list the student records in a text file.

set -e

# Validations
validate_registration_number() {

	# Check value is not empty
	local reg_no_value=$1
	local reg_no_length=${#reg_no_value}
	local min_length=15
	local max_length=16
	local reg_no_format="^IMC\/[A-Z]{3,4}\/[0-9]{7}$"
	
	if [[ -z "$reg_no_value" ]]; then
		echo "Error: Registration number cannot be empty!"
		return 1
	fi

	# Check length is 15-16 characters
	if [[ $reg_no_length -lt $min_length ]]; then
		echo "Error: Registration number cannot be less than $min_length"
		return 1
	fi
	
	if [[ $((reg_no_length)) -gt $max_length ]]; then
		echo "Error: Registration number cannot be greater than $max_length"
		return 1
	fi	

	# Check format IMC/XXXX/NNNNNNN where XXXX is faculty code and NNNNNNN is numeric. Note faculty code be 3 chars instead of 4
	if ! [[ "$reg_no_value" =~ $reg_no_format ]]; then
		echo "Error: Incorrect format. Registration number format is IMC/XXXX/NNNNNNN"
		return 1
	fi
	
	# Accept input in any case, but store in uppercase in the file. Return success or failure
	echo "${reg_no_value^^}"
	return 0

}


validate_grade() {

	# Check value is not empty

	# Ensure grade matches allowed values (A–F) and only take one character per entry
	
	# Must be uppercase

	# Return success or failure

}


validate_name() {

	# Check value is not empty

	# Ensure contains only alphabetic characters and no special characters

	# Ensure min length is 3 and max is 15 characters
	
	# Trip whitespace

	# Return success or failure

}


validate_record_array() {

	# Check array length equals 4
	
	# Trip whitespace

	# Loop through each item

	# If any item is empty:

	# Return failure

	# Return success

}


check_record_exists() {

	# Search file for line starting with reg_no|
		# If found:
			# Return true
		# Else:
			# Return false

}


# Features
add_record() {

	# Declare empty record array

	# Prompt user for registration number

	# Validate registration number format
		# If invalid -> show error -> return

	# Check if registration number already exists
		# If exists -> show error -> return

	# Prompt user for first name

	# Validate first name
		# If invalid -> show error -> return

	# Prompt user for last name

	# Validate last name
		# If invalid -> show error -> return

	# Prompt user for grade

	# Validate grade
		# If invalid -> show error -> return

	# Populate record array with validated inputs

	# Validate entire record array
		# Ensure no empty fields

	# Convert record array into delimited string. Store record as: REG_NO|FirstName|LastName|GRADE

	# Append record string to file

	# Display success message

}


delete_record() {

	# Prompt user for registration number

	# Validate registration number format
		# If invalid then return

	# Check if record exists
		# If not then show error -> return

	# Create a temporary file

	# Read records file line by line

	# For each line:
		# Extract registration number
		# If it does NOT match target:
			# Write line to temp file

	# Replace original file with temp file

	# Display confirmation message

}


view_record() {

	# Prompt user for registration number
	
	# Validate registration number
		# If invalid -> return

	# Search records file for matching registration number
		# If found:
	 		# Extract full record line
			# Parse fields into array
			# Print formatted output	
		# If not found:
			# Display "record not found"

}


list_records() {

	# Check if records file is empty
		# If empty -> show message -> return
		
	# Read file line by line
	
	# For each line:
		# Parse record into array
		# Print record in readable format
		
	# Display total count

}


main() {
	
	# Define path to records file
	
	# If file does not exist:
		# Create empty file
	
	# Loop forever:
		# Display menu:
			# Add record
			# Delete record
			# View record
			# List all records
			# Exit
		
		# Read user input
		# Based on choice:
			# Call corresponding function
		# Handle invalid menu choice

	# Exit loop only on explicit exit choice

}
