# ~/.config/bash

Formerly the jewel of my dotfiles. 💎

`bashrc.bash` in this directory should be symlinked from `~/.bashrc`. It sources
the following:

- `~/.config/bash/_*.bash`
- `~/.config/bash/*.d/*.bash`
- `~/.local/config/bashrc.d/*.bash`

(Where `~/.local/config` is a symlink to `~/.config/local/$HOSTNAME/config`, if
it exists.)

In addition:

- `init.bash` and any `~/.local/config/init.bash` are sourced immediately before
  the first prompt.
- `logout.bash` and any `~/.local/config/logout.bash` are sourced when bash exits.
