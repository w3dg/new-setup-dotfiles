# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Use for Profiling purposes
# zmodload zsh/zprof # at the top of the file
# zprof # at the end of the file

export PATH=$HOME/.local/bin:$HOME/bin:/usr/local/bin:$PATH
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

export ZSH="$HOME/.oh-my-zsh"
# ZSH_THEME="robbyrussell"
ZSH_THEME=""

# ZSH_THEME="powerlevel10k/powerlevel10k"
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
# [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

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

plugins=(
    git
    command-not-found
    colored-man-pages
    zsh-autosuggestions
    fast-syntax-highlighting
)

# Disable highlight on paste https://github.com/zsh-users/zsh/blob/ac0dcc9a63dc2a0edc62f8f1381b15b0b5ce5da3/NEWS#L37-L42
zle_highlight+=(paste:none)

source $ZSH/oh-my-zsh.sh

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
export LANG=en_US.UTF-8

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

setopt HIST_IGNORE_SPACE # ignore commands starting with space for sensitive stuff
export HISTORY_IGNORE="(ls|ll|lsa|lls|cd|pwd|exit|sudo reboot|reboot|history|cd -|cd ..|clear|cl)"

source ~/.bash/exports.bash        # Exports
source ~/.bash/functions.bash      # Custom functions
source ~/.bash/aliases.bash        # Aliases
source ~/.bash/completion-for-pnpm.zsh # pnpm completion

# git aliases handled by omz custom one here
function gitcd() {
  local TOP="`git rev-parse --show-cdup 2>/dev/null`" || return 1;
  [ "$TOP" ] && cd "$TOP";
}

# Use commitizen for conventional git commits
alias gcz="git cz"

source ~/.bash/npm-completion.bash # npm completion
source ~/.bash/pandoc-completion.bash # pandoc completion

# export NVM_DIR="$HOME/.nvm"
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
# [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
#
# nvm use stable 1>/dev/null

# get latest major version number
# fnm ls-remote | tail -1 | tr -d v | cut -d. -f1
eval "$(fnm env --use-on-cd --shell zsh)"

# Load Rust into Path
[ -f "$HOME/.cargo/env" ] && source $HOME/.cargo/env

export GPG_TTY=$(tty)

# alias reload="source ~/.zshrc"
alias reload="exec zsh"
alias glog='git log --graph --pretty="%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ad) %C(bold blue)<%an>%Creset" --date=short' # glods

# overriding git aliases from omz
alias gcl="git clone"
alias gcld="git clone --depth=1"  # for repos with large commit history, which i dont need

eval "$(zoxide init zsh)"

if [ $XDG_SESSION_TYPE = 'x11' ]; then
  alias clip="xclip -selection clipboard"
elif [ $XDG_SESSION_TYPE = 'wayland' ]; then
  alias clip="wl-copy"
fi

greeting() {
    UNAME_OUTPUT=$(uname -a)
    echo -e "\e[1mHostname: \e[0;32m$(echo $UNAME_OUTPUT | cut -d' ' -f2)\e[0m"
    echo -e "\e[1mKernel: \e[0;33m$(echo $UNAME_OUTPUT | cut -d' ' -f3)\e[0m"
    echo -e "\e[1mUptime: \e[0;36m$(uptime -p | cut -d' ' -f 2-)\e[0m"
    echo -e "\e[1mNetwork: \e[0;35m$(ip addr show scope global | grep inet | awk '{print $2}')\e[0m"
    echo "Today is $(date +"%a, %b %d")"
}

[[ $PWD = $HOME ]] && [[ -f ~/todo.md ]] && glow ~/todo.md || true
greeting
