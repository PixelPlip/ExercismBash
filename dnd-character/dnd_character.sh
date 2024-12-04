#!/usr/bin/env bash

modifier() {
	echo $(($1 / 2 - 5))
}

best_of_four_dice() {
	local -i lowest=10
	local -i total=0
	for _ in {1..4}; do
		((roll = (RANDOM % 6) + 1))
		((roll < lowest && (lowest = roll)))
		((total += roll))
	done
	((total -= lowest))
	echo "$total"
}

generate_character() {
	con=$(best_of_four_dice)
	echo "strength $(best_of_four_dice)"
	echo "dexterity $(best_of_four_dice)"
	echo "constitution $con"
	echo "intelligence $(best_of_four_dice)"
	echo "wisdom $(best_of_four_dice)"
	echo "charisma $(best_of_four_dice)"
	echo "hitpoints $(( 10 + $(modifier $con)))"
}

### Verifies that the ability score is a valid integer and
### within the range: 1 <= score <= 30
verify_ability_score() {
	if ! [[ $1 =~ ^([1-9]|[12][0-9]|30)$ ]]; then
		echo "Usage: Second param must be an integer between 1 and 30"
		exit 1;
	fi
}

main() {
	case "$1" in
		modifier)
			verify_ability_score "$2"
			modifier "$2" ;;

		generate)
			generate_character ;;

		*)
			echo -n "Unknown argument"
			exit 1 ;;
	esac
}

main "$@"
