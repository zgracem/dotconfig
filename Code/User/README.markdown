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

Use `~/.config/bin/vscode-extensions` to manage extensions against the
`extensions` file in this directory.

To install everything listed in `extensions`:

    ~/.config/bin/vscode-extensions install

To uninstall everything _not_ listed:

    ~/.config/bin/vscode-extensions cleanup

To overwrite `extensions` with the current loadout:

    ~/.config/bin/vscode-extensions dump
