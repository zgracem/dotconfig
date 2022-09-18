# ~/.config/Code/User

This directory contains [user configuration][vs] for Visual Studio Code.

[vs]: https://code.visualstudio.com/docs/getstarted/settings

## Setup

VS Code's built-in [settings sync] is now reliable enough to handle merging
platform-specific configuration without external tools like `jq`.

[settings sync]: https://code.visualstudio.com/docs/editor/settings-sync

### macOS

`settings.json`, `keybindings.json`, and `snippets/` should be symlinked into
`$HOME/Library/Application Support/Code/User`:

```sh
cd $XDG_CONFIG_HOME
make vscode-mac
```

### Windows

`windows/Code/User/settings.json` should be symlinked into `%APPDATA%\Code\User`:

```bat
cd %USERPROFILE%\Dropbox\.config\Code\User
mklink %APPDATA%\Code\User\settings.json windows\Code\User\settings.json
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
