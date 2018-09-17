# ~/.config

## Shell startup files

* `environment.sh` loads environment variables from `environment.d/` for all POSIX shells (`launchctl` makes them available to macOS GUI apps)
* `sh/profile.sh` symlinks to `~/.profile` and sources the contents of `sh/profile.d/*.sh`
* `bash/bashrc.bash` symlinks to `~/.bashrc` and sources the contents of `bash/*.d/*.bash`
