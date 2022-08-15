# Overrides $__fish_data_dir/functions/ll.fish
if in-path exa
    function ll --wraps exa --description 'List files vertically, info-heavy'
        ls --long $argv
    end
else
    function ll --wraps ls --description 'List files vertically, info-heavy'
        # [l]ong output w/ [h]uman-readable sizes
        set -l params -l -h

        if test $COLUMNS -le 100
            # don't display [g]roup or [o]wner
            set -a params -g -o
            # shorter timestamps
            is-gnu ls; and set -a params --time-style=long-iso
        end

        ls $params $argv
    end
end
