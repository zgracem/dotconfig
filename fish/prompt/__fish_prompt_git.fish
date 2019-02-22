function __fish_prompt_git --description 'Display git info in the fish prompt'
  # fail if git isn't even installed
  if not in-path git; return 0; end

  # fail if we're not inside a git repo
  if not set -l git_dir (command git rev-parse --git-dir 2>/dev/null)
    return $status
  end

  set -l git_status (command git status --branch --porcelain=v2 2>/dev/null)
  or return $status

  set -l git_branch (string match -r '(?<=branch.head ).*' $git_status)

  echo -n (set_color $__fish_prompt_color_git_branch) "$git_branch"

  if [ -r $git_dir/refs/stash ]
    set_color $__fish_prompt_color_git_stashed
    echo -n "+"
  end

  set -l staged (count (string match -ar '^1 \S\. .*' $git_status))
  or set -l staged 0

  set -l unstaged (count (string match -ar '^1 \.\S .*' $git_status))
  or set -l unstaged 0

  set -l untracked (count (string match -ar '^\? .*' $git_status))
  or set -l untracked 0

  if [ (math "$unstaged + $untracked") -gt 0 ]
    set_color $__fish_prompt_color_git_needs_add
    echo -n '•'
  else if [ $staged -gt 0 ]
    set_color $__fish_prompt_color_git_needs_commit
    echo -n '•'
  # else
  #   set_color $__fish_prompt_color_git_clean
  #   echo -n '•'
  end

  set -l ahead_behind (string match -r '(?<=branch.ab )\+(\d+) -(\d+)' $git_status)
  set -l ahead $ahead_behind[2]
  set -l behind $ahead_behind[3]

  if [ (math "$ahead + $behind") -gt 0 ]
    set_color $__fish_prompt_color_git_needs_push
    if [ $ahead -gt 0 -a $behind -eq 0 ]
      echo -n "↑" # "+"
    else if [ $ahead -eq 0 -a $behind -gt 0 ]
      echo -n "↓" # "−"
    else if [ $ahead -gt 0 -a $behind -gt 0 ]
      echo -n "↕" # "±"
    end
  end

  set_color normal
end
