# Updates the current working directory, etc.
# Sent whenever a new fish prompt is about to be displayed.
function __si_update_cwd --on-event fish_prompt
    set -q __si_hostname; or set -g __si_hostname (hostname -f 2>/dev/null)
    switch $TERM_PROGRAM
        case vscode
            __vsc_esc P "Cwd=$PWD"
        case iTerm.app
            __iterm_esc "RemoteHost=$USER@$__si_hostname"
            __iterm_esc "CurrentDir=$PWD"
    end
end
