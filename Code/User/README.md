# ~/.config/Code/User

This directory contains [user configuration][vs] for Visual Studio Code.

[vs]: https://code.visualstudio.com/docs/getstarted/settings

`snippets/`, `settings.json` and `keybindings.json` should be symlinked into:

- **Windows:** `%APPDATA%\Code\User`
- **macOS:**   `$HOME/Library/Application Support/Code/User`

Run `~/.config/misc/vscode-sync-settings.fish` on Windows/Cygwin machines 
without admin privileges to concatenate `settings.windows.json` with the base
`settings.json` file and install it to `$APPDATA`.

## Extensions

Run `~/.config/misc/vscode-sync-extensions.fish` to install everything listed 
in `extensions` and uninstall everything _not_ listed.

Run `code --list-extensions | tee ~/.config/Code/User/extensions` to update the
extensions file with the current loadout.
