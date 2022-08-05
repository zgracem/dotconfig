# ~/.config 🔩

Some people prune bonsai trees. I refactor my dotfiles. 🌱

## How I use this repo 💁🏻‍♀️

### Notes on compatibility 💼

* These dotfiles are *mostly* portable between macOS (10.6+), Cygwin, MSYS2,
  Windows Subsystem for Linux, and both BSD and GNU flavours of \*nix.
* I try to conform to the [XDG Basedir Spec], so configuration for `foo` lives
  in `~/.config/foo/`, etc.
* Everything in `environment.d/` and `sh/` is compatible with any POSIX shell.
* My bash config files can be run (with gracefully degrading functionality) on
  versions 3.2 to the latest 5.x release.
* Alas, most of my fish configuration files can only run on version 3.2+.

[XDG Basedir Spec]: https://specifications.freedesktop.org/basedir-spec/basedir-spec-latest.html

### General usage 👩🏻‍💻

* 🖥️ At home, I use a 2020 iMac that dual-boots the latest macOS and Windows 10,
  with an mid-2011 MacBook Air running High Sierra for "emergencies." My day-job
  computer has Windows 10, Cygwin, and no admin privileges 🤦🏻‍♀️, and from time to
  time I need to SSH into various Linux web servers 🐧.
* 🔄 Dropbox keeps everything synced between my Windows and Mac machines, and
  a custom `rsync` script pushes changes to my Linux boxes.
* ⌨️ On Windows, I use the venerable [PuTTY]; on macOS, I prefer [iTerm2];
  on iOS, there is only [Prompt].
* 🐟 I've been using [fish] as my primary shell since February 2019, though bash
  will always be my first love.
* 🗒 My primary text editor on all platforms is [VSCode].
* 🔐 Files that can be safely published to GitHub live in `~/.config/`.
  Everything else lives in `~/.private/`.

[PuTTY]: https://www.chiark.greenend.org.uk/~sgtatham/putty/
[iTerm2]: https://www.iterm2.com/
[Prompt]: https://panic.com/prompt/
[fish]: https://fishshell.com/
[VSCode]: https://github.com/Microsoft/vscode

### Setting up a new homedir 🏡

Minimum requirements:

* `~/.config/`  ← this repo
* `~/.private/` ← from encrypted repo

Then:

```sh
cd ~ && ln -s .private/ssh ~/.ssh
cd ~/.config && make shell-files symlinks
```

Then restart the shell.

## How you can use this repo 🙋🏻‍♀️

In ascending order of difficulty:

* 👀 Browse it! It's on GitHub for a reason. Important directories have `README`
  files explaining their contents, usage, setup, etc.
* ⚖️ Clone it. You're [more than welcome][licence] to integrate anything cool
  you find into your own dotfiles.
* 🍴 Fork it? I guess? Everything's *extremely* personalized; I do not expect
  and cannot guarantee that these will work "out of the box" for anyone but me.

[licence]: https://github.com/zgracem/dotconfig/blob/master/LICENCE

The only condition—and it's a personal request, not a legal requirement—is that
if you find anything here interesting or useful, [drop me a note 📫][email] and
say so.

[email]: mailto:zgm%40inescapable%2eorg

## Lineage 📈

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
