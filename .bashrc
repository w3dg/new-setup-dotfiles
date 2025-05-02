# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Yarn PATH
export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
# GO PATH
export PATH="$HOME/go/bin:$PATH"

echo "Today is $(date +"%a, %F %T")"

[[ -f ~/.dircolors ]] && eval "$(dircolors -b ~/.dircolors)"

source ~/.bash/bindings.bash       # Bindings
source ~/.bash/shopts.bash         # Shopts
source ~/.bash/exports.bash        # Exports
source ~/.bash/functions.bash      # Custom functions
source ~/.bash/aliases.bash        # Aliases
source ~/.bash/git_aliases.bash    # Git aliases

source ~/.bash/npm-completion.bash # npm completion
source ~/.bash/pandoc-completion.bash # pandoc completion

# fzf - Website: https://github.com/junegunn/fzf
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# export PS1='\[\033]0;Bash \007\]'

# prompt symbol - ❯

# prompt_command() {
#   # sync history between terminals
#   history -a; # append to history file the current session
#   history -c; # clear history for current session
#   history -r; # read in the latest everywhere
#  }
#
# export PROMPT_COMMAND=prompt_command

# export PS1="\[\e[38;5;47m\]\u\[\e[38;5;156m\]@\[\e[38;5;227m\]\h \[\e[38;5;231m\]\w \[\033[0m\]$ "
# export PS2="... "


# https://github.com/bahamas10/dotfiles/blob/master/bashrc
# Prompt
# Store `tput` colors for future use to reduce fork+exec
# the array will be 0-255 for colors, 256 will be sgr0
# and 257 will be bold
COLOR256=()
COLOR256[0]=$(tput setaf 1)
COLOR256[256]=$(tput sgr0)
COLOR256[257]=$(tput bold)

# Colors for use in PS1 that may or may not change when
# set_prompt_colors is run
PROMPT_COLORS=()

# Change the prompt colors to a theme, themes are 0-29
set_prompt_colors() {
	local h=${1:-0}
	local color=
	local i=0
	local j=0
	for i in {22..231}; do
		((i % 30 == h)) || continue

		color=${COLOR256[$i]}
		# cache the tput colors
		if [[ -z $color ]]; then
			COLOR256[$i]=$(tput setaf "$i")
			color=${COLOR256[$i]}
		fi
		PROMPT_COLORS[$j]=$color
		((j++))
	done
}

# Construct the prompt
# [(exit code)] <user> - <hostname> <uname> <cwd> [git branch] <$|#>

# exit code of last process
PS1='$(ret=$?;(($ret!=0)) && echo "\[${COLOR256[0]}\]($ret) \[${COLOR256[256]}\]")'

# username (red for root)
PS1+='\[${PROMPT_COLORS[0]}\]\[${COLOR256[257]}\]$(((UID==0)) && echo "\[${COLOR256[0]}\]")\u\[${COLOR256[256]}\] '

# zonename (global zone warning)
PS1+='\[${COLOR256[0]}\]\[${COLOR256[257]}\]'"$(zonename 2>/dev/null | grep -q '^global$' && echo 'GZ:')"'\[${COLOR256[256]}\]'

# hostname
PS1+='\[${PROMPT_COLORS[3]}\]\h '

# uname
PS1+='\[${PROMPT_COLORS[2]}\]'"$(uname | tr '[:upper:]' '[:lower:]')"' '

# cwd
PS1+='\[${PROMPT_COLORS[5]}\]\w '

# optional git branch
PS1+='$(branch=$(git rev-parse --abbrev-ref HEAD 2>/dev/null); [[ -n $branch ]] && echo "\[${PROMPT_COLORS[2]}\](\[${PROMPT_COLORS[3]}\]git:$branch\[${PROMPT_COLORS[2]}\]) ")'

# prompt character
PS1+='\[${PROMPT_COLORS[0]}\]\$\[${COLOR256[256]}\] '

# set the theme
set_prompt_colors 2

# Prompt command
_prompt_command() {
        local user=$USER
        local host=${HOSTNAME%%.*}
        local pwd=${PWD/#$HOME/\~}
        local ssh=
        [[ -n $SSH_CLIENT ]] && ssh='[ssh] '
        printf "\033]0;%s%s@%s:%s\007" "$ssh" "$user" "$host" "$pwd"
        #   # sync history between terminals
        history -a; # append to history file the current session
        history -c; # clear history for current session
        history -r; # read in the latest everywhere
}

PROMPT_COMMAND=_prompt_command

PROMPT_DIRTRIM=1

export GPG_TTY=$(tty)

# export NVM_DIR="$HOME/.nvm"
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
# [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
#
# nvm use stable 1>/dev/null

# get latest major version number
# fnm ls-remote | tail -1 | tr -d v | cut -d. -f1
eval "$(fnm env --use-on-cd --shell bash)"

if [ $XDG_SESSION_TYPE = 'x11' ]; then
  alias clip="xclip -selection clipboard"
elif [ $XDG_SESSION_TYPE = 'wayland' ]; then
  alias clip="wl-copy"
fi

eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
. "$HOME/.cargo/env"

# zoxide - Website: https://github.com/ajeetdsouza/zoxide
eval "$(zoxide init bash)"

