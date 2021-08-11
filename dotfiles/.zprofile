# Setting PATH for Python 3.9
export PATH="$(dirname $(which python3))":$PATH

# Setting Homebrew Shell
eval "$(/opt/homebrew/bin/brew shellenv)"

if [ -e "/Applications/Visual Studio Code.app" ];then
    # Setting `code` command on path
    export PATH="\$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"
fi

# History Configuration
HISTFILESIZE=5000
HISTSIZE=5000              
HISTFILE=~/.zsh_history    
SAVEHIST=5000              
HISTDUP=erase              
setopt    appendhistory    
setopt    sharehistory     
setopt    incappendhistory 