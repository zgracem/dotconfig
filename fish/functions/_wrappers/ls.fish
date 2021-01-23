# Overrides $__fish_data_dir/functions/ls.fish
if in-path exa
    function ls --wraps exa --description 'List (almost) all files'
        exa --all --color-scale $argv
    end
else
    function ls --description 'List (almost) all files'
        # list [A]ll files; print [q]uestion mark for nongraphic characters
        set params -A -q

        # append .exe if cygwin magic was needed
        is-cygwin; and set -a params --append-exe

        # colourize output
        if is-gnu ls
            set -a params --color=auto
        else
            set -a params -G
        end

        command ls $params $argv
    end
end
