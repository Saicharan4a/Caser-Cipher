#!/bin/bash

caesar_cipher() {
    local shift=$1
    local input=$2
    local mode=$3
    result=""

    for (( i=0; i<${#input}; i++ )); do
        char="${input:$i:1}"

        if [[ "$char" =~ [a-zA-Z] ]]; then
            ascii=$(printf "%d" "'$char")

            if [[ "$char" =~ [A-Z] ]]; then
                base=65
            else
                base=97
            fi

            if [[ "$mode" == "encode" ]]; then
                new_ascii=$(( (ascii - base + shift) % 26 + base ))
            else
                new_ascii=$(( (ascii - base - shift + 26) % 26 + base ))
            fi

            result+=$(printf \\$(printf '%03o' $new_ascii))
        else
            result+="$char"
        fi
    done

    echo "$result"
}

read -p "Enter the text to encode/decode: " text
read -p "Enter the shift value: " shift
read -p "Choose mode (encode/decode): " mode

caesar_cipher $shift "$text" $mode
