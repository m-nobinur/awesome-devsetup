#!/bin/bash

. ./lib/.pretty_func.sh
. ./vscode/extentions.sh

function setup_vs_code() {
    
    if [ -e "/Applications/Visual Studio Code.app" ]; then
        if test ! $(which code); then
            if [[ ! -f ~/.config/.zprofile || ! -f ~/.zprofile ]]; then
                mkdir -p ~/.config && touch ~/.config/.zprofile
                ln -s ~/.config/.zprofile ~/.zprofile               
            fi;
            #Adding VSCode to Path
            pretty_echo "Installing 'code' command in the path"
            cat << EOF >> ~/.zprofile

# Add Visual Studio Code (code)
export PATH="\$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"
EOF
        else
            color_echo "✓ 'code' command is already installed in path" $GREEN
            echo
        fi;

        #install all extentions from the extentions list.
        color_echo "==> Installing all vscode extentions from 'vscode/extentions.sh'"
        echo
        code --install-extension ${extentions[@]}

        #Update user settings
        if [ ! -d "$(brew --prefix coreutils)" ]; then
            brew install coreutils
        fi;

        # Install fonts if not already installed.
        if test ! $(brew list | grep "font-fira-code-nerd-font");then
            brew tap homebrew/cask-fonts
            brew install --cask font-fira-code-nerd-font
        else
            color_echo "✔ fira-code-nerd-font is installed." $GREEN
            echo
        fi;

        if test ! $(brew list | grep "font-victor-mono");then
            brew tap homebrew/cask-fonts
            brew install --cask font-victor-mono
        else
            color_echo "✔ font-victor-mono is installed." $GREEN
            echo
        fi;

        #script's absolute directory
        ABSPATH=$(greadlink -f $0)
        ABSDIR=$(dirname $ABSPATH)
        cd $ABSDIR
        color_echo "Updating User Settings, Keybindings and Snippets." $YELLOW
        color_echo "This might overwrite existing user settings." $YELLOW
        echo
        #loading user settings
        USER_PATH="$HOME/Library/Application Support/Code/User"
        cp ./vscode/vscode_user_settings.json  "$USER_PATH/settings.json"
        #loading user keybindings
        cp ./vscode/vscode_keybindings.json  "$USER_PATH/keybindings.json"
        ## loading user snippets
        mkdir -p "$USER_PATH/snippets"
        cp ./vscode/snippets/*  "$USER_PATH/snippets"
    else
        color_echo "You don't have Vs-Code installed in your system." $RED
        pretty_echo "Installing VS Code......."
        brew install --cask --appdir="/Applications" visual-studio-code
        color_echo "✓ VS Code is now installed."
    fi;
}

# confirmation to procceed.
color_echo "Starting Vs Code setup..."
color_echo "This script may overwrite some of existing files on \"~/Library/Application Support/Code/User/\"" $YELLOW
echo
# ping before running the script
if [ -f /System/Library/Sounds/Ping.aiff ]; then
    afplay /System/Library/Sounds/Ping.aiff -v 60
fi;

#running the setup
pretty_echo "⚙️ Setting up VS Code....."
setup_vs_code

pretty_echo " ✅ VS Code Setup Complete. "
# play sound when done
if [ -f /System/Library/Sounds/Blow.aiff ]; then
    afplay /System/Library/Sounds/Blow.aiff -v 60
fi;

unset setup_vs_code;