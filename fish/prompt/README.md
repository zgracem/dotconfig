# ~/.config/fish/prompt

![Screenshot]

My minimalist `fish` prompt progressively discloses information as and when it
becomes relevant, including:

* User and hostname appear only when connecting remotely
* Current working directory, abbreviated but still readable at a glance
* Basic git status: branch name, with coloured indicators for untracked,
  unstaged, uncommitted, unsynced and stashed files
* Background job count, if > 0
* Local rbenv version, if different from the global version
* Non-zero exit statuses appear against the right margin, as numbers or (if
  applicable) signal names
* The right margin can also include the duration of the last command and/or an
  indicator of the current `vi` mode

Prompt-related functions live here to avoid cluttering up `../functions`. The
path to this directory must be added to `$fish_package_path` so everything can
auto-load.

[Screenshot]: https://raw.githubusercontent.com/zgracem/dotconfig/master/fish/prompt/prompt.png

## `fish_title` → `fish_title_window` + `fish_title_tab`

The code supporting [`fish_title`] ([`reader_write_title()` in reader.cpp][1])
writes simultaneously to both the terminal "window" and "icon" titles. I prefer
to set those separately; hence [`set_terminal_title.fish`][2], which allows
separate [`fish_title_window`][3] and [`fish_title_tab`][4] functions, the
output of which will appear in the terminal window or tab title, respectively,
each time the prompt is displayed.

[`fish_title`]: https://fishshell.com/docs/current/cmds/fish_title.html
[1]: https://github.com/fish-shell/fish-shell/blob/77aeb6a/src/reader.cpp#L1565
[2]: https://github.com/zgracem/dotconfig/blob/main/fish/prompt/functions/set_terminal_title.fish
[3]: https://github.com/zgracem/dotconfig/blob/main/fish/prompt/functions/fish_title_window.fish
[4]: https://github.com/zgracem/dotconfig/blob/main/fish/prompt/functions/fish_title_tab.fish
