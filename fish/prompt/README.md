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

[Screenshot]: https://raw.githubusercontent.com/zgracem/dotconfig/main/fish/prompt/prompt.png
