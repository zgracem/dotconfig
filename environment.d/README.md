# ~/.config/environment.d

`*.sh` files in this directory are sourced during the startup of any POSIX shell
(plus fish) to produce a consistent environment.

In addition, `~/.config/etc/launchd.conf` makes that environment available to
macOS GUI apps via `launchd(8)`.
