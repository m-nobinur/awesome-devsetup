#!/bin/bash

. ./lib/.pretty_func.sh

# Install Homebrew if doesn't exist
if test ! $(which brew); then
    color_echo "==> Installing homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
    color_echo "✔ Homebrew is installed." $GREEN
    echo ""
fi;

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