# Path to your oh-my-zsh installation.
export ZSH="$HOME/.config/.oh-my-zsh"

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

### Path Variable
export PATH="$(dirname $(which anaconda))":$PATH
export PATH="$(dirname $(which nvim))":$PATH
export PATH="/usr/local/bin":$PATH
    
# Set name of the theme to load --- if set to "random", it will load a random theme
# MY Favourite "powerlevel10k/powerlevel10k" and "spaceship"
ZSH_THEME="spaceship"

# Set list of themes to pick from when loading at random and looking in $ZSH/themes/
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "powerlevel10k/powerlevel10k")

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Hyphen-insensitive completion.
HYPHEN_INSENSITIVE="true"

# Uncomment the following line to change how often to auto-update (in days).
export UPDATE_ZSH_DAYS=15

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# auto-setting terminal title.
DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="true"

# Display red dots whilst waiting for completion.
# Caution: this setting can cause issues with multiline prompts (zsh 5.7.1 and newer seem to work)
COMPLETION_WAITING_DOTS="true"

# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
plugins=(
    git
    python
    pipenv
    django
    node
    vscode
    zsh-autosuggestions
    zsh-syntax-highlighting
	)

source $ZSH/oh-my-zsh.sh


####### >>> User configuration <<<  ########

# You may need to manually set your language environment
#export LANG=en_US.UTF-8

# Announce 256 bit color support
export TERM=xterm-256color

# COLORED MANUAL PAGES (ex. man ls)
if $_isxrunning; then
  export LESS_TERMCAP_mb=$'\E[01;31m'
	export LESS_TERMCAP_md=$'\E[01;31m'
	export LESS_TERMCAP_me=$'\E[0m'
	export LESS_TERMCAP_se=$'\E[0m'
	export LESS_TERMCAP_so=$'\E[01;44;33m'
	export LESS_TERMCAP_ue=$'\E[0m'
	export LESS_TERMCAP_us=$'\E[04;92;146m'
fi

# Aliases(oh-my-zsh) are in ZSH_CUSTOM folder. Run `alias` to see all active aliases.
alias sz="source ~/.zshrc" 
alias ez="vim ~/.zshrc"

#import custom aliases
source "~/.config/zsh/.aliases"
source "~/.config/zsh/.sh_func"
