# ~/.config

## Shell startup files

* `environment.sh` loads environment variables from `environment.d/*.sh` 
  for all POSIX shells
    * `launchctl` makes them available to macOS GUI apps
* `~/.profile` is a symlink to `sh/profile.sh`, and sources `sh/profile.d/*.sh`
* `~/.bashrc` is a symlink to `bash/bashrc.bash`, and sources `bash/_*.bash`, 
  `bash/*.d/*.bash`, and (if present) `~/.local/config/bashrc.d/*.bash`
  * `~/.local` contains symlinks to the contents of `local/$HOSTNAME`,
    if it exists
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
- `.ssh/` ← symlink to `~/.private/ssh`
- `etc/terminfo/` ← custom terminfo source files
- `lib/bash/`
    - [`fxdoc`](https://github.com/zgracem/fxdoc)
    - [`wtf.bash`](https://github.com/zgracem/wtf.bash)

Then:

```bash
cd ~/.config && make shell-files symlinks
# after restarting the shell
cd ~/etc/terminfo && make install
# then restart the whole terminal emulator
```
