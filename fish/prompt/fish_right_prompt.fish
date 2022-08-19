function fish_right_prompt --description 'Display the right side of the interactive prompt'
    set -l exit $status
    set -l time $CMD_DURATION

    __fish_rprompt_signal $exit
    __fish_rprompt_timer $time
    __fish_rprompt_mode
end
