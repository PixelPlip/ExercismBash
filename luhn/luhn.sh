#!/usr/bin/env bash

valid_luhn_number() {
	if ! [[ "$1" =~ ^[0-9]{2,}$ ]]; then
		return 1
	fi
}

luhn_check() {
	local number="${*// /}"
	valid_luhn_number "${number}" || return 1

	local -i total=0
	local -i digit=0
	local -i length=${#number}

	for ((from_end = 1; from_end <= length; from_end++)); do
		((digit = ${number:length-from_end:1}))
		if (((from_end % 2) == 0)); then
			((digit *= 2))
			((digit >= 10)) && ((digit -= 9))
		fi
		((total += digit))
	done

	((total % 10 == 0))
}

if luhn_check "$@"; then echo "true"; else echo "false"; fi
