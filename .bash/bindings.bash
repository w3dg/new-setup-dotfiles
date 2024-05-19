#Bindings
bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'
bind '"\e[C": forward-char'
bind '"\e[D": backward-char'
bind 'set show-all-if-ambiguous on'
bind 'TAB:menu-complete'

bind '"\e[1;5D": backward-word'
bind '"\e[1;5C": forward-word'
bind '"\C-p":history-search-backward'
bind '"\C-n":history-search-forward'
bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'
bind '"TAB":menu-complete'

# Treat hyphens and underscores as equivalent
bind "set completion-map-case on"

bind 'set show-all-if-ambiguous on'
bind 'set bell-style none'
bind 'set colored-stats On'
bind 'set completion-ignore-case On'
bind 'set completion-prefix-display-length 3'
bind 'set mark-symlinked-directories On'
bind 'set show-all-if-ambiguous On'
bind 'set show-all-if-unmodified On'
bind 'set visible-stats On'

# Allow UTF-8 input and output, instead of showing stuff like $'\0123\0456'
bind "set input-meta on"
bind "set output-meta on"
bind "set convert-meta off"
