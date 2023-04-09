# ~/.config/Code/User

This directory contains [user configuration][vs] for Visual Studio Code.

[vs]: https://code.visualstudio.com/docs/getstarted/settings

## Setup

VS Code's built-in [settings sync] is now reliable enough to handle merging
platform-specific configuration without external tools like `jq`.

[settings sync]: https://code.visualstudio.com/docs/editor/settings-sync

### macOS

`settings.json`, `keybindings.json`, and `snippets/` should be symlinked into
`$HOME/Library/Application Support/Code/User`.

### Windows

`windows/Code/User/settings.json` should be symlinked into `%APPDATA%\Code\User`.

## Extensions

Use `~/.config/bin/vsx` to manage extensions against the `extensions.json` file
in this directory.

To install everything listed in `extensions.json`:

```sh
vsx install
```

To uninstall everything _not_ listed:

```sh
vsx cleanup
```

To overwrite `extensions.json` with the current loadout:

```sh
vsx dump
```

You can also copy `extensions.json` into a project's `.vscode` directory and use
it as a template for workspace recommendations.
