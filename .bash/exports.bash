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
export FZF_DEFAULT_OPTS='--layout=reverse --keep-right'

export FZF_DEFAULT_OPTS="--layout=reverse --keep-right"

# Bat themes
export BAT_THEME="ansi"

# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# micro theme catpuccin https://github.com/catppuccin/micro
export MICRO_TRUECOLOR=1

# jdk
export JAVA_HOME="/usr/lib/jvm/jdk-21-oracle-x64/"
export PATH=$PATH:$JAVA_HOME/bin
