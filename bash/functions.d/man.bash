# ------------------------------------------------------------------------------
# man pages for all
# ------------------------------------------------------------------------------

z::mantitle()
{
    local manfile title section

    manfile=$(command man -w "$@") || return

    title=${manfile##*/} # strip path
    title=${title%.gz}   # strip extension (if any)

    section=${title##*.} # isolate section
    title=${title%.*}    # remove section

    if [[ $section =~ (.+)(ssl|tcl)$ ]]; then
        section=${BASH_REMATCH[1]}
    elif [[ $section == 3o ]]; then
        section=3
    fi

    printf '%s(%s)' "$title" "$section"
}

man()
{   # open man page in a new window with a helpful title
    local OPT OPTIND

    while getopts ':acCdDeEfHiIkKlLmMpPrRStTuVwWXZ7?' OPT; do
        case $OPT in
            [dfhkVwW?])
                command man "$@"
                return
                ;;
            *)
                continue
                ;;
        esac
    done

    # get a nice title like "printf(1)" or "cron(8)"
    # or fail if man page doesn't exist
    local title
    title=$(z::mantitle "$@") || return

    # open the new window
    ### ZGM disabled 2015-10-04 -- doesn't respect MANPATH
    # if [[ $TERM_PROGRAM == Apple_Terminal ]]; then
    #     # let Terminal.app be clever about this
    #     open -b com.apple.terminal "x-man-page://$1${2:+/$2}"
    #     return 0
    # elif [[ $TERM_PROGRAM == iTerm.app ]]; then
    #     open -b com.googlecode.iterm2 "x-man-page://$1${2:+/$2}"
    #     return 0
    # else
        ### ZGM disabled 2015-09-04 -- behaviour too inconsistent w/ mc and tmux
        # setwintitle "$title"

        if _inScreen; then
            screen -t "$title" man "$@"
        elif _inTmux; then
            tmux new-window -n "$title" "MANLESS= man $*"
        else
            command man "$@"
        fi
    # fi
}

macman()
{   # open the Mac OS X manual page at developer.apple.com
    declare manPath manPathTrimmed
    declare baseURL='http://developer.apple.com/library/mac/#documentation/Darwin/Reference/ManPages/'

    # do we already know where to look?
    if manPath=$(command man --path "$@" 2>/dev/null); then
        manPathTrimmed=$(command grep -Eo 'man[1-8]/[^\.]+\.[^\.]+' <<< "$manPath")
    else # try anyway
        if [[ $# -eq 2 ]]; then # if the user specified a section
            manPathTrimmed="man$1/$2.$1"
        else                    # hope for the best
            manPathTrimmed="man1/$1.1"
        fi
    fi

    # go!
    "$BROWSER" "${baseURL}${manPathTrimmed}.html"
}
