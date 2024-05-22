#!/usr/bin/env bash

BASEDIR=$(pwd)

DOTFILES=(.bash_profile .bashrc .catppuccin.gitconfig .gitconfig .gitignore .inputrc .npmrc .zshrc .bash .p10k.zsh)

for dot in "${DOTFILES[@]}"; do
	echo "Removing $dot" && rm -f $HOME/$dot
	echo "Linking $dot" && ln -s $BASEDIR/$dot $HOME/$dot
done
