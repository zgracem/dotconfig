# ~/.config/sh/env.d

`*.sh` files in this directory are sourced during the startup of any POSIX shell
after the contents of `~/.config/env.d`.

Simple instructions whose syntax can also be parsed by the fish shell belong as
a `.env` file in `~/.config/env.d`. This directory is for variables that are set
according to more complex/less portable logic.
