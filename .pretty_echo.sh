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

export color_echo
export pretty_echo