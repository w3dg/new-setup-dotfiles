#!/usr/bin/bash

# Function to keep sudo credentials fresh
keep_sudo_alive() {
    sudo -v
    while true; do
        sudo -n true
        sleep 50
        kill -0 "$$" 2>/dev/null || exit
    done 2>/dev/null &
    SUDO_KEEPALIVE_PID=$!
}

# Function to stop the keep-alive process
stop_sudo_keepalive() {
    if [ -n "$SUDO_KEEPALIVE_PID" ]; then
        kill "$SUDO_KEEPALIVE_PID" 2>/dev/null
        wait "$SUDO_KEEPALIVE_PID" 2>/dev/null
    fi
}

keep_sudo_alive

BASEDIR=$(pwd)

# Update and upgrade your base system
sudo apt update -y && sudo apt upgrade -y

# Install basic necessities
sudo apt install -y  git vim wget curl neovim

# Run linking script for linking up dotfiles
bash "$BASEDIR"/link.sh

install_nerd_font() {
    base_dir=$(pwd)
    font_name="$1"
    curl -OLs "https://github.com/ryanoasis/nerd-fonts/releases/latest/download/${font_name}.tar.xz"
    mv "${base_dir}/${font_name}.tar.xz" /tmp
    cd /tmp || echo "failed to go to /tmp" && return

    tar xvf "${font_name}.tar.xz"

    sudo mv ./*ttf /usr/share/fonts/truetype 2>/dev/null
    sudo mv ./*otf /usr/share/fonts/opentype 2>/dev/null
    rm "/tmp/${font_name}.tar.xz"
}

if cd /tmp ; then
    # Install Fira Code Nerd Font
    install_nerd_font FiraCode
    install_nerd_font CommitMono
    install_nerd_font Inconsolata
    install_nerd_font Hack
    install_nerd_font JetBrainsMono
    install_nerd_font NotoMono
    install_nerd_font RobotoMono
    install_nerd_font AdwaitaMono

    sudo fc-cache -f -v
else
    echo "===== failed to go to /tmp for installing fonts, install them manually ====="
fi

cd "$BASEDIR" || echo "failed to go back to $BASEDIR after installing fonts in /tmp"

sudo apt install -y zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

git clone https://github.com/zdharma-continuum/fast-syntax-highlighting.git "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/fast-syntax-highlighting"

git clone https://github.com/zsh-users/zsh-autosuggestions "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions"

## Install HomeBrew non-interactively
NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Make sure brew is found in path during this install
export PATH=$HOME/bin:/usr/local/bin:$PATH
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

# Install from brewfile
# Temporarily increase system's file descriptor limit so that brew passes while installing lots of packages

BEFORE_ULIMIT_CHANGE=$(ulimit -n)
ulimit -n 65535
# xargs brew install < "${BASEDIR}/Brewfile"
brew bundle install --file="${BASEDIR}/Brewfile"
ulimit -n "$BEFORE_ULIMIT_CHANGE"

# Set bat themes https://github.com/catppuccin/bat
mkdir -p "$(bat --config-dir)/themes"
wget -P "$(bat --config-dir)/themes" https://github.com/catppuccin/bat/raw/main/themes/Catppuccin%20Latte.tmTheme
wget -P "$(bat --config-dir)/themes" https://github.com/catppuccin/bat/raw/main/themes/Catppuccin%20Frappe.tmTheme
wget -P "$(bat --config-dir)/themes" https://github.com/catppuccin/bat/raw/main/themes/Catppuccin%20Macchiato.tmTheme
wget -P "$(bat --config-dir)/themes" https://github.com/catppuccin/bat/raw/main/themes/Catppuccin%20Mocha.tmTheme
bat cache --build

git clone --depth 1 https://github.com/junegunn/fzf.git "$HOME/.fzf"
bash "$HOME"/.fzf/install --all
# automatically checks and adds necessary additions to shell scripts, but we did that before, at this point it should be there

# Get Micro as a text editor
curl -s https://getmic.ro | bash
# move it to bin for systemwide
sudo mv -i ./micro /usr/local/bin

# Setup micro, make a directory if not exists, and copy recursively settings and colorschemes
cp -r "$BASEDIR/micro" "$HOME/.config"

# Get NVM
# curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash

# enable fnm for session
eval "$(fnm env --use-on-cd --shell zsh)"
LATEST_NODE_MAJOR=$(fnm ls-remote | tail -1 | tr -d v | cut -d. -f1)
fnm install "$LATEST_NODE_MAJOR"

# Install wezterm
curl -fsSL https://apt.fury.io/wez/gpg.key | sudo gpg --yes --dearmor -o /usr/share/keyrings/wezterm-fury.gpg
echo 'deb [signed-by=/usr/share/keyrings/wezterm-fury.gpg] https://apt.fury.io/wez/ * *' | sudo tee /etc/apt/sources.list.d/wezterm.list
sudo chmod 644 /usr/share/keyrings/wezterm-fury.gpg
sudo apt update -y && sudo apt install -y wezterm

sudo apt -y install wl-clipboard  # wl-copy for wayland https://superuser.com/questions/1189467/how-to-copy-text-to-the-clipboard-when-using-wayland

# Zathura for pdf
sudo apt install -y zathura

########################## OTHER SOFTWARE #########################

## Install snaps

echo "Installing Snap and snaps - mailspring, notion, calendar, telegram, slack"
sudo apt install -y snapd
sudo snap install mailspring notion-snap-reborn telegram-desktop slack notion-calendar-snap

echo "Installing Flatpaks, RESTART NEEDED LATER TO MANUALLY INSTALL FLATPAKS"

sudo apt install flatpak
sudo apt install gnome-software-plugin-flatpak
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

## Restart needed ##
## install dconf-editor, discord, stretchly, fedora media writer as flatpaks
# ca.desrt.dconf-editor com.discordapp.Discord net.hovancik.Stretchly org.fedoraproject.MediaWriter

# OBS Studio
sudo apt install -y obs-studio

# Install TexLive and Eisvogel

read -r -p "Do you want to install texlive now? (y/n) " REPLY
if [[ $REPLY =~ ^[Yy]$ ]]; then
    echo "Installing texlive"
    sudo apt install -y texlive
else
    echo "Skipping texlive installation"
    echo "To install texlive later, run the following command:"
    echo "sudo apt install texlive"
fi

# Eisvogel Latex template - https://github.com/Wandmalfarbe/pandoc-latex-template
mkdir -p "$HOME/.local/share/pandoc/templates"
echo "======"
echo "Install eisvogel.latex in $HOME/.local/share/pandoc/templates"
echo "======"

## VSCODE https://code.visualstudio.com/
# GOOGLE CHROME https://www.google.com/chrome/
# TRANSMISSION https://transmissionbt.com/download

# ---

# Install other utilities
sudo apt install -y rlwrap # wrap another program in readline

# Rust
command curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
# shellcheck disable=SC1091
[ -f "$HOME/.cargo/env" ] && source "$HOME/.cargo/env" # add to path for this script

cargo install xcp http-server oxipng tinted-builder-rust xcp

# Golang
# The "go" command should already be there through brew
mkdir -p "$HOME/code/go"
export GOPATH="$HOME/code/go"
export PATH=${GOPATH:=$HOME/go}/bin:$PATH # Add Go bin to path

while read -r package; do go install "$package"; done < "$BASEDIR/go-binary-packages.txt"
# golang.org/x/tools/cmd/{gopls,staticcheck} should be prompted to be installed from the go vscode extension anyways

# Install global npm packages
while read -r package; do npm i -g "$package"; done < "$BASEDIR/npm-global-packages.txt"

stop_sudo_keepalive
