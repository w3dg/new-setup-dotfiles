#!/usr/bin/env bash

BASEDIR=$(pwd)

# link them as files or directory directly
DOTFILES=(.bash_profile .bashrc .gitconfig .gitignore .inputrc .npmrc .zshrc .bash bin .czrc .zshenv .config/starship.toml .config/ghostty .config/zathura .config/wezterm .hushlogin .config/atuin/config.toml .config/tmux/tmux.conf)

# create parent dir before linking the above files
DOTFILES_PRE_DIR=(.config/atuin .config/tmux)

mkdir -p "$HOME"/.config
for d in "${DOTFILES_PRE_DIR[@]}"; do
    echo "Creating dir ~/$d"
    mkdir -p "${HOME:-~}/$d"
done

for dot in "${DOTFILES[@]}"; do
	echo "Removing $HOME/$dot"
	rm -rf "${HOME:-~}/${dot}"
	echo "Linking $dot"
	ln -s "${BASEDIR}/${dot}" "${HOME}/${dot}"
done
