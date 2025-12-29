### Function extract for common file formats ###
SAVEIFS=$IFS
IFS=$(echo -en "\n\b")

### ARCHIVE EXTRACTION
# usage: ex <file>
ex() {
 if [ -z "$1" ]; then
    # display usage if no parameters given
    echo "Usage: ex <path/file_name>.<zip|rar|bz2|gz|tar|tbz2|tgz|Z|7z|xz|ex|tar.bz2|tar.gz|tar.xz>"
    echo "       extract <path/file_name_1.ext> [path/file_name_2.ext] [path/file_name_3.ext]"
 else
    for n in "$@"
    do
      if [ -f "$n" ] ; then
          case "${n%,}" in
            *.cbt|*.tar.bz2|*.tar.gz|*.tar.xz|*.tbz2|*.tgz|*.txz|*.tar)
                         tar xvf "$n"       ;;
            *.lzma)      unlzma ./"$n"      ;;
            *.bz2)       bunzip2 ./"$n"     ;;
            *.cbr|*.rar)       unrar x -ad ./"$n" ;;
            *.gz)        gunzip ./"$n"      ;;
            *.cbz|*.epub|*.zip)       unzip ./"$n"       ;;
            *.z)         uncompress ./"$n"  ;;
            *.7z|*.arj|*.cab|*.cb7|*.chm|*.deb|*.dmg|*.iso|*.lzh|*.msi|*.pkg|*.rpm|*.udf|*.wim|*.xar)
                         7z x ./"$n"        ;;
            *.xz)        unxz ./"$n"        ;;
            *.exe)       cabextract ./"$n"  ;;
            *.cpio)      cpio -id < ./"$n"  ;;
            *.cba|*.ace)      unace x ./"$n"      ;;
            *)
                         echo "ex: '$n' - unknown archive method"
                         return 1
                         ;;
          esac
      else
          echo "'$n' - file does not exist"
          return 1
      fi
    done
fi
}

IFS=$SAVEIFS

# navigation
cdup () {
  local d=""
  local limit="$1"

  # Default to limit of 1
  if [ -z "$limit" ] || [ "$limit" -le 0 ]; then
    limit=1
  fi

  for ((i=1;i<=limit;i++)); do
    d="../$d"
  done

  # perform cd. Show error if cd fails
  if ! cd "$d"; then
    echo "Couldn't go up $limit dirs.";
  fi
}


# Make a directory and cd into it all at once
mkcd() {
  mkdir $1 && cd $1
}

# get a random emoji. Usage - `emoji`
emoji() {
  emojis=("👾" "🌐" "🎲" "🌍" "🐉" "🌵")
  EMOJI=${emojis[$RANDOM % ${#emojis[@]} ]}
  printf "$EMOJI \n"
}

# Spin up a local python server in the current directory. Usage - `up <port>` if not specified, uses a random port
up() {
  re='^[0-9]+$' # Whether it is a number
  if [[ $1 =~ $re ]] ; then
    # port can be within 0-65535 only
    if ! [ $1 -ge 0 -a $1 -le 65535 ];
    then
      echo "Port number must be between 0 and 65535"
      return
    fi
     python3 -m http.server $1
  else
     echo "[i] Empty Or Invalid Port Number Specified." >&2;
     local PORT=$(($RANDOM+3000))
     echo -e "\e[33m Running on a random port: $PORT \e[0m"
     python3 -m http.server $PORT
  fi
}

# Uses fzf, fd
cd_with_fzf() {
    # cd $HOME && cd "$(fd -t d | fzf)"
	cd "$(fd -t d --maxdepth 5 --exclude node_modules --exclude .git | fzf --query=$1)"
}

cd_with_fzf_home() {
    # cd $HOME && cd "$(fd -t d | fzf)"
	cd $HOME && cd "$(fd -t d --maxdepth 5 --exclude node_modules --exclude .git | fzf --query=$1)"
}

cdf() {
	cd_with_fzf $1
}

cdfh() {
	cd_with_fzf_home $1
}

cdfl() {
	cd $HOME
	FILEPATH=$(fd -t f . | fzf --query=$1)
	# echo $FILEPATH | sed "s|$HOME||" # anything for the seperator to sed. File path will contain slashes so we use a different seperator
	if [ $? -ne 0 ]; then
		return
	fi
	DIR=`dirname ${FILEPATH} | sed "s|$HOME|~|"`
	cd $DIR
}

# Quickly make a backup of a file
back() {
	cp "$1"{,.bak};
}

# replace file name with spaces to have it with dashes instead
rename_with_dashes() {
  if [[ -z "$1" ]]; then
    echo "Usage: rename_with_dashes \"filename with spaces.ext\""
    return 1
  fi

  original="$1"
  # Replace spaces with dashes
  new_name="${original// /-}"

  if [[ "$original" == "$new_name" ]]; then
    echo "No spaces found. Filename unchanged: $original"
    return 0
  fi

  # Perform the rename
  mv -- "$original" "$new_name"
  echo "Renamed: \"$original\" -> \"$new_name\""
}


# fuzzy man page opener
fzman() {
    query=$(man -k . | fzf)
    if [[ $? -ne 0 ]]; then
        return 1
    fi

    man $(echo $query | awk '{ gsub(/[()]/, ""); print  $2" "$1 }')
}

table() {
    column -t -s, "$@"
}

# Grep current directories' files for todos etc
todos() {
	rg 'TODO|FIXME|WARN|BUG'
}

cleangit () {
  echo -e "WARNING: If you're on, say, a development branch that was branched off of master, you'll lose your master branch";
  echo -e "still want to do this? [y/N]";
  read REMOVE
  if [ "$REMOVE" = "y" ] || [ "$REMOVE" = "Y" ]; then
    git branch --merged | grep -v "\*" | grep -v master | grep -v dev | xargs -n 1 git branch -d
  fi
}

color256() {
    for i in {0..255}; do
        printf "\x1b[48;5;%dm %3d \x1b[0m" "$i" "$i"
        if [ $((($i + 1) % 16)) -eq 0 ]; then
            printf "\n"
        fi
    done
}

# Python Virtual Env activations

# source the closest virtualenv to pwd, if multiple are present, show a fzf picker
sv() {
	if [ ! -z $VIRTUAL_ENV ]; then
		deactivate # deactivate what venv is currently enabled
	fi
	local scripts=$(\find -type f -iname "activate")
	local scriptslen=$(echo ${scripts[@]} | wc -l)

    local PATH_TO_LOCAL_ACTIVATION_SCRIPT=""

	if [[ $scriptslen -ne 1 ]];
	then
	    chosenscript=$(echo ${scripts[@]} | fzf)
	    [[ $? -ne 0 ]] && echo "script not chosen" && exit
	    PATH_TO_LOCAL_ACTIVATION_SCRIPT=${chosenscript}
	else
	    PATH_TO_LOCAL_ACTIVATION_SCRIPT=${scripts}
	fi

	if [ ! -z $PATH_TO_LOCAL_ACTIVATION_SCRIPT ]; then
		source $PATH_TO_LOCAL_ACTIVATION_SCRIPT
		VENV_PARENT_DIR=$(dirname $(echo $VIRTUAL_ENV) | sed "s|$HOME|~|")
		echo "Enabled Virtual Environment from $VENV_PARENT_DIR"
	else
		echo "Could not find activation script. Are you in the root directory with venv folder?"
	fi
}


which_venv() {
	if [ -z $VIRTUAL_ENV ]; then
		echo "No virtual env set"
	else
		VENV_PARENT_DIR=$(dirname $(echo $VIRTUAL_ENV) | sed "s|$HOME|~|")
		echo "Current Venv from $VENV_PARENT_DIR"
	fi
}

wenv() {
	which_venv
}

# Use zathura as pdf viewer
zpdf() {
	selection=$(fd -I -t f --glob \*.pdf | fzf --query="$1")
	if [  $? -ne 0 ]; then
		return
	fi
	if [ -z $selection ]; then
		return
	fi
	zathura "$selection" &
	disown
}

# unset the variable for history file so that the commands after invoking
# this function will not be recorded
privatesession() {
	unset HISTFILE
}

update_global_npm_packages() {
    npm list -g | awk '{ print $2}' | sed -E "s/@[0-9]+\.[0-9]+\.[0-9]+//g" | xargs npm i -g
}

# Get your weather information
weather() {
    /usr/bin/env curl "wttr.in/${1}"
}


# EXPERIMENTING!!

# c is a shell function that attempts to expand to cd to relative or
# absolute paths, otherwise trying zoxide for jumping
c() {
    if [ $# -eq 0 ]; then
        # No arguments → just cd to $HOME
        cd ~ || return
        return
    fi

    local target="$1"

    # Expand ~ and relative paths
    case "$target" in
        ~*|/*) : ;;                # already expanded by the shell
        *) target="./$target" ;;   # relative paths
    esac

    if [ -d "$target" ]; then
        # It's a real directory → use builtin cd
        builtin cd "$target" || return
    else
        # Not a dir → fallback to zoxide
        z "$1"
    fi
}

trim_zsh_history() {
    # Backup first
    cp ~/.zsh_history ~/.zsh_history.backup
    cat -n ~/.zsh_history | sort -t ';' -k 2 -k 1n | uniq -f 1 | sort -n | cut -f 2- > ~/.zsh_history.tmp && mv ~/.zsh_history.tmp ~/.zsh_history
}

trim_bash_history() {
    # Backup first
    cp ~/.bash_history ~/.bash_history.backup
    # Remove duplicates (keeps last occurrence)
    awk '!seen[$0]++' ~/.bash_history > ~/.bash_history.tmp && mv ~/.bash_history.tmp ~/.bash_history
}
