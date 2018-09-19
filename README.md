# ~/.config

## Shell startup files

* `environment.sh` loads environment variables from `environment.d/` for all POSIX shells (`launchctl` makes them available to macOS GUI apps)
* `sh/profile.sh` symlinks to `~/.profile` and sources the contents of `sh/profile.d/*.sh`
* `bash/bashrc.bash` symlinks to `~/.bashrc` and sources the contents of `bash/**/*.bash`

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
- `etc/terminfo/` ← custom terminfo source files, run `make install`
- `lib/bash/` ← `HVDC` and `f(x)doc` bash libraries

Then:

```bash
ln -s .config/hushlogin ~/.hushlogin
ln -s .config/inputrc ~/.inputrc
ln -s .config/sh/profile.sh ~/.profile
ln -s .config/bash/profile.bash ~/.bash_profile
ln -s .config/bash/bashrc.bash ~/.bashrc
ln -s .config/bash/logout.bash ~/.bash_logout
ln -s .config/vimrc ~/.vimrc

# after restarting the shell
cd ~/etc/terminfo && make install
