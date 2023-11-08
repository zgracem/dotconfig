# Overrides $__fish_data_dir/functions/ls.fish
if in-path eza
    function ls --wraps eza --description 'List files'
        eza $argv
    end
else
    function ls --description 'List files'
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
