function fish_right_prompt --description 'Display the right side of the interactive prompt'
    set -l exit $status
    set -l time $CMD_DURATION

    __vsc_fish_rprompt_before

    __fish_right_prompt_signal $exit
    __fish_right_prompt_timer $time
    __fish_right_prompt_mode

    __vsc_fish_rprompt_after
end
