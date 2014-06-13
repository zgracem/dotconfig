# ------------------------------------------------------------------------------
# ~zozo/.config/bash/functions/man.bash
# man pages for all
# ------------------------------------------------------------------------------

man()
{   # open man page in a new window with a helpful title

    # some switches don't open a manpage; pass those through
    declare switchRegex='-[[:alpha:]]*[dfhkwW]'
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
    declare manpageTitle="$(command man "$@" 2>&- |
        grep -h -m1 ^. |                # get first non-blank line
        cut -d" " -f1)"                 # get first "field" in line

    manpageTitle="${manpageTitle,,}"    # lowercase for aesthetics
    
    # see functions/title.bash
    setWindowTitle "$titlePrefix: $manpageTitle"

    # open the new window
    if [[ $STY ]]; then
        screen -t "$manpageTitle" man "$@"
    elif [[ $TMUX ]]; then
        tmux new-window -n "$manpageTitle" "man $*"
    else
        # set the xterm title
        command man "$@"
    fi
}

manpdf()
{   # create a PDF from a man page
    # Based on: https://gist.github.com/phyllisstein/17ab8a9354cd7785736d

    declare page title pdf_file ps_file pdf_dir="$HOME/share/doc/manpdf"

    [[ $# -gt 0 ]] || cd "$pdf_dir"

    for page in "$@"; do
        # get path to manpage or die trying
        manpath="$(man -w "$page")" || continue

        title="${manpath##*/}"  # strip path
        title="${title%.gz}"    # strip extension (if any)

        ps_file="$(mktemp -t $title.XXXXXX.ps)"
        pdf_file="$pdf_dir/$title.pdf"

        # if a PDF doesn't already exist...
        if [[ ! -f $pdf_file ]]; then
            # generate the PostScript file
            command man -ct "$page" >| "$ps_file" || continue

            if [[ -f $ps_file ]]; then
                # generate the PDF file
                gs -sOutputFile="$pdf_file" -dBATCH -dQUIET -dNOPAUSE -sDEVICE=pdfwrite "$ps_file" \
                && printf "$pdf_file\n" # output the filename
            else
                scold "Failed to create PostScript file for $page"
                continue
            fi
        fi

        # open in default PDF viewer if not logged in remotely
        if [[ ! $SSH_CONNECTION ]]; then
            open "$pdf_file"
        fi
    done
}

macman()
{   # open the Mac OS X manual page at developer.apple.com
    declare manPath manPathTrimmed
    declare baseURL='http://developer.apple.com/library/mac/#documentation/Darwin/Reference/ManPages/'

    # do we already know where to look?
    manPath=$(command man --path "$@" 2>/dev/null) && {
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
