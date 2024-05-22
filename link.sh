#!/usr/bin/env bash

DOTFILES=(.bash_profile .bashrc .catppuccin.gitconfig .gitconfig .gitignore .inputrc .npmrc .zshrc .bash .p10k.zsh)

for dot in "${DOTFILES[@]}"; do
	ln -s ./$dot ~/$dot
done
