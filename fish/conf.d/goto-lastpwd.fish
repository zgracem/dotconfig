function update-lastpwd --on-variable PWD
    not status is-interactive
    or string match -q vscode "$TERM_PROGRAM"
    or string match -q Visor "$ITERM_PROFILE"
    or set -q fish_private_mode; and return

    set --universal last_pwd $PWD
end

function goto-lastpwd --on-event fish_prompt
    # Only run once
    functions --erase (status current-function)

    # Abort if not running interactively
    status is-interactive
    or return 0

    # Abort if running in private mode
    set -q fish_private_mode
    and return 0

    # Abort if the variable can't be found
    set -qU last_pwd
    or return 0

    # Abort if running in VSCode's integrated terminal or iTerm in dropdown mode
    string match -q vscode "$TERM_PROGRAM"
    or string match -q Visor "$ITERM_PROFILE"
    and return 0

    # Abort if we'd be moving to the same directory
    string match -q $PWD $last_pwd
    and return 0

    # Abort if the directory doesn't exist anymore
    path is --type=dir $last_pwd
    or return 0

    # Should be OK now
    cd $last_pwd
end
