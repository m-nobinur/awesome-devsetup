#!/bin/bash
#
##################################################
#              Author: NOBIN KHAN                #
#              File  : ./zsh-setup.sh            #
#              Date  : 23 May 2021               #
##################################################
#

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

#setting up zshell with themes and plugins
function setup_zsh() {
    # Keeping `sudo` alive
    sudo -v
    while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

    # Install Zsh if doesn't exist
    if test ! $(which zsh); then
        echo "+---------------------+"
        printf "\e[92m%s\e[m\n" "Installing zsh......."
        echo "\033[0m" "+---------------------+"
        echo ""
        case $(uname | tr '[:upper:]' '[:lower:]') in
            linux*)
                sudo apt install zsh
            ;;  
            darwin*)
                brew install zsh
            ;;
        esac;
    fi;

    echo ""
    echo "+-------------------------------+"
    printf "\e[92m%s\e[m\n" "+ Installing Oh My Zsh......."
    echo "\033[0m" "+-------------------------------+"
    echo ""
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

    #=====> Install Zsh Plugins via Oh My Zsh <=====#
    # 🖍 zsh-syntax-highlighting: Fish shell-like syntax highlighting for Zsh.
    echo ""
    echo "+-------------------------------+"
    printf "\e[92m%s\e[m\n" "+ Installing zsh-syntax-highlighting......."
    echo "\033[0m" "+-------------------------------+"
    echo ""
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
    
    # 🔎 zsh-autosuggestions: Suggests commands as you type based on history and completions.
    echo ""
    echo "+-------------------------------+"
    printf "\e[92m%s\e[m\n" "+ Installing zsh-autosuggestions......."
    echo "\033[0m" "+-------------------------------+"
    echo ""
    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
    
    # 🔄 Autojump - a faster way to navigate filesystem.
    cd $HOME && mkdir ZshPlug && cd ZshPlug
    git clone git://github.com/wting/autojump.git
    cd autojump
    echo ""
    echo "+-------------------------------+"
    printf "\e[92m%s\e[m\n" "+ Installing Autojump......."
    echo "\033[0m" "+-------------------------------+"
    echo ""
    chmod +x install.py
    ./install.py
    append_to_zshrc '[[ -s /Users/nobinkhan/.autojump/etc/profile.d/autojump.sh ]] && source /Users/nobinkhan/.autojump/etc/profile.d/autojump.sh'
    append_to_zshrc 'autoload -U compinit && compinit -u'
    append_to_zshrc 'export PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND ;} history -a"'
    cd ../..
    rm -rf ZshPlug
    
    # 📁 K: Directory listings for zsh with git features
    echo ""
    echo "+-------------------------------+"
    printf "\e[92m%s\e[m\n" "+ Installing k......."
    echo "\033[0m" "+-------------------------------+"
    echo ""
    git clone https://github.com/supercrabtree/k $ZSH_CUSTOM/plugins/k

    #=====> Install Zsh Themes via Oh My Zsh <=====#
    # 🔋 powerlevel10k
    echo ""
    echo "+---------------------------------------+"
    printf "\e[92m%s\e[m\n" "+ Downloading powerlevel10k theme for zsh..... "
    echo "\033[0m" "+----------------------------------------+"
    echo ""
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
    # 🚀 Spaceship ZSH
    echo ""
    echo "+---------------------------------------+"
    printf "\e[92m%s\e[m\n" "+ Downloading Spaceship theme for zsh..... "
    echo "\033[0m" "+----------------------------------------+"
    echo ""
    git clone https://github.com/denysdovhan/spaceship-prompt.git "$ZSH_CUSTOM/themes/spaceship-prompt" --depth=1
    ln -s "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH_CUSTOM/themes/spaceship.zsh-theme" 

    #change shell to zsh
    echo ""
    echo "+---------------------------------------+"
    printf "\e[95m%s\e[m\n" "Changing default shell to zsh... "
    echo "\033[0m" "+----------------------------------------+"
    echo ""
    chsh -s $(which zsh)

    # Backup existing one to ~/.backups/
    mkdir ~/.backups
    cp ~/.zshrc ~/.backups/.zshrc_copy
    cp ~/.zprofile ~/.backups/.zprofile_copy
    echo ""
    echo "+---------------------------------------+"
    echo '\e[1;32m' "Backing up .zshrc and .zprofile into ~/.backups/"
    echo "\033[0m" "+---------------------------------------+"

    # Overwriting .zshrc, .zprofile and
    case $(uname | tr '[:upper:]' '[:lower:]') in
        darwin*)
            if [ ! -d "$(brew --prefix coreutils)" ]; then
                brew install coreutils
            fi;
            #script's absolute directory
            ABSPATH=$(greadlink -f $0)
            ABSDIR=$(dirname $ABSPATH)
        ;;
        linux*)
            if [ ! "$(apt-cache policy coreutils)" ]; then
                sudo apt-get update
                sudo apt-get install coreutils
            fi;
            ABSPATH=$(readlink -f $0)
            ABSDIR=$(dirname $ABSPATH)
        ;;
    esac;
    cd $ABSDIR
    echo ""
    echo "+---------------------------------------+"
    echo '\e[0;31m' "Loading .zshrc and .zprofile from .dotfiles"
    echo "\033[0m" "+----------------------------------------+"
    echo ""
    # loading .zshrc
    cp .dotfiles/.zshrc  "$HOME/.zshrc"
    # loading .zprofile
    cp .dotfiles/.zprofile "$HOME/.zprofile"
    # loading aliases
    mkdir ~/.dots
    cp .dotfiles/.aliases "~/.dots/.aliases"
}

# Setting Up ZSH.
echo ""
echo "+-----------------------------------------+"
echo "Starting ZHS setup..."
echo "\e[1;32m" "This script may overwrite existing files like \"~/.zshrc, ~/.zprofile\""
echo "\033[0m" "+---------------------------------------+"
# ping before running the script
if [ -f /System/Library/Sounds/Ping.aiff ]; then
    afplay /System/Library/Sounds/Ping.aiff -v 60
fi;
echo ""
echo "+-----------------------------------------+"
echo "Your ZHS setup has been started...."
echo "If any error occurs just stop the process and run the script again."
echo "+---------------------------------------+"
echo ""

#running the setup
setup_zsh

echo ""
echo "+----------------------------+"
echo '\e[0;32m' "+ ✅ ZSH Setup Complete. +"
echo "\033[0m" "+----------------------------+"
echo ""
# play sound when done
if [ -f /System/Library/Sounds/Blow.aiff ]; then
    afplay /System/Library/Sounds/Blow.aiff -v 60
else
    make; spd-say "Setup done."
fi;

unset setup_zsh;
