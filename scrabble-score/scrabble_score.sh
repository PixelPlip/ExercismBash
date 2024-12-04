#!/usr/bin/env bash

declare -A letterScoringMap

initialize_letter_scores() {
	letterScoringMap["A"]=1
	letterScoringMap["E"]=1
	letterScoringMap["I"]=1
	letterScoringMap["O"]=1
	letterScoringMap["U"]=1
	letterScoringMap["L"]=1
	letterScoringMap["N"]=1
	letterScoringMap["R"]=1
	letterScoringMap["S"]=1
	letterScoringMap["T"]=1

	letterScoringMap["D"]=2
	letterScoringMap["G"]=2

	letterScoringMap["B"]=3
	letterScoringMap["C"]=3
	letterScoringMap["M"]=3
	letterScoringMap["P"]=3

	letterScoringMap["F"]=4
	letterScoringMap["H"]=4
	letterScoringMap["V"]=4
	letterScoringMap["W"]=4
	letterScoringMap["Y"]=4

	letterScoringMap["K"]=5

	letterScoringMap["J"]=8
	letterScoringMap["X"]=8

	letterScoringMap["Q"]=10
	letterScoringMap["Z"]=10
}

clean_word() {
	word="${*//[^a-zA-Z]/}"
	echo "${word^^}"
}

main() {
	initialize_letter_scores

	word=$(clean_word "$1")

	local -i score=0
	for ((i = 0; i < ${#word}; i++)); do
		letter=${word:i:1}
		((score += ${letterScoringMap[$letter]}))
	done

	echo "$score"
}

main "$@"
