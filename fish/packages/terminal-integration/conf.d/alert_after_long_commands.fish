set --local SUPPORTED_TERMS iTerm.app
contains -- $TERM_PROGRAM $SUPPORTED_TERMS; or return

# Set `long_cmd_duration` to whatever threshold (in ms) makes me switch to
# another tab from boredom.
set -q long_cmd_duration[1]; or set --global long_cmd_duration 30000

# Set `long_commands` to an exclusive list of commands to monitor for long runs.
set -q long_commands[1]; or set --global long_commands brew tinyjpg tinypng

function __iterm_alert_after_long_commands -a commandline --on-event fish_postexec
    not string match -q "iTerm.app" "$TERM_PROGRAM"; and return
    if test $CMD_DURATION -ge $long_cmd_duration
        string match -rq "(?:^|(?:and|or|;|[&|]{2})\s*)("(string join "|" $long_commands)")" $commandline
        or return

        set -l duration (__fish_human_readable_ms $CMD_DURATION)
        set -l message "‘$commandline’ finished after $duration"

        __iterm_alert "$message"
        __iterm_request_attention
    end
end
