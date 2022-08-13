# Marks the end of command output.
# Sent right after an interactive command has finished executing.
function __si_cmd_finished --on-event fish_postexec
    switch $TERM_PROGRAM
        case vscode
            __vsc_esc D $status
        case '*'
            __si_esc D $status
    end
end
