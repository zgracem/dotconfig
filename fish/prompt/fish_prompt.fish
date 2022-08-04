function fish_prompt --description 'Display the interactive prompt'
    __vsc_fish_prompt_before
    __fish_prompt
    __vsc_fish_prompt_after
end

function __fish_prompt
    if test (id -u) -eq 0
        set -l root_user yes
    end

    if set -q SSH_CONNECTION
        set_color $fish_color_host
        echo -ns $USER @ (prompt_hostname)
        set_color normal
        echo -n :
    end

    set_color $fish_color_cwd
    if set -q root_user # root gets an unobscured path
        echo -n (pwd)
    else
        echo -n (prompt_pwd)
    end

    set_color normal
    echo -n " "

    __fish_prompt_rbenv
    __fish_prompt_git
    __fish_prompt_jobs

    if set -q root_user
        set_color $fish_color_user_root
        echo -n "#"
    else if test -n "$fish_private_mode"
        set_color $fish_color_dimmed
        echo -n "?"
    else
        set_color $fish_color_user
        echo -n "¶"
    end

    set_color normal
    echo -n " "
end
