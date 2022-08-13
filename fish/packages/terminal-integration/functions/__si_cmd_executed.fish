# Marks the beginning of command output.
# Sent after accepting, but before executing, an interactive command.
function __si_cmd_executed --on-event fish_preexec
    # Ignore commands with leading spaces or in private mode
    if string match --quiet -- " *" "$argv"; or set --query fish_private_mode
        set argv ""
    end

    switch $TERM_PROGRAM
        case vscode
            __vsc_esc C
            __vsc_esc E (__vsc_escape_cmd "$argv")
        case iTerm.app
            __si_esc C \r
        case '*'
            __si_esc C
    end

    set --global __si_cmd_active
end
