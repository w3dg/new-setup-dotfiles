## Dotfiles and setup

I have come to the conclusion of having a consistent setup between things so that its easy to focus. Most of the things here are things I am using and have recently been configured to use the [catppuccin theme](https://catppuccin.com/)

## Development / Shell Setup

Get nerd fonts - https://github.com/ryanoasis/nerd-fonts/
- FiraCode ( current )
- Meslo
- Cascadia
- Code New Roman
- Hack
- Jetbrains mono
- Martian mono
- Recursive mono
- Roboto mono
- Zed mono
- Inconsolata Go
- Intel One Mono

```
# Install

sudo mv *ttf /usr/share/fonts/truetype
sudo mv *otf /usr/share/fonts/opentype

sudo fc-cache -f -v 
```

Get `zsh`, [ohmyzsh](https://github.com/ohmyzsh/ohmyzsh), [`zsh-autosuggestions`](https://github.com/zsh-users/zsh-autosuggestions), [`zsh-syntax-highlighting`](https://github.com/zsh-users/zsh-syntax-highlighting)

- Grab the sourced shell script here for syntax highlighting - https://github.com/catppuccin/zsh-syntax-highlighting

Most of the command line things I install via [brew](https://brew.sh)

```sh
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
 ```

Brewfile - 

```
bat
cmatrix
cowsay
exiftool
eza
fd
ffmpeg
fortune
git-delta
glow
go
httpie
lolcat
ripgrep
speedtest-cli
trash-cli
whois
zoxide
```

Get `fzf`. Check shell init file for loading it in.
`zoxide`. Check shell init file for loading it in for the correct shell (zsh/bash).

Delta catppuccin - https://github.com/catppuccin/delta/blob/main/catppuccin.gitconfig

Micro as the text editor - 
```sh
curl https://getmic.ro | bash
# move it to bin for systemwide
sudo mv ./micro /usr/bin
```

Powerlevel10k theme

https://github.com/romkatv/powerlevel10k

Use `p10k-catppuccin-configured.zsh` for fixed directory color for prompt. See changes below

```
# Change this color from the default colorscheme one
typeset -g POWERLEVEL9K_DIR_BACKGROUND=68
```

- See https://github.com/romkatv/powerlevel10k#directory-is-difficult-to-see-in-prompt-when-using-rainbow-style

Additional changes made to bat https://github.com/catppuccin/bat and fzf https://github.com/catppuccin/fzf

Get catppuccin for micro as well - https://github.com/catppuccin/micro and activate it

Install NVM

https://github.com/nvm-sh/nvm

Get npm global packages

```
# do some shenanigans on the file and install globally
sed -e "s/\/.*//g" -e "s/^$//g"  -e "s/├── //g" -e "s/└── //g" -e "s/@.*//g" npm-global-packages.txt | xargs npm i -g
```

## VSCode

Extensions

```
adpyke.codesnap
albert.tabout
andys8.jest-snippets
bierner.github-markdown-preview
bierner.markdown-checkbox
bierner.markdown-emoji
bierner.markdown-footnotes
bierner.markdown-mermaid
bierner.markdown-preview-github-styles
bierner.markdown-yaml-preamble
bradlc.vscode-tailwindcss
burkeholland.simple-react-snippets
catppuccin.catppuccin-vsc
christian-kohler.npm-intellisense
dbaeumer.vscode-eslint
dsznajder.es7-react-js-snippets
eamodio.gitlens
editorconfig.editorconfig
esbenp.prettier-vscode
fosshaas.fontsize-shortcuts
github.copilot
github.copilot-chat
github.github-vscode-theme
github.vscode-pull-request-github
golang.go
heybourn.headwind
johnpapa.vscode-cloak
miguelsolorio.symbols
mikestead.dotenv
ms-azuretools.vscode-docker
ms-python.debugpy
ms-python.python
ms-python.vscode-pylance
ms-vscode.cpptools
ms-vsliveshare.vsliveshare
mvllow.rose-pine
orta.vscode-jest
prisma.prisma
redhat.java
sleistner.vscode-fileutils
sndst00m.vscode-native-svg-preview
stivo.tailwind-fold
unifiedjs.vscode-mdx
usernamehw.errorlens
visualstudioexptteam.intellicode-api-usage-examples
visualstudioexptteam.vscodeintellicode
vscjava.vscode-java-debug
vscjava.vscode-java-pack
vscjava.vscode-java-test
vscode-icons-team.vscode-icons
wallabyjs.quokka-vscode
wix.vscode-import-cost
```

Copy this to extensions.txt, and install one by one like below

```sh
xargs code --install-extension < extensions.txt 
```

Settings.json ( should be synced, use settings sync )

```
{
  "terminal.integrated.minimumContrastRatio": 1,
  "gopls": {
    "ui.semanticTokens": true
  },
  "editor.lineHeight": 2,
  "editor.semanticHighlighting.enabled": true,
  "explorer.compactFolders": false, // dont clamp empty folders together
  "workbench.startupEditor": "none",
  "editor.formatOnPaste": true,
  "editor.tabSize": 2,
  "editor.fontFamily": "FiraCode Nerd Font Mono",
  "editor.fontWeight": "400",
  "editor.fontLigatures": true,
  "editor.cursorWidth": 3,
  "window.dialogStyle": "custom",
  "explorer.decorations.badges": false,
  "workbench.sideBar.location": "right",
  "workbench.colorCustomizations": {
    "[Night Owl]": {
      "activityBar.background": "#000C1D",
      "activityBar.border": "#102a44",
      "editorGroup.border": "#102a44",
      "sideBar.background": "#001122",
      "sideBar.border": "#102a44",
      "sideBar.foreground": "#8BADC1"
    },
    "[Night Owl (No Italics)]": {
      "activityBar.background": "#000C1D",
      "activityBar.border": "#102a44",
      "editorGroup.border": "#102a44",
      "sideBar.background": "#001122",
      "sideBar.border": "#102a44",
      "sideBar.foreground": "#8BADC1"
    },
    "[Just Black + Comments]": {
      "titleBar.inactiveBackground": "#000000"
    }
  },
  "editor.suggestSelection": "first",
  "editor.minimap.enabled": false,
  "files.associations": {
    "*.css": "tailwindcss"
  },
  "editor.quickSuggestions": {
    "strings": true
  },
  "[jsonc]": {
    "editor.defaultFormatter": "vscode.json-language-features",
    "editor.formatOnSave": true
  },
  "[javascript]": {
    "editor.defaultFormatter": "esbenp.prettier-vscode",
    "editor.formatOnSave": true
  },
  "[html]": {
    "editor.defaultFormatter": "esbenp.prettier-vscode",
    "editor.formatOnSave": true
  },
  "[json]": {
    "editor.defaultFormatter": "esbenp.prettier-vscode"
  },
  "[javascriptreact]": {
    "editor.defaultFormatter": "esbenp.prettier-vscode"
  },
  "[typescript]": {
    "editor.defaultFormatter": "esbenp.prettier-vscode"
  },
  "window.autoDetectHighContrast": false,
  "extensions.ignoreRecommendations": true,
  "debug.console.fontSize": 16,
  "editor.multiCursorModifier": "ctrlCmd",
  "editor.minimap.renderCharacters": false,
  "workbench.tree.indent": 20,
  "editor.formatOnSave": true,
  "window.newWindowDimensions": "maximized",
  "explorer.confirmDragAndDrop": false,
  "editor.find.addExtraSpaceOnTop": false,
  "markdown.preview.lineHeight": 1,
  "workbench.editor.enablePreview": false,
  "explorer.confirmDelete": false,
  "javascript.updateImportsOnFileMove.enabled": "always",
  "update.showReleaseNotes": false,
  "telemetry.telemetryLevel": "off",
  "files.autoSaveDelay": 0,
  "explorer.incrementalNaming": "smart",
  "editor.wordWrapColumn": 100,
  "fontshortcuts.step": 0.1,
  "fontshortcuts.defaultTerminalFontSize": 18,
  "fontshortcuts.defaultFontSize": 16,
  "files.autoSave": "onFocusChange",
  "editor.cursorBlinking": "smooth",
  "emmet.includeLanguages": {
    "javascript": "javascriptreact"
  },
  "editor.tokenColorCustomizations": {
    "textMateRules": []
  },
  "reactSnippets.settings.importReactOnTop": false,
  "editor.formatOnType": true,
  "terminal.integrated.fontWeight": "400",
  "editor.renderLineHighlight": "gutter",
  "git.confirmSync": false,
  "workbench.settings.openDefaultKeybindings": true,
  "terminal.integrated.tabs.enabled": true,
  "terminal.integrated.cursorBlinking": true,
  "window.title": "${rootName}${separator}${appName}",
  "editor.inlineSuggest.enabled": true,
  "security.workspace.trust.untrustedFiles": "open",
  "editor.bracketPairColorization.enabled": true,
  "editor.suggest.preview": true,
  "[java]": {
    "editor.defaultFormatter": "redhat.java"
  },
  "window.titleBarStyle": "custom",
  "go.toolsManagement.autoUpdate": true,
  "prettier.printWidth": 120,
  "eslint.validate": [
    "javascript",
    "typescript"
  ],
  "files.eol": "\n",
  "vsicons.dontShowNewVersionMessage": true,
  "[markdown]": {
    "editor.defaultFormatter": "esbenp.prettier-vscode"
  },
  "editor.renderWhitespace": "none",
  "workbench.layoutControl.enabled": false,
  "editor.linkedEditing": true,
  "editor.codeLensFontFamily": "FiraCode Nerd Font Mono",
  "git.openRepositoryInParentFolders": "never",
  "typescript.updateImportsOnFileMove.enabled": "always",
  "editor.inlayHints.enabled": "offUnlessPressed",
  "workbench.iconTheme": "symbols",
  "[typescriptreact]": {
    "editor.defaultFormatter": "esbenp.prettier-vscode"
  },
  "tailwind-fold.autoFold": false,
  "editor.cursorSmoothCaretAnimation": "on",
  "terminal.integrated.fontSize": 15,
  "symbols.hidesExplorerArrows": false,
  "editor.inlineSuggest.fontFamily": "FiraCode Nerd Font Mono",
  "editor.fontSize": 15,
  "codesnap.backgroundColor": "#00000000",
  "codesnap.showLineNumbers": false,
  "codesnap.showWindowControls": false,
  "codesnap.shutterAction": "copy",
  "codesnap.transparentBackground": true,
  "breadcrumbs.enabled": false,
  "github.copilot.enable": {
    "*": true,
    "plaintext": false,
    "markdown": false,
    "scminput": false
  },
  "workbench.colorTheme": "Catppuccin Mocha",
  "window.density.editorTabHeight": "compact",
  "prisma.showPrismaDataPlatformNotification": false,
  "gitlens.launchpad.indicator.enabled": false
}
```

Keybindings - 

```
// Place your key bindings in this file to override the defaults
[
  {
    "key": "ctrl+shift+/",
    "command": "editor.action.blockComment",
    "when": "editorTextFocus"
  },
  {
    "key": "ctrl+n",
    "command": "fileutils.newFileAtRoot",
  },
  {
    "key": "ctrl+0",
    "command": "-workbench.action.zoomReset"
  },
  {
    "key": "ctrl+numpad_add",
    "command": "-workbench.action.zoomIn"
  },
  {
    "key": "ctrl+-",
    "command": "-workbench.action.zoomOut"
  },
  {
    "key": "ctrl+shift+-",
    "command": "-workbench.action.zoomOut"
  },
  {
    "key": "ctrl+numpad_subtract",
    "command": "-workbench.action.zoomOut"
  },
  {
    "key": "ctrl+numpad_add",
    "command": "editor.action.fontZoomIn"
  },
  {
    "key": "ctrl+numpad_subtract",
    "command": "editor.action.fontZoomOut"
  },
  {
    "key": "ctrl+numpad0",
    "command": "editor.action.fontZoomReset"
  },
  {
    "key": "ctrl+tab",
    "command": "workbench.action.terminal.focusNext",
    "when": "terminalFocus"
  },
  {
    "key": "ctrl+w",
    "command": "workbench.action.terminal.kill",
    "when": "terminalFocus"
  },
  {
    "key": "ctrl+n",
    "command": "workbench.action.terminal.new",
    "when": "terminalFocus"
  },
  {
    "key": "shift+alt+up",
    "command": "editor.action.copyLinesUpAction",
    "when": "editorTextFocus && !editorReadonly"
  },
  {
    "key": "ctrl+shift+alt+up",
    "command": "-editor.action.copyLinesUpAction",
    "when": "editorTextFocus && !editorReadonly"
  },
  {
    "key": "shift+alt+down",
    "command": "editor.action.copyLinesDownAction",
    "when": "editorTextFocus && !editorReadonly"
  },
  {
    "key": "ctrl+shift+alt+down",
    "command": "-editor.action.copyLinesDownAction",
    "when": "editorTextFocus && !editorReadonly"
  }
]
```
---

- [SSH Access to github](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent)
- [GPG Signing for commits](https://docs.github.com/en/authentication/managing-commit-signature-verification/about-commit-signature-verification)
- *change signing key in gitconfig if needed*

---

See [other software](./install-other-software.md)

---

## Software 

- auto-cpufreq, thermald
- Discord
- Slack
- Notion / notion-snap-reborn packaged as a snap
- Google Chrome
- Docker
- Protonvpn
- mailspring
- Telegram
- Transmission
- Insomnia
- VLC
- GIMP
- Sublime Text
- Gnome Tweaks
	 - Gnome Extension manager
	 	- Color picker by color-picker@tuberry
	 	- Unblank lock screen by unblank@sun.wxg@gmail.com
