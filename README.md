# ~/.config

## Shell startup files

* `environment.sh` loads environment variables from `environment.d/*.sh` 
  for all POSIX shells
    * `launchctl` makes them available to macOS GUI apps
* `~/.profile` symlinks to `sh/profile.sh` and sources the contents of 
  `sh/profile.d/*.sh`
* `~/.bashrc` symlinks to `bash/bashrc.bash` and sources the contents of 
  `bash/_*.bash` and `bash/*.d/*.bash`
* Configurations for individual machines are under `local/`. The contents
  of each hostname subdir are symlinked to `~/.local` on that machine.
    * `.bashrc` also sources the contents of `~/.local/config/bashrc.d/*.bash`,
      if present
* `bash/init.bash` and (if present) `~/.local/config/init.bash` are sourced 
  immediately before the first prompt.
* `bash/logout.bash` and (if present) `~/.local/config/logout.bash` are 
  sourced when the shell exits.

## Setting up a new homedir

Minimum requirements:

- `.config/` ← this repo
    - `bash/`
    - `dircolors/`
    - `environment.d/`
    - `sh/`
    - `environment.sh`
    - `hushlogin`
    - `inputrc`
    - `vimrc`
- `.ssh/` ← not in this repo, obvs.
    - `authorized_keys`
    - `config`
    - `id_rsa.pub`
- `etc/terminfo/` ← custom terminfo source files
- `lib/bash/`
    - [`fxdoc`](https://github.com/zgracem/fxdoc)
    - [`wtf.bash`](https://github.com/zgracem/wtf.bash)

Then:

```bash
ln -s .config/hushlogin         ~/.hushlogin
ln -s .config/inputrc           ~/.inputrc
ln -s .config/sh/profile.sh     ~/.profile
ln -s .config/bash/profile.bash ~/.bash_profile
ln -s .config/bash/bashrc.bash  ~/.bashrc
ln -s .config/bash/logout.bash  ~/.bash_logout
ln -s .config/vimrc             ~/.vimrc

# after restarting the shell
cd ~/etc/terminfo && make install
# then restart the whole terminal emulator
```
