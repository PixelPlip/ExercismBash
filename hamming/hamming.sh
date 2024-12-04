#!/usr/bin/env bash

failWithMessage() {
	echo "$1"
	exit 1
}

if [[ $# -ne 2 ]]; then
	failWithMessage "Usage: hamming.sh <string1> <string2>" 
fi

if [[ $1 == "$2" ]]; then
	echo "0"
	exit 0
fi

first=$1
second=$2

if [[ ${#first} -ne ${#second} ]]; then
	failWithMessage "strands must be of equal length"
fi

for ((i = 0; i < ${#first}; i++)); do
	if [[ ${first:i:1} != "${second:i:1}" ]]; then
		((faults++))
	fi
done

echo "$faults"

