# ----------------------------------------------------------------------------
# Terminal–shell integration for fish
# See: iTerm.app/Contents/Resources/iterm2_shell_integration.fish
# and  `code --locate-shell-integration-path fish`
# ----------------------------------------------------------------------------

# Don't run in scripts, non-GUI clients, or more than once per session.
# Native OSC 133 injection was added in fish 3.8: fish-shell/fish-shell#10352
status is-interactive
and set --query TERM_PROGRAM
and ! set --query SHELL_INTEGRATION
and fish-is-older-than 3.8
or return

set --global --export SHELL_INTEGRATION $TERM_PROGRAM
switch $TERM_PROGRAM
    case vscode
        set --global VSCODE_SHELL_INTEGRATION 1
    case iTerm.app
        string match -q screen "$ITERM_ENABLE_SHELL_INTEGRATION_WITH_TMUX$TERM"
        and return
        set --global --export ITERM_SHELL_INTEGRATION_INSTALLED Yes
    case '*'
        set --erase SHELL_INTEGRATION
        exit
end

function __si_initialize --on-event fish_prompt
    functions --erase (status current-function)

    set --global __si_Ps 133

    # Sent after accepting, but before executing, an interactive command.
    # Marks the beginning of command output.
    function __si_cmd_executed --on-event fish_preexec
        # Ignore commands with leading spaces or in private mode
        if string match --quiet -- " *" "$argv"; or set --query fish_private_mode
            set argv ""
        end

        switch $TERM_PROGRAM
            case vscode
                __vsc_esc C
                __vsc_esc E (__vsc_escape_value "$argv")
            case iTerm.app
                __si_esc C \r
            case '*'
                __si_esc C
        end

        set --global __si_cmd_active
    end

    # Sent right after an interactive command has finished executing.
    # Marks the end of command output.
    function __si_cmd_finished --on-event fish_postexec
        switch $TERM_PROGRAM
            case vscode
                __vsc_esc D $status
            case '*'
                __si_esc D $status
        end
    end

    # Sent whenever a new fish prompt is about to be displayed.
    # Updates the current working directory, etc.
    function __si_update_cwd --on-event fish_prompt
        set -q __si_hostname; or set -g __si_hostname $hostname
        switch $TERM_PROGRAM
            case vscode
                __vsc_esc P "Cwd="(__vsc_escape_value $PWD)
                __si_cmd_check
            case iTerm.app
                __iterm_esc "RemoteHost=$USER@$__si_hostname"
                __iterm_esc "CurrentDir=$PWD"
        end
    end

    # Sent when a command line is cleared or reset, but no command was run.
    # Marks the cleared line with neither success nor failure.
    function __si_cmd_cancelled --on-event fish_cancel
        switch $TERM_PROGRAM
            case vscode
                __vsc_esc E
                __vsc_esc D
            case '*'
                __si_esc D
        end
    end

    # Runs whenever a new fish prompt is about to be displayed.
    # Marks the line as cancelled if no command was actually run.
    function __si_cmd_check --on-event fish_prompt
        if set --query __si_cmd_active
            set --erase __si_cmd_active
        else
            __si_cmd_cancelled
        end
    end

    # Preserve the user's existing prompt to wrap in escape sequences.
    functions --copy fish_prompt __si_original_fish_prompt

    # Only override fish_mode_prompt if it is non-empty.
    if __fish_has_mode_prompt
        functions --copy fish_mode_prompt __original_fish_mode_prompt

        function fish_mode_prompt
            __si_prompt_start
            __original_fish_mode_prompt
        end

        function fish_prompt
            __si_original_fish_prompt
            __si_cmd_start
        end
    else
        function fish_prompt
            __si_prompt_start
            __si_original_fish_prompt
            __si_cmd_start
        end
    end

    # Report (fake) shell integration version to iTerm.
    string match -q "iTerm.app" $TERM_PROGRAM
    and __iterm_esc ShellIntegrationVersion=69 shell=fish
    and __si_update_cwd
end
