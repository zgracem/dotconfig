function alpine
    argparse 'w/with=' -- $argv
    or return

    set -q _flag_with[1]; or set -f _flag_with pink

    set -fx PINERC $XDG_CONFIG_HOME/alpine/.pinerc
    set -lx PINERCEX ~/.private/alpine/.pinerc-$_flag_with

    if not path is -f $PINERC
        echo >&2 "not found: $PINERC"
        return 1
    end

    command alpine -p$PINERC -x$PINERCEX $argv
end
