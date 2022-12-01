set -gx LAST_PWD_CACHE $XDG_STATE_HOME/fish/last_pwd
mkdir -p (path dirname $LAST_PWD_CACHE)

function update-lastpwd --on-variable PWD
    string match -q vscode "$TERM_PROGRAM"
    or string match -q Visor "$ITERM_PROFILE"
    or set -q fish_private_mode; and return
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

    # Abort if running in VSCode's integrated terminal or iTerm in dropdown mode
    string match -q vscode "$TERM_PROGRAM"
    or string match -q Visor "$ITERM_PROFILE"
    and begin
        # echo -s (set_color --dim --italic) "skipping lastpwd..." (set_color normal) >&2
        return 0
    end

    read -l LWD <$LAST_PWD_CACHE

    # Abort if we'd be moving to the same directory
    string match -q $PWD "$LWD"
    and begin
        #echo -s (set_color --dim --italic) "lastpwd was pwd..." (set_color normal) >&2
        return 0
    end

    # Abort if the directory doesn't exist anymore
    path is --type=dir "$LWD"
    or begin
        #echo -s (set_color --dim --italic) "lastpwd not found: $LWD" (set_color normal) >&2
        return 0
    end

    # Should be OK now
    cd $LWD
end
