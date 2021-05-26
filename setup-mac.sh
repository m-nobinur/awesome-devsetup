#!/bin/bash

function setup_mac() {
    # Keeping `sudo` alive
    sudo -v
    while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &
    
    #vscode-insider confirmation
    echo ""
    echo "+---------------------------------------+"
    echo "Do you want to download Vscode Insider with this process? (y/n) "
    echo "+----------------------------------------+"
    echo ""
    read REPLY;
    
    #checking M1 or Intel
    if [[ `uname -m` == 'arm64' ]]; then
        echo ""
        echo "+------------------------+"
        echo "You MacOs is based on Apple M1 Chip"
        echo "+-------------------------+"
        echo ""
        # isntall rosseta 2
        if [[ ! `pkgutil --pkgs | grep Rosetta` ]]; then
            echo ""
            echo "+---------------------------------------+"
            echo "Installing rosseta 2......"
            echo "+----------------------------------------+"
            echo ""
            { # try
             /usr/sbin/softwareupdate --install-rosetta --agree-to-license
            } || 
            { # else
            echo ""
            echo "+-----------------------------------------------+"
            printf "\e[93m%s\e[m\n" "Rosseta 2 didn't install automatically.\nPlease, try manually"
            echo "\033[0m" "+-----------------------------------------------+"
            echo ""
            }
        fi;
    else;
        echo ""
        echo "+---------------------------------------+"
        echo "You MacOs is based on Intel Chip"
        echo "Skipping : rosseta 2 installation"
        echo "+----------------------------------------+"
        echo ""
    fi;

    echo ""
    echo "+---------------------------------------+"
    echo "Hey! we need you. If any prompt arise just read it and confirm it."
    echo "+----------------------------------------+"
    echo ""
    echo "Installing xcode-tools......"
    xcode-select --install
    echo ""
    echo "+---------------------------------------+"
    echo "This script now can automatically do every task. You can get rest 😃"
    printf "If you face any problem while running the script,\nPress ^c (control+c) to stop the script running\n and run the the script again."
    echo "+----------------------------------------+"
    echo ""

    # Install Homebrew if doesn't exist
    if test ! $(which brew); then
        echo ""
        echo "+---------------------------------------+"
        echo "Installing homebrew..."
        echo "+----------------------------------------+"
        echo ""
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    else;
        echo ""
        echo "+---------------------------------------+"
        printf "Skipping: " "\e[93m%s\e[m\n" "Homebrew already exists."
        echo "\033[0m" "+----------------------------------------+"
        echo ""
    fi

    #updating and  upgrading all brew formulae.
    brew update
    brew upgrade --all

    #----------------------------Brew Install---------------------------#
    echo ""
    echo "+---------------------------------------+"
    echo "Installing some important Homebrew formulae."
    echo "This might take a while to complete. Just wait and let it complete."
    echo "+----------------------------------------+"
    echo ""
    #Coreutils: GNU core utilities
    echo "Installing Coreutils....."
    brew install coreutils
    #Tree: for tree structure file and directories.
    echo "Installing Tree....."
    brew install tree
    #Git: for version control.
    echo "Installing Git....."
    brew install git
    #Docker: Pack, ship and run any application as a container.
    echo "Installing Docker....."
    brew install docker
    #Cmatrix: matrix scrolling lines in the terminal
    echo "Installing Cmatrix....."
    brew install cmatrix
    #Node: Javascript Runtime
    echo "Installing node....."
    brew install node
    #Node: Javascript Runtime
    echo "Installing node....."
    brew install node
    #Python3.9: Programming language
    echo "Installing Python3.9"
    brew install python@3.9
    #GCC: C++ GNU compiler
    echo "Installing gcc......"
    brew install gcc
    #Trash: CLI tool that moves files or folder to the trash
    echo "Installing Trash......"
    brew install trash
    #lsd: ls with colorful output, file type icons, and more
    echo "Installing lsd(ls with colorful output)......"
    brew install lsd
    #heroku: Herocu CLI
    echo "Installing heroku......"
    brew tap heroku/brew && brew install heroku
    #yarn: JavaScript package manager
    echo "Installing yarn......"
    brew install yarn
    #mas: mac appstore cli
    echo "Installing mas......"
    brew install mas

    # Install Zsh if doesn't exist
    if test ! $(which zsh); then
        echo ""
        echo "+---------------------+"
        echo "Installing zsh......."
        echo "+---------------------+"
        echo ""
        brew install zsh
    else;
        echo ""
        echo "+---------------------------------------+"
        printf "Skipping: " "\e[93m%s\e[m\n" "zsh already exists."
        echo "+----------------------------------------+"
        echo ""
    fi

    #NeoVim: Vim-fork focused on extensibility and agility
    echo ""
    echo "+-----------------------+"
    echo "Installing NeoVim......"
    echo "+-----------------------+"
    echo ""
    brew install neovim
    #----------------------------Brew Install End---------------------------#
    

    #----------------------------Brew Cask Install---------------------------#
    apps = (
        anaconda
        google-chrome
        iterm2
        vlc
        evernote
        visual-studio-code
        telegram-desktop
        whatsapp
        lastpass
        zoom
        google-drive
    )
    # Install apps to /Applications
    cd ~
    echo ""
    echo "+--------------------------------------+"
    echo "Installing (anaconda, google-chrome, iterm2, vlc,"
    echo "visual-studio-code, whatsapp, zoom and 3 others) apps with Brew Cask......"
    echo "This might take a while to complete."
    echo "+--------------------------------------+"
    echo ""
    brew install --cask --appdir="/Applications" ${apps[@]}

    ##install using mas: apps from appstore.
    #todoist: To-Do List & Tasks; Productivity tool;
    echo ""
    echo "+------------------------+"
    echo "Installing todoist......."
    echo "+------------------------+"
    echo ""
    mas install 585829637
    #CopyClip: Clip-Board History; Productivity tool;
    echo ""
    echo "+-------------------------+"
    echo "Installing copyclip......."
    echo "+-------------------------+"
    echo ""
    mas install 595191960
    #--------------------------Brew Cask Install End-------------------------#

    #----------------------------Brew Install Font---------------------------#
    brew tap homebrew/cask-fonts
    echo ""
    echo "+------------------------------------+"
    echo "Installing coding fonts......."
    echo "(jetbrains-mono, fira-code, victor-mono, meslo-lg)"
    echo "+------------------------------------+"
    echo ""
    brew install --cask font-jetbrains-mono
    brew install --cask font-fira-code
    brew install --cask font-fira-code-nerd-font
    brew install --cask font-victor-mono
    brew install --cask font-meslo-lg
    #brew install --cask font-monoid
    #brew install --cask font-anonymous-pro

    #Donloading some Bangla Fonts on ~/Desktop/Downloaded-Bangla-Fonts
    cd "$HOME/Desktop" && mkdir Downloaded-Bangla-Fonts && cd Downloaded-Bangla-Fonts
    echo ""
    echo "+------------------------------------+"
    echo "Downloading some Bangla fonts......."
    echo "Downloading on ~/Desktop/Downloaded-Bangla-Fonts. Install later if needed."
    echo "+------------------------------------+"
    echo ""
    curl -O https://lipighor.com/download/NiladriNur.zip
    curl -O https://okkhor52.com/download/NotoSansBengali.zip
    curl -O https://okkhor52.com/download/RuposhiBangla.zip
    #----------------------------Brew Install Font End---------------------------#

    #cleaning up all outdated brew formulae
    brew cleanup

    #Downloading apps those are not in Brew at $HOME/Desktop/DownloadedApps # working till June 2021
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        cd "$HOME/Desktop" && mkdir DownloadedApps && cd DownloadedApps
        D_HASH=`curl -s https://code.visualstudio.com/sha/download\?build\=insider\&os\=darwin-arm64 | grep -Eoi https://az764295.vo.msecnd.net/insider/\(.+\)/VSCode-.+.zip | cut -c"40-" | cut -d \/ -f 1`
        echo ""
        echo "+--------------------------------------+"
        echo "Downloading VScode-Insider into > $HOME/Desktop/DownloadedApps ..........."
        echo "Downloading from : https://code.visualstudio.com/insiders/"
        echo "+--------------------------------------+"
        echo ""
        if [[ $D_HASH ]]; then
            if [[ `uname -m` == 'arm64' ]]; then 
                echo ""
                echo "+--------------------------------------+"
                echo "Using link : https://az764295.vo.msecnd.net/insider/$D_HASH/VSCode-darwin-arm64.zip"
                echo "+--------------------------------------+"
                echo ""
                curl -O https://az764295.vo.msecnd.net/insider/$D_HASH/VSCode-darwin-arm64.zip
            else;
                echo ""
                echo "+--------------------------------------+"
                echo "Using link : https://az764295.vo.msecnd.net/insider/$D_HASH/VSCode-darwin.zip"
                echo "+--------------------------------------+"
                echo ""
                curl -O https://az764295.vo.msecnd.net/insider/$D_HASH/VSCode-darwin.zip
            fi;
        else;
            echo ""
            echo "+--------------------------------------+"
            printf "Sorry! We could not install VsCode Insider. Please, go to this link and \ndownload manually https://code.visualstudio.com/insiders/"
            echo "+--------------------------------------+"
            echo ""
        fi;
    fi;

    # Install pipenv for python3
    if test ! $(which python3); then
        pip3 install pipenv
    fi;
    
    ##====> System Settings <====##
    
    # Remove duplicates in the “Open With” menu (also see `lscleanup` alias)
    /System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister -kill -r -domain local -domain system -domain user
    
    # Set highlight color to green
    defaults write NSGlobalDomain AppleHighlightColor -string "0.764700 0.976500 0.568600"
    
    # Restart automatically if the computer freezes
    sudo systemsetup -setrestartfreeze on
    
    # Never go into computer sleep mode
    #sudo systemsetup -setcomputersleep Off > /dev/null

    # Set the computer to sleep after 60 minutes
    #sudo systemsetup -setcomputersleep 60

    # Check for software updates daily, not just once per week
    defaults write com.apple.SoftwareUpdate ScheduleFrequency -int 1

    # Disable smart quotes as they’re annoying when typing code
    defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false

    # Disable smart dashes as they’re annoying when typing code
    defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false

    # Trackpad: enable tap to click for this user and for the login screen
    defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
    defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
    defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1

    # Increase sound quality for Bluetooth headphones/headsets
    defaults write com.apple.BluetoothAudioAgent "Apple Bitpool Min (editable)" -int 40

    # Set a blazingly fast keyboard repeat rate
    defaults write NSGlobalDomain KeyRepeat -int 1
    defaults write NSGlobalDomain InitialKeyRepeat -int 15

    # Disable auto-correct
    defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false

    # Save screenshots to the Pictures/Screenshots
    mkdir ${HOME}/Pictures/Screenshots
    defaults write com.apple.screencapture location -string "${HOME}/Pictures/Screenshots"

    # Save screenshots in PNG format (other options: BMP, GIF, JPG, PDF, TIFF)
    defaults write com.apple.screencapture type -string "png"
   
    # Finder: disable window animations and Get Info animations
    #defaults write com.apple.finder DisableAllAnimations -bool true

    # Show icons for hard drives, servers, and removable media on the desktop
    defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool true
    defaults write com.apple.finder ShowHardDrivesOnDesktop -bool true
    defaults write com.apple.finder ShowMountedServersOnDesktop -bool true
    defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool true

    # Finder: show all filename extensions
    defaults write NSGlobalDomain AppleShowAllExtensions -bool true

    # Finder: allow text selection in Quick Look
    defaults write com.apple.finder QLEnableTextSelection -bool true

    # Automatically open a new Finder window when a volume is mounted
    defaults write com.apple.frameworks.diskimages auto-open-ro-root -bool true
    defaults write com.apple.frameworks.diskimages auto-open-rw-root -bool true
    defaults write com.apple.finder OpenWindowForNewRemovableDisk -bool true

    # Disable the warning before emptying the Trash
    defaults write com.apple.finder WarnOnEmptyTrash -bool false

    # Empty Trash securely by default
    defaults write com.apple.finder EmptyTrashSecurely -bool true
    
    # Show the ~/Library folder
    chflags nohidden ~/Library

    # Enable highlight hover effect for the grid view of a stack (Dock)
    defaults write com.apple.dock mouse-over-hilite-stack -bool true

    # Don’t animate opening applications from the Dock
    defaults write com.apple.dock launchanim -bool false

    # Enable Safari’s debug menu
    defaults write com.apple.Safari IncludeInternalDebugMenu -bool true
    
    # Enable the Develop menu and the Web Inspector in Safari
    defaults write com.apple.Safari IncludeDevelopMenu -bool true
    defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool true
    defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled -bool true

    # Don’t display the annoying prompt when quitting iTerm
    defaults write com.googlecode.iterm2 PromptOnQuit -bool false

    # Enable the WebKit Developer Tools in the Mac App Store
    defaults write com.apple.appstore WebKitDeveloperExtras -bool true

    # Enable Debug Menu in the Mac App Store
    defaults write com.apple.appstore ShowDebugMenu -bool true

    # Disable continuous spell checking
    defaults write com.apple.messageshelper.MessageController SOInputLineSettings -dict-add "continuousSpellCheckingEnabled" -bool false

}

# Starting the setup process
echo ""
echo "+-----------------------------------------+"
echo "Starting OSX setup........"
echo "MacOs : This script may overwrite some of existing files and settings"
echo "+---------------------------------------+"
# ping before running the script
if [ -f /System/Library/Sounds/Ping.aiff ]; then
    afplay /System/Library/Sounds/Ping.aiff -v 60
fi;
echo ""
echo "+-----------------------------------------+"
echo "Your OSX setup has been started...."
echo "If any error occurs just stop the process and run the script again."
echo "+---------------------------------------+"
echo ""

#running the setup
setup_mac

echo ""
echo "+----------------------------+"
echo "\e[0;32m" "+ ✅ MacOS Setup Complete. +"
echo "\033[0m" "+----------------------------+"
echo ""
# play sound when done
if [ -f /System/Library/Sounds/Blow.aiff ]; then
    afplay /System/Library/Sounds/Blow.aiff -v 60
fi;

unset setup_mac;