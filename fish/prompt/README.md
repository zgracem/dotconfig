# ~/.config/fish/prompt

My `fish` prompt is minimalist, but provides a surprising amount of information
as and when it becomes relevant, including:

* User and hostname, appear only when connecting remotely
* Current working directory, abbreviated but still readable at a glance
* Basic `git` status: just the branch name, with indicators for untracked,
  unstaged, uncommitted, unsynced and stashed files
* Background job count, if > 0
* Non-zero exit statuses appear against the right margin, as numbers or (if
  applicable) signal names
* The right margin can also include the duration of the last command, the
  current time, and/or an indicator of the current `vi` mode

Prompt-related functions live in this directory to avoid cluttering up
`../functions`. Its path must be added to `$fish_function_path` so they can
auto-load.
