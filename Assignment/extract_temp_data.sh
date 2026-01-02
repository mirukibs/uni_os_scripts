#!/usr/bin/env bash

# This scripts downloads the Tanzanian temperature change dataset from the global Berkey Earth dataset

if ! curl -O https://berkeley-earth-temperature.s3.us-west-1.amazonaws.com/Regional/TAVG/tanzania-TAVG-Trend.txt; then
	echo "Error: Couldn't complete the download."
	exit 1
fi

echo "Download successful!"
