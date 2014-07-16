# ------------------------------------------------------------------------------
# ~zozo/.config/bash/functions/man.bash
# man pages for all
# ------------------------------------------------------------------------------

man()
{   # open man page in a new window with a helpful title
    declare manpath title

    # some switches don't open a man page; pass those through
    declare regex_switches='-[[:alpha:]]*[dfhkwW]'

    if [[ $@ =~ $regex_switches ]]; then
        command man "$@"
        return
    fi

    # fail if man page doesn't exist
    manpath="$(command man -w "$@")" \
        || return

    # let Terminal.app be clever about this
    if [[ $TERM_PROGRAM == Apple_Terminal ]]; then
        open -b com.apple.terminal "x-man-page://$1${2:+/$2}"
        return
    fi

    # get a nice title like "printf(1)" or "cron(8)"
    title="${manpath##*/}"  # strip path
    title="${title%.gz}"    # strip extension (if any)
    title="${title/./(})"   # title.section -> title(section)

    # see functions/title.bash
    setWindowTitle "$titlePrefix: $title"

    # open the new window
    if [[ -n $STY ]]; then
        screen -t "$title" man "$@"
    elif [[ -n $TMUX ]]; then
        tmux new-window -n "$title" "MANLESS= man $*"
    else
        command man "$@"
    fi
}

manpdf()
{   # create a PDF from a man page
    # Requires: GhostScript
    # Based on: https://gist.github.com/phyllisstein/17ab8a9354cd7785736d

    declare page="$@" switches='t' manpath title ps_file pdf_file
    declare pdf_dir="$HOME/share/doc/manpdf"

    if [[ $# -eq 0 ]]; then
        cd "$pdf_dir"
        return 0
    fi

    _inPath mandb \
        || switches+='c'    # man-db reformats anyway

    _isGNU mktemp \
        && declare gnu=true

    # get path to manpage or die trying
    manpath="$(man -w "$page")" \
        || return $?

    # get a nice title like "printf.1.pdf" or "cron.8.pdf"
    title="${manpath##*/}"  # strip path
    title="${title%.gz}"    # strip extension (if any)

    ps_file="$(mktemp -t "${title}${gnu:+.XXXXXX}.ps")"
    pdf_file="${pdf_dir}/${title}.pdf"

    # if a PDF doesn't already exist...
    if [[ ! -f $pdf_file ]]; then
        # generate the PostScript file
        command man -${switches} "$manpath" >| "$ps_file" 2>/dev/null

        if [[ -s $ps_file ]]; then
            # generate the PDF file
            gs -sOutputFile="$pdf_file" -dBATCH -dQUIET -dNOPAUSE -sDEVICE=pdfwrite "$ps_file" \
                && printf "$pdf_file\n" # output the filename
        else
            scold "failed to create PostScript file for ${title/./(})"
            return 1
        fi
    fi

    # open in default PDF viewer if not logged in remotely
    if [[ -z $SSH_CONNECTION ]]; then
        open "$pdf_file"
    else
        return 0
    fi
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
