# ----------------------------------------------------------------------------
# Severely simplified shell integration for iTerm.app and VS Code.
#
# Requires manual installation:
#   - Add `__term_prompt_start` as the very first command in fish_prompt
#     (or fish_mode_prompt)
#   - Add `__term_prompt_end` as the very last command in fish_prompt
#   - Ensure this file is sourced somewhere in config.fish
#
# Improvements:
#   - Manual installation does not clobber any existing fish_prompt or
#     fish_mode_prompt function(s)
#   - Except for `__term_prompt_start` and `__term_prompt_end`, all control
#     sequences are triggered by appropriate event handlers
#     <https://fishshell.com/docs/current/language.html#event>
#   - Supports `--final-rendering` for transient prompts (new in fish 4.1)
#     <https://fishshell.com/docs/current/prompt.html#transient-prompt>
#
# References:
#   - https://code.visualstudio.com/docs/terminal/shell-integration
#   - https://iterm2.com/documentation-shell-integration.html#:~:text=Features,-Shell%20Integration
#   - https://iterm2.com/documentation-escape-codes.html#:~:text=Shell%20Integration,-/FinalTerm
#   - https://sw.kovidgoyal.net/kitty/shell-integration/#manual-shell-integration
#   - /Applications/iTerm.app/Contents/Resources/iterm2_shell_integration.fish
#   - `code --locate-shell-integration-path fish`
#
# Structure:
#   <A>prompt<B>command
#   <C>output 1
#   output 2<D>
#   <A>prompt<B>
# ----------------------------------------------------------------------------

# Don't run in scripts
status is-interactive; or return
# Don't run in non-GUI clients
contains -- "$TERM" dumb linux {screen,tmux}-256color; and return
# Don't run more than once
functions -q __term_osc; and return

# Prevent iTerm & VS Code's builtin shell integrations from running after this
# by setting the conditions they check for.
function iterm2_status; end
set -g VSCODE_SHELL_INTEGRATION 1

# Manually install kitty's shell integration
if set -q KITTY_INSTALLATION_DIR
    # Stub these out so fish_prompt will just ignore them
    function __term_prompt_start; end
    function __term_prompt_end; end
    set -g KITTY_SHELL_INTEGRATION enabled
    source "$KITTY_INSTALLATION_DIR/shell-integration/fish/vendor_conf.d/kitty-shell-integration.fish"
    set -p fish_complete_path "$KITTY_INSTALLATION_DIR/shell-integration/fish/vendor_completions.d"
    return
end

# ----------------------------------------------------------------------------

function __term_osc -d "Emit an operating system command"
    argparse c/command= -- $argv
    or return

    if not set -q _flag_command[1]
        if string match -q vscode $TERM_PROGRAM
            # Placing this logic here means we only have to write special cases
            # where VS Code's control sequences deviate from the "standard".
            set -f _flag_command 633
        else
            set -f _flag_command 133
        end
    end

    # `set -gx DEBUG_PROMPT 1` to see the placement of escape sequences.
    if set -q DEBUG_PROMPT
        set -l cmd "$_flag_command;"(string escape --style=script -- $argv | string join ";")
        echo -ns (set_color brmagenta) "<" $cmd ">" (set_color normal)
    end

    echo -ens "\e]" $_flag_command ";" (string join ";" -- $argv) "\a"
end

# Used for VS Code's 'P' ("Property") and 'E' ("Command Line") sequences
function __vsc_escape -d "Escape backslashes, semicolons and newlines"
    # `string replace` splits $argv on newlines
    string replace -a '\\' '\\\\' $argv \
        | string replace -a ';' '\\x3b' \
        | string join "\x0a"
end

function __term_prompt_start -d "Mark the start of the prompt"
    __term_osc A
end

function __term_prompt_end -d "Mark the end of the prompt and the start of user input"
    __term_osc B
end

function __term_command_exec -e fish_preexec -d "Mark the end of user input and the start of command output"
    set -l commandline $argv[1]
    switch $TERM_PROGRAM
        case vscode
            __term_osc E (__vsc_escape $commandline) $VSCODE_NONCE
            __term_osc C
        case iTerm.app
            __term_osc C \r
        case '*'
            __term_osc C
    end
end

function __term_status -e fish_postexec -d "Mark the end of command output"
    __term_osc D $status
end

function __fish_update_cwd -e fish_prompt -d "Notify terminal of the current directory, user and host"
    switch $TERM_PROGRAM
        case vscode
            __term_osc P "Cwd="(__vsc_escape $PWD)
        case iTerm.app
            __term_osc -c 1337 "RemoteHost=$USER@$hostname"
            __term_osc -c 1337 "CurrentDir=$PWD"
        # # fish does this automatically:
        # case '*'
        #     __term_osc -c 7 "file://$hostname"(string escape --style=url $PWD)
    end
end

# Sent when a command line is cleared or reset and no command was executed
function __term_cancel_command -e fish_cancel -d "Mark the line with neither success nor failure"
    switch $TERM_PROGRAM
        case vscode
            __term_osc E "" $VSCODE_NONCE
            __term_osc C
            __term_osc D
        case '*'
            __term_osc D
    end
end

switch $TERM_PROGRAM
    case vscode
        __term_osc P HasRichCommandDetection=True
    case iTerm.app
        __term_osc -c 1337 ShellIntegrationVersion=420 shell=fish
end

# ----------------------------------------------------------------------------
# Window and tab titles
# ----------------------------------------------------------------------------
# fish's default behaviour uses `OSC 0` to write the output of the `fish_title`
# function to both the terminal's "window" title and "tab" (or "icon") title.
# But many terminals, including PuTTY and iTerm, allow setting separate values
# for window and tab titles using `OSC 2` and `OSC 1` respectively. This
# reimplementation does that with the outputs of `my-title-window` and
# `my-title-tab` instead, while `fish_title` is disabled elsewhere by setting
# it to an empty function.
# ----------------------------------------------------------------------------

function __term_set_title
    argparse -N1 -xw,t w/window t/tab -- $argv
    or return

    if set -q _flag_window
        set -f Ps 2
    else if set -q _flag_tab
        set -f Ps 1
    else # if set -q _flag_both
        set -f Ps 0
    end

    __term_osc -c $Ps "$argv"
end

function __term_update_titles --on-event fish_prompt
    functions -q my-title-window; and __term_set_title --window (my-title-window)
    functions -q my-title-tab; and __term_set_title --tab (my-title-tab)
end
