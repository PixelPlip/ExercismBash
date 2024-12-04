#!/usr/bin/env bash

for l in {A..Z}; do
	if [[ "${1^^}" != *"$l"* ]]; then printf "%s\n" "false"; exit; fi
done
printf "%s\n" "true"
