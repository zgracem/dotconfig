# Overrides $__fish_data_dir/functions/prompt_login.fish
function prompt_login --description "display user and host names for the prompt"
    # DEFAULT_USER set in ~/.private/fish/conf.d/default_user.fish
    if string match -vq "$DEFAULT_USER" $USER
        set_color $fish_color_user
        echo -n $USER
        set_color $fish_color_at
        echo -n @
    end

    if set -q SSH_CONNECTION
        set_color $fish_color_host_remote
        prompt_hostname
    end

    set_color normal
end
