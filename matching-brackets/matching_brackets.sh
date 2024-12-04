#!/usr/bin/env bash

derive_enclosures() {
  printf "%s\n" "${1//[!\{\}\(\)\[\]]/}"
}

main() {
  local -a opening_stack
  local enclosures
  enclosures=$(derive_enclosures "$1")

  while read -r -n 1 character; do
    case "${character}" in
      "{" | "[" | "(") opening_stack+=("${character}") ;; # Push to stack

      "}" | "]" | ")")
        [[ -z "${opening_stack[*]}" ]] && { printf "%s\n" "false"; return; }

        case "${opening_stack[-1]}${character}" in
          "{}" | "[]" | "()") unset "opening_stack[-1]" ;; # Pop on matching pair

          *) printf "%s\n" "false"; return ;;
        esac
      ;;
    esac
  done <<<"$enclosures"

  if [[ ${#opening_stack[@]} -eq 0 ]]; then printf "%s\n" "true"; else printf "%s\n" "false"; fi
}

main "$@"
