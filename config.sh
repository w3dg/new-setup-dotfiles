#!/usr/bin/bash
BASEDIR=$(pwd)

# Update and upgrade your base system
sudo apt update -y && sudo apt upgrade -y

# Install basic necessities
sudo apt install -y  git vim wget curl neovim

# Run linking script for linking up dotfiles
bash "$BASEDIR"/link.sh

# Install Fira Code Nerd Font
curl -OLs https://github.com/ryanoasis/nerd-fonts/releases/latest/download/FiraCode.tar.xz
curl -OLs https://github.com/ryanoasis/nerd-fonts/releases/latest/download/CommitMono.tar.xz
curl -OLs https://github.com/ryanoasis/nerd-fonts/releases/latest/download/BitstreamVeraSansMono.tar.xz

mv "$BASEDIR"/FiraCode.tar.xz /tmp
mv "$BASEDIR"/CommitMono.tar.xz /tmp
mv "$BASEDIR"/BitstreamVeraSansMono.tar.xz /tmp

cd /tmp || echo "failed to go to /tmp; tar may fail on extracting"

tar xvf FiraCode.tar.xz
tar xvf CommitMono.tar.xz
tar xvf BitstreamVeraSansMono.tar.xz

sudo mv ./*ttf /usr/share/fonts/truetype
sudo mv ./*otf /usr/share/fonts/opentype

sudo fc-cache -f -v

rm /tmp/FiraCode.tar.xz
rm /tmp/CommitMono.tar.xz
rm /tmp/BitstreamVeraSansMono.tar.xz

cd "$BASEDIR" || echo "failed to go back to $BASEDIR after installing fonts in /tmp"

# Install zsh, ohmyzsh, starship, zsh-autosuggestions, fast-syntax-highlighting
sudo apt install -y zsh
# Get Ohmyzsh, this also changes default shell to zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

# Install fast syntax highlighting
git clone https://github.com/zdharma-continuum/fast-syntax-highlighting.git "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/fast-syntax-highlighting"

# Install auto-suggestions
git clone https://github.com/zsh-users/zsh-autosuggestions "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions"

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
# xargs brew install < "${BASEDIR}/Brewfile"
brew bundle "${BASEDIR}/Brewfile"
ulimit -n "$BEFORE_ULIMIT_CHANGE"

# Set bat themes https://github.com/catppuccin/bat
mkdir -p "$(bat --config-dir)/themes"
wget -P "$(bat --config-dir)/themes" https://github.com/catppuccin/bat/raw/main/themes/Catppuccin%20Latte.tmTheme
wget -P "$(bat --config-dir)/themes" https://github.com/catppuccin/bat/raw/main/themes/Catppuccin%20Frappe.tmTheme
wget -P "$(bat --config-dir)/themes" https://github.com/catppuccin/bat/raw/main/themes/Catppuccin%20Macchiato.tmTheme
wget -P "$(bat --config-dir)/themes" https://github.com/catppuccin/bat/raw/main/themes/Catppuccin%20Mocha.tmTheme
bat cache --build

git clone --depth 1 https://github.com/junegunn/fzf.git "$HOME/.fzf"
bash "$HOME/.fzf/install"
# automatically checks and adds necessary additions to shell scripts, but we did that before, at this point it should be there

# Get Micro as a text editor
curl https://getmic.ro | bash
# move it to bin for systemwide
sudo mv -i ./micro /usr/bin

# Setup micro, make a directory if not exists, and copy recursively settings and colorschemes
cp -r "$BASEDIR/micro" "$HOME/.config"

# Get NVM
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash

# brew install fnm
# enable fnm for session
eval "$(fnm env --use-on-cd --shell zsh)"
LATEST_NODE_MAJOR=$(fnm ls-remote | tail -1 | tr -d v | cut -d. -f1)
fnm install "$LATEST_NODE_MAJOR"

# install global npm packages
while read -r package; do npm i -g "$package"; done < "$BASEDIR/npm-global-packages.txt"

# Install terminator
# sudo apt install -y terminator

# copy over terminator config
# mkdir -p $HOME/.config/terminator
# cp $BASEDIR/terminator.config $HOME/.config/terminator/config

# Install wezterm
curl -fsSL https://apt.fury.io/wez/gpg.key | sudo gpg --yes --dearmor -o /usr/share/keyrings/wezterm-fury.gpg
echo 'deb [signed-by=/usr/share/keyrings/wezterm-fury.gpg] https://apt.fury.io/wez/ * *' | sudo tee /etc/apt/sources.list.d/wezterm.list
sudo chmod 644 /usr/share/keyrings/wezterm-fury.gpg
sudo apt update
sudo apt install wezterm

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

sudo apt install pandoc

read -r -p "Do you want to install texlive now? (y/n) " REPLY
if [[ $REPLY =~ ^[Yy]$ ]]; then
    echo "Installing texlive"
  sudo apt install texlive
else
    echo "Skipping texlive installation"
    echo "To install texlive later, run the following command:"
    echo "sudo apt install texlive"
fi

# Eisvogel Latex template - https://github.com/Wandmalfarbe/pandoc-latex-template
wget "https://raw.githubusercontent.com/Wandmalfarbe/pandoc-latex-template/master/eisvogel.tex"
mkdir -p "$HOME/.local/share/pandoc/templates"
mv "$BASEDIR/eisvogel.tex" "$HOME/.local/share/pandoc/templates/eisvogel.tex"

## VSCODE https://code.visualstudio.com/
# GOOGLE CHROME https://www.google.com/chrome/
# TRANSMISSION https://transmissionbt.com/download

# ---


# Install other utilities

sudo apt install rlwrap # wrap another program in readline

# Rust
command curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
[ -f "$HOME/.cargo/env" ] && source "$HOME/.cargo/env" # add to path for this script

cargo install xcp http-server oxipng tinted-builder-rust xcp

# Golang
# The "go" command should already be there through brew
mkdir -p "$HOME/code/go"
export GOPATH="$HOME/code/go"
export PATH=${GOPATH:=$HOME/go}/bin:$PATH # Add Go bin to path

while read -r package; do go install "$package"; done < "$BASEDIR/go-binary-packages.txt"
# golang.org/x/tools/cmd/{gopls,staticcheck} should be prompted to be installed from the go vscode extension anyways
