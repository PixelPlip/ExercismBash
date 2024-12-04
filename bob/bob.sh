#!/usr/bin/env bash

readonly SILENCE_PATTERN="^\s*$"
readonly SILENCE_RESPONSE="Fine. Be that way!"

readonly YELL_PATTERN="^[^a-z]*[A-Z][^a-z]*$"
readonly YELL_RESPONSE="Whoa, chill out!"

readonly QUESTION_PATTERN=".*\?$"
readonly QUESTION_RESPONSE="Sure."

readonly YELL_QUESTION_RESPONSE="Calm down, I know what I'm doing!"

readonly DEFAULT_RESPONSE="Whatever."

trim() {
	echo "$1" | awk '{$1=$1};1'
}

main() {
	input=$(trim "$1")
	
	if [[ "$input" =~ $SILENCE_PATTERN ]]; then
		echo "$SILENCE_RESPONSE"

	elif [[ "$input" =~ $YELL_PATTERN && "$input" =~ $QUESTION_PATTERN ]]; then
		echo "$YELL_QUESTION_RESPONSE"

	elif [[ "$input" =~ $YELL_PATTERN ]]; then
		echo "$YELL_RESPONSE"

	elif [[ "$input" =~ $QUESTION_PATTERN ]]; then
		echo "$QUESTION_RESPONSE"

	else
		echo "$DEFAULT_RESPONSE"

	fi
}

main "$@"
