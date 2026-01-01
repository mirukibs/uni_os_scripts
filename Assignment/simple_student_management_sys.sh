#!/usr/bin/env bash

# This bash script is a program that simulates a simple student record's management system. A user can add, delete and list the student records in a text file.

# set -e

RECORDS_FILE="student_records.txt"

# Validations
validate_registration_number() {

	local reg_no_value=$1
	local trimmed_reg_no_value=$(echo "$reg_no_value" | tr -d '[:space:]')
	local reg_no_length=${#trimmed_reg_no_value}
	local min_length=15
	local max_length=16
	local reg_no_format="^[Ii][Mm][Cc]\/[A-Za-z]{3,4}\/[0-9]{7}$"
	
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
	local name_value_format="^[A-Za-z]{3,15}$"
	
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
	local validated_regno
	local validated_firstname
	local validated_lastname
	local validated_grade
	
	# Check array length equals 4
	if [[ $student_record_array_length -ne 4 ]]; then
		echo "Error: A student record must have 4 fields!"
		return 1
	fi

	# Validate each item, return failure if validation fails	
	validated_regno=$(validate_registration_number "${student_record_array[0]}") || return 1
	
	validated_firstname=$(validate_name "${student_record_array[1]}") || return 1
	
	validated_lastname=$(validate_name "${student_record_array[2]}") || return 1
	
	validated_grade=$(validate_grade "${student_record_array[3]}") || return 1

	# Return success
	echo "${validated_regno}|${validated_firstname}|${validated_lastname}|${validated_grade}"
	return 0

}


check_record_exists() {

	local reg_no_value="$1"
	
	# If file does not exist or is empty, record cannot exist
	if [[ ! -f "$RECORDS_FILE" || ! -s "$RECORDS_FILE" ]]; then
		return 1
	fi
	
	# Search for record starting with REG_NO|
		# If found:
			# Return true
		# Else:
			# Return false	
	if ! grep -q "^${reg_no_value}|" "$RECORDS_FILE"; then
		return 1
	fi
	
	return 0
		
}


# Features
add_record() {
	
	# Accept user input for the record fields
	read -p "Registration Number: " registration_no
	read -p "First Name: " firstname
	read -p "Last Name: " lastname
	read -p "Grade: " grade
	
	# validate the reg number and check for duplicate in file
	validate_registration_number "$registration_no"
	registration_no=$(validate_registration_number "$registration_no")
	if [[ $? -ne 0 ]]; then
		return 1
	fi
	
	if check_record_exists "$registration_no"; then
		echo "Error: Record already exists!"
		return 1
	fi

	# Validate the array for a comlete record
	validate_record_array "$registration_no" "$firstname" "$lastname" "$grade"
	student_record=$(validate_record_array "$registration_no" "$firstname" "$lastname" "$grade")
	if [[ $? -ne 0 ]]; then
		return 1
	fi

	echo "$student_record" >> "$RECORDS_FILE" # Write to file

	echo "Record added successfully."

}


delete_record() {

	# Accept user input of reg number then validate it
	read -p "Registration Number to delete: " registration_no
	registration_no=$(validate_registration_number "$registration_no")
	
	if [[ $? -ne 0 ]]; then
		return 1
	fi

	if ! check_record_exists "$registration_no"; then
		echo "Error: Record not found!"
		return
	fi

	# Search for the reg number, select everything except the record with the reg number then create a temp copy of the records file for safety incase of wrong deletion
	grep -v "^${registration_no}|" "$RECORDS_FILE" > "${RECORDS_FILE}.tmp"
	mv "${RECORDS_FILE}.tmp" "$RECORDS_FILE" # Replace the original file with the temp which now doesnt have the selected record

	echo "Record deleted successfully."

}


view_record() {

	read -p "Registration Number to view: " registration_no
	registration_no=$(validate_registration_number "$registration_no")
	
	if [[ $? -ne 0 ]]; then
		return 1
	fi
	
	# Search for the entered reg number
	student_record=$(grep "^${registration_no}|" "$RECORDS_FILE")
	[[ -z "$student_record" ]] && { echo "Record not found."; return; }

	# Read the record then print it to screen
	IFS='|' read -r registration_no firstname lastname grade <<< "$student_record"
	echo "Registration No: $registration_no"
	echo "First Name     : $firstname"
	echo "Last Name      : $lastname"
	echo "Grade          : $grade"

}


list_records() {

	local count=0
	
	# Check if file in not empty
	[[ ! -s "$RECORDS_FILE" ]] && { echo "No records found."; return; }

	# Read each record, line by line, then print to screen
	while IFS='|' read -r registration_no firstname lastname grade; do
		echo "$registration_no | $firstname $lastname | Grade: $grade"
		((count++))
	done < "$RECORDS_FILE"

	echo "Total records: $count"


}


main() {
	
	# Create file if doesn't exist
	if ! [[ -f "$RECORDS_FILE" ]]; then
		touch "$RECORDS_FILE"
	fi

	while true; do
		echo
		echo "1. Add Record"
		echo "2. Delete Record"
		echo "3. View Record"
		echo "4. List Records"
		echo "5. Exit"
		
		read -p "Choice: " choice

		case "$choice" in
			1) add_record ;;
			2) delete_record ;;
			3) view_record ;;
			4) list_records ;;
			5) echo "Goodbye."; exit 0 ;;
			*) echo "Invalid choice." ;;
		esac
	done

}

main # Run the main function
