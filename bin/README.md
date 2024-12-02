# ~/.config/bin

This directory contains various bits and pieces I've written that should be
symlinked into `~/.local/bin`:

```sh
make -C $XDG_CONFIG_HOME/bin install
```

* `relpath` prints the relative path to a file from a given directory.
* `tbcopy` combines `tee` and `pbcopy`: it reads from standard input and writes
  to both standard output and macOS's clipboard.
* `trash` uses the Finder's own API, enabling "Put Back" on trashed items.
* `un1q` is like `uniq`, but also deletes non-consecutive duplicate lines.
