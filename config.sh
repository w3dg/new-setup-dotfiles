#!/usr/bin/bash

#####
# w3dg - 2025, Jan 12
#####

BASEDIR=$(pwd)

# Update and upgrade your base system
sudo apt update -y && sudo apt upgrade -y

# Install basic necessities
sudo apt install -y  git vim wget curl neovim

# Run linking script for linking up dotfiles

bash $BASEDIR/link.sh

# put expected file for git diff decorations
cp $BASEDIR/.catppuccin.gitconfig $HOME

mkdir -p $HOME/.config/zathura
cp $BASEDIR/.config/zathura/zathurarc $HOME/.config/zathura/zathurarc

# Install Fira Code Nerd Font
curl -OL https://github.com/ryanoasis/nerd-fonts/releases/latest/download/FiraCode.tar.xz
curl -OL https://github.com/ryanoasis/nerd-fonts/releases/latest/download/CommitMono.tar.xz

mv $BASEDIR/FiraCode.tar.xz /tmp
mv $BASEDIR/CommitMono.tar.xz /tmp

cd /tmp

tar xvf FiraCode.tar.xz
tar xvf CommitMono.tar.xz

sudo mv *ttf /usr/share/fonts/truetype
sudo fc-cache -f -v

cd $BASEDIR

# Install zsh, ohmyzsh, powerlevel10k, zsh-autosuggestions, zsh-syntax-highlighting
sudo apt install -y zsh
# Get Ohmyzsh, this also changes default shell to zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

# Install fast syntax highlighting
git clone https://github.com/zdharma-continuum/fast-syntax-highlighting.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/fast-syntax-highlighting

# Install auto-suggestions
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

# Add catppuccin syntax highlighting for zsh
# cp $BASEDIR/catppuccin_mocha-zsh-syntax-highlighting.zsh $HOME

## Install HomeBrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
# Make sure brew is found in path during this install
export PATH=$HOME/bin:/usr/local/bin:$PATH
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

# Get the list of installed packages
# brew list --installed-on-request

# Install from brewfile
# Temporarily increase system's file descriptor limit so that brew passes while installing lots of packages

BEFORE_ULIMIT_CHANGE=$(ulimit -n)

ulimit -n 65535

xargs brew install < $BASEDIR/Brewfile

ulimit -n $BEFORE_ULIMIT_CHANGE

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

# Setup micro, make a directory if not exists, and copy recursively settings and colorschemes
mkdir -p $HOME/.config/micro
cp $BASEDIR/micro/* $HOME/.config/micro

# Get NVM
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash

# brew install fnm
# enable fnm for session
eval "$(fnm env --use-on-cd --shell zsh)"
LATEST_NODE_MAJOR=$(fnm ls-remote | tail -1 | tr -d v | cut -d. -f1)
fnm install $LATEST_NODE_MAJOR

# install global npm packages
while read package; do npm i -g ${package}; done < $BASEDIR/npm-global-packages.txt

# Install terminator
sudo apt install -y terminator

# copy over terminator config
mkdir -p $HOME/.config/terminator
cp $BASEDIR/terminator.config $HOME/.config/terminator/config

sudo apt install wl-clipboard  # wl-copy for wayland https://superuser.com/questions/1189467/how-to-copy-text-to-the-clipboard-when-using-wayland

# Zathura for pdf
sudo apt install zathura

########################## OTHER SOFTWARE #########################

## Install snaps

echo "Installing Snap and snaps - mailspring, notion, calendar, telegram, slack"
sudo apt install snapd
sudo snap install mailspring notion-snap-reborn telegram-desktop slack notion-calendar-snap

echo "Installing Flatpaks, RESTART NEEDED LATER TO MANUALLY INSTALL FLATPAKS"

sudo apt install flatpak
sudo apt install gnome-software-plugin-flatpak
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

## Restart needed ##
## install dconf-editor, discord, stretchly, fedora media writer as flatpaks
# ca.desrt.dconf-editor com.discordapp.Discord net.hovancik.Stretchly org.fedoraproject.MediaWriter

# OBS Studio
sudo apt install obs-studio

# Install Pandoc and Eisvogel

sudo apt install pandoc texlive
# Eisvogel Latex template - https://github.com/Wandmalfarbe/pandoc-latex-template
wget "https://raw.githubusercontent.com/Wandmalfarbe/pandoc-latex-template/master/eisvogel.tex"
mkdir -p $HOME/.local/share/pandoc/templates
mv $BASEDIR/eisvogel.tex $HOME/.local/share/pandoc/templates/eisvogel.tex

## VSCODE https://code.visualstudio.com/
# GOOGLE CHROME https://www.google.com/chrome/
# TRANSMISSION https://transmissionbt.com/download
