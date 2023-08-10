# for my custom "goto" function

function __fish_complete_g2
    g2 --list | string replace ' → ' \t | string replace '$HOME' '~'
end

complete -c g2 -xa "(__fish_complete_g2)"
