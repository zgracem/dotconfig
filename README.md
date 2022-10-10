# ~/.config

Some people prune bonsai trees. I refactor my dotfiles.

## Usage

```sh
cd "$XDG_CONFIG_HOME"

# Initial setup:
make homebrew           # install Homebrew & formulae
make appsupport         # create symlinks in ~/Library/Application Support
make all                # everything else

# Targets not included in `all`:
make user-agent         # rebuild files like .wgetrc with a fake user-agent
make -C etc shells      # setup /etc/shells and `chsh` to /usr/local/bin/fish
make -C etc dnsmasq     # install config for local *.test TLD
make -C stow calendar   # install BSD calendar files
make -C stow words      # concat files in /usr/share/dict to a custom words file

# Uninstall:
make user-agent/clean
make -C bin uninstall           # uninstall shims from ~/bin
make -C brew clean              # remove .lock.json files from `brew bundle`
make -C dircolors clean         # remove built .ls_colors files
make -C etc dnsmasq/uninstall   # remove config from /etc and /usr/local/etc
make -C etc emond/uninstall     # disable console spam fix
make -C etc ssh/uninstall       # remove custom {ssh,sshd}_config from /etc/ssh
make -C jq uninstall            # remove modules for `jq` from $XDG_DATA_HOME
make -C launchd uninstall       # install LaunchAgent that sets env vars

# Misc:
make bat/syntax                 # install/update syntax files for `bat`
make -C brew brew/install       # install/update Homebrew formulae
make -C brew cask/install       # install/update Homebrew Casks
make ~/Dropbox/.mignore         # reinstall Maestral ignore file
```
