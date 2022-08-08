function fish_prompt --description 'Display the interactive prompt'
    if set -q SSH_CONNECTION
        prompt_login
        echo -n :
    end

    set_color $fish_color_cwd
    if fish_is_root_user # root gets an unobscured path
        echo -n (pwd)
    else
        echo -n (prompt_pwd)
    end

    echo -ns (set_color normal) " "

    __fish_prompt_rbenv
    __fish_prompt_git
    __fish_prompt_jobs

    if fish_is_root_user
        echo -ns (set_color $fish_color_user_root) "#"
    else if set -q fish_private_mode
        echo -ns (set_color $fish_color_dimmed) "?"
    else
        echo -ns (set_color $fish_color_user) "¶"
    end

    echo -ns (set_color normal) " "
end
