function alpine
    argparse 'w/with=' -- $argv
    or return

    set -q _flag_with[1]; or set -f _flag_with pink

    set -f PINERC $XDG_CONFIG_HOME/alpine/.pinerc
    set -f PINERCEX ~/.private/alpine/.pinerc-$_flag_with

    for p in $PINERC $PINERCEX
        if not path is -f $p
            echo >&2 "not found: $p"
            return 1
        end
    end

    command alpine -p$PINERC -x$PINERCEX $argv
end
