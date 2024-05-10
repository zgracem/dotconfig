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
