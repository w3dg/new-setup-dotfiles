#!/usr/bin/env bash

BASEDIR=$(pwd)

DOTFILES=(.bash_profile .bashrc .catppuccin.gitconfig .gitconfig .gitignore .inputrc .npmrc .zshrc .bash bin .czrc .zshenv .config/starship.toml .config/ghostty .config/zathura .config/wezterm)

mkdir -p $HOME/.config

for dot in "${DOTFILES[@]}"; do
	echo "Removing $HOME/$dot"
	rm -rf "$HOME/$dot"
	echo "Linking $dot"
	ln -s $BASEDIR/$dot $HOME/$dot
done
