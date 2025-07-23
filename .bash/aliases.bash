# Bash Aliases

# https://github.com/eza-community/eza
# alias ls='lsd'
# for normal ls
# alias ls='ls --color -F --group-directories-first'
alias ls='eza --color=auto -F --group-directories-first --icons=auto'
alias ll='ls --git -lAh'
alias l='ls -1'
alias la='ls -A'
alias sl='ls'
alias lls='ls'
# list all dotfiles
alias l.='/usr/bin/ls -A | grep "^\."'

# use eza for tree
alias tree="eza -TF --icons=auto"

# clear all history ; even from the current session; close the session to get rid of all persistence
alias historyclearall="/usr/bin/cat /dev/null > ~/.bash_history && history -c && exit"
alias size="du -hcs ."
alias total_files='ls -l | wc -l'
alias cl="clear"

# Reload bashrc after modifying, in the current session
alias reload='exec bash'

# confirm before overwriting something and verbose output
alias cp='cp -iv'
alias mv='mv -iv'
alias rm='rm -iIv'
alias ln='ln -i'

alias mkdir='mkdir -pv'
alias df='df -hT' # human readable sizes and fs type

# Additional Programs replacing normal ones
# bat is a rust utility similar to the cat(1) command. install via scoop or other package manager https://github.com/sharkdp/bat
alias cat='bat -p'
# https://micro-editor.github.io/
alias mc='micro'
alias m='micro'
# Alias grep to ripgrep. Project home page: https://github.com/BurntSushi/ripgrep
alias grep='rg'
# Alias find to fd. Project home page - https://github.com/sharkdp/fd
alias find='fd'
# Alias curl to httpie - Project home page - https://github.com/httpie/httpie/
# https://www.hanselman.com/blog/installing-httpie-http-for-humans-on-windows-great-for-aspnet-web-api-and-restful-json-services
alias curl='xh'
alias http='xh' # replace httpie with xh
# alias wget='http --download'
# Aliasing wget to aria2 for downloads
alias wget='aria2c'



# Utility Aliases
# Get your external IP
# Public facing IP Address
alias ipe='curl ipinfo.io/ip'

# Get your weather information
alias weather='curl wttr.in/'

# Custom Program Aliases
# reveal-md (see npm)
alias reveal-md="reveal-md --theme night --highlight-theme hybrid --port 1337 --w --css style.css"
# Open Settings for Windows terminal
# alias wtsetting="$EDITOR ~/AppData/Local/Packages/Microsoft.WindowsTerminal_8wekyb3d8bbwe/LocalState/settings.json"
# alias sublwt="subl $(alias wtsetting | cut  -d' ' -f3 | tr -d "'")"

# Print Each Path entry on a separate line
alias path='echo -e ${PATH//:/\\n}'

## NPM Project Aliases ##
# alias vitenew='npm create vite@latest'
alias vitenew='pnpm dlx create-vite@latest'

# Easier navigation: .., ..., ...., ....., ~ and -
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias ~="cd ~" # `cd` is probably faster to type though
alias -- -="cd -"


# Yt-dlp download best quality audio and video merge them into mp4
# Requires ffmpeg
alias yt-dlp="yt-dlp -f 'bestvideo[ext=mp4]+bestaudio[ext=m4a]/mp4'"
# yt-dlp download an audio only version
alias yt-dlp-audio="yt-dlp -f bestaudio -x --audio-format mp3 --audio-quality 0"

# https://www.npmjs.com/package/trash-cli
alias rm='trash'

# fastfetch
alias nf="fastfetch"
alias ff="fastfetch"

alias lg="lazygit"

# open current repo on github in browser (requires gh)
alias ghb="gh browse > /dev/null 2>/dev/null"

# wrap ivy with readline goodies and a prompt instead of default blank prompt
# Ivy is an interpreter for an APL-like language.
# go install robpike.io/ivy@latest
alias iv="rlwrap ivy -prompt 'ivy% '"

alias ipython="ipython3 --no-banner"
