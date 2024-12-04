#!/usr/bin/env bash

check_if_armstrong_number() {
	local -i total
	local -i digits=${#1}
	for ((index = 0; index < digits; index++)); do
		((total += ${1:index:1} ** digits))
	done
	((total == $1))
}

validate_integer() {
	if ! [[ "$1" =~ ^[0-9]+$ ]]; then
		echo "Usage: Param needs to be a positive integer"
		return 1;
	fi
}

main() {
	validate_integer "$1" || return 1
	if check_if_armstrong_number "$1"; then echo "true"; else echo "false"; fi
}

main "$@"
