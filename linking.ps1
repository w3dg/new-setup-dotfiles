#!/usr/bin/env pwsh

# New-Item -path $HOME\.bashrc -itemType SymbolicLink -target $HOME\code\dotfiles\.bashrc

# .bashrc .bash_profile .gitconfig .inputrc .npmrc .gitignore .dircolors
$dotfiles = (".bashrc", ".bash_profile", ".dircolors", ".gitconfig", ".gitconfig", ".inputrc", ".npmrc", ".bash")

foreach ($element in $dotfiles) {
echo Linking $element
New-Item -path $HOME\$element -itemType SymbolicLink -target $HOME\code\dotfiles\$element
}

