# ~/.config

Some people prune bonsai trees. I refactor my dotfiles.

## Usage

```sh
cd "$XDG_CONFIG_HOME"

# Initial setup:
make homebrew           # install Homebrew & formulae
make -C etc shells      # setup /etc/shells and `chsh -s /usr/local/bin/fish`
make appsupport         # create symlinks from ~/Library/Application Support to ~/.config
make -C etc dnsmasq     # install config for local *.test TLD
make user-agent         # rebuild files like .wgetrc with a fake user-agent
make all                # everything else

# To uninstall:
make user-agent/clean           # remove built files
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
make ~/Dropbox/.mignore         # (re)install Maestral ignore file

# Cygwin setup:
make -C cygwin appdata  # create symlinks from %APPDATA% to ~/.config
make -C cygwin/putty    # install & configure portable PuTTY
make -C cygwin          # everything else
```
