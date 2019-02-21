# ~/.config/fish/prompt

My `fish` prompt is minimalist, but provides a surprising amount of information
as and when it becomes relevant, including:

* Hostname, appears when connecting remotely
* Current working directory, abbreviated but still readable at a glance
* Basic `git` status: just the branch name, with indicators for untracked,
  unstaged, uncommitted, unsynced and stashed files
* Background job count, if > 0
* Non-zero exit statuses appear against the right margin, as numbers or (if
  applicable) signal names
* The right margin can also include the current time and an indicator of the 
  current `vi` mode
