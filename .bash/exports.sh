#Colors
export CLICOLOR=1
export LSCOLORS='exfxcxdxbxegedabagacad'

export PROMPT_DIRTRIM=3

# Don't put duplicate lines in history
export HISTCONTROL=ignoredups:erasedups

# export EDITOR="nano"
export EDITOR="micro"
export LANG="en_US.UTF-8"
export HISTSIZE=10000         # big big history (default is 500)
export HISTFILESIZE=$HISTSIZE # big big history
export HISTIGNORE="&:[ ]*:exit:ls:bg:fg:history:clear:ll:sl:cl" # Dont record some commands
# Save and reload the history after each command finishes
export PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"

export PAGER='less'

# set bat as man pager
export MANROFFOPT="-c"
export MANPAGER="sh -c 'col -bx | bat -l man -p'"

# FZF
export FZF_DEFAULT_COMMAND='rg --hidden --no-ignore -l ""'
export FZF_DEFAULT_OPTS='--layout=reverse --keep-right --color 16'

# Bat themes
export BAT_THEME="ansi"

# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# micro theme catpuccin https://github.com/catppuccin/micro
export MICRO_TRUECOLOR=1

# jdk
export JAVA_HOME="/usr/lib/jvm/jdk-21-oracle-x64/"
export PATH=$PATH:$JAVA_HOME/bin

# go
export GOPATH="$HOME/code/go"
export PATH=${GOPATH:=$HOME/go}/bin:$PATH # Add Go bin to path
export GOBIN=${GOPATH:=$HOME/go}/bin

# pnpm global setup for global packages
export PNPM_HOME="/home/dg/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

# Homebrew
export HOMEBREW_NO_AUTO_UPDATE=1
export HOMEBREW_NO_ENV_HINTS=1
