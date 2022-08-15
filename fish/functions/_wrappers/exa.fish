function exa --description "A modern replacement for ls"
    set -p argv --all # show hidden and .dotfiles
    set -p argv --color-scale # highlight levels of file sizes distinctly
    command exa $argv
end
