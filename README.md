# zozo's dotfiles

## Introduction

Welcome to the GitHub repository for the (slightly redacted) contents of my `~/.config` directory. Feel free to browse, steal, or ~~openly mock~~ gently suggest improvements for anything you find here.

I haven't figured out pull requests yet (or git in general, really), but feedback via email is more than welcome: [`printf "zozo\x40inescapable\x2eorg"`][e].

[e]: mailto:zozo%40inescapable%2eorg

## Environment

I have a 2009 iMac and a 2011 MacBook Air at home. I usually run [iTerm2][it], but once a while find myself back with good old Terminal.app. I recently switched from MacPorts to [Homebrew][br] for package management, and couldn't be happier.

[it]: http://www.iterm2.com/
[br]: http://brew.sh/

At work, [PuTTY][pt] and [Cygwin][cy] are the only things that keep me sane in the world of Windows 7. Because I'm back and forth between the two platforms so often, my config files run happily on either, with frequent checks to `$OSTYPE`, and I use the same alias and function names across both whenever possible. Functions and scripts check whether a utility uses GNU switches (Cygwin) or BSD (OS X, though these days I just install `coreutils` and call it done).

[pt]: http://www.chiark.greenend.org.uk/~sgtatham/putty/
[cy]: http://cygwin.com/

Depending on my mood, I'll edit with either `vim` or the latest dev build of [Sublime Text][st].

[st]: http://sublimetext.com/

Everything in my world is [Solarized][so]-coloured. I use the `$solarizedBG` environment variable to choose between light and dark modes, and set [custom colours][co] for `ls`, `grep`, man pages in `less`, and `screen`. (I use `tmux` on OS X, but sadly there's no cygwin port.)

[so]: http://ethanschoonover.com/solarized
[co]: https://github.com/cleversimon/dotfiles/blob/master/bash/colours.bash

The files in this repository live in `~/.config`, which is a symlink to a [Dropbox][db] folder that syncs between all my machines. When necessary, the files are symlinked in turn to their expected locations. I have a half-finished "installation" script that automates all that, but I so rarely set up new systems from scratch that it hasn't been much of a priority.

[db]: http://dropbox.com/

## `bash`

Some people tend bonsai trees; I fiddle with [shell functions][f]. The cool kids use `zsh` these days, but I learned `bash` and I'm sticking with it for now. [My config files][bash] have evolved over the years into a triumph -- if I say so myself -- of fastidious attention to questionably relevant detail.

[bash]: https://github.com/cleversimon/dotfiles/tree/master/bash
[f]: https://github.com/cleversimon/dotfiles/tree/master/bash/functions

My [prompt][ps1] is fairly simple, with a few subtle touches: the path to the working directory is truncated based on window width, non-zero exit codes appear on the right edge of the screen (`zsh`-style -- I'm not made of stone), and `xterm`-compatible terminals have their window title set with the current user, hostname, and full path to `$PWD`.

[ps1]: https://github.com/cleversimon/dotfiles/blob/master/bash/prompt.bash

These files are intended for version 4.1+, and haven't been tested on anything older than 3.2.

* * *

More to come...
