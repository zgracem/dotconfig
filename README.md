# ~/.config

Some people prune bonsai trees. I refactor my dotfiles.

## Shell startup files

* `environment.sh` loads environment variables from `environment.d/*.sh` 
  for all POSIX shells
    * `launchctl` makes them available to macOS GUI apps
* `~/.profile` symlinks to `sh/profile.sh`, and sources the contents of 
  `sh/profile.d`
* `~/.bashrc` symlinks to `bash/bashrc.bash`, and sources `bash/_*.bash`,
  the contents of `bash/*.d`, and (if present) the contents of
  `~/.local/config/bashrc.d`
    * `~/.local` symlinks to `~/.config/local/$HOSTNAME`, if it exists
* `bash/init.bash` and (if present) `~/.local/config/init.bash` are sourced 
  immediately before the first prompt
* `bash/logout.bash` and (if present) `~/.local/config/logout.bash` are sourced
  when the shell exits

## Setting up a new homedir

Minimum requirements:

- `.config/` ← this repo
    - `bash/`
    - `dircolors/`
    - `environment.d/`
    - `sh/`
    - `vim/`
    - `environment.sh`
    - `inputrc`
- `.private/` ← from encrypted repo
    - `bashrc.d`
    - `environment.d`
    - `ssh`
- `etc/terminfo/` ← custom terminfo source files
- `lib/bash/`
    - [`fxdoc`](https://github.com/zgracem/fxdoc)
    - [`wtf.bash`](https://github.com/zgracem/wtf.bash)

Then:

```bash
cd ~ && ln -s .private/ssh ~/.ssh
cd ~/.config && make shell-files symlinks
# after restarting the shell
cd ~/etc/terminfo && make install
# then restart the whole terminal emulator
```
