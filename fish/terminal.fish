# ----------------------------------------------------------------------------
# Terminal–shell integration for fish
# ----------------------------------------------------------------------------

# Don't run in scripts, non-GUI clients, or more than once per session.
status is-interactive
and set --query TERM_PROGRAM
and ! set --query SHELL_INTEGRATION
or exit

set --global SHELL_INTEGRATION $TERM_PROGRAM

# Setup variables
set --global __term_Ps 133

function __esc_seq -d "Emit escape sequences for shell integration"
    set --local OSC "\e]"
    set --local BEL "\a"
    builtin printf "$OSC$__term_Ps;%s$BEL" (string join ";" $argv)
end

function __iterm_esc -d "Emit escape sequences for iTerm.app shell integration"
    set --local --export __term_Ps 1337
    __esc_seq $argv
end

function __vsc_esc -d "Emit escape sequences for VS Code shell integration"
    set --local --export __term_Ps 633
    __esc_seq $argv
end

# Escapes backslashes, newlines, and semicolons.
function __vsc_escape_cmd -d "Serialize the command line"
    set --local commandline "$argv"
    # `string replace` automatically breaks its input apart on any newlines.
    # Then `string join` at the end will bring it all back together.
    string replace --all -- "\\" "\\\\" $commandline \
        | string replace --all ";" "\x3b" \
        | string join "\x0a"
end

# Report (fake) shell integration version to iTerm.
function __iterm_shin_version
    string match -q $TERM_PROGRAM "iTerm.app"
    and __iterm_esc ShellIntegrationVersion=69 shell=fish
end

# ----------------------------------------------------------------------------

# Mark the beginning of the prompt (and, implicitly, a new line).
function __shin_prompt_start
    __esc_seq A
end

# Marks the end of the prompt and the beginning of the user's command input.
function __shin_prompt_end
    __esc_seq B
end

# Marks the beginning of command output.
# Sent right before executing an interactive command.
function __shin_output_start --on-event fish_preexec
    # Ignore commands with leading spaces or in private mode
    if string match --quiet -- " *" "$argv"; or set --query fish_private_mode
        set argv ""
    end

    switch $TERM_PROGRAM
        case vscode
            __vsc_esc C
            __vsc_esc E (__vsc_escape_cmd "$argv")
        case iTerm.app
            __esc_seq C \r
        case '*'
            __esc_seq C
    end

    set --global __shin_cmd_active
end

# Marks the end of command output.
# Sent right after an interactive command has finished executing.
function __shin_report_status --on-event fish_postexec
    __esc_seq D $status
end

# Updates the current working directory, etc.
# Sent whenever a new fish prompt is about to be displayed.
function __shin_update_cwd --on-event fish_prompt
    switch $TERM_PROGRAM
        case vscode
            __vsc_esc P "Cwd=$PWD"
        case iTerm.app
            __iterm_esc "RemoteHost=$USER@"(hostname -f 2>/dev/null)
            __iterm_esc "CurrentDir=$PWD"
    end
end

# Marks the cleared line with neither success nor failure.
# Sent when a command line is cleared or reset, but no command was run.
function __shin_cmd_cancelled --on-event fish_cancel
    switch $TERM_PROGRAM
        case vscode
            __vsc_esc E
            __vsc_esc D
        case '*'
            __esc_seq D
    end
end

# Marks the line as cancelled if no command was actually run.
# Runs whenever a new fish prompt is about to be displayed.
function __shin_cmd_check --on-event fish_prompt
    if set --query __shin_cmd_active
        set --erase __shin_cmd_active
    else
        __shin_cmd_cancelled
    end
end

# Ctrl+X adds a mark to the line it was triggered on.
function __shin_mark_line -d "Mark the current line in the terminal"
    __iterm_esc SetMark
end
bind \cx __shin_mark_line

# ----------------------------------------------------------------------------

# Preserve the user's existing prompt, and wrap it in our escape sequences.
functions --copy fish_prompt __original_fish_prompt

function fish_prompt
    __shin_prompt_start
    __original_fish_prompt
    __shin_prompt_end
end

__iterm_shin_version
