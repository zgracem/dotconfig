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
