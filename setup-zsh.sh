#!/bin/bash

#setting up zshell with themes and plugins
function setup_zsh() {
    # Keeping `sudo` alive
    sudo -v
    while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

    . ./lib/.pretty_func.sh

    # Install Zsh if doesn't exist
    if test ! $(which zsh); then
        pretty_echo "Installing zsh......."
        brew install zsh
        #change shell to zsh
        pretty_echo "Changing default shell to zsh... "
        chsh -s $(which zsh)
    else
        #change shell to zsh
        if [[ $(which zsh) == $(echo $SHELL) ]]; then
            color_echo "Your default shell is zsh." $GREEN
        else
            pretty_echo "Changing default shell to zsh... "
            chsh -s $(which zsh)
        fi;
    fi;
    
    if [ ! -e ~/.oh-my-zsh ];then
        pretty_echo "Installing Oh My Zsh......."
        git clone https://github.com/ohmyzsh/ohmyzsh.git ~/.config/.oh-my-zsh

        #script's absolute directory
        ABSPATH=$(greadlink -f $0)
        ABSDIR=$(dirname $ABSPATH)
        cd $ABSDIR
        
        if [ -e ~/.zshrc ];then
            # Backup existing files to ~/.backups/ before overwriting
            mkdir ~/.backups
            color_echo "==> Backing up ~/.zshrc & ~/.zprofile into ~/.backups/" $GREEN
            mv ~/.zshrc ~/.backups/.zshrc.orig
            mv ~/.zprofile ~/.backups/.zprofile.orig
            mv ~/.zshenv ~/.backups/.zshenv.orig
            
            pretty_echo "Loading .zshrc and .zprofile from dotfiles" $GREEN
            Z_DIR="~/.config/zsh"
            # loading .zshrc
            mkdir -p $Z_DIR
            cp dotfiles/.zshrc  "$Z_DIR/.zshrc"
            ln -s ~/.config/.zshrc ~/.zshrc
            source ~/.zshrc
            # loading .zprofile
            cp dotfiles/.zprofile "$Z_DIR/.zprofile"
            ln -s ~/.config/.zprofile ~/.zprofile
            # loading .zshenv
            cp dotfiles/.zshenv "$Z_DIR/.zshenv"
            ln -s ~/.config/.zshenv ~/.zshenv
            # loading .sh_func
            cp dotfiles/.sh_func "$Z_DIR/.sh_func"
            # loading aliases
            cp dotfiles/.aliases "$Z_DIR/.aliases"
    else
        pretty_echo "Seems like Oh My Zsh already installed in ~/.oh-my-zsh" $RED
    fi;

    
    #===========> Install Zsh Plugins via Oh My Zsh <===========#
    
    # 🖍 zsh-syntax-highlighting: Fish shell-like syntax highlighting for Zsh.
    pretty_echo"Installing zsh-syntax-highlighting......."
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.config/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
    
    # 🔎 zsh-autosuggestions: Suggests commands as you type based on history and completions.
    pretty_echo"Installing zsh-autosuggestions......."
    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.config/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
    
    # 🔄 Autojump - a faster way to navigate filesystem.
    cd ~ && mkdir ZshPlug && cd ZshPlug
    git clone git://github.com/wting/autojump.git && cd autojump
    pretty_echo "Installing Autojump......."
    chmod +x install.py
    ./install.py
    append_to_zshrc '# autojump'
    append_to_zshrc '[[ -s /Users/nobinkhan/.autojump/etc/profile.d/autojump.sh ]] && source /Users/nobinkhan/.autojump/etc/profile.d/autojump.sh'
    append_to_zshrc 'autoload -U compinit && compinit -u'
    append_to_zshrc 'export PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND ;} history -a"'
    cd ../..
    rm -rf ZshPlug
    
    # 📁 K: Directory listings for zsh with git features
    pretty_echo "Installing k(Directory listings for zsh)......."
    git clone https://github.com/supercrabtree/k ${ZSH_CUSTOM:-~/.config/.oh-my-zsh/custom}/plugins/k

    
    #===========> Install Zsh Themes via Oh My Zsh <===========#
    
    # 🔋 powerlevel10k
    pretty_echo "Downloading powerlevel10k theme for zsh..... "
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
    append_to_zshrc '# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.'
    append_to_zshrc '[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh'
    
    # 🚀 Spaceship ZSH
    pretty_echo "Downloading Spaceship theme for zsh..... "
    git clone https://github.com/denysdovhan/spaceship-prompt.git "$ZSH_CUSTOM/themes/spaceship-prompt" --depth=1
    ln -s "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH_CUSTOM/themes/spaceship.zsh-theme" 
}

# Setting Up ZSH.
echo "Starting ZHS setup....."
color_echo "This script may overwrite existing files like \"~/.zshrc, ~/.zprofile\"" $RED
# ping before running the script
if [ -f /System/Library/Sounds/Ping.aiff ]; then
    afplay /System/Library/Sounds/Ping.aiff -v 60
fi;
pretty_echo "Your ZHS setup has been started...."
color_echo "If any error occurs just stop the process and run the script again."
echo ""

#running the setup
setup_zsh

pretty_echo " ✅ ZSH Setup Complete. +"
# play sound when done
if [ -f /System/Library/Sounds/Blow.aiff ]; then
    afplay /System/Library/Sounds/Blow.aiff -v 60
fi;

unset setup_zsh;
