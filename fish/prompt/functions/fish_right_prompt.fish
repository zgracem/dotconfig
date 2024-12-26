function fish_right_prompt --description 'Display the right side of the interactive prompt'
    set -l __fish_last_status $status
    set -l last_cmd_duration $CMD_DURATION

    __fish_print_pipestatus $__fish_last_status
    __fish_rprompt_timer $last_cmd_duration
    fish_mode_rprompt
end
