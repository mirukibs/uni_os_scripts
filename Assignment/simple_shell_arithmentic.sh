#!/usr/bin/env bash

# This bash script is a program that accepts 2 numbers, processes them then displays their sum, difference, product and quotient.

set -e

# This function is the doorway, it accepts the user's input
accept_numbers() {
	read -p "Number 1: " n1
	read -p "Number 2: " n2
	echo "$n1 $n2"
}

# This function checks the user's input for validity - must be a proper integer
is_integer() {
	local number_1=$1
	local number_2=$2
	[[ $number_1 =~ ^-?[0-9]+$ ]] && [[ $number_2 =~ ^-?[0-9]+$ ]] # Accepts any integer including negatives
}

# Addition logic is encapsulated here
add() {
	local number_1=$1
	local number_2=$2
	echo "$(( number_1 + number_2 ))"
}

# Subtraction logic is encapsulated here
subtract() {
	local number_1=$1
	local number_2=$2
	echo "$(( number_1 - number_2 ))"
}

# Multiplication logic is encapsulated here
multiply() {
	local number_1=$1
	local number_2=$2
	echo "$(( number_1 * number_2 ))"
}

# Division logic is encapsulated here. It also handles division by zero as invalid
divide() {
	local number_1=$1
	local number_2=$2
	
	if ((number_2 == 0)); then
		return 1 # Exit the logic since division by 0 is impossible
	fi
	
	echo "$(( number_1 / number_2 ))"
}

# This main functio orchestrates all the logic and workflow
main() {

	echo "Enter any two integers below. Press ctrl + c to cancel."

	# Ensure the user has multiple opportunities to enter the correct values
	while true; do
		read number_1 number_2 <<< "$(accept_numbers)"

		if is_integer "$number_1" "$number_2"; then
			break # exit the loop if correct values entered
		fi
		
		echo "Error: Enter valid integers."
	done
	
	sum=$(add "$number_1" "$number_2")
	difference=$(subtract "$number_1" "$number_2")
	product=$(multiply "$number_1" "$number_2")
	
	if ! quotient=$(divide "$number_1" "$number_2"); then
		quotient="Error: Cannot divide by 0!"
	fi
	
	echo ""
	echo "Sum = $sum"
	echo "Difference = $difference"
	echo "Product = $product"
	echo "Quotient = $quotient"

}

main # execute the main function
