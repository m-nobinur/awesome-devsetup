#!/bin/bash

. ./lib/.pretty_func.sh

function setup_alacritty(){
    
    check_brew_exist

    # Install Alacrity if doesn't exists
    if test ! $(which alacritty); then
        pretty_echo "==> Installing Alacritty..."
        brew install --cask --appdir="/Applications" alacritty
    else
        color_echo "✔ Alacritty is installed." $GREEN
        echo ""
    fi;

    # Install fonts
    if test ! $(brew list | grep "font-fira-code-nerd-font");then
        brew tap homebrew/cask-fonts
        brew install --cask font-fira-code-nerd-font
    else
        color_echo "✔ fira-code-nerd-font is already installed." $GREEN
        echo ""
    fi;

    if test ! $(brew list | grep "font-victor-mono");then
        brew tap homebrew/cask-fonts
        brew install --cask font-victor-mono
    else
        color_echo "✔ font-victor-mono is already installed." $GREEN
        echo ""
    fi;

    # setting up Alacritty
    mkdir -p ~/.config/alacritty

    ABSPATH=$(greadlink -f $0)
    ABSDIR=$(dirname $ABSPATH)
    cd $ABSDIR

    color_echo "==> Loading alacritty.yml from dotfiles to ~/.config/alacritty/alacritty.yml" $YELLOW
    cp ./shell/alacritty.yml ~/.config/alacritty/alacritty.yml
}

# confirmation to procceed.
color_echo "⚙️ Starting Alacritty setup....." $GREEN
echo
# ping before running the script
if [ -f /System/Library/Sounds/Ping.aiff ]; then
    afplay /System/Library/Sounds/Ping.aiff -v 60
fi;

#running the setup
setup_alacritty

pretty_echo " ✅ Alacritty Setup Complete. "
# play sound when done
if [ -f /System/Library/Sounds/Blow.aiff ]; then
    afplay /System/Library/Sounds/Blow.aiff -v 60
fi;

unset setup_alacritty;