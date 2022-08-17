set --local SUPPORTED_TERMS iTerm.app
contains -- $TERM_PROGRAM $SUPPORTED_TERMS; or exit
# Set LONG_CMD_DURATION to whatever threshold (in milliseconds) makes me switch
# to another tab from boredom.
set -q LONG_CMD_DURATION[1]; or set --global LONG_CMD_DURATION 15000
# Set LONG_COMMANDS to an exclusive list of commands to monitor for long runs.
set -q LONG_COMMANDS[1]; or set --global LONG_COMMANDS brew backup_discord
function __iterm_alert_after_long_commands -a commandline --on-event fish_postexec
    if test $CMD_DURATION -ge $LONG_CMD_DURATION
        string match -rq "(?:^|(?:and|or|;)\s*)("(string join "|" $LONG_COMMANDS)")" $commandline
        or return

        echo -ens "\e]9;`$commandline` finished after " \
            (math -s0 "$CMD_DURATION / 1000") " seconds\a"
    end
end
