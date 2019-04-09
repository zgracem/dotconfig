~/.config
=========

Some people prune bonsai trees. I refactor my dotfiles.

## How I use this repo

### Notes on compatibility & portability

* These dotfiles are written to be portable between macOS (10.5+), Cygwin,
  MSYS2, Windows 10's Linux Subsystem, and both BSD and GNU flavours of \*nix.
* I try to conform to the [XDG Base Directory Specification][xdg]:
  configuration for `foo` lives in `~/.config/foo/`, etc.
* Everything in `environment.d/` and `sh/` is compatible with any POSIX shell.
* My bash config files can be run (with gracefully degrading functionality) on
  anything from bash-3.2 to the latest 5.x release.
* Sadly, most of my fish configuration files can only run on 3.0.0 or newer.

[xdg]: https://specifications.freedesktop.org/basedir-spec/basedir-spec-latest.html

### General usage

* My primary machine at home is a 2015 iMac that dual boots macOS Mojave and
  Windows 10; I also have a 2011 MacBook Air running High Sierra. My day-job
  computer is a very fast Dell with Windows 7, Cygwin, and no admin login. 🤦‍♀
  And I frequently SSH into web servers running various flavours of Linux.
* Dropbox keeps things synced between my Windows and Mac machines, and a
  custom `rsync` script pushes changes to my Linux boxes.
* On Windows, I use nightly builds of the venerable [PuTTY]; on Mac, I prefer
  [iTerm2] over the built-in Terminal.app; on iOS, there is only [Prompt].
* As of April 2019, I'm transitioning from a long-term relationship with
  Sublime Text to something more... passionate... with Visual Studio Code.
* Files that can be safely published to this GitHub repo live in `~/.config/`.
  Everything else lives in `~/.private/`, which is encrypted by [Keybase].

[PuTTY]: http://www.chiark.greenend.org.uk/~sgtatham/putty/
[iTerm2]: http://www.iterm2.com/
[Prompt]: http://panic.com/prompt/
[Keybase]: https://keybase.io/zgm

### Shell startup files

* `environment.sh` loads environment variables from `environment.d/*.sh` for all
  POSIX shells
    * `fish/conf.d/___env.fish` does the same for `fish`
    * `misc/launchd.conf` makes them available to macOS GUI apps
* `~/.profile` is a symlink to `sh/profile.sh`, which sources
  `sh/profile.d/*.sh`
* `~/.bashrc` is a symlink to `bash/bashrc.bash`, which sources `bash/_*.bash`,
  `bash/*.d/*.bash`, and (if present) `~/.local/config/bashrc.d/*.bash`
    * `~/.local/config` is a symlink to `~/.config/local/$HOSTNAME/config`, if
      it exists
    * `bash/init.bash` and (if present) `~/.local/config/init.bash` are sourced
      immediately before the first prompt
    * `bash/logout.bash` and (if present) `~/.local/config/logout.bash` are
      sourced when `bash` exits

### Setting up a new homedir

Minimum requirements:

- `.config/` ← this repo
    - `bash/`
    - `dircolors/`
    - `environment.d/`
    - `readline/`
    - `sh/`
    - `vim/`
    - `environment.sh`
- `.private/` ← from encrypted repo
    - `bashrc.d/`
    - `environment.d/`
    - `ssh/`

Then:

```sh
cd ~ && ln -s .private/ssh ~/.ssh
cd ~/.config && make shell-files symlinks
```

Then restart the shell.

## How you can use this repo

In ascending order of difficulty:

* Browse it! It's on GitHub for a reason. Important directories have `README`
  files explaining their contents, usage, setup, etc.
* Clone it. You're [more than welcome][licence] to integrate anything cool
  you find into your own dotfiles.
* Fork it? I guess? Everything's _extremely_ personalized; I do not expect and
  cannot guarantee that these will work "out of the box" for anyone but me.

[licence]: https://github.com/zgracem/dotconfig/blob/master/LICENCE

The only condition—and it's a personal request, not a legal requirement—is that
if you find anything in this repo interesting or useful, [drop me a note][email]
and say so.

[email]: mailto:zgm%40inescapable%2eorg

## Lineage

Since 2011, these dotfiles have evolved alongside my understanding of the world
of the command line, and much of that understanding has been illuminated by
others. Notably, but not exclusively, the following:

* [Alyssa Ross](https://github.com/alyssais/dotfiles)
* [Cãtãlin Mariş](https://github.com/alrra/dotfiles)
* [Gianni Chiappetta](https://github.com/gf3/dotfiles)
* [Mathias Bynens](https://github.com/mathiasbynens/dotfiles)
* [Mike McQuaid](https://github.com/MikeMcQuaid/dotfiles)
* [Paul Irish](https://github.com/paulirish/dotfiles/)
* [Tom Ryder](https://sanctum.geek.nz/cgit/dotfiles.git/about/)
* [Zach Holman](https://github.com/holman/dotfiles)
* [Zhiming Wang](https://github.com/zmwangx/dotfiles)
