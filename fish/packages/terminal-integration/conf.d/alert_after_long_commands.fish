set --local SUPPORTED_TERMS iTerm.app
contains -- $TERM_PROGRAM $SUPPORTED_TERMS; or exit
# Set LONG_CMD_DURATION to whatever threshold (in milliseconds) makes me switch
# to another tab from boredom.
set -q LONG_CMD_DURATION[1]; or set --global LONG_CMD_DURATION 30000
# Set LONG_COMMANDS to an exclusive list of commands to monitor for long runs.
set -q LONG_COMMANDS[1]; or set --global LONG_COMMANDS brew backup_discord
function __iterm_alert_after_long_commands -a commandline --on-event fish_postexec
    if test $CMD_DURATION -ge $LONG_CMD_DURATION
        string match -rq "(?:^|(?:and|or|;|[&|]{2})\s*)("(string join "|" $LONG_COMMANDS)")" $commandline
        or return

        set -l duration (__fish_human_readable_ms $CMD_DURATION)
        set -l message "‘$commandline’ finished after $duration"

        __iterm_alert "$message"
        __iterm_request_attention
    end
end
