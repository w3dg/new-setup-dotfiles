# If not running interactively, don't do anything
[[ $- != *i* ]] && return

export PATH=$HOME/.local/bin:$HOME/bin:/usr/local/bin:$PATH
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
# jaischeema traffic (from internet)
# ZSH_THEME="custom-vercel"

# ZSH_THEME="powerlevel10k/powerlevel10k"
# [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Set Pure Prompt
# https://github.com/sindresorhus/pure#install
# fpath+=($HOME/.zsh/pure)
# autoload -U promptinit; promptinit
# prompt pure

eval "$(starship init zsh)"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"
# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.

# Make sure syntax highlighting theme loads before the plugin
# source ~/catppuccin_mocha-zsh-syntax-highlighting.zsh

# plugins=(git command-not-found  zsh-autosuggestions zsh-syntax-highlighting)
plugins=(git command-not-found  colored-man-pages zsh-autosuggestions fast-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

# User configuration
if [ -f "$HOME/.cargo/env" ] ; then
  source "$HOME/.cargo/env"
fi

export GOPATH="$HOME/go"
# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

setopt HIST_IGNORE_SPACE # ignore commands starting with space for sensitive stuff
export HISTORY_IGNORE="(ls|ll|lsa|lls|cd|pwd|exit|sudo reboot|history|cd -|cd ..)"

source ~/.bash/exports.bash        # Exports
source ~/.bash/functions.bash      # Custom functions
source ~/.bash/aliases.bash        # Aliases

# git aliases handled by omz custom one here
function gitcd() {
  local TOP="`git rev-parse --show-cdup 2>/dev/null`" || return 1;
  [ "$TOP" ] && cd "$TOP";
}

source ~/.bash/npm-completion.bash # npm completion
source ~/.bash/pandoc-completion.bash # pandoc completion

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# nvm use stable
nvm use stable 1>/dev/null

# Load Rust into Path
[ -f "$HOME/.cargo/env" ] && source $HOME/.cargo/env

export GPG_TTY=$(tty)

alias reload="source ~/.zshrc"
alias glog='git log --graph --pretty="%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ad) %C(bold blue)<%an>%Creset" --date=short' # glods

# overriding git aliases from omz
alias gcl="git clone"
alias gcld="git clone --depth=1"  # for repos with large commit history, which i dont need

eval "$(zoxide init zsh)"

# [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

if [ $XDG_SESSION_TYPE = 'x11' ]; then
  alias clip="xclip -selection clipboard"
elif [ $XDG_SESSION_TYPE = 'wayland' ]; then
  alias clip="wl-copy"
fi  

fortune | cowsay -f tux

[[ -f ~/todo.md ]] && glow ~/todo.md

