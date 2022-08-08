function __fish_prompt_rbenv
    command -sq rbenv
    or return 0

    read -l global_version <~/.rbenv/version
    set -l local_version (rbenv version | string split -f1 " ")

    if not string match -q "$global_version" "$local_version"
        set_color $fish_prompt_color_ruby
        echo -n $local_version

        set_color normal
        echo -n " "
    end
end
