function __fish_right_prompt_mode --description 'Display the current mode for the prompt'
    if test "$fish_key_bindings" = fish_vi_key_bindings
        or test "$fish_key_bindings" = fish_hybrid_key_bindings
        set -l color
        set -l mode
        switch $fish_bind_mode
            case default
                set color blue
                set mode e
            case insert
                set color green
                set mode i
            case replace_one
                set color yellow
                set mode r
            case visual
                set color brblue
                set mode v
            case '*'
                set color --bold red
                set mode '?'
        end
        set_color $color
        echo -n "$mode "
        set_color normal
    end
end
