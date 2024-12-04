#!/usr/bin/env bash

build_action_string() {
  local -a actions=("$@")
  local -i number_of_actions="${#actions[@]}"
  for ((i = 0; i < number_of_actions; i++)); do
    action_string+="${actions[i]}"
    ((i + 1 != number_of_actions)) && action_string+=","
  done
  echo "$action_string"
}

build_reverse_action_string() {
  local -a actions=("$@")
  local -i number_of_actions="${#actions[@]}"
  for ((i = 1; i <= number_of_actions; i++)); do
    action_string+="${actions[number_of_actions - i]}"
    ((i != number_of_actions)) && action_string+=","
  done
  echo "$action_string"
}
main() {
  (("$1" >= 1 && "$1" <= 31)) || return 0

  local -a actions
  (($1 & 2#00001)) && actions+=('wink')
  (($1 & 2#00010)) && actions+=('double blink')
  (($1 & 2#00100)) && actions+=('close your eyes')
  (($1 & 2#01000)) && actions+=('jump')

  if (($1 & 2#10000)); then
    action_string="$(build_reverse_action_string "${actions[@]}")"
  else
    action_string="$(build_action_string "${actions[@]}")"
  fi
  echo "$action_string"
}

main "$@"