shopt -s autocd 2> /dev/null # Prepend cd to directory names automatically
shopt -s dirspell 2> /dev/null # Correct spelling errors during tab-completion
shopt -s cdspell 2> /dev/null # Correct spelling errors in arguments supplied to cd
shopt -s no_empty_cmd_completion # TAB even on an empty prompt No More 'Display all GAZILLION possibilities...'
shopt -s cmdhist  # Save multi-line commands as one command
shopt -s histappend  # append to history, don't overwrite it
shopt -s checkwinsize # checks term size when bash regains contro
# Activate recursive globbing
shopt -s globstar
