# ~/.config/sh

`.profile` should be symlinked to `~/.profile` so that it is sourced by all
POSIX shells. That file, in turn, sources the following:

- `./xdg.sh` for `XDG_*` variables
- `./paths.sh` for `PATH` and friends
- `./env.sh` to set up environment
    - ...which sources `~/.config/env.d/*.env` and `~/.config/sh/env.d/*.sh`
- `./profile.d/*.sh`
