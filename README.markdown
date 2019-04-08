# ~/.config

Some people prune bonsai trees. I refactor my dotfiles.

## Shell startup files

* `environment.sh` loads environment variables from `environment.d/*.sh` for all
  POSIX shells
    * `fish/conf.d/___env.fish` does the same for `fish`
    * `misc/launchd.conf` makes them available to macOS GUI apps
* `~/.profile` is a symlink to `sh/profile.sh`, which sources
  `sh/profile.d/*.sh`
* `~/.bashrc` is a symlink to `bash/bashrc.bash`, which sources `bash/_*.bash`,
  `bash/*.d/*.bash`, and (if present) `~/.local/config/bashrc.d/*.bash`
    * `~/.local/config` is a symlink to `~/.config/local/$HOSTNAME/config`, if
      it exists
    * `bash/init.bash` and (if present) `~/.local/config/init.bash` are sourced
      immediately before the first prompt
    * `bash/logout.bash` and (if present) `~/.local/config/logout.bash` are
      sourced when `bash` exits

## Setting up a new homedir

Minimum requirements:

- `.config/` ← this repo
    - `bash/`
    - `dircolors/`
    - `environment.d/`
    - `readline/`
    - `sh/`
    - `vim/`
    - `environment.sh`
- `.private/` ← from encrypted repo
    - `bashrc.d/`
    - `environment.d/`
    - `ssh/`

Then:

```bash
cd ~ && ln -s .private/ssh ~/.ssh
cd ~/.config && make shell-files symlinks
```

Then restart the shell.

## Notes on compatibility & portability

* These dotfiles are written to be portable between macOS (10.5+), Cygwin,
  MSYS2, Windows 10's Linux Subsystem, and both BSD and GNU flavours of \*nix.
* Everything in `environment.d/` and `sh/` is compatible with any POSIX shell.
* Bash configuration files can be run (with gracefully degrading functionality)
  on anything from bash-3.2 to the latest 5.x release.
* Sadly, most of my fish configuration files can only run on fish 3.0 or newer.
