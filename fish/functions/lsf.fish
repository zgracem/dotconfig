if in-path exa
    function lsf --wraps exa --description 'List files with "full" info'
        exa --long --group --inode --extended $argv
    end
else
    function lsf --wraps ls --description 'List files with "full" info'
        # [l]ong list of [A]ll files; show [i]node numbers
        set -l params -l -A -i

        if is-macos
            # display extended attributes and file flags
            set -a params -@ -O

            # colourize output
            set -a params -G

            /bin/ls $params $argv
            return
        else if is-gnu ls
            # colourize output
            set -a params --color=auto
        else
            # colourize output (BSD syntax)
            set -a params -G
        end

        command ls $params $argv
    end
end
