# ~/.config/local

This directory contains per-host configuration files. The contents of each
subdirectory are linked into `~/.local` on the appropriate machine:

```sh
ln -s "$XDG_CONFIG_HOME/local/$HOSTNAME/config" ~/.local/config
```
