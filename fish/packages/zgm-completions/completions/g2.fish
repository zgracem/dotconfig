# for my custom "goto" function

function __fish_complete_g2
    string replace -fr '^\s+case ([^;]+);\s+set dir "?([^"]+)"?' '$1\t$2' \
        <$__fish_config_dir/functions/g2.fish
end

complete -c g2 -xa "(__fish_complete_g2)"
