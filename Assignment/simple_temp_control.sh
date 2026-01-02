#!/usr/bin/env bash

# This script simulates a check on temperature check. It raises a warning if the change is greater than 1 degree C.

TEMP_CHANGE=$1
THRESHOLD=1.0

# Check if input is provided
if [ -z "$TEMP_CHANGE" ]; then
	echo "Usage: $0 <temperature_change>"
	exit 1
fi

# Get absolute value (treat as positive change) using bc for bash decimal arithmentics
ABS_CHANGE=$(echo "if ($TEMP_CHANGE < 0) -($TEMP_CHANGE) else $TEMP_CHANGE" | bc)

# Compare the change to the threshold
if [ "$(echo "$ABS_CHANGE > $THRESHOLD" | bc)" -eq 1 ]; then # if change is > threshold then trigger warning, else acceptable
	echo "WARNING: Temperature change exceeded 1.0 (change = $TEMP_CHANGE)"
else
	echo "Temperature change is within safe range (change = $TEMP_CHANGE)"
fi

