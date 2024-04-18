# ~/.config/bin

This directory contains various bits and pieces I've written that should be
symlinked into `~/bin`:

```sh
make -C $XDG_CONFIG_HOME/bin install
```

## Utilities

* `relpath` prints the relative path to a file from a given directory.
* `tbcopy` combines `tee` and `pbcopy`: it reads from standard input and writes
  to both standard output and macOS's clipboard.
* `trash` uses the Finder's own API, enabling "Put Back" on trashed items.
* `un1q` is like `uniq`, but also deletes non-consecutive duplicate lines.

## Custom subcommands

* `brew-env` enables `brew env`, which prints the complete environment as seen
  by Homebrew.
* `git-browse` enables `git browse`, which prints the URL of the repo's origin
  (usually on GitHub).
* `git-cc` enables `git cc $user/$repo` as shorthand for
  `git clone git@github.com:$user/$repo.git $user/$repo`.

## macOS wrappers

Preferred to adding `/usr/libexec` or Xcode app bundle deep-links to `PATH`.

* `airport` wraps `airport(8)`.
* `lsregister` wraps the Launch Services database manager.
* `PlistBuddy` wraps `PlistBuddy(8)`.
