# Sublime Text

subl()
{
    local app

    if [[ $OSTYPE =~ darwin ]]; then
        app='/Applications/Sublime Text.app/Contents/SharedSupport/bin/subl'
    elif [[ -x $dir_mybin/subl ]]; then
        app="$dir_mybin/subl"
    elif [[ $OSTYPE =~ cygwin ]]; then
        app="$dir_scripts/cygsubl.sh"
    fi

    if [[ -x $app ]]; then
        "$app" "$@"
    else
        scold "$FUNCNAME: not found"
        return 64
    fi
}
