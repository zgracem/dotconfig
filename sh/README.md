# ~/.config/sh

`./profile.sh` should be symlinked from `~/.profile` so that it is sourced by
all POSIX shells. That file, in turn, sources the following:

- `~/.config/environment.sh`
  - ...which sources `~/.config/environment.d/*.sh`
- `./paths.sh`
- `./profile.d/*.sh`
