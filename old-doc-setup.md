# My Setup :computer:

### Visual Studio Code <\\>

#### Themes ➕ Extensions

check out this [gist](https://gist.github.com/47b6902a8cb1cdebe1164378448bb784) for that.

> This may not get updated very regularly, i have settings sync enabled. Will try to update as soon as possible. :)

## :pancakes: MongoDB

## 💠 Node.js

Get it here:- https://nodejs.dev/

npm_global modules access - https://docs.npmjs.com/resolving-eacces-permissions-errors-when-installing-packages-globally

Check npm-global-packages.txt for updated list of global packages

Login to Vercel - `vercel login`
Login to npm 

**IMPORTANT** **WINDOWS**

https://github.com/yarnpkg/yarn/issues/990  
 SPEED UP NODE | DISABLE AntiVirus ON DEV FOLDER AND NODE AND NPM AND YARN

## Heroku

Get it (CLI ) here:- https://devcenter.heroku.com/articles/heroku-cli
Login to heroku - `heroku login`

## :ice_cream: Scoop packages

Install Scoop ( on windows ) : https://scoop.sh/

Check ScoopApps.md file in the repo

## :zap: Terminal

Windows Terminal :- https://github.com/microsoft/terminal/releases
I use Git Bash as the shell and preferably, starship as the prompt. (on windows )
Git bash comes installed with Git
Get it from the Github repo or the Microsoft Store.

## :earth_americas: Chrome/Brave

#### Extensions for Chrome/Brave

- Bitwarden
- Dark Reader
- DuckDuckGo Privacy Essentials
- Enhancer for Youtube
- Github File Icons
- JSON Viewer
- React / Vue Dev tools
- Refined Github
- Stylus
- Tabliss
- Twitch Auto Bonus
- uBlock Origin
- Glide - https://github.com/KraXen72/glide OR Startpage https://github.com/deepjyoti30/startpage
- minimal twitter

## :coffee: **JDK** Java Development Kit

Download the latest one

Set the **Path** variable for Java, Visual Studio Code, etc

## 🎁 Other Stuff and programs (Productivity, Wireframing, Chatting etc. )

- **Discord** Get it:- https://discordapp.com/download
- **UELI** app launcher Get it:- https://ueli.app/#/
- **WOX** app launcher Get it:- https://github.com/Wox-launcher/Wox
- **Sumatra PDF** for pdfs Get it:- https://www.sumatrapdfreader.org/download-free-pdf-viewer.html
- **7 Zip** File Compresser Get it here:- https://www.7-zip.org/
- **Everything** Both installer and command line interface (Required by UELI). Get it:- https://www.voidtools.com/downloads/
- **OBS Studio** Record Screen, Stream etc. Get it here:- https://obsproject.com/
- **Python** Just in case Get it:- https://www.python.org/
- **Figma** Wireframing and prototyping. Use in the browser https://www.figma.com/ or download the Desktop Client: https://www.figma.com/downloads/
- **Firefox Developer Edition** I do not use it much but... hey?
- **ROBO 3T** For mongo dbs
- **Insomnia** https://insomnia.rest/
- **Spotify**
- **Zoom**
- **Telegram**
- **Snapdrop** https://snapdrop.net
- **Notion** https://notion.so/desktop
- **Microsoft ToDo**
- **Microsoft Office**
- **Microsoft Teams**

## Terminal

Setup Git , [SSH](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/about-ssh), [GPG](https://garrytrinder.github.io/2021/09/get-verified-configure-signed-git-commit-signing-on-windows)

## VSCode

Although I am pretty sure Settings Sync will handle this all but still heres a copy of the settings file.

<details>
    <summary>Settings JSON for VSCode</summary>
    <pre>
    {
      "workbench.startupEditor": "none",
      "update.enableWindowsBackgroundUpdates": false,
      "editor.formatOnPaste": true,
      "editor.tabSize": 2,
      "editor.fontFamily": "JetBrainsMono NF, Anonymice NF",
      "editor.cursorSmoothCaretAnimation": false,
      "editor.cursorWidth": 3,
      "window.dialogStyle": "custom",
      "explorer.decorations.badges": false,
      "workbench.colorCustomizations": {},
      "editor.suggestSelection": "first",
      "java.configuration.checkProjectSettingsExclusions": false,
      "editor.minimap.enabled": false,
      "java.errors.incompleteClasspath.severity": "ignore",
      "[jsonc]": {
        "editor.defaultFormatter": "esbenp.prettier-vscode",
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
      "[vue]": {
        "editor.defaultFormatter": "octref.vetur"
      },
      "[javascriptreact]": {
        "editor.defaultFormatter": "esbenp.prettier-vscode"
      },
      "[typescript]": {
        "editor.defaultFormatter": "esbenp.prettier-vscode"
      },
      "window.autoDetectHighContrast": false,
      "extensions.ignoreRecommendations": true,
      "workbench.tree.indent": 10,
      "debug.console.fontSize": 17,
      "editor.multiCursorModifier": "ctrlCmd",
      // "editor.cursorSmoothCaretAnimation": true,
      "editor.minimap.renderCharacters": false,
      "workbench.tree.renderIndentGuides": "always",
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
      "editor.fontLigatures": false,
      "editor.wordWrapColumn": 100,
      "java.jdt.ls.java.home": "C:\\Program Files\\Java\\jdk-17.0.1",
      "fontshortcuts.step": 0.1,
      "fontshortcuts.defaultTerminalFontSize": 18,
      "fontshortcuts.defaultFontSize": 20,
      "files.autoSave": "onFocusChange",
      "editor.cursorBlinking": "smooth",
      "editor.tokenColorCustomizations": {
        "textMateRules": []
      },
      "editor.linkedEditing": true,
      "editor.formatOnType": true,
      "terminal.integrated.fontWeight": "400",
      "editor.renderLineHighlight": "gutter",
      "git.confirmSync": false,
      "editor.fontWeight": "400",
      "editor.fontSize": 18,
      "workbench.editorAssociations": {
        "*.ipynb": "jupyter.notebook.ipynb"
      },
      "terminal.integrated.defaultProfile.windows": "Git Bash",
      "workbench.settings.openDefaultKeybindings": true,
      "terminal.integrated.tabs.enabled": true,
      "terminal.integrated.cursorBlinking": true,
      "window.title": "${rootName} ${appName}",
      "editor.inlineSuggest.enabled": true,
      "workbench.iconTheme": "file-icons",
      "security.workspace.trust.untrustedFiles": "open",
      "editor.bracketPairColorization.enabled": true,
      "editor.suggest.preview": true,
      "thunder-client.codeSnippetLanguage": "js-fetch",
      "terminal.integrated.fontSize": 18,
      "breadcrumbs.filePath": "off",
      "[java]": {
        "editor.defaultFormatter": "redhat.java"
      },
      "editor.lineHeight": 1.5,
      "github.copilot.enable": {
        "*": true,
        "yaml": true,
        "plaintext": false,
        "markdown": false,
        "java": true
      },
      "window.zoomLevel": -1,
      "settingsSync.ignoredExtensions": ["sldobri.bunker"],
      "go.toolsManagement.autoUpdate": true,
      "workbench.colorTheme": "Vitesse Dark",
      "workbench.productIconTheme": "icons-carbon",
      "prettier.printWidth": 200
    }
    
</pre>
</details>

<details>
<summary>Keybindings JSON</summary>
<pre>
// Place your key bindings in this file to override the defaults
[
  {
    "key": "ctrl+shift+/",
    "command": "editor.action.blockComment",
    "when": "editorTextFocus"
  },
  { "key": "ctrl+n", "command": "extension.advancedNewFile" },
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
}
]

</pre>
</details>
