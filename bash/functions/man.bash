# ------------------------------------------------------------------------------
# ~zozo/.config/bash/functions/man.bash
# man pages for all
# ------------------------------------------------------------------------------

man()
{   # open man page in a new window with a helpful title

    # some switches don't open a manpage; pass those through
    declare switchRegex='[[:space:]]?-[[:alpha:]]*[dfhkwW]'
    [[ $@ =~ $switchRegex ]] && {
        command man $@
        return $?
    }

    # fail if manpage doesn't exist
    command man -w "$@" 1>&- ||
        return $?

    # let Terminal.app be clever about this
    [[ $TERM_PROGRAM == Apple_Terminal ]] && {
        open -b com.apple.terminal "x-man-page://$1${2:+/$2}"
        return 0
    }

    # get title -- e.g. "cron(8)"
    declare manpageTitle=$(command man "$@" 2>&- |
        grep ^. |                       # ignore leading blank line
        head -n1 |                      # get first line of manpage
        cut -d" " -f1)                  # get first "field" in line

    manpageTitle="${manpageTitle,,}"    # lowercase for aesthetics

    # open the new window
    if [[ $STY ]]; then
        screen -t "$manpageTitle" man "$@"
    elif [[ $TMUX ]]; then
        tmux new-window -n "$manpageTitle" "man $*"
    else
        # set the xterm title
        setWindowTitle "$titlePrefix: $manpageTitle"
        command man "$@"
    fi
}

manpdf()
{   # create a PDF from a man page
    declare page pdf processor viewer pdfDir="$HOME/share/doc/manpdf"

    [[ $# -gt 0 ]] ||
        cd "$pdfDir"

    case $OSTYPE in
        darwin*)
            processor="pstopdf -i -o"
            viewer="open"
            ;;
        cygwin)
            processor="ps2pdf -"
            viewer="cygstart"
            ;;
        *)
            return 1
            ;;
    esac

    for page in "$@"; do
        pdf="$pdfDir/$page.pdf"

        # if a PDF doesn't already exist...
        [[ ! -f $pdf ]] && {
            # does the man page exist?
            command man -w "$page" &>/dev/null || {
                scold "No manual entry for $page"
                return 1
            }

            # generate the PDF
            command man -ct "$page" | $processor "$pdf" &>/dev/null &&
            # output the filename
            printf "$pdf\n"
        }

        # open in default PDF viewer if not logged in remotely
        [[ ! $SSH_TTY ]] &&
            $viewer "$pdf"
    done

    return 0
}

macman()
{   # open the Mac OS X manual page at developer.apple.com
    declare manPath manPathTrimmed
    declare baseURL='http://developer.apple.com/library/mac/#documentation/Darwin/Reference/ManPages/'

    # do we already know where to look?
    manPath=$(command man --path "$@" &>/dev/null) && {
        manPathTrimmed=$(echo $manPath | command grep -Eo 'man[1-8]/[^\.]+\.[^\.]+')
    } || { # try anyway
        [[ $# -eq 2 ]] && { # if the user specified a section
            manPathTrimmed="man$1/$2.$1"
        } || {              # hope for the best
            manPathTrimmed="man1/$1.1"
        }
    }

    # go!
    "$BROWSER" "${baseURL}${manPathTrimmed}.html"
}
