#!/usr/bin/env bash

declare -i index
declare reverse_string

for ((index = ${#1}; index >= 0; index--)); do
  reverse_string+=${1:index:1}
done

printf "%s\n" "$reverse_string"