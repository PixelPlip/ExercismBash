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
    return 1
  fi
}

remove_zero_prefix() {
  local trimmed
  if [[ "${1:0:1}" == "0" ]]; then
    trimmed=${resistor_value:1:${#resistor_value}}
  fi
  printf "%s\n" "${trimmed:-$1}"
}

print_with_prefix() {
  local trailing_zeroes prefix value
  trailing_zeroes=${*//[!0]/}
  case "${#trailing_zeroes}" in
    "3" | "4" | "5")
      prefix="kilo"
      value="${1:: -3}"
      ;;
    "6" | "7" | "8")
      prefix="mega"
      value="${1:: -6}"
      ;;
    "9")
      prefix="giga"
      value="${1:: -9}"
      ;;
  esac
  printf "%s\n" "${value:-$1} ${prefix}ohms"
}

main () {
  verify_color_exists "$1" || return 1
  verify_color_exists "$2" || return 1
  verify_color_exists "$3" || return 1

  local resistor_value
  resistor_value=${color_values["$1"]}${color_values["$2"]}
  resistor_value=$(remove_zero_prefix "${resistor_value}")
  ((resistor_value *= 10 ** ${color_values["$3"]}))

  print_with_prefix "${resistor_value}"
}

main "$@"