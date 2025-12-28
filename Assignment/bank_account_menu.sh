#!/usr/bin/env bash

# This is a script for a shell program that mimics a bank account menu

# How it works:
# 1. The user rans the script ./bank_account_menu.sh
# 2. The terminal displays a list of services offered by the bank (withdraw, deposit and check balance) which the user can choose from.
# 3. If the user picks withdrawing, they'll be prompted to enter an amount. They will then receive a success message and the script will terminate
# 4. If the user picks deposit, they'll be prompted to enter an amount. They will then receive a success message and the script will terminate
# 5. If the user picks check balance, they'll receive a message displaying an account balance and the script will terminate

set -e

echo "Welcome To Bash Bank!"

echo "1. Withdraw"
echo "2. Deposit"
echo "3. Check Balance"
echo ""

account_balance=$((1000000))

read -p "Please Choose Your Prefered Service (1-3): " prefered_bank_service

case $prefered_bank_service in

	1)
		read -p "Enter amount:" amount
		amount=$((amount))
		
		if ! [[ "$amount" -le "$account_balance" ]]; then
			echo "Error: Insufficient Balance"
			exit 1
		fi
		
		echo "Withdrawing. Please wait..."
		sleep 3
		echo "Withdrawal successful!"
		
		exit 0
		
		;;

	2)
		read -p "Enter amount:" amount
		amount=$((amount))
		upper_limit=$((1000000000))
		lower_limit=$((10000))
		
		if [[ "$amount" -lt "$lower_limit" ]]; then
			echo "Error: Deposit cannot be less than $lower_limit"
			exit 3
		fi
		
		if [[ "$amount" -gt "$upper_limit" ]]; then
			echo "Error: Deposit cannot be greater that $upper_limit"
			exit 4
		fi
		
		echo "Please wait..."
		sleep 1
		echo "Deposit successful!"
		
		exit 0
		
		;;
	
	3)
		echo "Current Balance: $account_balance"
		
		exit 0
		
		;;
		
	*)
		echo "Invalid option. Please choose 1, 2, or 3."
		exit 5
		
		;;

esac
