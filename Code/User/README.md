# ~/.config/Code/User

This directory contains [user configuration][vs] for Visual Studio Code.

[vs]: https://code.visualstudio.com/docs/getstarted/settings

## Setup

`settings.json`, `keybindings.json`, and `snippets/` should be symlinked into:

- **Windows:** `%APPDATA%\Code\User`
- **macOS:** `$HOME/Library/Application Support/Code/User`

On Windows/Cygwin machines without admin privileges, this script concatenates
the base `settings.json` with the Windows-specific `windows/…/settings.json` and
filters out non-Windows settings from `windows/…/macos_settings.json`, then
installs the results to `%APPDATA%\Code\User`:

```sh
~/.config/bin/vscode-sync-settings.fish
```

## Extensions

Use `~/.config/bin/vscode-extensions` to manage extensions against the
`extensions.json` file in this directory.

To install everything listed in `extensions.json`:

```sh
~/.config/bin/vscode-extensions install
```

To uninstall everything _not_ listed:

```sh
~/.config/bin/vscode-extensions cleanup
```

To overwrite `extensions.json` with the current loadout:

```sh
~/.config/bin/vscode-extensions dump
```

You can also copy `extensions.json` into a project's `.vscode` directory and use
it as a template for workspace recommendations.
