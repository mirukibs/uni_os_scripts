#!/usr/bin/env bash

# This bash script is a program that simulates a simple student record's management system. A user can add, delete and list the student records in a text file.

set -e

# Validations
validate_registration_number() {

	local reg_no_value=$1
	local trimmed_reg_no_value=$(echo "$reg_no_value" | tr -d '[:space:]')
	local reg_no_length=${#trimmed_reg_no_value}
	local min_length=15
	local max_length=16
	local reg_no_format="^IMC\/[A-Z]{3,4}\/[0-9]{7}$"]
	
	# Check value is not empty	
	if [[ -z "$trimmed_reg_no_value" ]]; then
		echo "Error: Registration number cannot be empty!"
		return 1
	fi

	# Check length is 15-16 characters
	if [[ $reg_no_length -lt $min_length ]]; then
		echo "Error: Registration number cannot be less than $min_length!"
		return 1
	fi
	
	if [[ $reg_no_length -gt $max_length ]]; then
		echo "Error: Registration number cannot be greater than $max_length!"
		return 1
	fi	

	# Check format IMC/XXXX/NNNNNNN where XXXX is faculty code and NNNNNNN is numeric. Note faculty code be 3 chars instead of 4
	if ! [[ "$trimmed_reg_no_value" =~ $reg_no_format ]]; then
		echo "Error: Incorrect format. Registration number format is IMC/XXXX/NNNNNNN!"
		return 1
	fi
	
	# Accept input in any case, but store in uppercase in the file. Return success or failure
	echo "${trimmed_reg_no_value^^}"
	return 0

}


validate_grade() {

	local grade_value=$1
	local trimmed_grade_value=$(echo "$grade_value" | tr -d '[:space:]')
	local grade_value_format="^[A-Fa-f]{1}$"
	local grade_value_length=${#trimmed_grade_value}

	# Check value is not empty
	if [[ $grade_value_length -lt 1 ]]; then
		echo "Error: Grade cannot be empty!"
		return 1
	fi

	# Ensure grade matches allowed values (A–F) and only take one character per entry
	if ! [[ "$trimmed_grade_value" =~ $grade_value_format ]]; then
		echo "Error: Grade can only a single character be A-F!"
		return 1
	fi
	
	# Must be uppercase. Return success or failure
	echo ${trimmed_grade_value^^}
	return 0

}


validate_name() {

	local name_value=$1
	local trimmed_name_value=$(echo "$name_value" | tr -d '[:space:]')
	local name_length=${#trimmed_name_value}
	local name_min_length=3
	local name_max_length=15
	local name_format="^[A-Za-z]{3,15}$"
	
	# Check value is not empty
	if [[ -z "$trimmed_name_value" ]]; then
		echo "Error: Name cannot be empty!"
		return 1
	fi

	# Ensure min length is 3 and max is 15 characters
	if [[ $name_length -lt $name_min_length ]]; then
		echo "Error: Name cannot be less than $name_min_length!"
		return 1
	fi
	
	if [[ $name_length -gt $name_max_length ]]; then
		echo "Error: Name cannot be greater than $name_max_length!"
		return 1
	fi
	
	# Ensure contains only alphabetic characters and no special characters
	if ! [[ "$trimmed_name_value" =~ $name_value_format ]]; then
		echo "Error: Name can only be alphabetic characters!"
		return 1
	fi
	
	# Must be uppercase. Return success or failure
	echo ${trimmed_name_value^^}
	return 0

}


validate_record_array() {

	local student_record_array=("$@")
	local student_record_array_length=${#student_record_array[@]}
	
	# Check array length equals 4
	if [[ $student_record_array_length -ne 4 ]]; then
		echo "Error: A student record must have 4 fields!"
		return 1
	fi

	# Validate each item, return failure if validation fails
	local validated_regno
	local validated_firstname
	local validated_lastname
	local validated_grade
	
	validated_regno=$(validate_registration_number "${student_record_array[0]}") || return 1
	
	validated_firstname=$(validate_name "${student_record_array[1]}") || return 1
	
	validated_lastname=$(validate_name "${student_record_array[2]}") || return 1
	
	validated_grade=$(validate_grade "${student_record_array[3]}") || return 1

	# Return success
	echo "${validated_regno}|${validated_firstname}|${validated_lastname}|${validated_grade}"
	return 0

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
