function fish_right_prompt --description 'Display the right side of the interactive prompt'
    set -l __fish_last_status $status
    set -l last_cmd_duration $CMD_DURATION

    my-prompt-right-status $__fish_last_status
    my-prompt-right-timer $last_cmd_duration
    my-prompt-right-mode
end
