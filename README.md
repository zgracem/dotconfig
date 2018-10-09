# ~/.config

## Shell startup files

* `environment.sh` loads environment variables from `environment.d/*.sh` 
  for all POSIX shells
    * `launchctl` makes them available to macOS GUI apps
* `sh/profile.sh` symlinks to `~/.profile` and sources the contents of 
  `sh/profile.d/*.sh`
* `bash/bashrc.bash` symlinks to `~/.bashrc` and sources the contents of 
  `bash/_*.bash` and `bash/*.d/*.bash`
* `local/` has per-machine configurations. The contents of each hostname subdir
  are symlinked to `~/.local` on that machine.
    * `~/.bashrc` also sources `~/.local/config/bashrc.d/*.bash`, if present
* `bash/init.bash` and (if present) `~/.local/config/init.bash` are sourced 
  immediately before the first prompt.
* `bash/logout.bash` and (if present) `~/.local/config/logout.bash` are sourced
  when the shell exits.

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
- `.private/` ← encrypted repo
- `.ssh/` ← not version controlled
    - `authorized_keys`
    - `config`
    - `id_rsa.pub`
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
