#!/bin/bash

function setup_mac() {
    # Keeping `sudo` alive
    sudo -v
    while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &
    
    . ./lib/.pretty_func.sh
    
    #checking M1 or Intel
    if [[ `uname -m` == 'arm64' ]]; then
        pretty_echo "You MacOs is based on Apple M1 Chip" $GREEN
        
        # isntall rosseta 2
        if [[ ! `pkgutil --pkgs | grep Rosetta` ]]; then
            pretty_echo "Installing rosseta 2......"
            { # try
                /usr/sbin/softwareupdate --install-rosetta --agree-to-license
            } || 
            { # else
                color_echo "Rosseta 2 didn't install automatically." $YELLOW
                color_echo "Please, try manually." $YELLOW
            }
        else
           pretty_echo "Rosseta 2 is already installed." $GREEN
        fi;
    else
        pretty_echo "You MacOs is based on Intel Chip" $GREEN
        pretty_echo "Skipping : rosseta 2 installation" $YELLOW
    fi;

    pretty_echo "If any prompt arise just read it and confirm it." $YELLOW
    color_echo "==> If you face any problem while running the script, "
    color_echo "    press ^c (control+c) to stop the script running"
    color_echo "    and run the the script again." 
    echo ""
    
    ## Install Tools, Apps and Utilities ##
    # Install xcode
    if test ! $(which xcode-select); then
        pretty_echo "Installing xcode-tools......"
        xcode-select --install
    else
        pretty_echo "Skipping: xcode already exists." $YELLOW
    fi;
    
    # Install Homebrew if doesn't exist
    if test ! $(which brew); then
        pretty_echo "Installing homebrew..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    else
        pretty_echo "Skipping: Homebrew already exists." $YELLOW
    fi;

    # cd into script's absolute directory
    ABSPATH=$(greadlink -f $0)
    ABSDIR=$(dirname $ABSPATH)
    cd $ABSDIR

    #--------------- Installing Brew Formulaes from ./os/utilities.sh -----------------#
    color_echo "Installing Homebrew formulaes from './os/utilities.sh'"
    color_echo "This might take a while to complete." $YELLOW
    echo ""
    . ./os/utilities.sh

    brew install ${utils[@]}
    pretty_echo "✅ Utilities installation complete." $GREEN

    #-------------- Installing Fonts ----------------#
    brew tap homebrew/cask-fonts
    pretty_echo "Installing fonts from './os/utilities.sh' "
    brew install --cask ${fonts[@]}
    pretty_echo "✅ Fonts installation complete." $GREEN

    #--------------- Installing Brew Cask Formulaes from ./os/applications.sh -----------------#
    . ./os/applications.sh
    color_echo "Installing Apps from './os/applications.sh'."
    color_echo "This might take a while to complete."
    echo ""
    brew install --cask --appdir="/Applications" ${apps[@]}
    pretty_echo "✅ Applications installation complete." $GREEN
    
    ##install apps using mas: apps from appstore not available in brew formulaes
    for app in $mas_apps;do
        mas install $app
    done

    # Install pipenv for python3
    if test $(which python3); then
        if test ! $(which pipenv); then
            pretty_echo "Installing pipenv....."
            pip3 install pipenv
        else
            pretty_echo "==> pipenv is already installed." $GREEN
        fi;
    fi;
    
    #---------- Updating System Settings -----------#
    pretty_echo "Updating Os default settings..." $YELLOW
    chmod +x ./os/system_settings.sh
    ./os/system_settings.sh
}

#---------- Starting the setup process -----------#
# ping before running the script
if [ -f /System/Library/Sounds/Ping.aiff ]; then
    afplay /System/Library/Sounds/Ping.aiff -v 60
fi;

pretty_echo "⚙️ Starting OSX setup........"
color_echo "🖍 This script may overwrite some " $RED
color_echo "of your default settings" $RED
echo ""
pretty_echo "Your OSX setup has been started...." $GREEN
color_echo "If any error occurs just stop the "
color_echo "process and run the script again." $YELLOW
echo ""

#running the setup
setup_mac

if [ -f /System/Library/Sounds/Blow.aiff ]; then
    afplay /System/Library/Sounds/Blow.aiff -v 60
fi;
pretty_echo "+ ✅ MacOS Setup Complete. +" $GREEN

unset setup_mac;