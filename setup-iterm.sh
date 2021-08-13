#!/bin/bash

. ./lib/.pretty_func.sh

function setup_iterm(){
    
    check_brew_exist

    # Install Alacrity if doesn't exists
    if [ ! -e "/Applications/iTerm.app/" ];then
        pretty_echo "==> Installing iTerm2..."
        brew install --cask --appdir="/Applications" iterm2
    else
        color_echo "✔ iterm2 is installed." $GREEN
        echo
    fi;

    # Install fonts
    if test ! $(brew list | grep "font-fira-code-nerd-font");then
        brew tap homebrew/cask-fonts
        brew install --cask font-fira-code-nerd-font
    else
        color_echo "✔ fira-code-nerd-font is already installed." $GREEN
        echo
    fi;

    if test ! $(brew list | grep "font-victor-mono");then
        brew tap homebrew/cask-fonts
        brew install --cask font-victor-mono
    else
        color_echo "✔ font-victor-mono is already installed." $GREEN
        echo
    fi;
}

# ping before running the script
if [ -f /System/Library/Sounds/Ping.aiff ]; then
    afplay /System/Library/Sounds/Ping.aiff -v 60
fi;
# confirmation to procceed.
color_echo "🤏🏼 Iterm setup need some manual help " $YELLOW
color_echo "👨🏽‍🦯 You will be guided what to do in the end of the setup."
echo

#running the setup
setup_iterm

unset setup_iterm;