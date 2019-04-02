# ~/.config/Code/User

This directory contains [user configuration][vs] for Visual Studio Code.

[vs]: https://code.visualstudio.com/docs/getstarted/settings

`snippets/`, `settings.json` and `keybindings.json` should be symlinked into:

- **Windows:** `%APPDATA%\Code\User`
- **macOS:**   `$HOME/Library/Application Support/Code/User`

On Windows/Cygwin machines without admin privileges, to concatenate the base
`settings.json` file with `settings.windows.json` and install it to `$APPDATA`:

    ~/.config/bin/vscode-sync-settings.fish

## Extensions

To install everything listed in `extensions` (and uninstall everything _not_
listed):

    ~/.config/bin/vscode-sync-extensions.fish

To overwrite `extensions` with the current loadout:

    code --list-extensions | tee ~/.config/Code/User/extensions

To list `extensions` combined with the current loadout (`fish` syntax):

    cat ~/.config/Code/User/extensions (code --list-extensions | psub) | sort -uf
