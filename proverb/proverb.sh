#!/usr/bin/env bash

if (("$#" >= 1)); then
  words=("$@")
  for ((index = 1; index < "$#"; index++)); do
    printf "%s\n" "For want of a ${words[index-1]} the ${words[index]} was lost."
  done
  printf "%s\n" "And all for the want of a $1."
fi
