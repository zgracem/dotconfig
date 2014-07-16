# ------------------------------------------------------------------------------
# ~zozo/.config/bash/functions/text.bash
# for editing and processing text and text files
# ------------------------------------------------------------------------------

_edit()
{   # open a file in the appropriate editor
    # Usage: _edit FILE[:LINE]

    declare line file="$1"
    declare -r lineno_regex=':([[:digit:]]+)$'

    # get line number (if specified)
    if [[ $file =~ $lineno_regex ]]; then
        line="${BASH_REMATCH[1]}"
        file="${file%:*}"
    fi

    if [[ -n $SSH_CONNECTION ]]; then
        # working remotely; use a console editor
        declare windowTitle="$(basename "$EDITOR")"

        if [[ $EDITOR =~ vim && -n $line ]]; then
            # see functions/newwin.bash
            newwin --title "$windowTitle" "$EDITOR" +$line "$file"
        else
            newwin --title "$windowTitle" "$EDITOR" "$file"
        fi

        return
    else
        # use a GUI editor

        if [[ $VISUAL =~ subl && $line ]]; then
            file="$file:$line" # for Sublime Text
        fi

        "$VISUAL" "$file"
    fi
}

export -f _edit

clip()
{   # copy a plain text file to the clipboard
    # adapted from http://brettterpstra.com/2013/01/15/clip-text-file-a-handy-dumb-service/

    declare textFile="$1"

    if file "$textFile" | grep -q text; then
        cat "$textFile" | pbcopy \
        && printf "Copied '%s' to clipboard\n" "$textFile"
    else
        scold $FUNCNAME "'$textFile' is not plain text"
        return 1
    fi
}

pastenote()
{   # paste the contents of the clipboard to a text file
    
    if [[ ! -d $dir_notes ]]; then
        scold $FUNCNAME "can't find notes directory"
        return 1
    fi

    declare fileName="${1:-"Note $(date '+%F at %H.%M.%S')"}"
    declare filePath="$dir_notes/${fileName%.txt}.txt"

    if [[ -f $filePath ]]; then
        scold $FUNCNAME "$fileName.txt: already exists"
        return 1
    fi

    pbpaste > "$filePath" \
    && echo "$filePath"
}

rot13()
{   # translate text to or from ROT13
    declare mask='a-zA-Z n-za-mN-ZA-M'

    # file
    if [[ -f $1 ]]; then
        # file
        tr $mask < "$1"
    elif [[ -t 0 ]]; then
        # string
        echo "$1" | tr $mask
    else
        # standard input
        tr $mask
    fi
}

flip()
{
    echo "$@" \
    | sed "y/abcdefghijklmnopqrstuvwxyz,'?!./ɐqɔpǝɟƃɥıɾʞlɯuodbɹsʇnΛmxλz',¿¡˙/" \
    | rev
}
