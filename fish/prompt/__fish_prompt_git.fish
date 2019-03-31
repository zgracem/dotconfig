function __fish_prompt_git --description 'Display git info in the fish prompt'
  set -l icon_stash "+"
  set -l icon_dirty "•"
  set -l icon_clean "√"
  set -l icon_ahead "↑" # "+"
  set -l icon_behind "↓" # "−"
  set -l icon_ahead_and_behind "↕" # "±"

  # fail if git isn't even installed
  in-path git
  or return 0

  # fail if we're not inside a git repo
  set -l git_dir (command git rev-parse --git-dir 2>/dev/null)
  or return 0

  set -l git_status (git status --branch --porcelain=v2 2>/dev/null)
  or return

  set -l git_branch (string match -r '(?<=branch.head ).*' $git_status)
  set_color $fish_prompt_color_git_branch
  echo -n " $git_branch"

  if test -r $git_dir/refs/stash
    set_color $fish_prompt_color_git_stashed
    echo -n $icon_stash
  end

  set -l staged (count (string match -ar '^1 \S\. .*' $git_status))
  or set -l staged 0

  set -l unstaged (count (string match -ar '^1 \.\S .*' $git_status))
  or set -l unstaged 0

  set -l untracked (count (string match -ar '^\? .*' $git_status))
  or set -l untracked 0

  if test (math "$unstaged + $untracked") -gt 0
    set_color $fish_prompt_color_git_needs_add
    echo -n $icon_dirty
  else if test $staged -gt 0
    set_color $fish_prompt_color_git_needs_commit
    echo -n $icon_dirty
  else if test -n "$__fish_prompt_show_git_clean"
    set_color $fish_prompt_color_git_clean
    echo -n $icon_clean
  end

  set -l ahead_behind (string match -r '(?<=branch.ab )\+(\d+) -(\d+)' $git_status)
  set -l ahead $ahead_behind[2]
  set -l behind $ahead_behind[3]

  test -n "$ahead"; or set -l ahead 0
  test -n "$behind"; or set -l behind 0

  if test "$ahead" -gt 0 -o "$behind" -gt 0
    set_color $fish_prompt_color_git_needs_push
    if test $behind -eq 0
      echo -n $icon_ahead
    else if test $ahead -eq 0
      echo -n $icon_behind
    else
      echo -n $icon_ahead_and_behind
    end
  end

  set_color normal
end
