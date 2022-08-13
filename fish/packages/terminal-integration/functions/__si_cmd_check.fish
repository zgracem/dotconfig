# Marks the line as cancelled if no command was actually run.
# Runs whenever a new fish prompt is about to be displayed.
function __si_cmd_check --on-event fish_prompt
    if set --query __si_cmd_active
        set --erase __si_cmd_active
    else
        __si_cmd_cancelled
    end
end
