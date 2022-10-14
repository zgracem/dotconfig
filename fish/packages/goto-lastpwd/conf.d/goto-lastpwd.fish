set -gx LAST_PWD_CACHE $XDG_CACHE_HOME/fish/last_pwd
mkdir -p (path dirname $LAST_PWD_CACHE)

function update-lastpwd --on-variable PWD
    set -q fish_private_mode; and return
    echo "$PWD" >$LAST_PWD_CACHE
end

function goto-lastpwd --on-event fish_prompt
    # Only run once
    functions --erase goto-lastpwd

    # Abort if not running interactively
    status is-interactive
    or return 0

    # Abort if running in private mode
    set -q fish_private_mode
    and return 0

    # Abort if the cache file can't be found
    path is --type=file "$LAST_PWD_CACHE"
    or begin
        echo -s (set_color --dim --italic) "file not found: $LAST_PWD_CACHE" (set_color normal) >&2
        return 0
    end

    # Abort if running in VSCode's integrated terminal
    string match -q vscode "$TERM_PROGRAM"
    and begin
        echo -s (set_color --dim --italic) "skipping lastpwd..." (set_color normal) >&2
        return 0
    end

    read -l LWD <$LAST_PWD_CACHE

    # Abort if we'd be moving to the same directory
    string match -q $PWD "$LWD"
    and begin
        echo -s (set_color --dim --italic) "lastpwd was pwd..." (set_color normal) >&2
        return 0
    end

    # Abort if the directory doesn't exist anymore
    path is --type=dir "$LWD"
    or return 0

    # Should be OK now
    cd $LWD
end
