# ~/.config/environment.d

`*.sh` files in this directory are sourced during the startup of any POSIX shell
to produce a consistent environment.

In addition, `~/.config/launchd/Makefile` makes that environment available to
macOS GUI apps via `launchd(8)`.
