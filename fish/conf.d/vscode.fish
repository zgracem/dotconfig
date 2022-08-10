# ----------------------------------------------------------------------------
# Visual Studio Code terminal integration for fish
# <https://code.visualstudio.com/docs/terminal/shell-integration>
# With ideas from: <https://github.com/kidonng/vscode.fish>
# ----------------------------------------------------------------------------

# Don't run in scripts, other terminals, or more than once per session.
status is-interactive
and string match --quiet "$TERM_PROGRAM" "vscode"
and ! set --query VSCODE_SHELL_INTEGRATION
or exit

set --global VSCODE_SHELL_INTEGRATION 1

# Helper function
function __vsc_esc -d "Emit escape sequences for VS Code shell integration"
    builtin printf "\e]633;%s\007" (string join ";" $argv)
end

# Escapes backslashes, newlines, and semicolons to serialize the command line.
function __vsc_escape_cmd
    set --local commandline "$argv"
    # `string replace` automatically breaks its input apart on any newlines.
    # Then `string join` at the end will bring it all back together.
    string replace --all -- "\\" "\\\\" $commandline \
        | string replace --all ";" "\x3b" \
        | string join "\x0a"
end

# Sent right before executing an interactive command.
# Marks the beginning of command output.
function __vsc_cmd_output_start --on-event fish_preexec
    # Ignore commands with leading spaces or in private mode
    if string match --quiet -- " *" "$argv"; or set --query fish_private_mode
        set argv ""
    end

    __vsc_esc C
    __vsc_esc E (__vsc_escape_cmd "$argv")

    set --global _vsc_cmd_active
end

# Sent right after an interactive command has finished executing.
# Marks the end of command output.
function __vsc_cmd_output_end --on-event fish_postexec
    __vsc_esc D $status
end

# Sent when a command line is cleared or reset, but no command was run.
# Marks the cleared line with neither success nor failure.
function __vsc_cmd_cancelled --on-event fish_cancel
    __vsc_esc E
    __vsc_esc D
end

# Runs whenever a new fish prompt is about to be displayed.
# Marks the line as cancelled if no command was actually run.
function __vsc_cmd_check --on-event fish_prompt
    if set --query _vsc_cmd_active
        set --erase _vsc_cmd_active
    else
        __vsc_cmd_cancelled
    end
end

# Sent whenever a new fish prompt is about to be displayed.
# Updates the current working directory.
function __vsc_update_cwd --on-event fish_prompt
    __vsc_esc P "Cwd=$PWD"
end

# Sent at the start of the prompt.
# Marks the beginning of the prompt (and, implicitly, a new line).
function __vsc_fish_prompt_start
    __vsc_esc A
end

# Sent at the end of the prompt.
# Marks the beginning of the user's command input.
function __vsc_fish_cmd_start
    __vsc_esc B
end

# Preserve the user's existing prompt, and wrap it in our escape sequences.
functions --copy fish_prompt __vsc_fish_prompt

function fish_prompt
    __vsc_fish_prompt_start
    __vsc_fish_prompt
    __vsc_fish_cmd_start
end

# Ctrl+X adds a mark to the left of the line it was triggered on.
bind \cx 'builtin printf "\e]1337;SetMark\007"'
