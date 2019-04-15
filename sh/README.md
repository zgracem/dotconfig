# ~/.config/sh

`profile.sh` in this directory should be symlinked from `~/.profile` so that it
is sourced by all POSIX shells. That file, in turn, sources the following:

- `~/.config/environment.sh`
    - ...which sources `~/.config/environment.d/*.sh`
- `~/.config/sh/paths.sh`
- `~/.config/sh/profile.d/*.sh`

Any environment variables set by the scripts in this sequence are made available
to the fish shell via [`../fish/conf.d/___env.fish`][env].

[env]: https://github.com/zgracem/dotconfig/blob/master/fish/conf.d/___env.fish
