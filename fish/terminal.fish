# ----------------------------------------------------------------------------
# Terminal–shell integration for fish
# ----------------------------------------------------------------------------

# Don't run in scripts, non-GUI clients, or more than once per session.
status is-interactive
and set --query TERM_PROGRAM
and ! set --query SHELL_INTEGRATION
or exit

switch $TERM_PROGRAM
    case vscode
        set --global VSCODE_SHELL_INTEGRATION 1
    case iTerm.app
        set --global ITERM_SHELL_INTEGRATION_INSTALLED Yes
end
set --global SHELL_INTEGRATION $TERM_PROGRAM

# Setup variables
set --global __si_Ps 133
set --global __iterm_Ps 1337
set --global __vsc_Ps 633

function __si_esc -d "Emit escape sequences for shell integration"
    set --local OSC "\e]"
    set --local ST "\a"
    builtin printf "$OSC$__si_Ps;%s$ST" (string join ";" $argv)
end

function __iterm_esc -d "Emit escape sequences for iTerm.app shell integration"
    set --local --export __si_Ps $__iterm_Ps
    __si_esc $argv
end

function __vsc_esc -d "Emit escape sequences for VS Code shell integration"
    set --local --export __si_Ps $__vsc_Ps
    __si_esc $argv
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

# ----------------------------------------------------------------------------

# Mark the beginning of the prompt (and, implicitly, a new line).
function __si_prompt_start
    __si_esc A
end

# Marks the end of the prompt and the beginning of the user's command input.
function __si_cmd_start
    __si_esc B
end

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

# Ctrl+X adds a mark to the line it was triggered on.
bind \cx '__iterm_esc SetMark'

# ----------------------------------------------------------------------------

# Preserve the user's existing prompt, and wrap it in our escape sequences.
functions --copy fish_prompt __original_fish_prompt

function fish_prompt
    __si_prompt_start
    __original_fish_prompt
    __si_cmd_start
end

# Report (fake) shell integration version to iTerm.
string match -q $TERM_PROGRAM "iTerm.app"
and __iterm_esc ShellIntegrationVersion=69 shell=fish
