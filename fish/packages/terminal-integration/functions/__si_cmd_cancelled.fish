# Marks the cleared line with neither success nor failure.
# Sent when a command line is cleared or reset, but no command was run.
function __si_cmd_cancelled --on-event fish_cancel
    switch $TERM_PROGRAM
        case vscode
            __vsc_esc E
            __vsc_esc D
        case '*'
            __si_esc D
    end
end
