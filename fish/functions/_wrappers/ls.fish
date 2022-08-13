# Overrides $__fish_data_dir/functions/ls.fish
if in-path exa
    function ls --wraps exa --description 'List (almost) all files'
        set -p argv --all
        set -p argv --color-scale
        command exa $argv
    end
else
    function ls --description 'List (almost) all files'
        # list [A]ll files; print [q]uestion mark for nongraphic characters
        set -p argv -A -q

        # append .exe if cygwin magic was needed
        is-cygwin; and set -p argv --append-exe

        # colourize output
        if is-gnu ls
            set -p argv --color=auto
        else
            set -p argv -G
        end

        command ls $argv
    end
end
