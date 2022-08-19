# ~/.config/stow

This directory contains configuration files for [GNU stow](https://gnu.org/software/stow),
which should be symlinked into `$HOME`:

```sh
make -C $XDG_CONFIG_HOME symlinks
```

***

[11. Resource Files](https://gnu.org/software/stow/manual/stow.html#Resource-Files):

> Default command line options may be set in `.stowrc` (current directory) or
> `~/.stowrc` (home directory). These are parsed in that order, and are appended
> together if they both exist.

[4.2. Types and Syntax of Ignore Lists](https://gnu.org/software/stow/manual/stow.html#Types-And-Syntax-Of-Ignore-Lists):

> If you put Perl regular expressions, one per line, in a `.stow-local-ignore`
> file within any top level package directory... any file or directory within
> that package matching any of these regular expressions will be ignored. In the
> absence of this package-specific ignore list, Stow will instead use the
> contents of `~/.stow-global-ignore`, if it exists.
