# ~/.config/bash

Formerly the jewel of my dotfiles. 💎

As of April 2019, most of the good stuff has been ported to [fish].

[fish]: https://github.com/zgracem/dotconfig/tree/master/fish

***

`./bashrc.bash` should be symlinked from `~/.bashrc`. It sources the following:

- `./_*.bash`
- `./*.d/*.bash`
- `~/.local/config/bashrc.d/*.bash`

(Where `~/.local/config` is a symlink to `~/.config/local/$HOSTNAME/config`, if
it exists.)

In addition:

- `./init.bash` and `~/.local/config/init.bash` (if present) are sourced
  immediately before the first prompt.
- `./logout.bash` and `~/.local/config/logout.bash` (if present) are sourced
  when bash exits.
