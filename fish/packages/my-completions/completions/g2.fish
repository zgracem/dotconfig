# for my custom "goto" function

function __fish_complete_g2
    g2 --list | string replace ' → ' \t | string replace '$HOME' '~'
end

complete -c g2 -f
complete -c g2 -n "__fish_is_nth_arg 1" -xa "(__fish_complete_g2)"
complete -c g2 -s l -l list -n "__fish_is_nth_arg 1" -d "List all destinations"
complete -c g2 -s h -l help -n "__fish_is_nth_arg 1" -d "Print help"
