#!/usr/bin/bash

#####
# w3dg - 2024, May 22
#####

BASEDIR=$(pwd)

# Update and upgrade your base system
sudo apt update -y && sudo apt upgrade -y

# Install basic necessities
sudo apt install -y  git vim wget curl

# Run linking script for linking up dotfiles

bash $BASEDIR/link.sh

# put expected file for git diff decorations 
cp $BASEDIR/.catppuccin.gitconfig $HOME

# Install Fira Code Nerd Font
curl -OL https://github.com/ryanoasis/nerd-fonts/releases/latest/download/FiraCode.tar.xz
mv $BASEDIR/FiraCode.tar.xz /tmp
cd /tmp
tar xvf FiraCode.tar.xz

sudo mv *ttf /usr/share/fonts/truetype
sudo fc-cache -f -v

cd $BASEDIR

# Install zsh, ohmyzsh, powerlevel10k, zsh-autosuggestions, zsh-syntax-highlighting
sudo apt install -y zsh
# Get Ohmyzsh, this also changes default shell to zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
# Get powerlevel10k for ohmyzsh
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
# theme should already be set in ~/.zshrc
# ZSH_THEME="powerlevel10k/powerlevel10k"

# Install syntax highlighting
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
# Install auto-suggestions
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

# Add catppuccin syntax highlighting for zsh
cp $BASEDIR/catppuccin_mocha-zsh-syntax-highlighting.zsh $HOME

## Install HomeBrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
# Make sure brew is found in path during this install
export PATH=$HOME/bin:/usr/local/bin:$PATH
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

# Get the list of installed packages
# brew list --installed-on-request

# Install from brewfile

xargs brew install < $BASEDIR/Brewfile

# Set bat themes https://github.com/catppuccin/bat
mkdir -p "$(bat --config-dir)/themes"
wget -P "$(bat --config-dir)/themes" https://github.com/catppuccin/bat/raw/main/themes/Catppuccin%20Latte.tmTheme
wget -P "$(bat --config-dir)/themes" https://github.com/catppuccin/bat/raw/main/themes/Catppuccin%20Frappe.tmTheme
wget -P "$(bat --config-dir)/themes" https://github.com/catppuccin/bat/raw/main/themes/Catppuccin%20Macchiato.tmTheme
wget -P "$(bat --config-dir)/themes" https://github.com/catppuccin/bat/raw/main/themes/Catppuccin%20Mocha.tmTheme
bat cache --build

# Install fzf
git clone --depth 1 https://github.com/junegunn/fzf.git $HOME/.fzf
bash $HOME/.fzf/install
# automatically checks and adds necessary additions to shell scripts, but we did that before, at this point it should be there

# Get Micro as a text editor
curl https://getmic.ro | bash
# move it to bin for systemwide
sudo mv -i ./micro /usr/bin

# p10k prompt should be linked automatically above

# Setup micro, make a directory if not exists, and copy recursively settings and colorschemes
mkdir -p $HOME/.config/micro
cp -R $BASEDIR/micro/* $HOME/.config/micro

# Get NVM
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash

# Load nvm in the current shell
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

# Get stable version of node
nvm install stable
nvm use stable

# install global npm packages
sed -E -e "s/├── //g" -e "s/└── //g" -e "s/^$//g" -e "s/^\/.*//g" -e "s/@[0-9]+\.[0-9]+\.[0-9]+//g" $BASEDIR/npm-global-packages.txt| xargs -I{} echo npm i {}@latest

# Install terminator
sudo apt install -y terminator

# copy over terminator config
mkdir -p $HOME/.config/terminator
cp $BASEDIR/terminator.config $HOME/.config/terminator/config

# Install Pandoc and Eisvogel

sudo apt install pandoc texlive
# Eisvogel Latex template - https://github.com/Wandmalfarbe/pandoc-latex-template
wget "https://raw.githubusercontent.com/Wandmalfarbe/pandoc-latex-template/master/eisvogel.tex"
mkdir -p $HOME/.local/share/pandoc/templates
mv $BASEDIR/eisvogel.tex $HOME/.local/share/pandoc/templates/eisvogel.tex
