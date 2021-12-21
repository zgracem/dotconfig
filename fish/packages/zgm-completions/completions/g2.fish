# for my custom "goto" function

function __fish_complete_g2_parsefile -a rx
    set -l func_file $__fish_config_dir/functions/g2.fish
    string replace --filter --regex "^\s+$rx\$" '$1' <$func_file
end

function __fish_complete_g2
    set -l aliases (__fish_complete_g2_parsefile 'case (\w+)')
    set -l dirs (__fish_complete_g2_parsefile 'set dir (\S+)' \
        | tr -d '"' | string replace -r '^\$HOME' '~' )

    for n in (seq 1 (count $aliases))
        printf '%s\t%s\n' "$aliases[$n]" "$dirs[$n]"
    end
end

complete -c g2 -xa "(__fish_complete_g2)"
