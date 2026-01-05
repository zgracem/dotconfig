function fish_prompt --description 'Display the interactive prompt'
    __term_prompt_start

    if set -q SSH_CONNECTION
        echo -ns (my-prompt-login) :
    end

    set_color $fish_color_cwd
    if fish_is_root_user # root gets an unobscured path
        echo -n (pwd)
    else
        echo -n (my-prompt-pwd)
    end

    set_color normal
    echo -n " "

    my-prompt-rbenv
    my-prompt-git
    my-prompt-jobs

    if fish_is_root_user
        set_color $fish_color_prompt_ps_root
        echo -n "#"
    else if set -q fish_private_mode
        set_color --dim
        echo -n "?"
    else if is-raspi
        set_color --bold --italics magenta
        echo -n "π"
    else
        set_color $fish_color_prompt_ps
        echo -n "¶"
    end

    set_color normal
    echo -n " "

    __term_prompt_end
end
