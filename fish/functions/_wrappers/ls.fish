# Overrides $__fish_data_dir/functions/ls.fish
if in-path exa
    function ls --wraps exa --description 'List (almost) all files'
        exa --all --color-scale $argv
    end
else
    function ls --description 'List (almost) all files'
        set params -A -q
        #           │  └─ print ? instead of nongraphic characters
        #           └──── list (almost) all files

        if is-cygwin
            # append .exe if cygwin magic was needed
            set -a params --append-exe
        end

        # colourize output
        if is-gnu ls
            set -a params --color=auto
        else
            set -a params -G
        end

        command ls $params $argv
    end
end
