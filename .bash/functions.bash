### Function extract for common file formats ###
SAVEIFS=$IFS
IFS=$(echo -en "\n\b")

### ARCHIVE EXTRACTION
# usage: ex <file>
function ex {
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
	cd "$(fd -t d --maxdepth 3 --exclude node_modules --exclude .git | fzf --query=$1)"
}

cd_with_fzf_home() {
    # cd $HOME && cd "$(fd -t d | fzf)"
	cd $HOME && cd "$(fd -t d --maxdepth 3 --exclude node_modules --exclude .git | fzf --query=$1)"
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

# Qickly make a backup of a file
back() {
	cp "$1"{,.bak};
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
	for i in {0..255}; do print -Pn "%K{$i}  %k%F{$i}${(l:3::0:)i}%f " ${${(M)$((i%6)):#3}:+$'\n'}; done
}

# Python Virtual Env activations

# source the closest virtualenv to pwd
sv() {
	if [ ! -z $VIRTUAL_ENV ]; then
		deactivate # deactivate what venv is currently enabled
	fi
	PATH_TO_LOCAL_ACTIVATION_SCRIPT=$(\find -type f -iname "activate")
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
    npm list -g | sed -E -e 's|^/.*$||g' -e 's/├──//g' -e 's/└──//g' -e 's/@[0-9]+\.[0-9]+\.[0-9]+//g' | xargs npm i -g
}
