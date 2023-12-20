# Overrides $__fish_data_dir/functions/prompt_login.fish
function prompt_login --description "display user name for the prompt"
    # DEFAULT_USER set in ~/.private/fish/conf.d/default_user.fish
    if set -q DEFAULT_USER; and string match -vq $DEFAULT_USER $USER
        echo -n -s (set_color $fish_color_user) "$USER" (set_color $fish_color_at) @
    end
    echo -n -s (set_color $fish_color_host) (prompt_hostname) (set_color normal)
end
