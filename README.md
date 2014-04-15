# zozo's dotfiles

## Introduction

Welcome to the GitHub repository for the (slightly redacted) contents of my `~/.config` directory. Feel free to browse, steal, or ~~openly mock~~ gently suggest improvements for anything you find here.

I haven't figured out pull requests yet (or git in general, really), but feedback via email is more than welcome: [`printf "zozo\x40inescapable\x2eorg"`][e].

[e]: mailto:zozo%40inescapable%2eorg

## Environment

I have a 2009 iMac and a 2011 MacBook Air at home. I usually run [iTerm2][it], but once a while find myself back with good old Terminal.app. I've switched from MacPorts to [Homebrew][br] for package management, and couldn't be happier.

[it]: http://www.iterm2.com/
[br]: http://brew.sh/

At work, [PuTTY][pt] and [Cygwin][cy] keep me sane in the world of Windows 7. Because I'm back and forth between the two platforms so often, my config files run happily on either, with frequent checks to `$OSTYPE`, and I use the same alias and function names across both whenever possible. Functions and scripts check whether a utility uses GNU switches (Cygwin) or BSD (OS X), though these days I just install `coreutils` and call it done.

[pt]: http://www.chiark.greenend.org.uk/~sgtatham/putty/
[cy]: http://cygwin.com/

Depending on my mood, I'll edit with either `vim` or the latest dev build of [Sublime Text][st].

[st]: http://sublimetext.com/

Everything in my world is [Solarized][so]-coloured. I use the `$solarized` environment variable to choose between light and dark modes, and set [custom colours][co] for `ls`, `grep`, man pages in `less`, and `screen`. (I use `tmux` on OS X, but sadly there's no cygwin port.)

[so]: http://ethanschoonover.com/solarized
[co]: blob/master/bash/colours.bash

The files in this repository live in `~/.config`, which is a symlink to a [Dropbox][db] folder that syncs between all my machines. When necessary, the files are symlinked in turn to their expected locations. I have a half-finished "installation" script that automates all that, but I so rarely set up new systems from scratch that it hasn't been much of a priority.

[db]: http://dropbox.com/

## `bash`

The cool kids use `zsh`, apparently, but I learned `bash` first and I'm sticking with it (for now). [My config files][bash] have evolved over the years into a triumph -- if I say so myself -- of fastidious attention to questionably relevant detail.

[bash]: tree/master/bash

### Prompt

My [prompt][ps1] is fairly simple, with a few subtle touches: the path to the working directory is truncated based on window width, non-zero exit codes appear on the right edge of the screen (`zsh`-style -- I'm not made of stone), and `xterm`-compatible terminals have their [window title set][win] with the current user, hostname, and full path to `$PWD`.

[ps1]: blob/master/bash/prompt.bash
[win]: blob/master/bash/functions/title.bash

### Functions

Some people tend bonsai trees; I fiddle with [shell functions][func]. A few I'm particularly proud of:

* [A wrapper for `man`][man] that opens the page in a new `tmux` or `screen` window and changes the `tmux`/`screen`/`xterm` window title to the title of the man page, e.g. "cron(8)".
* [`q`][q] with no arguments returns "true" or "false" based on the last command's exit code, and `q 'EXPRESSION'` is a handy wrapper for `[[` when you want to check a quick conditional.
* [A superpowered version of `which`][wh] with colourized output, and its sibling function `what`, which provides a brief synopsis of commands, programs, topics and variables.
* `_edit` opens files in the appropriate text editor (`vim` or Sublime Text), based on whether I'm in the console or a GUI.

[man]: blob/master/bash/functions/man.bash
[q]:   blob/master/bash/functions/exits.bash
[wh]:  blob/master/bash/functions/help.bash

Because my functions are sorted into [different files by purpose][func], and because I'm incessantly fiddling with them, `fe [function]` quickly opens the right file -- and if I'm using vim or Sublime Text, even sends me to the right line. (If I already know the right file, `bf [filename]` takes me there.)

[func]: tree/master/bash/functions

**N.B.:** These files are intended for version 4.1+, and haven't been tested on anything older than 3.2.

* * *

More to come...
