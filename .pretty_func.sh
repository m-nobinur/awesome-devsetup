#!/bin/bash

# color variables
export NO_COLOR="\033[0m"
export BLUE="\e[1;34m"
export GREEN="\e[1;32m"
export RED="\e[1;31m"
export YELLOW="\e[1;33m"

# print message with color : pretty_echo <Message> <Color>
function pretty_echo(){
    echo "+---------------------------------------+"
    printf "${2:-$BLUE}"
    echo $1
    printf $NO_COLOR
    echo "+----------------------------------------+"
    echo ""
}

function color_echo(){
    printf "${2:-$BLUE}"
    echo $1
    printf $NO_COLOR
}

#append @arg to ~/.zshrc
append_to_zshrc() {
    local text="$1" zshrc
    local skip_new_line="${2:-0}"

    if [ -w "$HOME/.zshrc.local" ]; then
        zshrc="$HOME/.zshrc.local"
    else
        zshrc="$HOME/.zshrc"
    fi;

    if ! grep -Fqs "$text" "$zshrc"; then
        if [ "$skip_new_line" -eq 1 ]; then
            printf "%s\\n" "$text" >> "$zshrc"
        else
            printf "\\n%s\\n" "$text" >> "$zshrc"
        fi;
    fi;
}

export color_echo
export pretty_echo

