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

# tokyo night
export FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS"\
" --color=bg+:#16161e,bg:#1a1b26,spinner:#b4f9f8,hl:#2ac3de"\
" --color=fg:#787c99,header:#2ac3de,info:#0db9d7,pointer:#b4f9f8"\
" --color=marker:#b4f9f8,fg+:#cbccd1,prompt:#0db9d7,hl+:#2ac3de"

# classic light
# export FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS"\
# " --color=bg+:#e0e0e0,bg:#f5f5f5,spinner:#75b5aa,hl:#6a9fb5"\
# " --color=fg:#505050,header:#6a9fb5,info:#f4bf75,pointer:#75b5aa"\
# " --color=marker:#75b5aa,fg+:#202020,prompt:#f4bf75,hl+:#6a9fb5"

# classic dark
export FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS"\
" --color=bg+:#202020,bg:#151515,spinner:#75b5aa,hl:#6a9fb5"\
" --color=fg:#b0b0b0,header:#6a9fb5,info:#f4bf75,pointer:#75b5aa"\
" --color=marker:#75b5aa,fg+:#e0e0e0,prompt:#f4bf75,hl+:#6a9fb5"

# Bat themes
export BAT_THEME="base16"

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
