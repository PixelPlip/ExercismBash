#!/usr/bin/env bash

readonly INNER_CIRCLE_RADIUS=1.0
readonly MIDDLE_CIRCLE_RADIUS=5.0
readonly OUTER_CIRCLE_RADIUS=10.0
readonly DECIMAL_REGEX="^-?[0-9]+([.][0-9]+)?$"

if ! [[ "$1" =~ $DECIMAL_REGEX && "$2" =~ $DECIMAL_REGEX ]]; then
  printf "%s\n" "Error: invalid arguments" >&2
  exit 1
fi

distance=$(bc <<<"scale=2; sqrt(($1^2 + $2^2))")

if (($(bc <<<"$distance >= 0 && $distance <= $INNER_CIRCLE_RADIUS"))); then
  score=10
elif (($(bc <<<"$distance >= $INNER_CIRCLE_RADIUS && $distance <= $MIDDLE_CIRCLE_RADIUS"))); then
  score=5
elif (($(bc <<<"$distance >= $MIDDLE_CIRCLE_RADIUS && $distance <= $OUTER_CIRCLE_RADIUS"))); then
  score=1
else
  score=0
fi

printf "%d\n" "${score}"
