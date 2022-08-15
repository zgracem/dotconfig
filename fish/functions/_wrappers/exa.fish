function exa --description "A modern replacement for ls"
    set -p argv --all
    set -p argv --color-scale
    command exa $argv
end
