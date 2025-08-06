#!/bin/bash

# ANSI color codes
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
MAGENTA='\033[0;35m'
CYAN='\033[0;36m'
WHITE='\033[0;37m'
NC='\033[0m' # No Color

# Bold Color codes
BRED='\033[1;31m'
BGREEN='\033[1;32m'
BYELLOW='\033[1;33m'
BBLUE='\033[1;34m'
BMAGENTA='\033[1;35m'
BCYAN='\033[1;36m'
BWHITE='\033[1;37m'

# Background color codes
BG_RED='\033[41m'
BG_GREEN='\033[42m'
BG_YELLOW='\033[43m'
BG_BLUE='\033[44m'
BG_MAGENTA='\033[45m'
BG_CYAN='\033[46m'
BG_WHITE='\033[47m'

# Function to print in red
print_red() {
  echo -e "${RED}$1${NC}"
}

# Function to print in green
print_green() {
  echo -e "${GREEN}$1${NC}"
}

# Function to print in yellow
print_yellow() {
  echo -e "${YELLOW}$1${NC}"
}

# Function to print in blue
print_blue() {
  echo -e "${BLUE}$1${NC}"
}

# Function to print in magenta
print_magenta() {
  echo -e "${MAGENTA}$1${NC}"
}

# Function to print in cyan
print_cyan() {
  echo -e "${CYAN}$1${NC}"
}

# Function to print in white
print_white() {
  echo -e "${WHITE}$1${NC}"
}

# Function to print in bold red
print_bold_red() {
  echo -e "${BRED}$1${NC}"
}

# Function to print in bold green
print_bold_green() {
  echo -e "${BGREEN}$1${NC}"
}

# Function to print in bold blue
print_bold_blue() {
  echo -e "${BBLUE}$1${NC}"
}

print_bold_yellow() {
  echo -e "${BYELLOW}$1${NC}"
}

# Function to print with red background.
print_bg_red() {
    echo -e "${BG_RED}$1${NC}"
}

# print_red "This is red text."
# print_green "This is green text."
# print_yellow "This is yellow text."
# print_blue "This is blue text."
# print_magenta "This is magenta text."
# print_cyan "This is cyan text."
# print_white "This is white text."
# print_bold_red "This is bold red text."
# print_bold_green "This is bold green text."
# print_bold_blue "This is bold blue text."
# print_bg_red "This has red background"


print_bold_blue "Updating repositories"
sudo apt update -y

print_bold_blue "Upgrading packages"
sudo apt upgrade -y

print_bold_blue "Running dist-upgrade"
sudo apt-get -y dist-upgrade

print_bold_yellow "Running Autoremove for packages"
sudo apt -y autoremove

print_bold_yellow "Running apt clean"
sudo apt -y clean

print_bold_blue "Updating flatpaks"
flatpak update -y

print_bold_yellow "Running brew update"

BEFORE_ULIMIT_CHANGE=$(ulimit -n)

ulimit -n 65535

brew update
sleep 2
print_bold_yellow "Running brew upgrade"
brew upgrade

brew cleanup --prune=all

ulimit -n $BEFORE_ULIMIT_CHANGE

print_bold_green "Running global node modules update"
npm list -g | sed -E -e 's|^/.*$||g' -e 's/├──//g' -e 's/└──//g' -e 's/@[0-9]+\.[0-9]+\.[0-9]+//g' | xargs npm i -g

print_bold_yellow "Running global cargo packages update"
cargo install --list | awk '/v/ {print $1}' | xargs cargo install

print_bold_green "Updates finished."
