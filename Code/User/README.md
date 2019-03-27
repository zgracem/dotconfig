# ~/.config/Code/User

This directory contains [user configuration][vs] for Visual Studio Code.

[vs]: https://code.visualstudio.com/docs/getstarted/settings

`settings.json` and `keybindings.json` should be symlinked into:

- **Windows:** `%APPDATA%\Code\User`
- **macOS:**   `$HOME/Library/Application Support/Code/User`

Run `~/.config/misc/vscode-sync-extensions.fish` to install everything listed 
in `extensions` and uninstall everything _not_ listed.
