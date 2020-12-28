function __fish_complete_rl
    begin
        functions -n \
            | string split ", "

        printf "%s\\n" $__fish_config_dir/*.fish \
            | string replace -r "^$__fish_config_dir/(.+)\.fish" '$1'

        printf "%s\\n" $__fish_config_dir/conf.d/*.fish \
            | string replace -r "^$__fish_config_dir/conf.d/(.+)\.fish" '$1'
    end \
        | sort -u
end

complete -c rl -xa "(__fish_complete_rl)"
