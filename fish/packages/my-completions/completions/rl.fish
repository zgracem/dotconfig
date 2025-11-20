function __fish_complete_rl
    begin
        functions -n \
            | string split ", "

        printf "%s\\n" $__fish_config_dir/*.fish \
            | string match -rg "^$__fish_config_dir/(.+)\.fish"

        printf "%s\\n" $__fish_config_dir/conf.d/*.fish \
            | string match -rg "^$__fish_config_dir/conf.d/(.+)\.fish"
    end \
        | path sort -u
end

complete -c rl -xa "(__fish_complete_rl)"
