# ~/.config/Code/User

This directory contains [user configuration][vs] for Visual Studio Code.

`settings.json` should be symlinked to the following location:

- **Windows:** `%APPDATA%\Code\User`
- **macOS:**   `$HOME/Library/Application Support/Code/User`

[vs]: https://code.visualstudio.com/docs/getstarted/settings

Run `./misc/vscode-sync-extensions.fish` to install everything listed in 
`extensions` and uninstall everything _not_ listed.
