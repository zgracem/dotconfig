return # TODO: archive this

manpdf()
{   # create a PDF from a man page (requires GhostScript)
    # Based on: https://gist.github.com/phyllisstein/17ab8a9354cd7785736d
    _inPath gs || return

    local pdf_dir="$HOME/share/doc/manpdf"

    if (( $# == 0 )); then
        cd "$pdf_dir"
        return
    else
        local page=$1
        local pdf_file=$2 # optional
    fi

    # get path to man page or die trying
    local man_file
    man_file=$(command man -w "$page") || return

    # get a nice title like "printf.1.pdf" or "cron.8.pdf"
    local title
    title=${man_file##*/}   # strip path
    title=${title%.gz}      # strip extension (if any)

    if [[ -z $pdf_file ]]; then
        pdf_file="$pdf_dir/$title.pdf"
    fi

    # if a PDF doesn't already exist...
    if [[ ! -f $pdf_file ]]; then
        # output in PostScript
        local opts=t

        # force-reformat man page unless we have man-db, which does it automatically
        _inPath mandb || opts+=c

        # GNU mktemp(1) requires at least three X's to end the template string
        _isGNU mktemp && local gnu=true

        # generate the PostScript file
        local ps_file
        ps_file=$(mktemp -t "${title}${gnu:+.XXX}.ps") || return
        command man -${opts} "$man_file" >| "$ps_file" || return

        # generate a PDF from the PostScript output
        if [[ -s $ps_file ]] && gs -q -dBATCH -dNOPAUSE -sDEVICE=pdfwrite  -sOutputFile="$pdf_file" "$ps_file"; then
            # output the filename
            printf "%s\n" "$pdf_file"

            # delete the PostScript file
            rm -f "$ps_file" &>/dev/null
        else
            scold "failed to create PostScript file for ${title/./(})"
            return $EX_CANTCREAT
        fi
    fi

    # open in default PDF viewer (if not logged in remotely)
    if [[ -z $SSH_CONNECTION ]]; then
        open "$pdf_file"
    else
        return $EX_OK
    fi
}
