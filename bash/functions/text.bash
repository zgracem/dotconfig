# ------------------------------------------------------------------------------
# ~zozo/.config/bash/functions/text.bash
# for editing and processing text and text files
# ------------------------------------------------------------------------------

_edit()
{   # open file(s) in the appropriate editor
    # Usage: _edit FILE[:LINE] [FILE[:LINE] ...]

    local -a files=("$@")
    local file line
    local -r lineno_regex=':([[:digit:]]+)$'

    for file in "${files[@]}"; do
        if [[ $file =~ $lineno_regex ]]; then
            line="${BASH_REMATCH[1]}"
            file="${file%:*}"
        fi

        # use a console editor if working remotely
        if [[ -n $SSH_CONNECTION ]]; then
            local window_title
            read  window_title < <(command basename "$EDITOR")

            if [[ $EDITOR =~ vim && -n $line ]]; then
                newwin --title "$window_title" "$EDITOR" +$line "$file"
            else
                newwin --title "$window_title" "$EDITOR" "$file"
            fi
        else
        # use a GUI editor
            if [[ $VISUAL =~ subl && -n $line ]]; then
                file="${file}:${line}"
            fi

            "$VISUAL" "$file"
        fi
    done
}

export -f _edit

clip()
{   # copy a plain text file to the clipboard
    # adapted from http://brettterpstra.com/2013/01/15/clip-text-file-a-handy-dumb-service/

    declare textFile="$1"

    if file "$textFile" | grep -q text; then
        cat "$textFile" \
        | pbcopy \
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
