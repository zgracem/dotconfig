# ~/.config

Some people prune bonsai trees. I refactor my dotfiles.

## Usage

```sh
cd "$XDG_CONFIG_HOME"

# Initial setup:
make homebrew
make appsupport
make all

# Targets not included in `all`:
make user-agent
make -C etc shells
make -C etc/dnsmasq
make -C stow calendar
make -C stow words

# Uninstall:
make user-agent/clean
make -C bin uninstall
make -C brew clean
make -C dircolors clean
make -C etc/dnsmasq uninstall
make -C etc emond/uninstall
make -C etc ssh/uninstall
make -C jq uninstall
make -C launchd uninstall
```
