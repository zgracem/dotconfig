# ----------------------------------------------------------------------------
# Terminal–shell integration for fish
# ----------------------------------------------------------------------------

# Don't run in scripts, non-GUI clients, or more than once per session.
status is-interactive
and set --query TERM_PROGRAM
and ! set --query SHELL_INTEGRATION
or exit

set --global SHELL_INTEGRATION $TERM_PROGRAM
switch $TERM_PROGRAM
    case vscode
        set --global VSCODE_SHELL_INTEGRATION 1
    case iTerm.app
        string match -q screen "$ITERM_ENABLE_SHELL_INTEGRATION_WITH_TMUX$TERM"
        and exit
        set --global ITERM_SHELL_INTEGRATION_INSTALLED Yes
    case '*'
        set --erase SHELL_INTEGRATION
        exit
end

function __si_initialize --on-event fish_prompt
    functions --erase __si_initialize

    set --global __si_Ps 133

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

    # Marks the line as cancelled if no command was actually run.
    # Runs whenever a new fish prompt is about to be displayed.
    function __si_cmd_check --on-event fish_prompt
        if set --query __si_cmd_active
            set --erase __si_cmd_active
        else
            __si_cmd_cancelled
        end
    end

    # Preserve the user's existing prompt to wrap in escape sequences.
    functions --copy fish_prompt __original_fish_prompt

    # Only override fish_mode_prompt if it is non-empty.
    if __fish_has_mode_prompt
        functions --copy fish_mode_prompt __original_fish_mode_prompt

        function fish_mode_prompt
            __si_prompt_start
            __original_fish_mode_prompt
        end

        function fish_prompt
            __original_fish_prompt
            __si_cmd_start
        end
    else
        function fish_prompt
            __si_prompt_start
            __original_fish_prompt
            __si_cmd_start
        end
    end

    # Report (fake) shell integration version to iTerm.
    string match -q $TERM_PROGRAM "iTerm.app"
    and __iterm_esc ShellIntegrationVersion=69 shell=fish
end
