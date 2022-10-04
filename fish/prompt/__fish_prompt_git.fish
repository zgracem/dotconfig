function __fish_prompt_git --description 'Display git info in the fish prompt'
    set -l icon_stash "+"
    set -l icon_dirty "•"
    set -l icon_clean "✓"
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

    # branch name
    set -l git_branch (string match -r '(?<=branch.head ).*' $git_status)
    set_color $__fish_git_prompt_color_branch
    echo -n $git_branch
    set_color normal

    # stash icon
    if path is -r $git_dir/refs/stash
        set_color $__fish_git_prompt_color_stashstate
        echo -n $icon_stash
    end

    # uncommitted changes
    set -l staged (count (string match -ar '^1 \S\.' $git_status))
    set -l unstaged (count (string match -ar '^1 \.\S' $git_status))
    set -l untracked (count (string match -ar '^\?' $git_status))

    if test (math "$unstaged + $untracked") -gt 0
        set_color $__fish_git_prompt_color_dirtystate
        echo -n $icon_dirty
    else if test $staged -gt 0
        set_color $__fish_git_prompt_color_stagedstate
        echo -n $icon_dirty
    else if set -q __fish_prompt_show_git_clean
        set_color $__fish_git_prompt_color_cleanstate
        echo -n $icon_clean
    end

    # unpushed commits
    string match -r '(?<=branch.ab )\+(\d+) -(\d+)' $git_status \
        | read --line _both ahead behind

    test -n "$ahead"
    or set ahead 0

    test -n "$behind"
    or set behind 0

    if test $ahead -gt 0 -o $behind -gt 0
        set_color $__fish_git_prompt_color_upstream
        if test $behind -eq 0
            echo -n $icon_ahead
        else if test $ahead -eq 0
            echo -n $icon_behind
        else
            echo -n $icon_ahead_and_behind
        end
    end

    set_color normal
    echo -n " "
end
