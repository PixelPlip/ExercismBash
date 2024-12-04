#!/usr/bin/env bash

declare -A color_values

color_values["black"]=0
color_values["brown"]=1
color_values["red"]=2
color_values["orange"]=3
color_values["yellow"]=4
color_values["green"]=5
color_values["blue"]=6
color_values["violet"]=7
color_values["grey"]=8
color_values["white"]=9

verify_color_exists() {
  if ! [[ -v color_values["$1"] ]]; then
    echo "invalid color"
    return  1
  fi
}

remove_zero_prefix() {
  if [[ "${1:0:1}" -eq "0" ]]; then
    trimmed=${resistor_value:1:${#resistor_value}}
  fi
  echo "${trimmed:-$1}"
}

main () {
  verify_color_exists "$1" || return 1
  verify_color_exists "$2" || return 1

  resistor_value=${color_values["$1"]}${color_values["$2"]}

  remove_zero_prefix $resistor_value
}

main "$@"