#Colors
export CLICOLOR=1
export LSCOLORS='exfxcxdxbxegedabagacad'

export PROMPT_DIRTRIM=3

# export EDITOR="nano"
export EDITOR="micro"
export LANG="en_US.UTF-8"
export HISTSIZE=10000                          # big big history (default is 500)
export HISTFILESIZE=$HISTSIZE                   # big big history
export HISTIGNORE="&:[ ]*:exit:ls:bg:fg:history:clear:ll:sl:cl" # Dont record some commands
# Save and reload the history after each command finishes
export PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"

# FZF
export FZF_DEFAULT_COMMAND='rg --hidden --no-ignore -l ""'
# export FZF_DEFAULT_OPTS='--layout=reverse --keep-right'
export FZF_DEFAULT_OPTS=" \
--color=spinner:#f5e0dc,hl:#f38ba8 \
--color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
--color=marker:#b4befe,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8 \
--color=selected-bg:#45475a \
--color=border:#313244,label:#cdd6f4 \
--layout=reverse --keep-right"

# Bat themes
# export BAT_THEME="ansi"
export BAT_THEME="Catppuccin Mocha"

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
