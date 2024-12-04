#!/usr/bin/env bash

readonly a_ASCII=97
readonly z_ASCII=122
readonly CHUNK_SIZE=5

clean_space_and_punctuation() {
    local cleaned="${*//[^a-zA-Z0-9]/}"
    printf "%s" "${cleaned,,}"
}

char_to_ascii() {
    printf "%d" "'$1"
}

ascii_to_char() {
    local char
    printf -v char '\\%03o' "$1"
    printf "%b" "${char}"
}

remove_trailing_space() {
    printf "%s\n" "${1% }"
}

print_chunks() {
    local chunk
    local -a chunks
    while read -r -n $CHUNK_SIZE chunk; do
        chunks+=("${chunk}")
    done
    remove_trailing_space "${chunks[*]}"
}

symetric_atbash() {
    local input char atbash_string
    local -i ascii pos
    input=$(clean_space_and_punctuation "$1")
    for ((pos = 0; pos < ${#input}; pos++)); do
        char=${input:pos:1}
        if [[ $char =~ ^[a-z]$ ]]; then
            ascii=$(char_to_ascii "${char}")
            char=$(ascii_to_char "$((z_ASCII - (ascii - a_ASCII)))")
        fi
        atbash_string+=${char}
    done
    printf "%s\n" "${atbash_string}"
}

main() {
    case "$1" in
    encode) symetric_atbash "$2" | print_chunks ;; 

    decode) symetric_atbash "$2" ;; 

    *) printf "%s\n" "Usage: unknown argument" >&2 ;; 
    esac
}

main "$@"