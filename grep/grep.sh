#!/usr/bin/env bash

declare prepend_line_number=0
declare output_filenames=0
declare invert_matches=0
declare full_match_only=0

set_arg_flags() {
  while getopts nlivx flag; do
      case $flag in
          n) prepend_line_number=1 ;;
          l) output_filenames=1 ;;
          i) shopt -s nocasematch ;;
          v) invert_matches=1 ;;
          x) full_match_only=1 ;;
          ?) printf "%s\n" "Usage: PROGRAM [-n] [-l] [-i] [-v] [-x] <file>..." >&2; return 1 ;;
      esac
  done
}

main() {
    local pattern file
    local -i line_number line_match

    set_arg_flags "$@" || return 1
    shift $((OPTIND - 1)) # Remove parsed flags from the arglist
    pattern="$1" && shift # Pop the first argument, remaining arguments is now only file references
    ((full_match_only)) && pattern="^${pattern}$"

    for file in "$@"; do
        ((line_number=1))
        while read -r line; do

            line_match=$([[ "${line}" =~ ${pattern} ]] && echo 1 || echo 0)

            if ((invert_matches != line_match)); then

                if ((output_filenames)); then
                    printf "%s\n" "${file}"
                    break
                else
                    (($# > 1)) && printf "%s" "${file}:"
                    ((prepend_line_number)) && printf "%s" "${line_number}:"
                    printf "%s\n" "${line}"
                fi
            fi
            ((line_number++))
        done<"${file}"
    done
}

main "$@"
