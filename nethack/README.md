# `.nethackrc`

This directory contains configuration files for [NetHack].

[NetHack]: https://nethack.org

## Windows

Copy `nethackrc` to `%USERPROFILE%\NetHack\.nethackrc` and make sure to use the
settings defined in the `[windows]` block.

## macOS/Linux

```bash
export NETHACKOPTIONS="@$XDG_CONFIG_HOME/nethack/nethackrc"
```

To modify NetHack's system-level configuration file:

```bash
make -C $XDG_CONFIG_HOME/nethack
```
