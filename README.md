# ~/.config

Some people prune bonsai trees. I refactor my dotfiles.

## Shell startup files

* `environment.sh` loads environment variables from `environment.d/*.sh` 
  for all POSIX shells
    * `misc/launchd.conf` makes them available to macOS GUI apps
    * `fish/conf.d/___env.fish` does the same for `fish`
* `~/.profile` is a symlink to `sh/profile.sh`, which sources the contents of 
  `sh/profile.d`
* `~/.bashrc` is a symlink to `bash/bashrc.bash`, which sources `bash/_*.bash`,
  the contents of `bash/*.d`, and (if present) the contents of
  `~/.local/config/bashrc.d`
    * `~/.local/config` is a symlink to `~/.config/local/$HOSTNAME/config`,
      if it exists
    * `bash/init.bash` and (if present) `~/.local/config/init.bash` are 
      sourced immediately before the first prompt
    * `bash/logout.bash` and (if present) `~/.local/config/logout.bash` are 
      sourced when `bash` exits

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
    - `bashrc.d/`
    - `environment.d/`
    - `ssh/`
- `etc/terminfo/` ← custom terminfo source files
- `lib/bash/`
    - [`fxdoc/`](https://github.com/zgracem/fxdoc)
    - [`wtf.bash/`](https://github.com/zgracem/wtf.bash)

Then:

```bash
cd ~ && ln -s .private/ssh ~/.ssh
cd ~/.config && make shell-files symlinks
# after restarting the shell
cd ~/etc/terminfo && make install
# then restart the whole terminal emulator
```

## Compatibility notes

These dotfiles are written to be portable between macOS (10.5+), Cygwin,
MSYS2, Windows 10's Linux Subsystem, and both BSD and GNU flavours of \*nix. 
Everything in `environment.d/` and `sh/` is compatible with any POSIX shell.
Bash configuration files can be run (with gracefully degrading functionality)
on anything from bash-3.2 to the latest 5.x release.
